Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D0FCD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0rq4bpZA2YAsQMhkXw2dOUmACHBkG7tzeov2Za/MF8=; b=AMQP8m0ey2VRSM7NmHd+gJDqwg
	A95u9Tb+YWeQp2dCDzqTxiOhdRshQRbA+RkooE1rgKugznH4CJeZ8tP+QpZuSacZ9SaWQHom7mz4z
	7M8qcVAvWromwrx7vXzrtk8PMO2pUvISLEApzgLrR4jcTdRfYvIMguDfkRFlWFp5ToiA1Qy7kltKs
	IXQCr+4zTTnl8/qELPNoEM4gwmyL2DPIDa7MzSVd13fSO4FqiHrtdYSf/1kdxANQz4GsJb7QyhCZq
	awoeVyS5fMgY1LzE7PTnNNrbRc8QrATSzA8FGILle9LGzZ6U/meK10ZkqYzfMLzQkKF54oPCjStVZ
	IWVO4+EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKg6-0000000806C-41FE;
	Wed, 10 Jun 2026 15:17:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKg4-0000000805p-3y9l
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 15:17:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 75C9A443F0;
	Wed, 10 Jun 2026 15:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212561F00893;
	Wed, 10 Jun 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104632;
	bh=o0rq4bpZA2YAsQMhkXw2dOUmACHBkG7tzeov2Za/MF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PIBzly6Lj8waoI9I2zDy+hiIAx45ZMmUdNJl3T12RGlVgWI9R6duuCfF8IZSWcZ1G
	 D5jsDlHnOEJW387lO78wgUVMIrUS6JQa+H/SmaSeT6pbQnUTK3oqp+0OOvMdahSLKK
	 PwsdxPibzyH9o5YKAW0+wPxAXRnC3XcTFBQkDlf2/Cx2XeuvDZ4Eit+EcdY7f+bFf6
	 vO7a9vLsMt0IeF7zJEbfc+RUKj4ixtd80+Up3BemiaZcd+p3pki6Nj2L27tAIKFI3Q
	 KxIQLsc0hvDqN7J4hb8GIDxoxO52HMX3gJKIJeqE/dpANfpU8GmJYOuPpsHoRzqWSN
	 Dh+eSMmTm7acQ==
Date: Wed, 10 Jun 2026 09:17:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, sagi@grimberg.me,
	mlombard@arkamax.eu
Subject: Re: [PATCH] nvmet-tcp: handle TCP_CLOSING state in
 nvmet_tcp_state_change
Message-ID: <ail_9nXtm8UmkWC6@kbusch-mbp>
References: <20260316164441.180393-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316164441.180393-1-mlombard@redhat.com>
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

On Mon, Mar 16, 2026 at 05:44:41PM +0100, Maurizio Lombardi wrote:
> When an NVMe/TCP connection shuts down, the underlying
> TCP socket can enter the TCP_CLOSING state (state 11).
> Currently, the nvmet_tcp_state_change() callback does not
> explicitly handle this state, which results in harmless but
> noisy kernel warnings:
> 
> nvmet_tcp: queue 2 unhandled state 11
> 
> Add TCP_CLOSING to the switch statement alongside TCP_FIN_WAIT2 and
> TCP_LAST_ACK to silently ignore the state transition.

Thanks, applied to nvme-7.2.

