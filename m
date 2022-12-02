Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6ABC4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 01:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Rbgrk0pHR3XDRZi+UgmNvYoa8dmTefR/iVkPi32vR0=; b=TMzTyq3DkQZFldzSGz+IZA2L8Z
	EX6HRUWZtl19r6YCNSZoYkW45SE4juwk2q8fRF0S6tBWulwWsDXyWC9gktpxtpduSHCRRmR0AyDJk
	fyktsg+ZuBcEPAz24E1Z7UXSJcKCUjOMQJUfK8BW3hBC/rq08dBh1tHtWsSb/5n306hScjdp2nqEI
	/CtL5/22ya3jcMxdXdphJA7+Hm50IATmXxz009yydbO/Nzx5qjcGByUTVJIHZtA7nFjWj8ulwwd3X
	BiSFE6+9HcHQuWmkDz3A6n9+MWkULrCkcrBHcmslcrRVytKKXxrl02/iqWV4Gzv7pZig+urTSXSFu
	R2OXWEbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ukB-00CCfc-8I; Fri, 02 Dec 2022 01:21:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0uk8-00CCYG-1u
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 01:21:33 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNZrM2TqzzRpkT
	for <linux-nvme@lists.infradead.org>; Fri,  2 Dec 2022 09:20:35 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 09:21:17 +0800
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
To: <linux-nvme@lists.infradead.org>
References: <20221118232756.1457075-1-csander@purestorage.com>
 <20221124002432.3715594-1-csander@purestorage.com>
 <20221129083905.GA25314@lst.de>
 <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me>
 <20221130083514.GA15442@lst.de>
 <3ac2968f-c640-815c-a7cb-fd6a8fe0cffb@grimberg.me>
 <CADUfDZqT5z3XiRBoueP+==JB3qizBKQJ+o82qw50nydTL9RzEQ@mail.gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5e3e0a43-b318-5ca9-b22a-b62c7891bc96@huawei.com>
Date: Fri, 2 Dec 2022 09:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CADUfDZqT5z3XiRBoueP+==JB3qizBKQJ+o82qw50nydTL9RzEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_172132_292647_EBD3A046 
X-CRM114-Status: GOOD (  15.71  )
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



On 2022/12/2 5:17, Caleb Sander wrote:
> On Wed, Nov 30, 2022 at 12:40 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>>> I understand what you mean in general, but in this particular case
>>>> I don't understand what is not working.
>>>
>>> How does this work?
>>
>> Particularly, the sleeping contexts are guaranteed not to dereference
>> this NS after the two previous srcu synchronization steps so at this
>> point, the only protection of nvme_ns_remove is against this
>> non-sleepable traversal, which should be enough to protect with rcu.
> 
> Can you help me understand the safety here?
> The namespace will be dereferenced when traversing the siblings list,
> which is protected by SRCU.
> But nvme_ns_remove() only synchronizes with RCU between removing the namespace
> from the siblings list and freeing the namespace.
> So it seems like there's a race here:
> Thread A:                               Thread B:
> nvme_ns_remove() executes
> past the last synchronize_srcu()
>                                          nvme_ns_head_submit_bio()
>                                          calls srcu_read_lock(),
>                                          starts traversing siblings list,
>                                          holds pointer to ns
> Removes ns from siblings list
> Calls synchronize_rcu()
> (does not block for the SRCU reader)
del_gendisk will wait all requests to be completed, "use after free" will do not happen.
> nvme_put_ns() reaches 0 references,
> frees ns
>                                          Dereferences ns to continue traversal
>                                          => USE AFTER FREE
> 
> .
> 

