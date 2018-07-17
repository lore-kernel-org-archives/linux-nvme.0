From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:12:39 +0200
Subject: [PATCH] nvme: register ns_id attributes as default sysfs groups
In-Reply-To: <20180716103721.96363-1-hare@suse.de>
References: <20180716103721.96363-1-hare@suse.de>
Message-ID: <20180717131239.GA13582@lst.de>

On Mon, Jul 16, 2018@12:37:21PM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attributes as default sysfs groups,
> otherwise we have a race condition between nvme_mpath_add_disk() and
> nvme_mpath_remove_disk() which will lead to a kobject warning during
> rapid connect/disconnect cycles.
> 
> Reported-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---

Didn't Martin Wilck habe a patch to pass the default attribute
group to an add_disk variant?  We've been waiting for him to just
clean it up a bit, and it would be a lot less ugly than opencoding
the device model details in the callers.
