From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:41:24 +0200
Subject: [PATCH v6 01/10] scatterlist: add sg_zeroout_area() helper
In-Reply-To: <20170607094536.32419-2-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-2-jthumshirn@suse.de>
Message-ID: <20170608074124.GA13953@lst.de>

>  size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>  			  void *buf, size_t buflen, off_t skip);
>  
> +size_t sg_zeroout_area(struct scatterlist *sgl, unsigned int nents,
> +		       size_t buflen, off_t skip);

Maybe sg_zero_buffer to fit with the other functions in the family?

(I'd be happy to fix this up if you're ok and we don't need another
respin otherwise).

> +	while ((offset < buflen) && sg_miter_next(&miter)) {

Nit: no need for the inner braces.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
