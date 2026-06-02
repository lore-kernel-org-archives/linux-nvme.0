Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38776CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvgG8elpY5kC1tmOmtJ925WyWExqIFQwb9CQv7YaSuI=; b=WxJWxkNJGpn2IDICKLpe8uOwuq
	YFgpU/e7vUXqCvD/MjsQrNyRhVG/gWd6+DW0i5dOBG1VtBFo1Mg678P2nl0TRO0oPneO9KL1g1WQR
	IXs01s93qw/zVFLQR/vAaRr/VgTwDoQJUiSlrD4VsG/cc44EsICoqUreRS4NzpV/mAse/VYPCnBsb
	966Q7EO+RVvePjOfYr82YPy3WoSpHT3DGf5ojyA0Jb9hJw5w0wbHBM3AZqdh3K6F+jyUVUkg6SeTa
	VOJqjnZOmmy5zTM/y3sW+0KOmQZPOKwZUUK3brzBXhHaE04sXZGe5FlQyzOq1060sIKe1wTXfU77+
	arn6weZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKab-0000000CZsG-06EI;
	Tue, 02 Jun 2026 08:35:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKaX-0000000CZqg-2SDw
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 08:35:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5E1841A53;
	Tue,  2 Jun 2026 08:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC64D1F00893;
	Tue,  2 Jun 2026 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780389304;
	bh=JvgG8elpY5kC1tmOmtJ925WyWExqIFQwb9CQv7YaSuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzull5NKHCZc1Ix0SxveUYuTmAftN8ECgK2P/Z/p0MKEDSo3K3pB8xG+UgbJ6Zuoi
	 rNkNA2mntqBnfT2Ll4s/zGLOAF4laT1Fh8l1NTSSV5YfrjbQyL+jC2FozoWaGejJ91
	 MFDNdqrmeqOvR43sg8WG8EIz4YJHqCctZa8Tfu6Tm8OkCL1fYzzASMQwdxyQucl0Vb
	 0YS0u/aaPAoShYMlcNwJmAnLifJ8qj1bu90+fe4GcukHfWbGVUrKTlg6282lYCSPp3
	 FBDVNtv/dIZ5isc+SabhBGhL0m65O9oksPbluRn7DwQgpbYNdDX9IeFzTGKkYy+K4S
	 qxxW1b7UMB4fw==
Date: Tue, 2 Jun 2026 09:34:58 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth arbitrary kernel-memory read in Discovery
 Get-Log-Page (buffer + offset, unchecked attacker u64 lpo)
Message-ID: <ah6Vsn9eIBlgH_gB@kbusch-mbp>
References: <6a1e4ce3.77e39773.179d8b.1a31@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6a1e4ce3.77e39773.179d8b.1a31@mx.google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_013505_765307_076458DF 
X-CRM114-Status: UNSURE (   8.70  )
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

On Mon, Jun 01, 2026 at 08:24:19PM -0700, Jeremy Erazo wrote:
> I'm reporting a pre-authentication arbitrary kernel-memory read in
> `nvmet_execute_disc_get_log_page` (`drivers/nvme/target/discovery.c`).
> A single network packet to a Discovery subsystem - which by design
> accepts any hostnqn - lets a remote, unauthenticated attacker copy up
> to `data_len` bytes from ANY kernel virtual address back to themselves
> over NVMe-TCP or NVMe-RDMA.

Duplicate report:

https://lore.kernel.org/linux-nvme/39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me/

