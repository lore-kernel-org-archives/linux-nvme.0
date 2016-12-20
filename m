From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 19 Dec 2016 22:21:58 -0800
Subject: [PATCH v3 3/5] fs: Wire up SED/Opal to ioctl
In-Reply-To: <1482176149-2257-4-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-4-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220062158.GD4765@infradead.org>

> @@ -853,6 +854,7 @@ struct file {
>  #ifdef CONFIG_SECURITY
>  	void			*f_security;
>  #endif
> +	struct sed_context      *f_sedctx;

Adding a new field to the global struct file for a block driver
feature is not acceptable.  And I don't really see why it would
be nessecary anyway.
