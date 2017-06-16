From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 11:45:47 +0200
Subject: [PATCH v5 for-4.13 2/7] mlx5e: don't assume anything on the
 irq affinity mappings of the device
In-Reply-To: <1497533594-11579-3-git-send-email-sagi@grimberg.me>
References: <1497533594-11579-1-git-send-email-sagi@grimberg.me>
 <1497533594-11579-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170616094547.GA12547@lst.de>

On Thu, Jun 15, 2017@04:33:09PM +0300, Sagi Grimberg wrote:
> mlx5e currently assumes that irq affinity is really spread first
> irq vectors across device home node cpus, with the new generic affinity
> mappings this is no longer the case, hence mlxe should not rely on
> this anymore.

Looks fine, but the explanation sounds a bit short - only spreading
the vectors of the single node sounds rather odd, so there needs to
be an explanation of why this was done before and isn't valid anymore.
