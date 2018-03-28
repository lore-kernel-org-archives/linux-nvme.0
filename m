From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Mar 2018 08:20:14 -0600
Subject: [PATCH] nvme: use upper_32_bits() instead of bit shift
In-Reply-To: <20180328135817.2419127-1-arnd@arndb.de>
References: <20180328135817.2419127-1-arnd@arndb.de>
Message-ID: <20180328142014.GB13039@localhost.localdomain>

On Wed, Mar 28, 2018@03:57:47PM +0200, Arnd Bergmann wrote:
> @@ -2233,8 +2233,8 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	c.get_log_page.lid = log_page;
>  	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
>  	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
> -	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
> -	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
> +	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
> +	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
>  
>  	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
>  }

Right, Matias posted the same fix here:

 http://lists.infradead.org/pipermail/linux-nvme/2018-March/016474.html

In addition to the type safe shifting, a 64-bit type was used to match
the spec.
