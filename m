From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 May 2017 15:42:14 -0600
Subject: [RFC PATCH 03/16] kfifo: Cleanup example to not use page_link
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Message-ID: <1495662147-18277-4-git-send-email-logang@deltatee.com>

This is a layering violation so we replace the uses with calls to
sg_page(). This is a prep patch for replacing page_link and this
is one of the very few uses outside of scatterlist.h.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 samples/kfifo/dma-example.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
index aa243db..be0d4a5 100644
--- a/samples/kfifo/dma-example.c
+++ b/samples/kfifo/dma-example.c
@@ -75,8 +75,8 @@ static int __init example_init(void)
 	for (i = 0; i < nents; i++) {
 		printk(KERN_INFO
 		"sg[%d] -> "
-		"page_link 0x%.8lx offset 0x%.8x length 0x%.8x\n",
-			i, sg[i].page_link, sg[i].offset, sg[i].length);
+		"page %p offset 0x%.8x length 0x%.8x\n",
+			i, sg_page(&sg[i]), sg[i].offset, sg[i].length);
 
 		if (sg_is_last(&sg[i]))
 			break;
@@ -104,8 +104,8 @@ static int __init example_init(void)
 	for (i = 0; i < nents; i++) {
 		printk(KERN_INFO
 		"sg[%d] -> "
-		"page_link 0x%.8lx offset 0x%.8x length 0x%.8x\n",
-			i, sg[i].page_link, sg[i].offset, sg[i].length);
+		"page %p offset 0x%.8x length 0x%.8x\n",
+			i, sg_page(&sg[i]), sg[i].offset, sg[i].length);
 
 		if (sg_is_last(&sg[i]))
 			break;
-- 
2.1.4
