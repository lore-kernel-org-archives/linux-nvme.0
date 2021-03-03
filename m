Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:13:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A97F64E4A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A97F64E4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WG/Bsu2mebzO37UsanlWbsbDrNADuRgEHn1Wgy3gNS0=; b=Gymo4KQ4KIZHh3wfV+R2EpKTC
	SQNnz6wJ5fjwtO9y5icDokSO8C4A/1jCVW12kMOf/XRPm5J/eXNOxJ2oH7phTrEvDf9ZtjY+sZzTu
	6+z6A8ZUn2XgagnzSSRYUp5ccVx/TnjpFfpN+LvX2RUQQ2Zrx8s+Xpl7+kRorRkyOliDGH7qVuc9P
	MrNnQbdpTKPkyeTeVX9eWc1DVIQ1MKD7pfLxCuMLfEJqq/tKSPkwl7fgG/E1rK5gaWymdeFUXGEDY
	qd+0/9XiVbOEgZ7+8AZ9zbIFf69EujSvP19RofV6LRrr62nzl931nmtx/RZXdn27AaIGty7n40J6w
	qpAAh1ymQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHSFa-0055N9-5w; Wed, 03 Mar 2021 14:13:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHS5r-0052N8-7T
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=QWHlX+/Njb2Bp4emcCkPzkm+ElQ+MtiXq0JzK3DeTvI=; b=PHOej8j9kfYP0dVBZ38yGm2337
 NlE86JGDsjJOi6LSP9zN70sk5xIS77vqqu01RAw9LnZSGFo16nyy0z/l+xBfEXUgO1ZGbO+4FTbwV
 YWhXqDQaim9j6TaUQIeYw0IKdGhpzyCXdzSmbs9i0EyqyBeXbYCRSg3eYamhqfd0+D9oFc23agQjU
 k26ypIuwze6Rf5D4WU7EpHFX7X9p3sYYgKb0zgFbjplSVd26Il7msJzg0XvBvyl8VYJNoKwDOA9vg
 lRxiKsCpjJuTeiVuutakZS2UI1na+CYCgP48KlQUuTc3VwE2Q/YXfRR/dAUOMfmv/NlA/M7axnvQK
 aSfCq+Cw==;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHIMM-0018yB-Jq
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 03:39:41 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dr07g1mDnzYFSX;
 Wed,  3 Mar 2021 11:37:51 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 3 Mar 2021 11:39:12 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 3 Mar
 2021 11:39:11 +0800
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: Keith Busch <kbusch@kernel.org>
CC: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
 <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
 <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
 <20210303031416.GD22346@redsun51.ssa.fujisawa.hgst.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <1fc0b92d-0726-9309-42ce-3e64858cd3aa@huawei.com>
Date: Wed, 3 Mar 2021 11:39:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210303031416.GD22346@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_033941_730064_3F38DC73 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/3/3 11:14, Keith Busch wrote:
> On Wed, Mar 03, 2021 at 10:27:01AM +0800, Chao Leng wrote:
>> On 2021/3/3 2:24, Keith Busch wrote:
>>> We can continue to administrate a controller that didn't create IO
>>> queues, but the controller must provide a response to all commands. If
>>> it doesn't, the controller will either be reset or abandoned. This
>>> should be the same behavior for any transport, though; there's nothing
>>> special about PCIe for that.
>> Though I don't see any useful scenarios for nvme over fabric now,
>> Reserved for future possibilities may be a better choice.
> 
> The admin queue may be the only way for a user to retrieve useful
> information on the malfunctioning controller. The telemetry log isn't
> unique to PCIe.
User can also directly visit target to get these information for
nvme over fabrics.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
