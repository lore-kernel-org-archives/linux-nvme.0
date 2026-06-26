Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4050CC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqAmEKB6Irv4GXMyF4eOsLWLUqYiNEvb7TRZH4EwPCs=; b=cIv3a/XPLgWQHmvUof+G9Pldnf
	aBpkAtl8cvluDBGf50iOnqEGEdqbY2KvXeLLpR/qDl2zCViXXxo3tvZINtYanwjuL4hIU/03M0Wvc
	ANKxTdfA8qOeabDPhS8FR5fW0BTVdLmsxE1hze7zBzwmCYwX5UB94DRtCHv/+xLpp0qdzES+yyYXu
	0ahU0mOZL/XJobJuWmDEwA2N62atmjF877I294RdoSXCsemdLPKA0+gk2Y5Ci6iJ2vLcc8aua0NvF
	0tP8C7mSEdKm5R651MceLtay9JViDD9bVkOQL+Pfv6K6eX1A/zdmeGVEVhSf/7eUQutLlOTP+duq2
	fOUi596w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdEwX-0000000ByAL-0oKZ;
	Fri, 26 Jun 2026 22:22:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdEwV-0000000ByAD-1SJz
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 22:22:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CE87600AA;
	Fri, 26 Jun 2026 22:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899421F000E9;
	Fri, 26 Jun 2026 22:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782512553;
	bh=rqAmEKB6Irv4GXMyF4eOsLWLUqYiNEvb7TRZH4EwPCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gz87EqOPyTGVXxqe0VZs948r97g5kt+Uu0paku61diVd4FP3P+sJprsPWvKh/ctu5
	 Dvr9/x9ogU4Q4zKrn/BSpR8lbJpfGYfiqjxvF4eNnacHPpga8Gd/3Ka6vYWW40sELc
	 ACc4xjCBvn4GAxUd7Aw6ndRr1rv6Q3VNcAkKGxtjOpWNUypZGyTp9gjD8D+Jv+1xGQ
	 B18QFLx2UeFrMyD8wdm09bM52c1G2MARaqSBn9YKBqh/OOETSFKs7GTBRcmSZ0O2JG
	 /MweNCLnWDs/l27Di2FKsvzMnAdnCZzTrD22mSLBYcqf28wuCujxDlHc5Jd1BuQ70B
	 zz1DilXD+HYYw==
Date: Fri, 26 Jun 2026 16:22:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <aj77qInSZ3jJfNRU@kbusch-mbp>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
 <ajlRnLI8OdaUVOZp@kbusch-mbp>
 <ajphNQIpfIRYZg_H@ubuntu-server>
 <ajp5vFaVB4wOHjpf@kbusch-mbp>
 <20260624074045.GB12649@lst.de>
 <aj69FEOLH82dLErr@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj69FEOLH82dLErr@ubuntu-server>
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

On Fri, Jun 26, 2026 at 07:55:32PM +0200, David Epping wrote:
> Thank you both for your feedback, I get the point. I'll definitely look
> into using SRIOV or SPDK to migrate the system to an unmodified upstream
> NVMe driver mid-term.

SRIOV could definitely get you there with existing capable hardware and
software as long as you don't need to exceed the VF count, but it is a
bit heavy for what you're describing.

My SIOV suggestion is more fine grained for similar use cases, however
there's no nvme standard or kernel support for the feature, so anything
using the concepts would be a custom solution; NVMe would need some
mechanism to associate an IO queue to a PASID, then attach namespace
access to that queue. After that it's just a matter of implementing the
"mediated" device.

If you're interested, this is a recent proposal to generically setup
SIOV, but it needs some work:

  https://lore.kernel.org/linux-pci/20260604150153.3619662-1-dimitri.daskalakis1@gmail.com/

