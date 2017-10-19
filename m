From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 17:29:10 +0200
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl
 setup/teardown symmetric
In-Reply-To: <1508324864-23087-2-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
Message-ID: <20171019152910.GA24808@lst.de>

On Wed, Oct 18, 2017@02:07:40PM +0300, Sagi Grimberg wrote:
> From: Roy Shterman <roys at lightbitslabs.com>
> 
> Its strange to have some of the cleanup for nvme_init_ctrl in
> nvme_free_ctrl. This cause us to have some magic ctrl refcount
> handling in controller initialization error paths.
> 
> Make the init/uninit symmetric so we can have a sane and
> maintainable error sequences.

This totally conflicts with my refcount / device rework in the
mpath patchset..
