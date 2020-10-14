Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6CC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 15:48:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C202222A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxUFKmDW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Ao8GKCWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C202222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h5nOVx0aloTgYqf2dOH/YMPX11mV2Wlqcudt+midKuM=; b=WxUFKmDWu4KHnvvUsYgXJlVwW
	jKCo+xoQwZk6n/6ydhX0hKONvvXhPEbQLOfJ2j1niowsTBupISCCptx2nDk17jd10G9Z4xsvzbH+j
	YHk3y/8CYQpFkuRV2jGy2ozdB2ZkURiaKxDUeG1FLja2nNw4Onk9ESc6A2L6a8CkNnS49SBk+etYx
	8KTjeSVyGtRiORBMJJEHrlf9NwpN1fJQi83NYk4KUCgSAv38DXB8ZN/pyeF7GIYmqSrJRpNQz+26C
	II08gDVFKU0QsP4QTlLPVK3zt28XZdxWVDwZ9ECIKZWmIR3o8RBNRhQuBJv/9Ug/zmDgcXyk4+OVE
	rqgyQxG5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSj0a-0001dc-Bz; Wed, 14 Oct 2020 15:48:08 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSj0X-0001cX-ER
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 15:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tCmziOcW2+QZPNTlF8RLWvUF+OxMcZwQMIajVppELJ4=; b=Ao8GKCWieeyb3ljB4AhdwLS7pW
 EvfYolqZdAtQ7Cfbnv0XN5dAJlLYB8FyXxQ8UiGiYgT1FCMRXswujsq4TE5X5L1w3vUD7uu+OF5jK
 pGTjUlWmRI9xXScLtoznSEuji+1y088MAJO8kBYBiktdsym0vIe4JTd/nvwixMg7s7Z2Mwwfma5ZD
 /vBHyujBLc3zfBjFAY+Ctgh0rUqfJw8844iE0u7OHz/IAdZPR3HdGQSjcZ6XJkNKWhWA2zWS6F9Cy
 rhM7SLtrnf9ddxoDZsMRhtgwwws08QQueFvOfWUoCE6yEWJP1hB+OMeKzM4KA6tT88YBaBBHq/r3t
 k+/hoxZQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kSj0S-0005RQ-Bx; Wed, 14 Oct 2020 09:48:02 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20201009231816.1524-1-logang@deltatee.com>
 <BYAPR04MB496556A3CBC239BC57EE588B86050@BYAPR04MB4965.namprd04.prod.outlook.com>
 <e7d76d3e-955b-1827-fd2f-9b7db49646ed@deltatee.com>
 <BYAPR04MB49654B340081F257BF9C4BB486050@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <542a1ba5-3a6a-1a5d-6b35-de5c2d1ff8ac@deltatee.com>
Date: Wed, 14 Oct 2020 09:47:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654B340081F257BF9C4BB486050@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, dgilbert@interlog.com,
 linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201014_114805_511824_490DF31D 
X-CRM114-Status: GOOD (  20.30  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-13 6:25 p.m., Chaitanya Kulkarni wrote:
> On 10/13/20 17:20, Logan Gunthorpe wrote:
>>
>> On 2020-10-13 6:16 p.m., Chaitanya Kulkarni wrote:
>>> On 10/9/20 16:18, Logan Gunthorpe wrote:
>>>> Clean up some confusing elements of nvmet_passthru_map_sg() by returning
>>>> early if the request is greater than the maximum bio size. This allows
>>>> us to drop the sg_cnt variable.
>>>>
>>>> This should not result in any functional change but makes the code
>>>> clearer and more understandable. The original code allocated a truncated
>>>> bio then would return EINVAL when bio_add_pc_page() filled that bio. The
>>>> new code just returns EINVAL early if this would happen.
>>>>
>>>> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>>> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>> why the prefix is nvmet-passthru ?
>> Well that's the prefix I used in the first patch, which follows other
>> similar conventions like nvmet-tcp, nvmet-fc, nvmet-rdma, nvmet-loop, etc.
>>
>> Logan
>>
>>
> Those are transport types and passthru is a target backend.
> 
> I found this [1] in the git log, only one patch has that prefix.
> 
> The convention is to not add backend prefixes for target patches (see
> bdev/file),
> 
> I'm not sure we want to start adding prefixes unless there is a specific
> 
> reason.

Well, I don't see the harm in it, but if whomever merges it wants to
change the prefix, I won't object.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
