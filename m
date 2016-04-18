From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 18 Apr 2016 21:46:32 +0300
Subject: [PATCH 4/5] nvme: move namespace scanning to core
In-Reply-To: <1460982893-11315-5-git-send-email-hch@lst.de>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-5-git-send-email-hch@lst.de>
Message-ID: <57152B88.1080403@grimberg.me>


> @@ -1549,13 +1554,26 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
>   		if (!nvme_scan_ns_list(ctrl, nn))
>   			goto done;
>   	}
> -	__nvme_scan_namespaces(ctrl, le32_to_cpup(&id->nn));
> +	nvme_scan_ns_sequential(ctrl, nn);
>    done:
>   	list_sort(NULL, &ctrl->namespaces, ns_cmp);
>   	mutex_unlock(&ctrl->namespaces_mutex);
>   	kfree(id);
> +
> +	if (ctrl->ops->finish_scan)
> +		ctrl->ops->finish_scan(ctrl);

finish_scan suggest this is a ns-scan related activity, but
that does not seem to be the case (pci just sets affinity
hints). Why does the affinity hints setting needs to happen
after the ns scan?

Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi at rimberg.me>
