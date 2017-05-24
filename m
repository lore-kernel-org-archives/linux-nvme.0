From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 May 2017 15:42:16 -0600
Subject: [RFC PATCH 05/16] tile: provide default ioremap declaration
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Message-ID: <1495662147-18277-6-git-send-email-logang@deltatee.com>

Add a default ioremap function which was not provided in all
circumstances. (Only when CONFIG_PCI and CONFIG_TILEGX was set).

I have designs to use them in scatterlist.c where they'd likely never
be called with this architecture, but it is needed to compile.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 arch/tile/mm/pgtable.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
index 492a736..c61df18 100644
--- a/arch/tile/mm/pgtable.c
+++ b/arch/tile/mm/pgtable.c
@@ -503,6 +503,19 @@ void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
 }
 EXPORT_SYMBOL(ioremap_prot);
 
+#if !defined(CONFIG_PCI) || !defined(CONFIG_TILEGX)
+/* ioremap is conditionally declared in pci_gx.c */
+
+void __iomem *ioremap(resource_size_t phys_addr, unsigned long size)
+{
+	pgprot_t pgprot = {};
+
+	return ioremap_prot(phys_addr, size, pgprot);
+}
+EXPORT_SYMBOL(ioremap);
+
+#endif
+
 /* Unmap an MMIO VA mapping. */
 void iounmap(volatile void __iomem *addr_in)
 {
-- 
2.1.4
