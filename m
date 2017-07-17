From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 17 Jul 2017 09:13:41 +0800
Subject: [PATCH 4/4] libmultipath: fix over-long NVME WWIDs
In-Reply-To: <20170714113209.17177-5-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-5-mwilck@suse.com>
Message-ID: <f82ac570-4d40-0c69-5c98-7eb2d8c9c875@huawei.com>

Hi, Martin:

On 2017/7/14 19:32, Martin Wilck wrote:
> Fix for NVME wwids looking like this:
> nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002

I think the above line is too long and  it's better to split it into two lines.
Otherwise , this patch looks good for me.

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

> which are encountered in some combinations of Linux NVME host and target,
> where the 2nd field represents the serial number (SN) and the 3rd the
> model number (MN).
