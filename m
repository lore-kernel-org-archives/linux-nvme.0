Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD8C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:44:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7562073A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohgbwBtE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPx+fFSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v4huaI/STTL/6xG/mdaaT112lk3lGE9Mw5xxz9O9S3o=; b=ohgbwBtEnSLKiDsMk0fobnKbn
	RxX5y5KenvelbIZ2kqwK6DB02Piccv7ilXXh8QeyiN2sYPjso/adNYEheYkOfJCqnx59px7F6Zim+
	hGoaN+yK3E46ZJKbcH9xZVIfp27M55nu1aDUknsqVUn8MutpVTslmhvhOfIzXqxszpQnKXG4yiKza
	yiD28/8LiHY780QcbX9ofrkiihJXpgHBuxRGg39qJWiya7g2WGt7lKYgf/XA4okns3fDGR3RvRn3O
	mlxO23qVxf7CvTaYR6lkIB1LYAMou/DVt2q2L9Tv4mF3r1T56u0Ne4pFvBPfZ7L6I2sm9Qia+TAfD
	d+gALIU7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBWFk-0008CM-Kd; Fri, 28 Aug 2020 04:44:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBWFi-0008Bt-An
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 04:44:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4ACAD2073A;
 Fri, 28 Aug 2020 04:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598589877;
 bh=ClAPztiO+kVT9J0Hpn3mYBZ71d85JH1Gxzv4DVRgU8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NPx+fFSOHXx7mPJ8OtqK+vGEnRC8Z+cAbQg7KNIol5ZiIxdhZGmDmMXKYURMFZsFg
 phOiv4vSJWwjuWgOSGyVDGTBvFF0+GECyMtq5kVzL8084ipglvL8ooys6iJT6WQP26
 jGoqV29Z9tLgt+FAF8gXdHdxnYjwEQUE+c04zGug=
Date: Thu, 27 Aug 2020 21:44:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200828044435.GA2825639@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828041645.GB2784469@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751CF0BBED62F4EF6BF36FFE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751CF0BBED62F4EF6BF36FFE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_004438_440166_033F254D 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 28, 2020 at 04:30:02AM +0000, Damien Le Moal wrote:
> On 2020/08/28 13:16, Keith Busch wrote:
> > As long as zone sizes reuse the queue's chunk_sectors, the zone size
> > needs to take precedence since it's more than just a hint compared to
> > NOIOB. If people complain about the warning, that may indicate we ought
> > to find a way to get around overloading the chunk_sectors queue limit,
> > but I suspect ZNS drives won't report an iob value.
> 
> Understood. But for ZNS, since the zone size would take precedence over iob for
> chunk sectors, wouldn't it make sense to have the entire code block under a
> if (!blk_queue_is_zoned(ns->queue)) ? Something like this:
> 
> 	if (!blk_queue_is_zoned(ns->queue)) {
> 		if (is_power_of_2(iob))
> 			blk_queue_chunk_sectors(ns->queue, iob);
> 		else if (iob && !(disk->flags & GENHD_FL_UP))
> 			dev_warn(ctrl->device,
> 				"namespace:%u has unused io boundary:%u\n",
> 				ns->head->ns_id, iob);
> 	}

Oh, I see. I think we should have the warning for ZNS too, though, just
to get an indication that devices really want this kind of
consideration.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
