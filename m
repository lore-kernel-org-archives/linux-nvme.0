Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD2C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065DB60249
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 07:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065DB60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1zEfWU1am+y5hjr6D4CjNI5TY7ir91/0O9fAfRW1pw=; b=P9reJ0h+NoOQmSFRPcqaAR/PiJ
	zr/gSef0LejBgbOfoZquprjYtmCIyh0gV4GZSe5cTK4BwnQkLwgMftT03DchxTYwgVEI0vnXeArCR
	69qvklgU2fCcoW0q56vwJr4hKFCPZeeqnO1DV7fEE5nTkzrma/GuAnW2cApL+MJpo4D1GOS09PfCq
	6PZaz3EDBaRBt725stZWP/ut+6G0a9MFB/O7dHz5cfYir5B6Q9iBmH0wb2y6ije5J1IUziHpjF/2s
	/waMdeX10Gtg/Yr/HIjgvCi9v8Jx2XBdQnEMj18rNBGasrV+xmiQArBqU9/FkAJ/tCQFMu55y4TBn
	KRKBlnVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6TRq-000aOM-CF; Thu, 22 Jul 2021 07:48:50 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6TRm-000aMr-T4
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 07:48:48 +0000
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVkhy5rnBz6D94x;
 Thu, 22 Jul 2021 15:33:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 09:48:43 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 08:48:42 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To: Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, Wen Xiong
 <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de>
 <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
 <87y29zpgct.ffs@nanos.tec.linutronix.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <27cf7c97-6b03-d1fd-7bfc-6aaf3cd50272@huawei.com>
Date: Thu, 22 Jul 2021 08:48:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87y29zpgct.ffs@nanos.tec.linutronix.de>
Content-Language: en-US
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_004847_141522_72F25A8A 
X-CRM114-Status: GOOD (  11.49  )
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

On 21/07/2021 21:22, Thomas Gleixner wrote:
>>> That's what I assumed, but this text from John suggested there is
>>> something odd about the platform case:
>>>
>>> "Did you consider that for PCI .."
>>> .
>> For this special platform MSI case there is a secondary interrupt
>> controller (called mbigen) which generates the MSI on behalf of the
>> device, which I think the MSI belongs to (and not the device, itself).
> MBIGEN is a different story because it converts wired interrupts into
> MSI interrupts, IOW a MSI based interrupt pin extender.
> 
> I might be wrong, but I seriously doubt that any multiqueue device which
> wants to use affinity managed interrupts is built on top of that.

Actually the SCSI device for which platform device managed interrupts 
support was added in commit e15f2fa959f2 uses mbigen.

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
