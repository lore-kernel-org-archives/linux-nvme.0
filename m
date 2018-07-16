From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 14:00:50 +0300
Subject: [PATCH] nvme: register ns_id attributes as default sysfs groups
In-Reply-To: <20180716103721.96363-1-hare@suse.de>
References: <20180716103721.96363-1-hare@suse.de>
Message-ID: <9f683d12-f52d-2b0e-07d1-892b634784ad@grimberg.me>


> We should be registering the ns_id attributes as default sysfs groups,
> otherwise we have a race condition between nvme_mpath_add_disk() and
> nvme_mpath_remove_disk() which will lead to a kobject warning during
> rapid connect/disconnect cycles.

Looks good to me,

Reviewed-by: Sagi Grimberg <sagi at rimberg.me>
