From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 09 May 2018 15:03:18 -0400
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-6-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
Message-ID: <1525892598.30724.276.camel@localhost.localdomain>

On Fri, 2018-05-04@13:28 +0200, Hannes Reinecke wrote:
> Add ANA support to the nvme host. If ANA is supported the state
> and the group id are displayed in new sysfs attributes 'ana_state' and
> 'ana_group'.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c      | 123 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/multipath.c |  12 ++++-
>  drivers/nvme/host/nvme.h      |   3 ++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
...
> +static void nvme_ana_change_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work,
> +				struct nvme_ctrl, ana_change_work);
> +
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return;
> +
> +	down_read(&ctrl->namespaces_rwsem);
> +	nvme_get_full_ana_log(ctrl);
> +	up_read(&ctrl->namespaces_rwsem);
> +}
> +

Do we really want to be holding the semaphore while performing the
command to get the log page, particularly in a fabric environment?
Or would it be sufficient to hold it after the log page is fetched
and we are iterating over the ctrl->namespaces list in
nvme_get_full_ana_log()?

(BTW, nvme_get_full_ana_log() has the same issue w/error returned
from nvme_get_log() as nvme_get_ana_log()).

-Ewan
