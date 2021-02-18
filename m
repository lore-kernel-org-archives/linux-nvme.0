Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B497EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:28:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ADC60C3D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 03:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ADC60C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2T9R5K/q2Qa24T63TmlGPQgYuO6InrEKd4gkTjhVDOU=; b=0S/ehKZ/OGjhrRZO/BSFE/M8C
	fbSBJl4fUzN9YpdyTlGaa8FftZ9QwPcDBQEh1946swLMchfokdSPQl7JsIwltZLwv+SMa+0E6+VzZ
	F56T8F1LSmqj9ulXHjPPhJyEv6/4wdinYFIvzQwRptv8kBB5vJoM5EbNwI+CiQiL1GlZwLb3RzdoK
	Oh/KeORm47TTi4N7EIJ3HB71No8MgG0RGe1LWC8/zTNn/oj6k+BreWlIK0fUYAFkTBHHteohWeLTH
	YKIwvuR0TkoYg8sF3R1Ekmq7GKn3/7UbjQSAhN6Z7blAVfodvJ4PPrlEs2edQyAdtfHKizb+GTfNz
	bmE9OJevg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCZzR-0005gv-EO; Thu, 18 Feb 2021 03:28:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCZzO-0005gW-Py
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 03:28:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC5C64D79;
 Thu, 18 Feb 2021 03:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613618904;
 bh=ysYtoE4M152z2q0wGwVB+M7NXFEM2We7NUqwykRKBv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q6+QjDbQQ49/6wNWEGEnzjOty1181cgzeAqvpaoBy8759GlMl3J/2ZO70D28ay5R+
 2a3P++V0DXCCLnh5p4xC4dhHR/oP6jIDt4dISvCbxziiXSSVBb7PkWvGUj3IIk4MZc
 XXsTMHu9Aim7mADJEQhHio6mZ559UPJXFcnwoAf+pbfOWpQw/rqNZBpEfKxn1tI0hO
 dc6xIDgtR8pi59VKIPDnEr0ry1wXQPcyncEwhiKEFcW43GNOdR5ba31CcCyyluej75
 iwLCozmwKQDpK8vUA3VOnFXW0VMuIi2xptDRGB99P8chnktyCYKA7cmaUbwiEqdsL1
 Y5RbRqdFSy2wg==
Date: Wed, 17 Feb 2021 19:28:22 -0800
From: Keith Busch <kbusch@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Message-ID: <20210218032822.GA2711165@dhcp-10-100-145-180.wdc.com>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
 <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_222827_460291_E040B1DD 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Jens Axboe <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 17, 2021 at 08:26:30AM +0100, Heiner Kallweit wrote:
> On 17.02.2021 00:59, Chaitanya Kulkarni wrote:
> > On 2/14/21 08:30, Heiner Kallweit wrote:
> >> Based on the description we should be fine using the less heavy-weight
> >> smp barriers here. On x86 this would be compiler barriers only.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > Can you share performance numbers ?
> > 
> 
> I stumbled across this code piece by chance and don't have hw to test it.
> Having said that the change is based on code inspection only.
> Unfortunately the barrier comment is very generic and doesn't mention
> a problematic scenario. Also the commit message of 3a7afd8ee42a doesn't
> mention a potential race. Most likely the barrier can be removed
> completely. Helpful would be if someone could explain the potential race
> in detail, means which reordering / variable accesses could be racy.
> Then we would have a basis to talk about READ_ONCE/WRITE_ONCE vs.
> smp barrier vs. dma barrier vs. full barrier.

The variables the driver was protecting no longer exist, so I also agree
the barriers should not be necessary.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
