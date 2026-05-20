Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2D9CD5BA6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XuumR3ELpsuetsgZhIwTN5JimHj8jH4OyA95lBtrTLw=; b=pVudgkKhLc5QJ7b2vu3Ae8P3X/
	GQcwOiddK8tY4JlhXV9Jog/KIyZBYU6NLKuHpzp2tv/SVfQaIOfMhsVpF4cIKB0thRgMIpI+dHqsI
	dUXajN/WQ9mz7M9gX6PTTWvjiTlwFe3TvYjvKBzdTTWU80LK2v7SSuGT9MZHiXuSa2Wyl+ckIc0dP
	MJLyUfZ60SsOVo5Lz6F/XJ/e/rsRHZ3QPt4i3CpxiAtIFTX+YAeAL9Rd4Yp+Kh8m4F0l7IsSoJmMv
	L28zBfv9aukiA75jabGg3bnyhW3f9OOz6u9s24BaIG3fy2cF9DkVz4AuU/DnuJG2L/QoR7+Y1rFHe
	eX5xfEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmfj-00000005cJH-45bS;
	Wed, 20 May 2026 19:33:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmfd-00000005cHf-1Vg3
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 19:33:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 96904441AE;
	Wed, 20 May 2026 19:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017F51F000E9;
	Wed, 20 May 2026 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305612;
	bh=XuumR3ELpsuetsgZhIwTN5JimHj8jH4OyA95lBtrTLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RRcnM8CC3aaLlqPZoXywt2/FILkZGvMmUUK2nPkREH/njOs+O20qui7EywHM7K6Ck
	 0Be8yLVrtQhiQ/cwOCHt+45brIA6nKj361FXOAFitEdr98XUjZilB0hMQq8z30ja+v
	 10bz6U3FcT315G/0pooJqzZpNhGeY3o1pYwUz8Jgxy+GY3PD3+UHIptuMfebBlxuSf
	 /Ofj3Tou54z9TkwsMb7aTjgDLprlYLKUJGTCr2jR5duq9zzFYe/lALwA2DoCp3nVJa
	 kwfdslPWnjtsut9ztFQdjwrUH19/6Kow8RjGdT07Q3wRWs0t+fSgY+Wq+rxJ2l942N
	 lyVtH6yJ5NZyA==
Date: Wed, 20 May 2026 13:33:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from
 Identify Namespace
Message-ID: <ag4Mism3AV_2nPDR@kbusch-mbp>
References: <20260515185853.2761456-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515185853.2761456-1-coshi036@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_123333_413813_1B054E0A 
X-CRM114-Status: GOOD (  12.97  )
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

On Fri, May 15, 2026 at 02:58:53PM -0400, Chao Shi wrote:
> nvme_update_ns_info_block() trusts id->lbaf[lbaf].ds from the
> controller and assigns it directly to ns->head->lba_shift without
> bounds checking.  nvme_lba_to_sect() then does:
> 
>     return lba << (head->lba_shift - SECTOR_SHIFT);
> 
> When called with lba = le64_to_cpu(id->nsze) to compute the device
> capacity, an attacker-controlled controller can choose ds < 9 or a
> combination of (ds, nsze) that makes the left shift overflow
> sector_t.  The former is a C undefined behaviour that UBSAN reports
> as a BUG; the latter silently yields a bogus capacity that the
> block layer then trusts for bounds checking.
> 
> Validate ds against SECTOR_SHIFT and use check_shl_overflow() to
> compute capacity so that any (ds, nsze) combination that would
> overflow sector_t is rejected.  The namespace is skipped with
> -ENODEV instead of crashing the kernel.  This is reachable by a
> malicious NVMe device, a buggy firmware, or an attacker-controlled
> NVMe-oF target.

Thanks, applied to nvme-7.2.

