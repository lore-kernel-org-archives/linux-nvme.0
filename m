Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC3310F9972
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+U/K92nZbnLJDmQ7H6E3zKRaFwY6Q8XpX63wgDgatc=; b=OeykZwcxGgJNUIPovNJwwxeE6U
	hXM6bTvxte+PseYJKkOFIcVo0zccqvuVLbqHpsj3Xfo+0KrjW/u8q2qcP4tZiDzD1iCKdGXrmQLAL
	1En+1GJIfAJoaospcHgW9cHkxpaqMRAJDi8tbiJGgJzyIVjlOmODibe+J643Kdn1edN5kaabWFllm
	cw3ObRp8IhSVT4nemO+C0KCuOjl/XtJS7QjIAFOeNIuuMSWGRnKo6WmHGEwa5GoJ5SM6lzIkgc//p
	4Dq1FGzuUsXd5yBs5eBuz6938gLLfcId0YlhFshmPhiGJH3QZkXsuWsje9Cr4UJvOgITSlk+P0EPT
	A3/VeAcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYDS-00000009If8-17Nm;
	Wed, 08 Apr 2026 19:05:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYDP-00000009Ieb-2CHE
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 19:05:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C594140472;
	Wed,  8 Apr 2026 19:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAFBC19421;
	Wed,  8 Apr 2026 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775675126;
	bh=Kn9tvhcYKPE42NCp1qQ16WUPx8CvAMx9aG5ZfwSr8Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZmPBfOm1Mt5Klra6xSt1TZAwxRwM2ZrfDT49RTts9HEOKcbsjbecjT/XARLkmquA
	 7Tc3R9WC5FkQqt/IFgblLyMA0zUAKgIMkP9SZwfl9BPLDOrkxYBs5c+etPtnYPbU2r
	 t0m7dCUdWW6hYLJ0CstIfGKIXqaXUouMDtJ8Lzb4jSQAOb2LxSZFQbdIm9oRABMJ6w
	 D5D0xaR0Ndlp+iaja/gkruQBReVDs7YQNEol3wyua4Zy/NmfrfvpaAJmnsIOC9gY1T
	 FPLU6rE61eV3Gbu2a3fqSmsBz6pFBm6kTN+/UV8Y2yOQcZ4w6sbORb7j75ff0PgHCP
	 02e1OusqTuufw==
Date: Wed, 8 Apr 2026 13:05:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: Re: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and
 state machine
Message-ID: <adam9I0CCWi5_Ipl@kbusch-mbp>
References: <20260316143936.120999-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316143936.120999-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_120527_584705_59AC77B0 
X-CRM114-Status: GOOD (  10.80  )
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

On Mon, Mar 16, 2026 at 03:39:34PM +0100, Maurizio Lombardi wrote:
> Patch 1 fixes a potential issue where network data could be read into an
> uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns void,
> meaning callers are unaware if an out-of-bounds PDU length or offset triggers
> an early return. Consequently, callers blindly overwrite the queue state to
> NVMET_TCP_RECV_DATA. This patch modifies the function to return an error code,
> shifting the handling responsibility to the callers to ensure proper socket
> teardown.
> 
> Patch 2 cleans up redundant, localized calls to nvmet_tcp_fatal_error() scattered
> across the receive path. It delegates the responsibility of executing the fatal
> error function to the top-level caller by bubbling up the error codes.

Thanks, applied to nvme-7.1.

