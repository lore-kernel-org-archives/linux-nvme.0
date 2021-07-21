Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF17FC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 09:45:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E37F6121E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 09:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E37F6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wfIcKgSVDfwacpGXsnnpd/KTn95sZrNo3cjPqVdYNQ=; b=I9ssjkfrJTCpwkEhmYxmNvC1KG
	9N8+5CRKzqtvBkN0+MLLekKU8X8e7NU/cOPv1UXsivuNaosCbsJHZYv2dM6/XZXUAUrwTztPtSyOX
	47arJgSqxvIkctTmHghd5nEuurP1zxdrvt0bHOyPxwKLNnmSSG20xfUMFCCK9BuCleKSNzHRSRrSx
	+NFSlGnzMtT4GZb4ljUSaV/NneXa5/Rn9TgBGUZIQ1WB5cjIVOungWKE861sfMvcnYgGSKU5itUfN
	5mtj0p/XRpVeFZMbQVPwA1MmfMdOwZCRc8ZFFNNlA5PE7mCbLHSrs7haWoUYJY8ESKadZpGpeOFpo
	9LNUHLYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m68mn-00F7cQ-3W; Wed, 21 Jul 2021 09:45:05 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m68mj-00F7bY-2D
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 09:45:02 +0000
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GV9Kb61r5z6D8nk;
 Wed, 21 Jul 2021 17:30:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 11:44:57 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 10:44:56 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>
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
From: John Garry <john.garry@huawei.com>
Message-ID: <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
Date: Wed, 21 Jul 2021 10:44:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210721072445.GA11257@lst.de>
Content-Language: en-US
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210721_024501_310373_C2C341CB 
X-CRM114-Status: GOOD (  18.61  )
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

+ Marc

On 21/07/2021 08:24, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>>> Just walking the list seems fine to me given that this is not a
>>> performance criticial path.  But what are the locking implications?
>> At the moment there are none because the list is initialized in the
>> setup path and never modified afterwards. Though that might change
>> sooner than later to fix the virtio wreckage vs. MSI-X.
> What is the issue there?  Either way, if we keep the helper in the
> IRQ code it should be easy to spot for anyone adding the locking.
> 
>>> Also does the above imply this won't work for your platform MSI case?
>> The msi descriptors are attached to struct device and independent of
>> platform/PCI/whatever.
> That's what I assumed, but this text from John suggested there is
> something odd about the platform case:
> 
> "Did you consider that for PCI .."
> .

For this special platform MSI case there is a secondary interrupt 
controller (called mbigen) which generates the MSI on behalf of the 
device, which I think the MSI belongs to (and not the device, itself).

See "latter case" mentioned in commit 91f90daa4fb2.

I think Marc and Thomas can explain this much better than I could.

Anyway, as I mentioned earlier, I think that this specific problem is 
unique and can be solved without using a function which examines the 
struct device.msi_list .

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
