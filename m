From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Mon, 25 Jun 2018 07:13:26 -0400
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <703993f1-31a2-c175-f4cb-541713fac14e@kernel.dk>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
 <20180624211520.GA16559@sbauer-Z170X-UD5>
 <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>
 <703993f1-31a2-c175-f4cb-541713fac14e@kernel.dk>
Message-ID: <SD8jBn-I8XgsF2B_aXrAPtIvG5xW3rTqE9qLrv-XWe3856vgUkFTUIRKtp2JmJ3oYgOpbXvw1pKtQalOTloi1DfrWcQQJXi-AzRDh-o4VtQ=@protonmail.ch>

On June 25, 2018 5:13 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> Ugh, CONFIG_NEED_SG_DMA_LENGTH was accounted for, but the debug was not.
> 
> Actually I think it's about time to remove it, I'm not aware of anything
> 
> interesting it's caught since I introduced it.
> 
> We can still retain the other checks, just getting rid of the magic.
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> 
> index 51f52020ad5f..88544bf2359a 100644
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
>     @@ -98,7 +95,6 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>     
>     */
>     
>     BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
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
> @@ -129,7 +125,6 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
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
> @@ -195,9 +190,6 @@ static inline void sg_chain(struct scatterlist *prv, unsigned int prv_nents,
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
> @@ -215,9 +207,6 @@ static inline void sg_mark_end(struct scatterlist *sg)
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
> @@ -260,12 +249,6 @@ static inline void *sg_virt(struct scatterlist *sg)
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
>     --
>     
>     Jens Axboe

Above patch is breaking the build for me. I have :
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

---------------------------------------------------------------
In file included from ./include/linux/init.h:5,
                 from drivers/gpu/drm/i915/gvt/kvmgt.c:31:
drivers/gpu/drm/i915/i915_drv.h: In function ?__sg_next?:
drivers/gpu/drm/i915/i915_drv.h:2249:11: error: ?struct scatterlist? has no member named ?sg_magic?
  BUG_ON(sg->sg_magic != SG_MAGIC);
           ^~
./include/linux/compiler.h:77:42: note: in definition of macro ?unlikely?
 # define unlikely(x) __builtin_expect(!!(x), 0)
                                          ^
drivers/gpu/drm/i915/i915_drv.h:2249:2: note: in expansion of macro ?BUG_ON?
  BUG_ON(sg->sg_magic != SG_MAGIC);
  ^~~~~~
make[4]: *** [scripts/Makefile.build:324: drivers/gpu/drm/i915/gvt/kvmgt.o] Error 1
make[3]: *** [scripts/Makefile.build:558: drivers/gpu/drm/i915] Error 2
make[2]: *** [scripts/Makefile.build:558: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:558: drivers/gpu] Error 2
make[1]: *** Waiting for unfinished jobs....
---------------------------------------------------------------

Jordan
