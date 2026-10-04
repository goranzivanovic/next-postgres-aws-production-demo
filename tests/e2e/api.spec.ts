import { test, expect } from "@playwright/test";
test("health and tenant API work", async ({ request }) => {
  const health = await request.get("/api/health");
  expect(health.ok()).toBeTruthy();
  const res = await request.get("/api/records", { headers: { "x-demo-tenant": "11111111-1111-1111-1111-111111111111" } });
  expect(res.ok()).toBeTruthy();
  const body = await res.json();
  expect(body.records).toHaveLength(1);
});
