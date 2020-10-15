Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56AEC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 14:46:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8CC2076B
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tJVivz+k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XelHnjnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8CC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6jvD0QUstMJTPGefeYHJIa6iEpGYSu3tL6EqMCwvFmU=; b=tJVivz+kW76Qz+hbDaNGozdiY
	PtOO1uFRWKW8tOx/eagk1qTFxxCGZD0m10D7SU43/2MVb5uJu7hP3QWZWBrSIEsyKflxR7836dpgh
	crGDiPqnpBJGlk6Snq2KZLgBgXEbql8OUpePAftyCB8bj2PgUEEaKUsukteh5KHxipPrN6vB1R3ve
	tyxjG4ztwmsIkzOxmEAlYwWVtZ2WLJNqUBnLRaZM1/a5ukCyge14On2qFANZYsRnM+7qAo2JcrIEi
	3QyzaTgPlRdWhTOCCfHos3di1uIEQ4FtHeBDrAdve+jzEAq5PD5/UZ9yEcioW7OHVCUKjwd/n7R27
	MV9wYYy8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kT4Vu-0005p0-TP; Thu, 15 Oct 2020 14:45:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT4Vs-0005oe-L0
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 14:45:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C3252076B;
 Thu, 15 Oct 2020 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602773151;
 bh=ET0HamK7vVRd07KirE7gmm+uMaSiwVlFj2Epony0LeE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XelHnjnlLmh5zYK9cz9/AWwG3k2s8U6nnf15bfhGrh+fbMY5HVWBXuolASuSYxoow
 kLAAppT4ZbER9nMw+/z2ksp3Ou/jUr2RChv6cI1dmWTCvFpNAAF8vvDFfTfba2U5Dk
 LirhBY6BJUB5fpx95OPsm5sJd2izbPgSiZFSCMx4=
Date: Thu, 15 Oct 2020 07:45:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: set passthrough command gendisk
Message-ID: <20201015144548.GA1401094@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201014203845.1400053-1-kbusch@kernel.org>
 <20201015074222.GA14082@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015074222.GA14082@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_104552_880241_4494BAAB 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 15, 2020 at 09:42:22AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 14, 2020 at 01:38:45PM -0700, Keith Busch wrote:
> > The nvme event traces for IO commands are reporting the wrong QID
> > because we never set the request's gendisk. Set this parameter if the
> > passthrough command is being sent through an IO queue.
> 
> Why do we event need the check for a non-NULL disk in nvme_req_qid?

It's the criteria we use to know if we're tracing an Admin vs IO
command. I suppose we could change the criteria we check rather than set
the disk parameter. Maybe rq->queue->queuedata instead of rq->bd_disk.
Would you prefer that?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
