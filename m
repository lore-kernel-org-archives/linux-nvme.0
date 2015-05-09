From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 9 May 2015 09:00:07 -0700
Subject: [PATCH v3 1/7] bio: Introduce LightNVM payload
In-Reply-To: <1429712816-10336-2-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
 <1429712816-10336-2-git-send-email-m@bjorling.me>
Message-ID: <20150509160007.GA16058@infradead.org>

On Wed, Apr 22, 2015@04:26:50PM +0200, Matias Bj??rling wrote:
> LightNVM integrates on both sides of the block layer. The lower layer
> implements mapping of logical to physical addressing, while the layer
> above can string together multiple LightNVM devices and expose them as a
> single block device.
> 
> Having multiple devices underneath requires a way to resolve where the
> IO came from when submitted through the block layer. Extending bio with
> a LightNVM payload solves this problem.
> 
> Signed-off-by: Matias Bj??rling <m at bjorling.me>
> ---
>  include/linux/bio.h       | 9 +++++++++
>  include/linux/blk_types.h | 4 +++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index da3a127..4e31a1c 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -354,6 +354,15 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
>  
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +#if defined(CONFIG_NVM)
> +
> +/* bio open-channel ssd payload */
> +struct bio_nvm_payload {
> +	void *private;
> +};

Can you explain why this needs to be done on a per-bio instead of a
per-request level?  I don't really think a low-level driver should add
fields to struct bio as that can be easily remapped.

On the other hand in th request you can already (ab)use the ->cmd and
related fields for your own purposes.
