From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 13:15:47 +0200
Subject: [PATCH 1/9] nvme: fix the dangerous reference of namespaces list
In-Reply-To: <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <c57de825-102e-527d-ab7e-4b2c1120c514@grimberg.me>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e810487..bc05bc4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3092,11 +3092,20 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					unsigned nsid)
>   {
>   	struct nvme_ns *ns, *next;
> +	LIST_HEAD(rm_list);
>   
> +	mutex_lock(&ctrl->namespaces_mutex);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			nvme_ns_remove(ns);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_init(&ns->list);
> +			list_add_tail(&ns->list, &rm_list);

list_move_tail?
