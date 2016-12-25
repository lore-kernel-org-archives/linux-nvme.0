From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 25 Dec 2016 15:15:52 +0100
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
Message-ID: <3d8b8516-aac6-c11c-dbbb-47fc01308f8c@jbeekman.nl>

On 19-12-16 20:35, Scott Bauer wrote:
> @@ -1796,6 +1797,13 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> +	result = nvme_opal_initialize(&dev->ctrl);
> +	if (result)
> +		goto out;

It seems you always try to intialize OPAL even if the drive doesn't support it.
I think you should check if the device supports security commands and then see
if it supports OPAL before calling this. See e.g.
https://lkml.org/lkml/2016/6/19/139 . Ideally, this code would check all
supported protocols and initialize the appropriate security device based on that.

Jethro
