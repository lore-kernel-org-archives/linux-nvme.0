Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07030C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 12:37:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0010F2250E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 12:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0010F2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IlEo2/wLHKWAc/H6jaJwT3ZOcOVGzO0IMxW6VMSLA74=; b=V8vdmMedzKpd6m7W7fPrrYVic
	AzJgE1zzkKobKrbRntt9IK+RaKQwmCvWJi/VU6aBlmG7PxqzeXR97Bubakb4zhiihMQ5I7DJWaVkq
	ppjhyZK3sCzV8Uloe8zjoWzi94NRdfXhblEVwenVqZw0A8ce2nXhaQbl0SnL0R8o5ZLy7NLoj4onh
	7ZdsTz6ZXxf5ayjmeNQVcegE/ZDvtU4FcqzMoBwwFkFEfKvtEhPHJfWvJC/wPPw7qCuV7jbxD9Vd3
	qJOIAE/ZnGyXTMDe+K/He3afvuqqck+C2UnLltGGqqa/CWxFzJBCrtnI89QboGUTzxdFKr/W3CZo8
	rUZF307hA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2CjJ-0000ss-6t; Wed, 20 Jan 2021 12:36:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2CjG-0000sA-E5
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 12:36:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 086E667357; Wed, 20 Jan 2021 13:36:50 +0100 (CET)
Date: Wed, 20 Jan 2021 13:36:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] block: introduce zone_write_granularity limit
Message-ID: <20210120123649.GA3870@lst.de>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
 <20210119131723.1637853-2-damien.lemoal@wdc.com>
 <20210120101018.GB25746@lst.de>
 <BL0PR04MB65144D0B02939681617B61A8E7A20@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65144D0B02939681617B61A8E7A20@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_073654_599906_EFC095D1 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 20, 2021 at 11:00:29AM +0000, Damien Le Moal wrote:
> Hmm. I wanted to keep this limit to 0 for regular devices. If we default to 512,
> regular devices will see that value. They can ignore it of course, but having it
> as 0 makes it clear that it should be ignored.

Hmm.  Maybe we should keep the 0 default and only set it in sd.c.  Then the
query helper can default to the logical block size instead.  That'll just d
o the right thing without changes to most drivers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
