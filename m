Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:51:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B62B239A1
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B62B239A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DpTm3WUCXer11/dvkHkMGdD8+jFSGyqOKLiDxRlJvwc=; b=koZzApHA8Ya9XqEsbg3YsMVua
	ZU73JzkHezZBPo8rb3lu7+nEAUR3WWTnNiPMzhRfmfzHc/8H1Wj1gRXXhOzOgOMWvpqIZQ4mxjM6y
	s62R5omsNjEnFqu7ztVBb98s/NlcjPGYOO9EXvRjgQ0TTWPnD3q0P4AYFs6vUmpDZF7iqmRqeMvx0
	scyG8Rl8jcFDordZdhIl7Hse9SeQrt50G1sxjJen73/SfoY7z9K9iw3qgDWj2wtL5DqcJvaIBC62K
	jbEsAFO/YWGJp8JB6hTvRXL0BVDAJCU0IPgcCe5GhULfDx8V42dubSmcGA0q+cWMrIIbxAjN6GbTP
	w7GnmyPnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwT1-0007xV-M5; Thu, 14 Jan 2021 06:50:47 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwSx-0007vT-O5
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 06:50:44 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DGZg9565kzQsZj;
 Thu, 14 Jan 2021 14:49:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:50:37 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:50:36 +0800
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_set_request_complete
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-2-lengchao@huawei.com>
 <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5868f270-9fda-be39-808d-929e270f52dc@huawei.com>
Date: Thu, 14 Jan 2021 14:50:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_015044_111239_956AC827 
X-CRM114-Status: GOOD (  10.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/14 8:17, Sagi Grimberg wrote:
> 
>> In some scenarios, nvme need setting the state of request to
>> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
>> For details, see the subsequent patches.
> 
> Its kinda difficult to understand the meaning of all of this...
> the cover letter tells us nothing, and patches 1/2 also tells us
> to see subsequent patches.
> 
> This is saved in the git change log history, so please try
> describe what it is you are going with this, even if there are
> overlaps between patches.
ok, thanks for your suggest.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
