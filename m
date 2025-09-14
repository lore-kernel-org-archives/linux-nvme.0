Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9DDCA0EE8
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Sep 2025 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LF33A9R61ZdnzfPHyrEbpe5BcMf7U3ad63kCUDGgDA0=; b=aMQus7PPuu+J2C1Pu3r/SHznl/
	P6dXYDcW59iz8zXyBht9sTPaLaFpK4NrWcA1tjx26LRzwctdxwvumFRb4N8MVu6+Yg1JiUZ6NyKNB
	0HS0+oDpKNyh1u0gA/i5ZH0ONVEN1uXTuiqrX4Ab3JeJ77yT8NBqR7y4T7zsJ2MK7XqSqWcShsv1p
	xy0wNDaIxdCsHH0JIJlenKx7gW05NkyWKSL0D58UvJoUe0r42uCq62ad5+A+QjxTm+ezq15Tl/TyK
	t3pbMO0lVVm7gRaweE54v7VsMnkwgoXUAs1/KiC4nQW0wVkyOR1HKYHdE1Z3FkFAUjzPv1nI6idyw
	Vnfk+u+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxnlg-00000001Wfr-0PIv;
	Sun, 14 Sep 2025 14:31:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxnld-00000001WeV-2Vb9
	for linux-nvme@lists.infradead.org;
	Sun, 14 Sep 2025 14:31:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B9B640506;
	Sun, 14 Sep 2025 14:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A4C4CEF0;
	Sun, 14 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757860307;
	bh=LF33A9R61ZdnzfPHyrEbpe5BcMf7U3ad63kCUDGgDA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7q1RPbADMgafuUyPRKGurzY0ACZbnk8PxK8xXgE/xQnYzXhqZgVfCRxR8TO+o2gu
	 ItXYYSZ/GRR8ayQP+gvhOxI2SUzbYkcxw9LMJMowXVBLgF0Rri1Qg09xlSKG/Utl7E
	 7YVr173tsUohj02VFrnDT1IONuPFUSuCqLwC+vDvNt808KmtXy6Y0qjkj0CradbZ5/
	 5DV0X5MFEd4vxab5lvEdly4c2CaC67Q7+ZJNdRjxkYf3xT6fzsEh+k0oqvtbTHhakX
	 BFESyxMO4uv+hy3MtwRM5af6cdmNO93Cb9bxJzcmcEs2x1AMi4ySyjU228xg/uPMKj
	 gzJM81ImFleqw==
Date: Sun, 14 Sep 2025 08:31:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Apachez <apachez@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Increase maxsize of io_queue_depth for nvme driver?
Message-ID: <aMbR0aWqFjklHzfR@kbusch-mbp>
References: <CALbmT6fF+1n+W1r+JNyr8+yY8Ub7PB6yYT2gpS12MBLbuHk9hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALbmT6fF+1n+W1r+JNyr8+yY8Ub7PB6yYT2gpS12MBLbuHk9hQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_073149_661239_3F15BA75 
X-CRM114-Status: GOOD (  11.26  )
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

On Sun, Sep 14, 2025 at 02:45:35PM +0200, Apachez wrote:
> I would like to propose that NVME_PCI_MAX_QUEUE_SIZE should be
> increased from 4095 to 32767 to match the current NVMe specification
> regarding MQES and to give the sysop ability to fully utilize the
> performance of the hardware being used, or am I missing something
> here?

We use the upper bits of the command id to detect duplicate completions,
so we don't have enough bits to tag commands beyond 4095. As far as I
know, though, we haven't seen such breakage in a *long* time. It's more
of a sanity thing to know with high certainty that duplicate completions
are not occurring.

But I don't think you'll see any performance difference by increasing
the queue depth. Devices saturate the link at far lower already, so
going higher just increases completion latency.

