Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E070DCD37BE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FwFa4F/v/Sb/Xj10Lk5oy2v43Dl3klb2zErMbuOPZe0=; b=lQRoez9Xy5nxTvqCyP9P8VdZp9
	CTmySaqiwL8ICgUm8Awt7OlSav7HzV+sMioS0buZtznqpTtKOGKm8TYBAIH+vump2v5LQOEB1WJ+x
	+8BoCRwGsOuWIMB70AhN03G85yvyefEpkrESU6do/RdMC/UzxVWZUOJeCMjJZaNpnMkmEUwXpqhOF
	ebCNozCdEghbcc88k+GaoPLIsFPA0LbNe1v5fDwAhPKnO9JF9y77SnewbmEHZBcR9zqfNvP20yEd3
	zMGjHP/3R+/w6xfBQDB5hu8vWFkcblhAwkAghtbUuDjGoLbZfRecerv++pWK+WCn0vYCnK6lskPvW
	gH/q9hGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMS6z-0000000DyeF-0ytv;
	Mon, 11 May 2026 15:00:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMS6x-0000000DydF-2zJo
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 14:59:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D195B60121;
	Mon, 11 May 2026 14:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D57C2BCC9;
	Mon, 11 May 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511598;
	bh=FwFa4F/v/Sb/Xj10Lk5oy2v43Dl3klb2zErMbuOPZe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKLCQIWQlZimK2UeCTnL42peVusFJh0bTWBvIAC3m4OnRuU8CVvCGfIbA9iyJXOHc
	 PHM+a9MisZyYKPUi8eKj/anLzZt1lBYUbXKTk5QTty7h41vnA+mkmDYGK7/7fBOaxx
	 dVpWx42oFYpVO1A1XGzkavQtfvnVkl5LbmrXDvE9nVW/acnjJlNQCGfB4hZOOGlM/j
	 jG/adHjNAFM+EM+AMWIPBecyI/SZZuEew2FEjjTulO/2kWpxmP8DxXiVg/69TJIrwD
	 4z4VEhl4KvPXQrHzIWXh+u/pCeuAHGnCwbSWP2JOUssxzElUujeTUl2iVHgWx8xnXS
	 zM9X4MtQbIsxQ==
Date: Mon, 11 May 2026 08:59:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	security@kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix potential UAF when ddgst mismatch
Message-ID: <agHu7NoaTWC2ksJA@kbusch-mbp>
References: <20260510203029.119712-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260510203029.119712-1-sagi@grimberg.me>
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

On Sun, May 10, 2026 at 11:30:29PM +0300, Sagi Grimberg wrote:
> Shivam Kumar found via vulnerability testing:
> When data digest is enabled on an NVMe/TCP connection and a digest
> mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
> data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
> calls nvmet_req_uninit() - which performs percpu_ref_put() on the
> submission queue - but does NOT mark the command as completed. It
> does not set cqe->status, does not modify rbytes_done, and does not
> clear any flag. When the subsequent fatal error triggers queue
> teardown, nvmet_tcp_uninit_data_in_cmds() iterates all commands,
> checks nvmet_tcp_need_data_in() for each one, and finds that the
> already-uninited command still appears to need data (because
> rbytes_done < transfer_len and cqe->status == 0). It therefore calls
> nvmet_req_uninit() a second time on the same command - a double
> percpu_ref_put against a single percpu_ref_get.

Thanks, applied to nvme-7.1.

