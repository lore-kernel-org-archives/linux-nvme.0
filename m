From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Mar 2018 14:00:55 -0600
Subject: [PATCH] nvme: enforce 64bit offset for nvme_get_log_ext fn
In-Reply-To: <20180327180033.28316-1-mb@lightnvm.io>
References: <20180327180033.28316-1-mb@lightnvm.io>
Message-ID: <20180327200054.GC30867@localhost.localdomain>

On Tue, Mar 27, 2018@08:00:33PM +0200, Matias Bj?rling wrote:
> Compiling on 32 bits system produces a warning for the shift width
> when shifting 32 bit integer with 64bit integer.
> 
> Make sure that offset always is 64bit, and use macros for retrieving
> lower and upper bits of the offset.

Thanks, applied to nvme.
