From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 4 Jan 2018 12:01:54 +0800
Subject: [PATCH] nvme: check ctrl.tagset before start ns scan
In-Reply-To: <ef7f1b69-c042-60f7-6bd3-6dd4c4d73b90@grimberg.me>
References: <1514916461-8696-1-git-send-email-jianchao.w.wang@oracle.com>
 <ef7f1b69-c042-60f7-6bd3-6dd4c4d73b90@grimberg.me>
Message-ID: <a5b2d8a9-5241-28a3-5f8d-6a9ba0e6ac7d@oracle.com>

Hi sagi

Many thanks for your kindly response.

On 01/03/2018 05:37 PM, Sagi Grimberg wrote:
> Hi Jianchao,
> 
>> ctrl.tagset maybe NULL due to failure of io queue setup or blk-mq
>> tagset allocation in nvme_reset_work. Then panic would come up.
>> To fix this, just add ctrl.tagset check in nvme_scan_work.
> 
> This came up before (and forgotten...) I think we should not
> have state indicators other than ctrl->state.
> 
> How about instead we add a new state NVME_CTRL_ADMIN_LIVE when we have
> no I/O queues.
> 
Yes, that's a good idea that add a new state NMVE_CTRL_ADMIN_LIVE to indicate
only the admin queue live. On the other hand, add a sanity checking that whether
ctrl->tagset is NULL is also necessary. :)

Thanks
Jianchao
