Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A455CCD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uc5E+GOo9Ti+HLKRxWPZb9QJwMUCbl8G9oqBSZ89rL4=; b=blEGiXahF4IHqqjI5RGtIHB98j
	/jy0w49y56RUCm7+MJj5Jm80PaYinMmJZgCBiG92+KECFwffmY2+8P5CKJbpZw4ilnzLhHgITRmnD
	7EVj/Snww25AQ8chnRHLjJhp1WOcDKPLQ0cmCt12GNbx4QsST7yE24rBcV5Y+cuCVKqmIv/JApTVP
	oODf3NZFmq/P+YUoIka2Zrmoqt+Geqihiv0WiDI1sJ2ehOwJjEwWuJ24LJqgm0XmnnN1xqD+sp6WT
	2+2oZ1XmYxuECK/Q7WjlSx0d425h4Iugrk0nzHPSiwDWoLCfu+QvvmO2f0BmxD74cIs+kcRcm0j8f
	spXYPHgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKDA-00000007x0d-432y;
	Wed, 10 Jun 2026 14:47:20 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXKD7-00000007wy7-3CaW
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=fLcK4QgVX74lcd
	NB/SKVPXx3MAr94VM7+WZse1gYT98=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=TOO64i1tvjxJ54LqSLyrFbwbDmY4+th+amgUG
	caYPuq+5rEp+QqlxIoCMKKgX5aW7Uc2bTIejHeBCuT1TC1flCWgcCqY0zu05d3d7qk68xG
	VVrnfN1rEJxWsuqLWzLqFC4dKSgnT3mRClbhwCnaZBZzt356Inb0HrlWcMD3EScHov2rrO
	3El7GG/DCFyyC7jIkTa/Mk+gb6lqnBrC+Y7+QGsmFbmO2si6HKYtu5dg7bgxm3V8VXsG/c
	upZsnvqm6OBw8kTj1w9txPuMextp2ZT0P1ztTC3Tu/f7HGjuZU+akUmC05mTSjC25jdPAs
	1olSc+9q7pWp3PhSToS3f+BUQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 69901fb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 16:47:12 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 16:47:12 +0200
Message-Id: <DJ5G9DKDHTLN.XZZ7G3J78S1X@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <hare@suse.de>, <sagi@grimberg.me>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvmet-tcp: handle TCP_CLOSING state in
 nvmet_tcp_state_change
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260316164441.180393-1-mlombard@redhat.com>
In-Reply-To: <20260316164441.180393-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_074718_151715_4F8FCB59 
X-CRM114-Status: GOOD (  12.47  )
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

On Mon Mar 16, 2026 at 5:44 PM CET, Maurizio Lombardi wrote:
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
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index acc71a26733f..ce497843b979 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1667,6 +1667,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>  	switch (sk->sk_state) {
>  	case TCP_FIN_WAIT2:
>  	case TCP_LAST_ACK:
> +	case TCP_CLOSING:
>  		break;
>  	case TCP_FIN_WAIT1:
>  	case TCP_CLOSE_WAIT:

Ping, it looks this patch has been forgotten
Can I get some reviews?

Maurizio

