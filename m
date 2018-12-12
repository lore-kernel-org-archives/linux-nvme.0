From: davem@davemloft.net (David Miller)
Date: Tue, 11 Dec 2018 22:29:50 -0800 (PST)
Subject: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Message-ID: <20181211.222950.1995970751331458343.davem@davemloft.net>

From: Ashish Mhetre <amhetre@nvidia.com>
Date: Wed, 12 Dec 2018 11:54:13 +0530

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 68e91ef..0a07a29 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -587,7 +587,7 @@ enum {
>  
>  struct nvme_sgl_desc {
>  	__le64	addr;
> -	__le32	length;
> +	__le64	length;
>  	__u8	rsvd[3];
>  	__u8	type;
>  };

Isn't this a device or protocol defined datastructure?  You can't just
change it like this.
