From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 22:46:52 -0800
Subject: [PATCH] scatterlist: Update size type to support greater then 4GB
 size.
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
Message-ID: <39a4f02c-d054-2651-2381-a8d86cdf3c13@grimberg.me>


>   struct nvme_sgl_desc {
>   	__le64	addr;
> -	__le32	length;
> +	__le64	length;
>   	__u8	rsvd[3];
>   	__u8	type;
>   };

in what world changing a wire protocol for this make sense?

please get rid of this hunk, NVMe will never cross the 32 bit sg element 
size.
