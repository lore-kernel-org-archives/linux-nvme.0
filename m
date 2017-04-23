From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 20:43:53 +0300
Subject: [PATCH 3/3] nvme_fc: add controller reset support
In-Reply-To: <20170423153008.22795-4-jsmart2021@gmail.com>
References: <20170423153008.22795-1-jsmart2021@gmail.com>
 <20170423153008.22795-4-jsmart2021@gmail.com>
Message-ID: <ef1354c7-d1df-a90f-e67f-063159c5959a@grimberg.me>


> +
> +	ctrl->ctrl.sqsize =
> +		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);

This will conflict with 4.11 fixes...
