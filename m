From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Sep 2017 17:00:07 -0600
Subject: [PATCH 2/2] nvme: use device_add_disk_with_groups()
In-Reply-To: <20170928193637.24707-2-mwilck@suse.com>
References: <20170928193637.24707-1-mwilck@suse.com>
 <20170928193637.24707-2-mwilck@suse.com>
Message-ID: <20170929230006.GQ8463@localhost.localdomain>

On Thu, Sep 28, 2017@09:36:37PM +0200, Martin Wilck wrote:
> By using device_add_disk_with_groups(), we can avoid the race
> condition with udev rule processing, because no udev event will
> be triggered before all attributes are available.
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
