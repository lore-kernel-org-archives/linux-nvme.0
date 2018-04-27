From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Apr 2018 15:39:42 -0600
Subject: [PATCH] nvme-cli: Add ioctl retry support for connect-all
In-Reply-To: <20180427172901.3479-1-jsmart2021@gmail.com>
References: <20180427172901.3479-1-jsmart2021@gmail.com>
Message-ID: <20180427213942.GC5073@localhost.localdomain>

On Fri, Apr 27, 2018@10:29:01AM -0700, James Smart wrote:
>  /* Generic passthrough */
> -int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd);
> +int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd,
> +		int maxretry);

Hi James,

Since the far majority of the callers don't care for retries, let's
leave this API alone and create a new one that takes the retries. The
old API can call the new one with the default value of NO_RETRIES, and
that should simplify this patch significantly.

Thanks,
Keith
