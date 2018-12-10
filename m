From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Dec 2018 12:40:29 -0800
Subject: [PATCH 10/12] nvmet: add error log support for admin-cmd
In-Reply-To: <20181210055011.3146-11-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-11-chaitanya.kulkarni@wdc.com>
Message-ID: <64db4e65-9cd9-60ad-5b60-2209a5a09983@grimberg.me>


> @@ -380,6 +381,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>   	u16 status = 0;
>   
>   	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>   		status = NVME_SC_INVALID_NS | NVME_SC_DNR;

I'm wandering how we can guarantee that we don't forget to set
req->error_loc for all future errors...

Anyways..

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
