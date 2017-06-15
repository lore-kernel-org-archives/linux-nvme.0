From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 20:04:53 +0300
Subject: [PATCH 5/6] nvme: track subsystems
In-Reply-To: <20170615163502.10548-6-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-6-hch@lst.de>
Message-ID: <c6be6cd6-bb33-e3a7-484a-0070eff55949@grimberg.me>



On 15/06/17 19:35, Christoph Hellwig wrote:
> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs unless
> the involved subsystems support multiple controllers.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c    | 111 ++++++++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/fabrics.c |   4 +-
>   drivers/nvme/host/nvme.h    |  12 ++++-
>   3 files changed, 116 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 328da5d8c469..57e48d893173 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -68,6 +68,9 @@ MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if qu
>   struct workqueue_struct *nvme_wq;
>   EXPORT_SYMBOL_GPL(nvme_wq);
>   
> +static LIST_HEAD(nvme_subsystems);
> +static DEFINE_MUTEX(nvme_subsystems_lock);
> +
>   static LIST_HEAD(nvme_ctrl_list);
>   static DEFINE_SPINLOCK(dev_list_lock);
>   
> @@ -1633,13 +1636,14 @@ static bool quirk_matches(const struct nvme_id_ctrl *id,
>   		string_matches(id->fr, q->fr, sizeof(id->fr));
>   }
>   
> -static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ctrl,
> +		struct nvme_id_ctrl *id)
>   {
>   	size_t nqnlen;
>   
>   	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
>   	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> -		strcpy(ctrl->subnqn, id->subnqn);
> +		strcpy(subsys->subnqn, id->subnqn);
>   		return;
>   	}
>   
> @@ -1647,12 +1651,89 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
>   
>   	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
> -	snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
> +	snprintf(subsys->subnqn, NVMF_NQN_SIZE,
>   		"nqn.2014.08.org.nvmexpress:%4x%4x",
>   		le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
> -	memcpy(ctrl->subnqn + 35, id->sn, sizeof(id->sn));
> -	memcpy(ctrl->subnqn + 55, id->mn, sizeof(id->mn));
> -	memset(ctrl->subnqn + 95, 0, sizeof(ctrl->subnqn) - 95);
> +	memcpy(subsys->subnqn + 35, id->sn, sizeof(id->sn));
> +	memcpy(subsys->subnqn + 55, id->mn, sizeof(id->mn));
> +	memset(subsys->subnqn + 95, 0, sizeof(subsys->subnqn) - 95);
> +}
> +
> +static void nvme_destroy_subsystem(struct kref *ref)
> +{
> +	struct nvme_subsystem *subsys =
> +			container_of(ref, struct nvme_subsystem, ref);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_del(&subsys->entry);
> +	mutex_unlock(&nvme_subsystems_lock);
> +
> +	kfree(ref);
> +}
> +
> +static void nvme_put_subsystem(struct nvme_subsystem *subsys)
> +{
> +	kref_put(&subsys->ref, nvme_destroy_subsystem);
> +}
> +
> +static struct nvme_subsystem *__nvme_find_subsystem(const char *subsysnqn)

__nvme_find_get_subsystem?

> +{
> +	struct nvme_subsystem *subsys;
> +
> +	lockdep_assert_held(&nvme_subsystems_lock);
> +
> +	list_for_each_entry(subsys, &nvme_subsystems, entry) {
> +		if (strcmp(subsys->subnqn, subsysnqn))
> +			continue;
> +		if (!kref_get_unless_zero(&subsys->ref))
> +			continue;
> +		return subsys;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +{
> +	struct nvme_subsystem *subsys, *found;
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&subsys->ctrls);
> +	kref_init(&subsys->ref);
> +	nvme_init_subnqn(subsys, ctrl, id);
> +	mutex_init(&subsys->lock);

Nit: might be nicer to allocate the subsys only if its new (in the
else case) instead of freeing if you found a match. Maybe
nvme_init_subsysnqn should receive the subsysnqn buffer (on stack
here) which would be copied to the subsys->subnqn if new.

Just a suggestion.
