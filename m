Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F38CC2D0CD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcCwQk2zdcqbYLtEHKYcnXSPH1rgzUUWk5IvUPz0oLY=; b=XwEnq490BnUcYrYZexVnGansKV
	dXRCf7OoLrwdXxJj7fz8ePRoULhnW936XFfkkRKIybMaQD2+SNcj1g8ZHW93uBSlBfClSGBdZ4Zsp
	StpxTKLLfOzlYrWxm0DueR8z8GC7APS3i/5KH6l/hjw/jLcCAmLqwiiBBuNwZ/nYtLL13TiS0De5z
	vNCrjXEXgK72tIGjbB4Ey3WY8BEoPXrWm2vDH7IqWpk13M43XZQOxSWyhMUt1OBgnmJGQ0OPfLZ76
	qmJuGSIePMVAB0aVEDXP9Cr40xI5wQmbam0YEN8eDAGkxhZrprPjYo/ZMNoUqya66t/vjE86hY38g
	4NH1sEEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFfA2-00000001nQj-3cYi;
	Thu, 15 May 2025 20:26:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFewk-00000001lfM-13hp
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 20:12:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A23B1434A0;
	Thu, 15 May 2025 20:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22F1C4CEE7;
	Thu, 15 May 2025 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747339969;
	bh=fGPTYiA6cdbBydyA22vKFEs2piBzXgBhEu5Frcpbros=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVlfuHKgjAfU5NWY8AgjXLeWjafxAwEFhJBl5HWk1jgr7/FqCdrcDoxZ5UpRTrIVx
	 tFOeGFiM0DfmxTyQbGMKHB/5Lg0mpryUEwoTQMVe/dx5w0m/bkNV94/HxC1RRzHNg7
	 OabmtMEN2j/tIV+ugY/gBAe6F+9Qmb+YpJ3vKYOug9Eu3adVO43emVVAXRhQ0dQD2c
	 sRSLixA8n+IvpBFntjGRERkUn3e7eg2k1JbSRCF7kugaoCcadw8vdLRG1M1vZyLVAi
	 lhsvKhbttP/uvfXmt3MUTcSklnUou90moJEaYY4jKLScbZsQRNagW3+Q4XfM9mfZL0
	 RCIw2ZZXatXbA==
Date: Thu, 15 May 2025 13:12:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: netdev@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250515201247.GM1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_131250_316562_ADBBA625 
X-CRM114-Status: GOOD (  15.64  )
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

On Thu, May 15, 2025 at 01:02:20PM -0700, Bart Van Assche wrote:
> On 5/10/25 5:41 PM, Eric Biggers wrote:
> > Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> > does CRC32C, just call the new function skb_crc32c().  This is faster
> > and simpler.
> Bernard, since you are the owner and author of the siw driver, please help
> with reviewing this patch.
> 
> Eric, do you already have a test case for the siw driver? If not,
> multiple tests in the blktests framework use this driver intensively,
> including the SRP tests that I wrote myself. See also
> https://github.com/osandov/blktests.

No.  I'll try that out when I have a chance.

If the developers/maintainers of the driver could help test it, that would be a
lot easier though.  I've been cleaning up the CRC calls across the whole kernel,
and it gets time-consuming when individual subsystems insist on me running their
custom test suite(s) and providing subsystem-specific benchmarks.

- Eric

