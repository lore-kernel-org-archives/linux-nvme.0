From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 09:45:31 -0600
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
In-Reply-To: <20180619152859.3686-1-revanth.rajashekar@intel.com>
References: <20180619152859.3686-1-revanth.rajashekar@intel.com>
Message-ID: <20180619154531.GC19922@localhost.localdomain>

On Tue, Jun 19, 2018@09:28:59AM -0600, Revanth Rajashekar wrote:
> +int nvme_ctrl(int fd, __u32 cdw10, void *data)
> +{
> +	struct nvme_admin_cmd cmd = {
> +		.opcode 	= nvme_admin_virtual_mgmt,

A pitfall from not having a capable device to test with: I'm sure you
don't possibly mean to use the nvme_admin_virtual_mgmt opcode here.

Just use nvme_identify().
