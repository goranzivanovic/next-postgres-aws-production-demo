import type { Metadata } from "next";
import "./globals.css";
export const metadata: Metadata = { title: "Production-Ready Next.js + PostgreSQL Demo", description: "Client-safe public engineering demo." };
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="en"><body>{children}</body></html>;}
