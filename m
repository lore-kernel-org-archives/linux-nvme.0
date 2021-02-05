Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEEFC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 02:02:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953164F87
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 02:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953164F87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GhMrlN2iKe8vd8umketA7IjkD8I6xlTjn1bFxBjNofA=; b=yrcUw9MgBJD1NRADp86JTn/Ql
	bEP9cdHdTVYZLb8Ss4/0rgcv04sOgE9G7T2kmMvkbm74UM/NGlr3BSAB/QEmiWhsfvv5m1UcjOO+x
	dGVSAUqzQ0iRGacT/9JU6kkGbJI9VF4CL2SPlS1J24Tf9bUDRzZIJonHv8iUXmx0bVLzwTGW0+Isw
	5UH0IuGAfyNWwrHGzTgfhwhqpVCmZgld02YuxSWAipd5iDMc+ItlxzJ7XMK6WxgKVQpe09LN0xMvc
	Y9JXt4CwFkTCdwR4e0F1Yc67HSATzNmbGhVEaZy4eqiArWI7CKnxvyEVj/tQqXf7JVChKJfls+NPB
	dYVob/9QA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7qS3-0006Ym-H4; Fri, 05 Feb 2021 02:02:27 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7qRz-0006Y6-R9
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 02:02:26 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DWzD16hg1zY5t0;
 Fri,  5 Feb 2021 10:01:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 5 Feb 2021 10:02:17 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 5 Feb
 2021 10:02:17 +0800
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
To: Christoph Hellwig <hch@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210203161455.GB4116@lst.de>
 <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
 <20210204080442.GA30542@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <47992bb8-3f37-ac6a-1544-e2cd30caefae@huawei.com>
Date: Fri, 5 Feb 2021 10:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210204080442.GA30542@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_210224_185300_5A780237 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/4 16:04, Christoph Hellwig wrote:
> On Thu, Feb 04, 2021 at 01:56:34PM +0800, Chao Leng wrote:
>> This looks good to me.
>> Thank you very much.
> 
> Thanks a lot to you!
> 
> Please double check there version here:
> 
> http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.12
Looks good.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
