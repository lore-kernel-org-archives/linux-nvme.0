From: keith.busch@intel.com (Keith Busch)
Date: Wed, 23 Sep 2015 20:37:44 +0000 (UTC)
Subject: [PATCH] NVMe: Set affinity after allocating request queues
In-Reply-To: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
References: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1509232035500.23840@localhost.lm.intel.com>

On Thu, 3 Sep 2015, Keith Busch wrote:
> The asynchronous namespace scanning caused affinity hints to be set before
> its tagset initialized, so there was no cpu mask to set the hint. This
> patch moves the affinity hint setting to after namespaces are scanned.

Hi Jens,

Would it be okay to get this merged in for 4.3? The affinity hint is
very important to top out performance, so this should be considered a
bug that the setting wasn't correct.

Thanks,
Keith

> Reported-by: ??? <ks0204.kim at samsung.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> drivers/block/nvme-core.c |   36 +++++++++++++++++-------------------
> 1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b97fc3f..30758bd 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
