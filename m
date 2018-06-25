From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Mon, 25 Jun 2018 11:01:26 -0400
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <21f7e774-0be6-f314-b531-b1772dff90fd@kernel.dk>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
 <20180624211520.GA16559@sbauer-Z170X-UD5>
 <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>
 <703993f1-31a2-c175-f4cb-541713fac14e@kernel.dk>
 <SD8jBn-I8XgsF2B_aXrAPtIvG5xW3rTqE9qLrv-XWe3856vgUkFTUIRKtp2JmJ3oYgOpbXvw1pKtQalOTloi1DfrWcQQJXi-AzRDh-o4VtQ=@protonmail.ch>
 <21f7e774-0be6-f314-b531-b1772dff90fd@kernel.dk>
Message-ID: <k1ZwR981KHzLzUi8iJfe4zRCcoiZuiVCtig8k-0EHM6cd54iqeDZmzKhnO4cGS73YL0bMaVb3zY4e1jazgdAcOshTcp4epJm1acjRonHfBo=@protonmail.ch>

On June 25, 2018 3:52 PM, Jens Axboe <axboe@kernel.dk> wrote:

> On 6/25/18 5:13 AM, Jordan Glover wrote:
> 
> > Above patch is breaking the build for me. I have :
> > 
> > CONFIG_DRM_I915_GVT=y
> > 
> > CONFIG_DRM_I915_GVT_KVMGT=m
> 
> Try this one, actually did a grep for users of it too...
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> 
> index 7014a96546f4..52f3b91d14fd 100644
> 
> --- a/drivers/gpu/drm/i915/i915_drv.h
> 
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> 
> @@ -2245,9 +2245,6 @@ static inline struct scatterlist *____sg_next(struct scatterlist *sg)
> 
> **/
> 
> static inline struct scatterlist *__sg_next(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> return sg_is_last(sg) ? NULL : ____sg_next(sg);
> 
> }
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> 
> index 51f52020ad5f..093aa57120b0 100644
> 
> --- a/include/linux/scatterlist.h
> 
> +++ b/include/linux/scatterlist.h
> 
> @@ -9,9 +9,6 @@
> 
> #include <asm/io.h>
> 
> struct scatterlist {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   unsigned long sg_magic;
>     
>     -#endif
>     
>     unsigned long page_link;
>     
>     unsigned int offset;
>     
>     unsigned int length;
>     
>     @@ -64,7 +61,6 @@ struct sg_table {
>     
> 
> -   
> 
> */
> 
> -#define SG_MAGIC 0x87654321
> 
> #define SG_CHAIN 0x01UL
> 
> #define SG_END 0x02UL
> 
> @@ -98,7 +94,6 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
> 
> */
> 
> BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
> 
> #ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
>     
>     BUG_ON(sg_is_chain(sg));
>     
>     #endif
>     
>     sg->page_link = page_link | (unsigned long) page;
>     
> 
> @@ -129,7 +124,6 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
> 
> static inline struct page *sg_page(struct scatterlist *sg)
> 
> {
> 
> #ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
>     
>     BUG_ON(sg_is_chain(sg));
>     
>     #endif
>     
>     return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
>     
> 
> @@ -195,9 +189,6 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
> 
> **/
> 
> static inline void sg_mark_end(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> /*
> 
> * Set termination bit, clear potential chain bit
> 
> */
> 
> @@ -215,9 +206,6 @@ static inline void sg_mark_end(struct scatterlist *sg)
> 
> **/
> 
> static inline void sg_unmark_end(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> sg->page_link &= ~SG_END;
> 
> }
> 
> @@ -260,12 +248,6 @@ static inline void *sg_virt(struct scatterlist *sg)
> 
> static inline void sg_init_marker(struct scatterlist *sgl,
> 
> unsigned int nents)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   unsigned int i;
> -   
> -   for (i = 0; i < nents; i++)
> -         sgl[i].sg_magic = SG_MAGIC;
>         
>     
> 
> -#endif
> 
> sg_mark_end(&sgl[nents - 1]);
> 
> }
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> 
> index 1642fd507a96..7c6096a71704 100644
> 
> --- a/lib/scatterlist.c
> 
> +++ b/lib/scatterlist.c
> 
> @@ -24,9 +24,6 @@
> 
> **/
> 
> struct scatterlist *sg_next(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> if (sg_is_last(sg))
> 
> return NULL;
> 
> @@ -111,10 +108,7 @@ struct scatterlist *sg_last(struct scatterlist *sgl, unsigned int nents)
> 
> for_each_sg(sgl, sg, nents, i)
> 
> ret = sg;
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sgl[0].sg_magic != SG_MAGIC);
>     
>     BUG_ON(!sg_is_last(ret));
>     
>     -#endif
>     
>     return ret;
>     
>     }
>     
>     EXPORT_SYMBOL(sg_last);
>     
>     diff --git a/tools/virtio/linux/scatterlist.h b/tools/virtio/linux/scatterlist.h
>     
>     index 9a45f90e2d08..369ee308b668 100644
>     
>     --- a/tools/virtio/linux/scatterlist.h
>     
>     +++ b/tools/virtio/linux/scatterlist.h
>     
>     @@ -36,7 +36,6 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>     
>     */
>     
>     BUG_ON((unsigned long) page & 0x03);
>     
>     #ifdef CONFIG_DEBUG_SG
>     
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
>     
>     BUG_ON(sg_is_chain(sg));
>     
>     #endif
>     
>     sg->page_link = page_link | (unsigned long) page;
>     
> 
> @@ -67,7 +66,6 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
> 
> static inline struct page *sg_page(struct scatterlist *sg)
> 
> {
> 
> #ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
>     
>     BUG_ON(sg_is_chain(sg));
>     
>     #endif
>     
>     return (struct page *)((sg)->page_link & ~0x3);
>     
> 
> @@ -116,9 +114,6 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
> 
> **/
> 
> static inline void sg_mark_end(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> /*
> 
> * Set termination bit, clear potential chain bit
> 
> */
> 
> @@ -136,17 +131,11 @@ static inline void sg_mark_end(struct scatterlist *sg)
> 
> **/
> 
> static inline void sg_unmark_end(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> sg->page_link &= ~0x02;
> 
> }
> 
> static inline struct scatterlist *sg_next(struct scatterlist *sg)
> 
> {
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   BUG_ON(sg->sg_magic != SG_MAGIC);
> 
> -#endif
> 
> if (sg_is_last(sg))
> 
> return NULL;
> 
> @@ -160,13 +149,6 @@ static inline struct scatterlist *sg_next(struct scatterlist *sg)
> 
> static inline void sg_init_table(struct scatterlist *sgl, unsigned int nents)
> 
> {
> 
> memset(sgl, 0, sizeof(*sgl) * nents);
> 
> -#ifdef CONFIG_DEBUG_SG
> 
> -   {
> -         unsigned int i;
>         
>     
> -         for (i = 0; i < nents; i++)
>         
>     
> -         	sgl[i].sg_magic = SG_MAGIC;
>         
>     
> -   }
>     
>     -#endif
>     
>     sg_mark_end(&sgl[nents - 1]);
>     
>     }
>     
>     --
>     
>     Jens Axboe
>

This one works and there is no warning on boot anymore. Thank you.

Jordan
