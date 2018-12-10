From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Dec 2018 12:32:56 -0800
Subject: [PATCH 07/12] nvmet: add error log support for file backend
In-Reply-To: <20181210055011.3146-8-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-8-chaitanya.kulkarni@wdc.com>
Message-ID: <b2bc67f7-0b75-40cd-ff74-3b4f3284be3b@grimberg.me>


> +	case -EILSEQ:
> +		req->error_loc = offsetof(struct nvme_rw_command, nsid);
> +		status = NVME_SC_INVALID_PI;

Same here...
