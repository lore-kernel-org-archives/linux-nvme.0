From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 20:19:54 +0300
Subject: [PATCH V2] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170605114309.GA31824@dhcp-216.srv.tuxera.com>
References: <20170605114309.GA31824@dhcp-216.srv.tuxera.com>
Message-ID: <7a49d9eb-2a46-dc8f-7284-b71c843cce8e@grimberg.me>


> 
> V2: 1. Use cancel_work_sync instead of introducing new state (Sagi)
>      2. Skip using NVME_CTRL_SCHED_RESET state (Sagi)
> V1: nvme_probe set RESETTING state and check for NVME_CTRL_RESETTING
>      state in nvme_should_reset instead of work_busy (hch)

This type of information should come after the '---' separator
so git history won't keep it forever.

> Fixes: c5f6ce97c1210 ("nvme: don't schedule multiple resets")
> Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
> ---
Other than that,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
