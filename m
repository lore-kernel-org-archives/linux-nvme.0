From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Wed,  6 Jul 2016 18:03:31 -0300
Subject: [PATCH 1/3] dma: introduce DMA_ATTR_NO_WARN
In-Reply-To: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-ID: <1467839013-22481-2-git-send-email-mauricfo@linux.vnet.ibm.com>

Introduce the DMA_ATTR_NO_WARN attribute, and document it.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>
---
 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 include/linux/dma-attrs.h        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf..841e771 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,20 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_NO_WARN
+----------------
+
+This tells the DMA-mapping subsystem to supress allocation failure reports
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
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index f3c5aea..0577389 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -19,6 +19,7 @@ enum dma_attr {
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
 	DMA_ATTR_ALLOC_SINGLE_PAGES,
+	DMA_ATTR_NO_WARN,
 	DMA_ATTR_MAX,
 };
 
-- 
1.8.3.1
