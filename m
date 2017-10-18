From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Oct 2017 09:08:59 -0600
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <1508324864-23087-2-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
Message-ID: <20171018150859.GD32530@localhost.localdomain>

On Wed, Oct 18, 2017@02:07:40PM +0300, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> Its strange to have some of the cleanup for nvme_init_ctrl in
> nvme_free_ctrl. This cause us to have some magic ctrl refcount
> handling in controller initialization error paths.
> 
> Make the init/uninit symmetric so we can have a sane and
> maintainable error sequences.

It's not magic. It's just preventing name reuse when some management
code retains an open handle after the device was removed. Otherwise
you're going to get naming clashes when you bring up a new device with
the same name from reusing the still in-use instance.
