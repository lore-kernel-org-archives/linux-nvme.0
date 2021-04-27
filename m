Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE83C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783D61027
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783D61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=snZ1bBvSviuD9+BTAMyJQ7zHv+7tzMfXLM6GpTHpsAA=; b=mQcIbGcwR3PxL+jLNDEiTtML+
	g/I1TMGqV4RZ5H0RCGs9Zqbh/lKvz4C37+9isKz/JthWxFy7+kxL0z+B6v6T3TyJkBQ3xqcfykb3X
	ECu6NjH3R7f7z0pcMCfwCNoH1ZMccak9mitQWEyvzVzuazsoJTxJB7jBNjlm3lcQ7faYQqOEwGv4A
	uqU277zvpUQqPanfYPJ9icPim82xDqfOyIMD5SYf1z9wNE+li3kEivVKeIaT2ePCEwQL80399YlzJ
	7jNL30UXGf/QRrL2CyZ93lPEOKtezNBiz3zqeS1SMDyj92ZtMz+GcHB7MgCp4F9lMAdDJGbdSJZcZ
	ziDb63aBw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbCnq-000Pfp-0B; Tue, 27 Apr 2021 01:46:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbCnR-000PeK-AN
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 01:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UHFaNfEZk7/TrFdJIS2aL3UIml8PkhgKNDu7d0w2T5c=; b=iMuCBhRe6Sztpgqv0aFkmqnTnF
 SreRmCUSouqq7TBzqnxRTdrMpDhenl944LY1vDe16sj322pBl3e6aiodAZdUxmckwEU47bEZHl+41
 URwBhzsLDJ69Jmp7s2gM5INS+BmY53YiRf3aEO8nMRgVy+kXhIvJk/p1TzA17QYoqXu6uUj1vguqd
 1yuRL3xU+Rvh0eaFM1npO9MGiHBH2Qhp71WExVUs30VANLhRJFRqJzmNvcEjpKdS6TMFHk5jqNe4B
 ppCbnPfZ+2oqAPp4U9VVQAheoFruJTnyhJNQbevIIc8GVo4egllGnRT/RxGHTnuX4CczFFiOBow0G
 og+DGFFg==;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbCnO-00GNBq-BI
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 01:45:51 +0000
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FTl001xDPz5vr6;
 Tue, 27 Apr 2021 09:43:12 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 09:45:39 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 27
 Apr 2021 09:45:38 +0800
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
To: Martin Wilck <mwilck@suse.com>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, "Daniel
 Wagner" <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
 <20210426145105.GA22120@lst.de>
 <2df7213105b42f08fdb021e084f277bb881fb230.camel@suse.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <8b5c6deb-82d1-8803-48db-d104264e17dc@huawei.com>
Date: Tue, 27 Apr 2021 09:45:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2df7213105b42f08fdb021e084f277bb881fb230.camel@suse.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_184550_593174_8EF6B08A 
X-CRM114-Status: GOOD (  11.96  )
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/4/27 0:27, Martin Wilck wrote:
> On Mon, 2021-04-26 at 16:51 +0200, Christoph Hellwig wrote:
>> On Fri, Apr 23, 2021 at 05:21:03PM -0700, Sagi Grimberg wrote:
>>>
>>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>>> index be905d4fdb47..fc07a7b0dc1d 100644
>>>> --- a/drivers/nvme/host/rdma.c
>>>> +++ b/drivers/nvme/host/rdma.c
>>>> @@ -1202,6 +1202,7 @@ static void
>>>> nvme_rdma_error_recovery_work(struct work_struct *work)
>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
>>>>  =A0=A0=A0=A0=A0=A0=A0=A0}
>>>>  =A0 +=A0=A0=A0=A0=A0nvme_mpath_stop(&ctrl->ctrl);
>>>>  =A0=A0=A0=A0=A0=A0=A0=A0nvme_rdma_reconnect_or_remove(ctrl);
>>>
>>> Its pretty annoying to have to needlessly wait for the ana log page
>>> request to timeout... But this is also needed because we init
>>> ana_lock
>>> in nvme_mpath_init while it can be potentially taken in ana_work,
>>> which
>>> is a precipice for bad things...
>>
>> I also really hate open coding this mpath detail in the transport
>> drivers.=A0 Didn't you at some point have a series to factor out more
>> common code from the whole reset and reconnect path?
>>
> =

> So ... resubmit and cc stable as Sagi suggested, or work out something
> else?
Another option:call nvme_mpath_stop in nvme_mpath_init.
In this way, transport drivers do not care mpath detail.
> =

> Martin
> =

> =

> .
> =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
