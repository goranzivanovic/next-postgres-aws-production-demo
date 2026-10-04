import { Pool, PoolClient } from "pg";
const pool=new Pool({connectionString:process.env.DATABASE_URL});
export async function withTenant<T>(tenantId:string,fn:(client:PoolClient)=>Promise<T>):Promise<T>{const client=await pool.connect();try{await client.query("BEGIN");await client.query("SET LOCAL ROLE app_runtime");await client.query("SELECT set_config('app.tenant_id',$1,true)",[tenantId]);const result=await fn(client);await client.query("COMMIT");return result;}catch(e){await client.query("ROLLBACK");throw e;}finally{client.release();}}
export async function healthcheck(){const {rows}=await pool.query("SELECT now() AS now");return rows[0];}
