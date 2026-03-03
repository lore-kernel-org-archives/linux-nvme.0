Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720EEEDA686
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ak4rvzSvNvLPGu6yi0Wcsdf2+0OPRXpBr0AARJsdae0=; b=R/mRwr6hNSfAULUavP6hZ4qECG
	F75JZGL4synw92MSYWYB6d16PB2x8Qo3IuOGirTRafBBC3dg//oAayYr9rgtvlUdz7zFu7hlGWgKo
	+KIhL2w3bLBqayvA88wRjeDA6u1PvuIPiLCbv8XYTtguCom5kcpwL9jvMgTGDx7tNin0c7hYBjSyz
	mEbgqCVUd+/PaKd12yar7Nr+rc2iLQn8N/fLw2qp41X2kQoyeOCN6kJ83Lkif0WTOTG0Z4jZDkAza
	dfkTrMX3yx1nJ3bOgPolcgFx0baTDmhymThvcwuqg2rXeQDjxYKrqjOtX2rE0s+6TSJhjcjVnpv3N
	xWttxRwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRqr-0000000FRf3-40Zf;
	Tue, 03 Mar 2026 15:40:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRqq-0000000FRea-2bJq
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 15:40:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 94089600AE;
	Tue,  3 Mar 2026 15:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD247C116C6;
	Tue,  3 Mar 2026 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772552399;
	bh=ak4rvzSvNvLPGu6yi0Wcsdf2+0OPRXpBr0AARJsdae0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tW7wvyJarBqRc0AZ+5PO9Vshep0TF4Z1ZemMTT0IzOOWLnLXwEl8HnIyh1VfIoYgM
	 82xzM9nfWTkiRLHVtfmf2R4GnZzBLBXPRGLbkTlN7ia8IOw1Tm+1VB3TQE9TjM0rhz
	 pr/offf3dlOdHfMilLSg5hCDiOGQA69tXzM1RbJI6WBwVxKAYgI0guu82zNvwFh0S9
	 H88gWD/+vMF4WZ5rp3XuH7/6DhIDyuHHFZXuT+xTGaELbW5/SWIZUYfuPE2xaVi9Dc
	 eEDb5TUvdxP5SuE32oKyxsXUadZCCP+seGsvX6W95IVGLGtaD3gdGYRsDGof2aAJqQ
	 LsINfDUh13teA==
Date: Tue, 3 Mar 2026 08:39:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
Message-ID: <aacAzGpNJ2RXedvG@kbusch-mbp>
References: <20260302222532.3400786-1-kbusch@meta.com>
 <20260302222532.3400786-2-kbusch@meta.com>
 <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de>
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

On Tue, Mar 03, 2026 at 08:34:38AM +0100, Hannes Reinecke wrote:
> The idea is nice, and I would love to go into that
> direction.
> But have you checked how this holds up under
> rescan/remapping (eg things like blktest/nvme/058)?
> Removal of the sysfs nodes might be delayed, and we cannot
> create new entries with the same name until then.
> So if that is taken care of, fine, but I don't see that in
> the patch ...

I see. I set out to ensure everything was ordered, but apparently I've
missed this case. Thanks for pointing out the test.

