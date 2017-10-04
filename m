From: keith.busch@intel.com (Keith Busch)
Date: Wed, 4 Oct 2017 14:04:00 -0600
Subject: [PATCH V4 1/2] nvme: add SGL controller capability constant
In-Reply-To: <1507058666-15298-2-git-send-email-ckulkarnilinux@gmail.com>
References: <1507058666-15298-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507058666-15298-2-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <20171004200359.GA2384@localhost.localdomain>

On Tue, Oct 03, 2017@12:24:25PM -0700, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 9310ce77..22bbcfb 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -466,6 +466,8 @@ enum nvme_opcode {
>  	nvme_cmd_resv_release	= 0x15,
>  };
>  
> +#define NVME_CTRL_SUPP_SGL     0x1
> +

I don't think this needs to be its own patch.

This should be in enum along with all the other NVME_CTRL_* identify
controller constants.

SGLs would also be supported if the value is 2 as well, right?
