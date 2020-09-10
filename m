Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF1C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC31206A2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cs88yFrg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMM7zxiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC31206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xL74aDApdhjBO5PBqRPtpmO0gGXYT2W1A0vzRNOtX4M=; b=Cs88yFrgwTJspr8c4TJ4hwuAx
	CIUzlf9XCzvSwqJzn93O8lPKeqmM34TAEI7Yd+GslNpnkqUrhmnPOv/eBuGOj2N9WrEwc/PmB3+vI
	gAjDIG5fv6pKsyxnvDTEQGcIKob4AzEy/75kCCaDCz0fZ+4GX/eMw7LeQGH8PqG594qn/XizcmdVz
	Jt8P2FKCB2TQursFXUmEuuvVYqr7c2/+w4ugq9bsMLmJ+t1qK8+1c+sZNpbOVj37W26F0m3PPhPco
	YDmvzxIg0Erm1UCIkYOGden7Vgha1HxOGoeiPhywh8sma3yiGYIunUkjIUIP2NrJQWS+DoirUzPzv
	OSFq0PXHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGNpU-0002rq-1D; Thu, 10 Sep 2020 14:45:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGNpR-0002rX-MQ
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 14:45:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27FAE206A2;
 Thu, 10 Sep 2020 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599749136;
 bh=3o9KDqTzD4Kj/QGscSM9YIjAc25RT96edx1U07tdhr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TMM7zxiP/lXwy8+N1kC26Sk07AUM7asa+Gl/mxc7XbCx3gYj73gHVnYADJzWfuyA6
 phGlvhXSB+hx8CrPvvfLO5fmY9VTjap+PcQLbSTqaPzQLJhDaVCqc0aJYvTU82axOC
 fBPTMs3l2LIe0GNVAjJjirWaZUn5rSGUVwa64hPc=
Date: Thu, 10 Sep 2020 07:45:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200910144534.GA3446191@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910052643.GA18283@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_104537_796368_3D859EFD 
X-CRM114-Status: GOOD (  20.39  )
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

On Thu, Sep 10, 2020 at 07:26:43AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 09, 2020 at 01:33:24PM -0700, Keith Busch wrote:
> > EBUSY is the appropriate errno for commands that complete with zone
> > resource errors.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ea1fa41fbba8..aff556837115 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -249,6 +249,9 @@ static blk_status_t nvme_error_status(u16 status)
> >  		return BLK_STS_NEXUS;
> >  	case NVME_SC_HOST_PATH_ERROR:
> >  		return BLK_STS_TRANSPORT;
> > +	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
> > +	case NVME_SC_ZONE_TOO_MANY_OPEN:
> > +		return BLK_STS_DEV_RESOURCE;
> 
> I'm not sure this is the best idea, we probably need specific error codes
> if we want file systems to be aware of the limit.

I was more considering the errno the user sees going direct to the
device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
