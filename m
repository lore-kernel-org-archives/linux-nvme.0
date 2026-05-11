Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C998CCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fuQ8mnCQXWx60rzu4kiGsP7LtP20P3DIwOELA7wN6iA=; b=MUtQwG7YSMHONbGEjQPVoAU4E0
	Jc+PGpy82W8GxB5uxN3qiet+Gt4QTyTGUpSjU1TDDBooFaoxTVUGsGIAcCCem6omH6Etzt2kQNNxQ
	/sFBcFKCdQCrng7uyW3yOsBiSF/9ZXqk9qclJzqsis/0obJ3UfESNPgVIKf8bJ2vidGwXdby2F5pP
	9IAZipt7OfXOkJvoZ+E8Adswgt6f9U0P907EdA5qnfkIPc/YS4FhIODwvjormv0ao2ZMZlMVHrL6J
	FvNfV14pyk44OEazuybxnD9iuPK3ZgeuYWvJJBwpwSfgi0fyEfGG1nvwDMHqTDgrzh1meA+J2Gz7H
	dEskWTvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLh4-0000000Ci6I-1P54;
	Mon, 11 May 2026 08:08:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLh1-0000000Ci5F-2tTi
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:08:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 148BC68BFE; Mon, 11 May 2026 10:08:45 +0200 (CEST)
Date: Mon, 11 May 2026 10:08:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 4/9] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
Message-ID: <20260511080844.GE29677@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-5-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_010847_867006_80D47064 
X-CRM114-Status: UNSURE (   9.82  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2026 at 03:33:30PM +0200, Maurizio Lombardi wrote:
> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
> timeout target. Instead, use the configured admin queue's timeout value
> to match the device's existing timeout setting.

Shouldn't this go into the patch introducing the configurable timeout?

Otherwise looks good.


