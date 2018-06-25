From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 24 Jun 2018 21:13:17 -0600
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
 <20180624211520.GA16559@sbauer-Z170X-UD5>
 <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>
Message-ID: <703993f1-31a2-c175-f4cb-541713fac14e@kernel.dk>

On 6/24/18 4:06 PM, Jordan Glover wrote:
> On June 24, 2018 11:15 PM, Scott Bauer <scott.bauer@intel.com> wrote:
> 
>> On Sun, Jun 24, 2018@04:37:35PM -0400, Jordan Glover wrote:
>>
>>> Hello,
>>>
>>> After update to Linux 4.18-rc2 I see the following warning at every boot.
>>>
>>> It doesn't occur on Linux 4.18-rc1.
>>>
>>> WARNING: CPU: 0 PID: 1 at drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
>>>
>>> Modules linked in:
>>
>> I suspect that you have CONFIG_DEBUG_SG and CONFIG_NEED_SG_DMA_LENGTH set, can you
>>
>> confirm for us please?
> 
> Yes, I have both of them enabled.

Ugh, CONFIG_NEED_SG_DMA_LENGTH was accounted for, but the debug was not.
Actually I think it's about time to remove it, I'm not aware of anything
interesting it's caught since I introduced it.

We can still retain the other checks, just getting rid of the magic.

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 51f52020ad5f..88544bf2359a 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -9,9 +9,6 @@
 #include <asm/io.h>
 
 struct scatterlist {
-#ifdef CONFIG_DEBUG_SG
-	unsigned long	sg_magic;
-#endif
 	unsigned long	page_link;
 	unsigned int	offset;
 	unsigned int	length;
@@ -98,7 +95,6 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 	 */
 	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
 #ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
 #endif
 	sg->page_link = page_link | (unsigned long) page;
@@ -129,7 +125,6 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 static inline struct page *sg_page(struct scatterlist *sg)
 {
 #ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
 	BUG_ON(sg_is_chain(sg));
 #endif
 	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
@@ -195,9 +190,6 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
  **/
 static inline void sg_mark_end(struct scatterlist *sg)
 {
-#ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
-#endif
 	/*
 	 * Set termination bit, clear potential chain bit
 	 */
@@ -215,9 +207,6 @@ static inline void sg_mark_end(struct scatterlist *sg)
  **/
 static inline void sg_unmark_end(struct scatterlist *sg)
 {
-#ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
-#endif
 	sg->page_link &= ~SG_END;
 }
 
@@ -260,12 +249,6 @@ static inline void *sg_virt(struct scatterlist *sg)
 static inline void sg_init_marker(struct scatterlist *sgl,
 				  unsigned int nents)
 {
-#ifdef CONFIG_DEBUG_SG
-	unsigned int i;
-
-	for (i = 0; i < nents; i++)
-		sgl[i].sg_magic = SG_MAGIC;
-#endif
 	sg_mark_end(&sgl[nents - 1]);
 }
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 1642fd507a96..7c6096a71704 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -24,9 +24,6 @@
  **/
 struct scatterlist *sg_next(struct scatterlist *sg)
 {
-#ifdef CONFIG_DEBUG_SG
-	BUG_ON(sg->sg_magic != SG_MAGIC);
-#endif
 	if (sg_is_last(sg))
 		return NULL;
 
@@ -111,10 +108,7 @@ struct scatterlist *sg_last(struct scatterlist *sgl, unsigned int nents)
 	for_each_sg(sgl, sg, nents, i)
 		ret = sg;
 
-#ifdef CONFIG_DEBUG_SG
-	BUG_ON(sgl[0].sg_magic != SG_MAGIC);
 	BUG_ON(!sg_is_last(ret));
-#endif
 	return ret;
 }
 EXPORT_SYMBOL(sg_last);

-- 
Jens Axboe


-- 
Jens Axboe
