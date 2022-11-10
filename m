Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4369BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uYG6fBtOSCvrn/alPV4HUoHDZ8jPmjeCcG3iORISL14=; b=YNSuPepIFezuJJtSeRJ/m++4dp
	1iJpAZcatU7mFQBBkeXZqoa2v0JpIKuGGUUXAXLpR+CaS0uNSYp252Nq4CcO9y0t47g+e0u92FhBm
	f5URBqvOol1B1RIVYqUNHW8rTp0LF7297UBbV16LdbIBMjAWaUPOPDvJwr834bHsbqYsDvaSisBw4
	Sp+c7ramGYXBXJSzRc7tRcqZyWVAN2X1mD1u/ahdeEU2oZ4yhdc9XBmZ9ySXqJLUSuvb7oXh3PQRg
	ryF8ipQS2LX7vm0MyNsh9Zf/FEODIJzHtgJaKX77cH0B/K8cMoj92cxZSy3u0dMqQM7r6pJAnWMU5
	bchat5Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osvtb-001doH-Mb; Thu, 10 Nov 2022 00:58:19 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osvtY-001dmo-81
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 00:58:18 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N73K728lyzJnY1;
	Thu, 10 Nov 2022 08:55:07 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 08:58:08 +0800
Subject: Re: [PATCH 3/3] nvme: Convert NVMe errors to PT_STS errors
To: Mike Christie <michael.christie@oracle.com>, <kbusch@kernel.org>,
	<axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221109031106.201324-1-michael.christie@oracle.com>
 <20221109031106.201324-4-michael.christie@oracle.com>
 <9df9d0cf-5583-ccfd-ffd7-54432767fdfb@huawei.com>
 <cd524e32-d154-cd67-39b0-5f153a84125a@oracle.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6396da68-5c87-a36d-b013-2d2fe36a8d52@huawei.com>
Date: Thu, 10 Nov 2022 08:58:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <cd524e32-d154-cd67-39b0-5f153a84125a@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_165816_474418_0789198F 
X-CRM114-Status: GOOD (  12.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2022/11/10 1:35, Mike Christie wrote:
> On 11/9/22 2:28 AM, Chao Leng wrote:
>>
>>
>> On 2022/11/9 11:11, Mike Christie wrote:
>>> This converts the NVMe errors we could see during PR handling to PT_STS
>>> errors, so pr_ops callers can handle scsi and nvme errors without knowing
>>> the device types.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> ---
>>>    drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 40 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index dc4220600585..8f0177045a2f 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2104,11 +2104,43 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
>>>        return nvme_submit_sync_cmd(ns->queue, c, data, 16);
>>>    }
>>>    +static enum pr_status nvme_sc_to_pr_status(int nvme_sc)
>>> +{
>>> +    enum pr_status sts;
>>> +
>>> +    switch (nvme_sc) {
>>> +    case NVME_SC_SUCCESS:
>>> +        sts = PR_STS_SUCCESS;
>>> +        break;
>>> +    case NVME_SC_RESERVATION_CONFLICT:
>>> +        sts = PR_STS_RESERVATION_CONFLICT;
>>> +        break;
>>> +    case NVME_SC_HOST_PATH_ERROR:
>>> +        sts = PR_STS_PATH_FAILED;
>> All path-related errors should be considered.
> 
> Will do. Just one question.
> 
> I didn't see NVME_SC_CTRL_PATH_ERROR and NVME_SC_INTERNAL_PATH_ERROR
> being used. Are they retryable errors?
These two types of errors depend on the implementation of the target.
All in all, the request with path-related error should fail over to retry successfully.

