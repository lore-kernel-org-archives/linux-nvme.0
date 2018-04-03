From: keith.busch@intel.com (Keith Busch)
Date: Tue, 3 Apr 2018 15:07:35 -0600
Subject: nvme_free_ns_head: ida_remove called for id=1 which is not
 allocated
In-Reply-To: <6fe0bfff-0ca3-a752-6faa-3d36796977e0@gmail.com>
References: <6fe0bfff-0ca3-a752-6faa-3d36796977e0@gmail.com>
Message-ID: <20180403210734.GC4485@localhost.localdomain>

On Tue, Apr 03, 2018@12:46:34PM -0500, Alex G. wrote:
> I noticed a new and interesting error. While it's ominous, it doesn't
> seem to cause any ill side-effects. This is reproduced with
> firmware-first error handling, so I'm not sure if it's even an issue of
> concern to nvme_core. Log files attached

Does this reproduce if you're not using CONFIG_NVME_MULTIPATH?
