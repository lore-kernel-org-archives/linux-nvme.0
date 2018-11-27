From: james.smart@broadcom.com (James Smart)
Date: Tue, 27 Nov 2018 14:56:43 -0800
Subject: [PATCH] nvme-core: flush namespace scanning work just before
 removing namespaces
In-Reply-To: <20181121231737.6802-1-sagi@grimberg.me>
References: <20181121231737.6802-1-sagi@grimberg.me>
Message-ID: <f7e80598-d638-5a4d-154c-97820c431dc0@broadcom.com>


On 11/21/2018 3:17 PM, Sagi Grimberg wrote:
> nvme_stop_ctrl can be called also for reset flow and there is no need to
> flush the scan_work as namespaces are not being removed. This can cause
> deadlock in rdma, fc and loop drivers since nvme_stop_ctrl barriers
> before controller teardown (and specifically I/O cancellation of the
> scan_work itself) takes place, but the scan_work will be blocked anyways
> so there is no need to flush it.
>
> Instead, move scan_work flush to nvme_remove_namespaces() where it really
> needs to flush.
>
> Reported-by: Ming Lei <ming.lei at redhat.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> This is a stable candidate...
>
>   drivers/nvme/host/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
Looks good to me.

Reviewed by:? James Smart? <jsmart2021 at gmail.com>

-- james
