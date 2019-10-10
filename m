Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2363C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEFB20B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZPE2KFy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNE+XbKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEFB20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xhu0kOzVdeEKOOX7ew6tfoQ2k477/DF9aQ+dRG2j5pE=; b=pZPE2KFyfQ1+Sv
	BF6fMSkdqrdYkDvIFHPmVoo6Xd3wxuW5kbHG92aCRWnz2YLDf9w//lOVtL9I15lAoZeTiXaY7S/Fc
	ayRgTXmA10r6bIcC4jGMtkzlBSh1LXhPsW8kVWzBGDzr0/d/rXWo5iV3aneUTqbNNZ908bWt8CvdH
	ENK4wJlBQ31YOlzfFw56k3JEe07a2p0jIuR1BIWiEBu1q2Pb+3R8q3TQWnXOFio39XBBHje0NTg6l
	RaCET2WPmuM+BavWeIpNkCsjVGYopaJuuuv+QKQzp80Kki8DxSvfOew1Gu3v7FFpoNzjPGFufkTJY
	B+U5xr3qkXViVGVlonFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIbKs-00058z-5L; Thu, 10 Oct 2019 16:30:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIbKo-00058N-TB
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:30:40 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A76F2067B;
 Thu, 10 Oct 2019 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570725038;
 bh=l99HuFhleehFucsJiZ7IagRiyNIii5LinjZcUdmUWvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jNE+XbKsLGIb20xHf16ytx6zGCY26ofIP5adbq/I6PFC2TKOZkWptkkvgNbFDhfzD
 Ncrxtc8b12mmApJpgI6cO/hTC7Zi1Rg+4kRagdWTt68NBjhWEWCQ6JNXYhJI5OXe4q
 NN7MRQ+uP8iEzg2MKu941JCw5Nd5P/BxISVrvsmw=
Date: Fri, 11 Oct 2019 01:30:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 5/5] nvme: Wait for reset state when required
Message-ID: <20191010163034.GA22635@washi1.fujisawa.hgst.com>
References: <20191010160527.22376-1-kbusch@kernel.org>
 <20191010160527.22376-6-kbusch@kernel.org>
 <20191010161847.GA1942@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010161847.GA1942@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_093038_965263_DBEE15B0 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 06:18:47PM +0200, Christoph Hellwig wrote:
> > +int nvme_reset_schedule(struct nvme_ctrl *ctrl)
> >  {
> >  	if (ctrl->state != NVME_CTRL_RESETTING)
> >  		return -EBUSY;
> > @@ -133,6 +133,7 @@ static int nvme_reset_schedule(struct nvme_ctrl *ctrl)
> >  		return -EBUSY;
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(nvme_reset_schedule);
> 
> Oh well, forgot we grow more users later.  The naming of the thing
> still puzlles me, though.  Maybe something like nvme_schedule_reset_work
> is a little better?  Not that I'm fully happy with that either.

I'm struggling to discover the right name here. Something like
nvme_schedule_reset_work_if_resetting() really captures it, but is a
bit verbose. Maybe nvme_try_sched_reset_work()?
 
> >  static void nvme_reset_done(struct pci_dev *pdev)
> >  {
> >  	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > -	nvme_reset_ctrl_sync(&dev->ctrl);
> > +
> > +	if (!nvme_reset_schedule(&dev->ctrl))
> > +		flush_work(&dev->ctrl.reset_work);
> 
> Do we need a comment on the flush?

Will do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
