Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A0C47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 02:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EC46KIrzklGtmPx1vm3JpTftmOw1p4urknNLul0fKdc=; b=CtV5dAw2oKTIoL/zwX9aDEnoFb
	LLC0/onaVNn0Ty5vDJNhScxJRNCxTYty5M1VXA84toPyhdbYM84/AfR1NJummqoZcra1IsvJnbRFh
	Eho8Bu2koNWVvkTJyL6sQf4N3YC/mlmPjE8zyi4XhyQSYarcAY3DXq3jq526Ig0C8NLfcdz3mxPoS
	1C3rj7MHzT8U6m5LScnPRVhjm2Q4e8VBhY/ra+TjgjuFK9sKBEQ/dZ0j5Torpr170MhdTaIh/MzRA
	g7XMisXwgJt91/lnC/R24TvwHdhueiWJzzYKKb6CzD/s6t/ZWuHUjKVOXQt/zMttJ7wZlmKKS0lvy
	IePWE26Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVMQ4-00000006G5W-185A;
	Thu, 01 Feb 2024 02:03:12 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVMQ0-00000006G3z-3RQK
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 02:03:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706752984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EC46KIrzklGtmPx1vm3JpTftmOw1p4urknNLul0fKdc=;
	b=qeuWuzHNWIMYWFXkd+d1+ZAJI9HEi5i1HCrLgzAV9VZ6GeC/P9mFHwOK3NBaSP6qbHD+Gce+uaWt6ra9Togy4q1O0ufN/CqIUmU81mkACpMO51JReQrMDmePHkjp8Xs9SKwzD4y5ZqJqLMEeUTIQj1gc/xI5Y8qeJfp4CBDCHPM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.l5yIr_1706752982;
Received: from 30.178.83.62(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.l5yIr_1706752982)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 10:03:03 +0800
Message-ID: <e9f1780e-e785-4ed3-b1f1-22302253182b@linux.alibaba.com>
Date: Thu, 1 Feb 2024 10:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] *** nvme: add some commands tracing ***
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
 <f7eb8e6b-3833-4b68-812a-b533f7931b5c@nvidia.com>
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <f7eb8e6b-3833-4b68-812a-b533f7931b5c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_180309_405443_3F0FBE60 
X-CRM114-Status: GOOD (  11.74  )
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


在 2024/2/1 07:08, Chaitanya Kulkarni 写道:
> Guixin,
>
> On 1/31/24 01:12, Guixin Liu wrote:
>> Hi guys:
>>       I found that there are no reservation commands tracing and some
>> commands's parsing aren't fit the newest NVMe spec, and aren't readble.
>>
>> Changes from v1 to v2:
>> - Remove idr and idw parsing of dsm command.
>>
>> - Remove lbafl and lbafu variables and add a comment for the lbaf
>> calculation in nvme_trace_admin_format_nvm().
>>
>> Guixin Liu (3):
>>     nvme: add tracing of reservation commands
>>     nvme: parse dsm command's attr deallocate when tracing
>>     nvme: parse format command's lbafu when tracing
>>
>>    drivers/nvme/host/trace.c | 73 ++++++++++++++++++++++++++++++++++++---
>>    1 file changed, 69 insertions(+), 4 deletions(-)
>>
> One suggestion can you please not add *** in the subject line ? that
> is not a common practice on the mailing list.
>
> This series addresses the comments posted in the last version.
> Looks good, for the entire series :-
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck

Oh, Sorry, I dont notice that, just change the "SUBJECT HERE" of

cover-letter, I will pay attention of that.

Best regards,

Guixin Liu

>

