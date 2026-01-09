Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD9D1A639
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8GFhFMY/CKmH6HmBpRE8aFWaOGC7MLEOUg+Ow/UuAM=; b=IrJ/44NYToYV5LihbArlSFkvbx
	fPDEvTEYlmP0aMm5vVPydp5f0w86TihsbhfmdSSxjYrwYZjnu55BasRYj2IRSNCdckTB0gMb1iMxI
	A62VZwC4SSn5ftx433XGSWw16XRwLQ2zWi56XW0aqMrRUoKo67fVom7k9P7sUPED0saXry3ePNYC8
	UwLObXTeSLcOZct038RoI+JnyD8+480MPEgXJXZ+LJtgRrc/P3x9xgUw0MmgBuc9mElxvIuoxg6sI
	q61waljXqIP9krSVC5F40+pwZj6mxkO+mj+fy72EHKktKzwaptxb85r/5YI9zrn12uJWPDC0ihocL
	GeZTOzyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDtI-00000002R8R-1gZz;
	Fri, 09 Jan 2026 14:55:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDtB-00000002R6x-27D5
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 14:55:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BBB041856;
	Fri,  9 Jan 2026 14:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9315EC19422;
	Fri,  9 Jan 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767970497;
	bh=G9Kulp6cAVnfRTKJB8kIRjClsN5/Uq9V4Uaw8mLNX9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpzEsQEOWk9ChbitNfs4+DYdZeKYDVJF6LAGiZTwH+sBimXezYewuTiXIYPYtHdVp
	 2saIGyavy/avQt6ncucujhMI3EjEMj2wfSSO168kgZXvXr9xq42oH4UYytamR+xbp6
	 uA20dM0yjaFuSH/FN6j86+kEG7XNzuKqUPV25cRfU6UoaJtMyy+FyqBfGPOVBHGcXz
	 s5CwJJT/SIcpaWajKe+tTZW+6QkHQkjyI/btKOZ+WZAyKLrYZQBk/kYXyNPnWTxNb2
	 OMwxGNFFr8nlgT2cw/YFI/DiNzWG6dHp1QTT+8w9U12nHfyxVnHsofweHaoS0yrdEj
	 jzXngpsDSDPpQ==
Date: Fri, 9 Jan 2026 07:54:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, hch@lst.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3] nvme-tcp: fix NULL pointer dereferences in
 nvmet_tcp_build_pdu_iovec
Message-ID: <aWEWvtMsh-aSViGy@kbusch-mbp>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
 <20251213185748.1060422-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251213185748.1060422-1-kumar.shivam43666@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_065457_563533_A8F962E1 
X-CRM114-Status: UNSURE (   9.85  )
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

On Sat, Dec 13, 2025 at 01:57:48PM -0500, Shivam Kumar wrote:
> Commit efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
> added ttag bounds checking and data_offset
> validation in nvmet_tcp_handle_h2c_data_pdu(), but it did not validate
> whether the command's data structures (cmd->req.sg and cmd->iov) have
> been properly initialized before processing H2C_DATA PDUs.
> 
> The nvmet_tcp_build_pdu_iovec() function dereferences these pointers
> without NULL checks. This can be triggered by sending H2C_DATA PDU
> immediately after the ICREQ/ICRESP handshake, before
> sending a CONNECT command or NVMe write command.
> 
> Attack vectors that trigger NULL pointer dereferences:
> 1. H2C_DATA PDU sent before CONNECT -> both pointers NULL
> 2. H2C_DATA PDU for READ command -> cmd->req.sg allocated, cmd->iov NULL
> 3. H2C_DATA PDU for uninitialized command slot -> both pointers NULL
> 
> The fix validates both cmd->req.sg and cmd->iov before calling
> nvmet_tcp_build_pdu_iovec(). Both checks are required because:
> - Uninitialized commands: both NULL
> - READ commands: cmd->req.sg allocated, cmd->iov NULL
> - WRITE commands: both allocated

Thanks, applied.

