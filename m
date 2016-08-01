From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Mon,  1 Aug 2016 19:59:48 -0300
Subject: [PATCH 1/3] dma-mapping: introduce the DMA_ATTR_NO_WARN attribute
In-Reply-To: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1470092390-25451-2-git-send-email-mauricfo@linux.vnet.ibm.com>

Introduce the DMA_ATTR_NO_WARN attribute, and document it.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
---
 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 include/linux/dma-mapping.h      |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 2d455a5..98bf7ac 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,20 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_NO_WARN
+----------------
+
+This tells the DMA-mapping subsystem to suppress allocation failure reports
+(similarly to __GFP_NOWARN).
+
+On some architectures allocation failures are reported with error messages
+to the system logs.  Although this can help to identify and debug problems,
+drivers which handle failures (eg, retry later) have no problems with them,
+and can actually flood the system logs with error messages that aren't any
+problem at all, depending on the implementation of the retry mechanism.
+
+So, this provides a way for drivers to avoid those error messages on calls
+where allocation failures are not a problem, and shouldn't bother the logs.
+
+NOTE: At the moment DMA_ATTR_NO_WARN is only implemented on PowerPC.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 66533e1..6efbd27 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -56,6 +56,11 @@
  * that gives better TLB efficiency.
  */
 #define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 7)
+/*
+ * DMA_ATTR_NO_WARN: This tells the DMA-mapping subsystem to suppress
+ * allocation failure reports (similarly to __GFP_NOWARN).
+ */
+#define DMA_ATTR_NO_WARN	(1UL << 8)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
-- 
1.8.3.1
