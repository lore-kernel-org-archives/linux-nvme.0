From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Apr 2017 09:20:34 -0400
Subject: [PATCH] nvme-cli: return 0 if disconnect operation with cfg.nqn
 successfully
In-Reply-To: <20170418092024.18252-1-yizhan@redhat.com>
References: <20170418092024.18252-1-yizhan@redhat.com>
Message-ID: <20170418132033.GB16224@localhost.localdomain>

On Tue, Apr 18, 2017@05:20:24PM +0800, Yi Zhang wrote:
> disconnect_by_nqn function will return the number of controllers
> successfully disconnected, so change ret = 0 if disconnect operation
> with nqn successfully.

Thanks, applied.
