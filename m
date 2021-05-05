Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB1C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 05:07:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC986139A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 05:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC986139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e85gykuBBltNHl+9ENzo5tErl6kbZekcPPZNIhIM9W0=; b=dpVhaoZKYMoySKwP5TjWm591Y
	V+5bmWGS7JL5eg61S5V4wV/xTR9oc2TmuU2Dr7h0AlFwrySvAWMyR6+2O32ShNdruNB3+Ansk48LY
	mkAEtcvkMLm/UY8GLDFC6VE7vY/tD9sTU64ZaxVGoKuGCYte+KD8G47PVOPO5rw1Ff6uw0ujkbOvT
	MmO+Rxe/NhnIE5wxqfkL9czY4HcBTGDq9lR5a+K+nIFbiHvp+NmrPVCBFrisXYGPW582qdi00y3QI
	KEUePv1D02UIIwWllOwvIS2rBz36KTj5TaOfh+EYqJnupVvdfGNV3TPW/LW+Hhzuhzyw8ZsYENheS
	i9od25x+Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le9kV-000Eq2-FP; Wed, 05 May 2021 05:07:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le9kP-000Epj-7a
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 05:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RWGAydsjZKUls4/S9mHy0LATQ/YElMr4A/BjYHMrIuk=; b=iRcbflkRnBzp8eA8oMtqVLOHcI
 yxFZOiEYZFtxHAvWQ5pnNngGXbQixUCqIgP1QtAbeF4onmvV2prWJR0EAH92mxMY+JDUQLKALh/dH
 oSFARg9yfcvNu6myw2CW/tA2woZ5QYUq60JPGS40JqgR9p0DmFdWkt2OHEgkzNzujoWx/wwamho/c
 uOnmdgUtk/MAAalmhS+NA5GoWnqg9S1OapuQivx3wLfgqtkFcM9OQfllyDhV1ZH9TUEANzEIS9jQP
 sO6/yEUCNPcvbCAz+TZY/g80nBGI8E4/cBalp5F6rMFomwkGZKzTdSC9NU1Hp2fzb01QdwBAnSnzr
 r4iueWzQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le9kM-004T9e-S3
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 05:06:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 70EDD68AFE; Wed,  5 May 2021 07:06:52 +0200 (CEST)
Date: Wed, 5 May 2021 07:06:52 +0200
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvmet: check sg_cnt for inline bio for bdev-ns
Message-ID: <20210505050652.GA12095@lst.de>
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
 <20210429184357.9185-2-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496590BD6ADAF0BF37179C58865A9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496590BD6ADAF0BF37179C58865A9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_220655_073572_D2526418 
X-CRM114-Status: UNSURE (   8.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 04, 2021 at 10:03:27PM +0000, Chaitanya Kulkarni wrote:
> One more thing, in the V2 to avoid open-coding in bdev and passthru (and
> ZBD)
> we should add a helper ?

Fine with me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
