From: sbates@raithlin.com (Stephen  Bates)
Date: Mon, 7 Aug 2017 13:13:48 +0000
Subject: [PATCH v2 1/1] nvme: fix CMB sysfs file removal in reset path
In-Reply-To: <1501368308-20750-1-git-send-email-maxg@mellanox.com>
References: <1501368308-20750-1-git-send-email-maxg@mellanox.com>
Message-ID: <733D56EB-5028-4EBA-9057-011C50DE6C8D@raithlin.com>


> Currently we create the sysfs entry even if we fail mapping
> it. In that case, the unmapping will not remove the sysfs created
> file. There is no good reason to create a sysfs entry for a non
> working CMB and show his characteristics.
>
> Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")

Looks good.

Reviewed-by: Stephen Bates <sbates at raithlin.com>
