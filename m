From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Jul 2017 17:56:30 +0200
Subject: [PATCH 1/1] nvme: fix CMB sysfs file removal in reset path
In-Reply-To: <1500991116-8227-1-git-send-email-maxg@mellanox.com>
References: <1500991116-8227-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170725155630.GA25693@lst.de>

On Tue, Jul 25, 2017@04:58:36PM +0300, Max Gurtovoy wrote:
> Currently we create the sysfs entry even if we fail mapping
> it. In that case, the unmapping will not remove the sysfs created
> file.
> 
> Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")

This looks correct, but I wonder if the better plan would be to only
add the sysfs file if we have a working CMB?

Also the comment about the auto-removal above the call to
sysfs_add_file_to_group for dev_attr_cmb looks wrong to me, that
might be worth fixing up as well.
