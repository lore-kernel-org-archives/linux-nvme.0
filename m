Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B86C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFE02086A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="adSy5bx2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWQPidMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFE02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eQZq9ddCuKO0I7itwkRO2QUUIXRxATHjPMymhic6j4c=; b=adSy5bx2E3sp0b
	p/PKPOPNdljiBi6bAKMrhRao8kZtv4I8FBBENfM0V5nvJGzCaR2uEaW/tDENYJK5EIdDbDZrM25ZW
	+kwrPBNyCH2MT/uGLQrgHVNANj6OglqBJytaVoF8ooeVehPi+u39Fv89q9tl+axoReOXyEfQ/xtYo
	LP9dWdGEDZ5vaCUFq/YOJW6AOmnq9M6YYmfmPsgtjROEWLO9kmO+WEGrYz3EOgetNMhSDaRvIsXij
	+b3p4XsX0N6wvMH7GNwPK9NvEFAodW2gUAH4rdAvjZGDRXy8QWqHR3SanaljKrizL4/RKYcqP5X3A
	daMQcvBdOXYq59bwkIGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN6S-0005uQ-12; Fri, 20 Sep 2019 17:53:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN6P-0005sZ-U1
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:53:55 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5380C208C0;
 Fri, 20 Sep 2019 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569002033;
 bh=0iQq9F8mXl+BcVV56komRet+Xcto/LA1aHyYI9gedLM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uWQPidMTYFqX4kYlwxZoO2x4rR2D+95wNT7ctsp+N4JdfcGI/BfKrRhPqLTchzQgr
 jKG1Y0bq/biqtGb36vu3H8c9v7R/WSdoY8IUHrybAqu1WtR5uF5ZAqqPsRqT06OSDN
 IVysQpSVFlrk8/EX8TdjVNJrmPILba9A1oVaxpAE=
Date: Fri, 20 Sep 2019 11:53:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 1/6] nvme-pci: Free tagset if no IO queues
Message-ID: <20190920175351.GA97854@C02WT3WMHTD6>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-2-kbusch@kernel.org>
 <d6c5e276-6479-89e6-4a59-5e950ddf2fe5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6c5e276-6479-89e6-4a59-5e950ddf2fe5@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_105353_984925_6A2F9491 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 10:49:11AM -0700, Sagi Grimberg wrote:
> 
> > +static void nvme_free_tagset(struct nvme_dev *dev)
> > +{
> > +	if (dev->tagset.tags)
> > +		blk_mq_free_tag_set(&dev->tagset);
> > +	dev->ctrl.tagset = NULL;
> > +}
> > +
> 
> testing dev->tagset.tags and nulling dev->ctrl.tagset?
> why not check dev->ctrl.tagset?

We could theoretically use either. I don't see any case where we've
allocated dev->tagset.tags but didn't set dev->ctrl.tagset.  But I
just kept the same check we had before, just moved it into a helper
function.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
