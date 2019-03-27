From: sashal@kernel.org (Sasha Levin)
Date: Wed, 27 Mar 2019 12:16:58 -0400
Subject: [PATCH stable only] nvmet: set loop queue's segment boundary
 mask as PAGE_SIZE - 1
In-Reply-To: <20190327090230.12671-1-ming.lei@redhat.com>
References: <20190327090230.12671-1-ming.lei@redhat.com>
Message-ID: <20190327161658.GL25262@sasha-vm>

On Wed, Mar 27, 2019@05:02:30PM +0800, Ming Lei wrote:
>NVMe target only accepts single-page sg list, either file or block
>device backed target code follows this assumption.
>
>However, loop target is one exception, given the sg list is from
>the host queue directly.
>
>This patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
>for following NVMe target assumption.
>
>Reported-by: Yi Zhang <yi.zhang at redhat.com>
>Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
>Cc: Yi Zhang <yi.zhang at redhat.com>
>Cc: Sagi Grimberg <sagi at grimberg.me>
>Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>Cc: <stable at vger.kernel.org>
>Signed-off-by: Ming Lei <ming.lei at redhat.com>

Could you provide some background as to why this is -stable only in the
commit message?

--
Thanks,
Sasha
