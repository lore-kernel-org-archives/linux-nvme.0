Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3E4C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 08:46:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4C0208E4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 08:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPAFIQSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4C0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mtjt+SLVx1aLhMLt/75+Oujyv4pJqAAKHU2aRtJJtDM=; b=ZPAFIQSKMeo+Wz
	SZYzlqykKDQm4lkq3HVHrFrK3vCeWnTBbqFiSU6fHqYrmiZndmo2j+ddPcgqaZHuLrVmMnwSMVHBC
	nIL0anSA5axFpamaNED8OfDPiC5exudE7f/1939h5YekdPsA1QHY8B0BDP28Ew+pFg+myqtZ847ZA
	bILPvnI4fod/gKmgvYux6h6HMThB4gm0glOi0GrHiF2CWr+V7wBWTexhsqa5wiXWIdN9xkB+7iD3l
	wDSUOCIBr4eFKA7vlsFAe9QZ0tPhYkASb7b+0KbaKJB9nBWhly/Lii61i5kG2XXJ0nBjJiEyRMRh/
	FaoypclMIzeex1/KmRiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJvUV-0006fK-PW; Thu, 02 Apr 2020 08:46:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJvUT-0006em-So
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 08:46:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DBC568C4E; Thu,  2 Apr 2020 10:46:19 +0200 (CEST)
Date: Thu, 2 Apr 2020 10:46:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [REVERT] nvme_fc: add module to ops template to allow module
Message-ID: <20200402084618.GA18356@lst.de>
References: <db0e6c75-ac72-26b7-4791-9ad9969c12ec@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db0e6c75-ac72-26b7-4791-9ad9969c12ec@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_014622_077460_C92BFD39 
X-CRM114-Status: UNSURE (   6.07  )
X-CRM114-Notice: Please train this message.
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
Cc: Sasha Levin <sashal@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, Arun Easi <aeasi@marvell.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 01, 2020 at 11:58:17AM -0700, James Smart wrote:
> (not quite sure how to request this)
>
> Please revert commit=A0 863fbae929c7 nvme_fc: add module to ops template =
to =

> allow module=A0 references

Please send a patch explaining the revert.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
