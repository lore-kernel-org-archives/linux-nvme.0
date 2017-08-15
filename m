From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 15 Aug 2017 14:58:35 +0300
Subject: [PATCH] blk-mq: Fix queue usage on failed request allocation
In-Reply-To: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
References: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
Message-ID: <1810fc11-5199-977c-4505-eece5d2fa44d@mellanox.com>



On 8/14/2017 11:40 PM, Keith Busch wrote:
> blk_mq_get_request() does not release the callers queue usage counter
> when allocation fails. The caller still needs to account for its own
> queue usage when it is unable to allocate a request.
>
> Fixes: 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")
>
> Reported-by: Max Gurtovoy <maxg at mellanox.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

tested with 4.13-rc5+ using the following commands in a loop:

1. modprobe nvme
2. sleep 10
3. modprobe -r nvme

Looks good,

Tested-by: Max Gurtovoy <maxg at mellanox.com>
