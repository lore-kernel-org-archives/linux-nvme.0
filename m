From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 13:16:02 +0200
Subject: [PATCH 2/9] nvme: fix the deadlock in nvme_update_formats
In-Reply-To: <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>

>   	mutex_lock(&ctrl->namespaces_mutex);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		if (ns->disk && nvme_revalidate_disk(ns->disk))
> -			nvme_ns_remove(ns);
> +		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
> +			list_del_init(&ns->list);
> +			list_add_tail(&ns->list, &rm_list);

list_move_tail?
