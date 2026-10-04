import { test, expect } from "@playwright/test";
test("home page renders production demo", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByRole("heading", { name: /Production-Ready Next.js/ })).toBeVisible();
  await expect(page.getByText(/PostgreSQL RLS/)).toBeVisible();
});
