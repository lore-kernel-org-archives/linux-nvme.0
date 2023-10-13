Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BFCCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nznzzpEsr3J0tZcaRkT7wenFrYgpFbJamlcsyCadBc8=; b=qhkZOH3jRaDFWEl5Tk1Tx1budB
	5NEAM1ciAx75bags3YTdUO+a6v4TvvpB65Il82sluL9f/R/Kx8OICQa5ZTpcTC8XAa8O0x7gBrATy
	UxvkuT8C+ZO91dTRme6LfmObXdpkmvTteicpTUXc1AnWSrIsaF83OlzkEbLCQp3Fz83mF2HTg11YJ
	hO16Khmy9f16kak8SImZte1AC+z/jrsTn7aZBMp7jIVxNd7ksUtRgZv7J9of7aiTbp6fTyc93FGAa
	2pjnb4H+yvKplArNlG6AaYT3zgLsSbm05P5sqCmhIhkONCfmwJoP2Crfh4JjBu4l0j7llJJb72FP3
	bfhOkJLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrJDR-003b60-1B;
	Fri, 13 Oct 2023 14:32:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrJDO-003b5a-0j
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 14:32:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8EF72620F6;
	Fri, 13 Oct 2023 14:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01C3C433C7;
	Fri, 13 Oct 2023 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697207553;
	bh=rTpDE4bgxLTkvJKrGIcTAXlCA2DIvbEDRFlAwveaDTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1ypZyW+l+AKR8Lh9anoXYN3e9APQbGyZHtBQ8aDF/H3ePWlXlTqUPzpf/+UAbvmy
	 AdYfhGnS+AoXfvM0SM1oFhjPeBobD4ZeRoXW3fLnlAbRm61vNcc+kQyQ1TrmSBWAnq
	 3KjhrAfIEdvo3M0ZfVK0cEGVdPZ5/v8bysaFoYnaApD6J+ra0aIsDvfVv6iA5fuf7Z
	 3FvsP72Q0DL8QawrhiE+mDI0QfQV8Jlw0fnAalGozQREB+XRMVRPzfE+dxU33s8ZrW
	 HLRAj5l/kw0tKHJaVv+7plbrqa5Br8icKbXRXDqz1Pl2xf1FyjUakHE0W24uh1yTCr
	 0Tl+64Fs9ypnw==
Date: Fri, 13 Oct 2023 08:32:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: andreas.thalhammer@linux.com
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Bug 216809 - nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting
Message-ID: <ZSlU_kQOtpyQEJK0@kbusch-mbp>
References: <4933a8ea-56d4-4094-b9fd-bc16fc5dd920@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4933a8ea-56d4-4094-b9fd-bc16fc5dd920@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_073234_314598_74A65435 
X-CRM114-Status: GOOD (  14.40  )
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

On Fri, Oct 13, 2023 at 03:25:37AM +0200, Andreas Thalhammer wrote:
> I'd like to make you aware of
> Bug 216809 - nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216809
> 
> I personally don't see the reported errors AND system freeze on my own
> systems, but the reporters do, which are:
> jfhart085@gmail.com
> Nelson G <konoha02@yahoo.com>

Does the device just stop responding entirely, or is it just reponding
exceptionally slowly? Output from something like "iostat -X 1" that
includes the period timeouts occur would be useful to see what workload
is being thrown at the device, and how it is handling it.

If the device is responding very slowly, suggestions I might have
include:

  a. Enable discards if you've disabled them
  b. Disable discards if you've enabled them
  c. If not already enabled, use an io scheduler, like mq-deadline or kyber

If the device isn't responding at all, which appears to be the case in
one of the dmesg's from the bz, then suggestion is report a bug to the
device vendor.

