Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088310A88E0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InFgNg8Sob57XbGGWSWjOFxbIcsiUOCIjDCKJai/WZc=; b=2gabmvOSuz/i2VWH3dOb8TE0k4
	DQt7dkXONlwtzLG+JwdzoOjJPLBgUl3vqn7f6REWyyNTihxqywhK71ehRM24p9qZjN4unH02JcFiM
	/Z+zousJjdkz5awzmdfMgocC8xR6HKzSW1gnPg4rzRGadtmh+h/DsehRKKhMz3MilfMTS731DjQg6
	C0L1NwhebIPPGP1EtCplzch4e522HpPy0P6uiGeNfugZF7YMMTcavrcSivaRmZWyUDzWE1ekKPjdv
	suD7RXs7JLMc7a3vZSXyGZeX5Wu6yjgfuScnjEbEq3y7BVCX+6ovQQRYi1u4PeLXy8uhm/e/BAeA/
	HGGaAtYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5npE-00000005sZl-1jt5;
	Thu, 26 Mar 2026 16:44:52 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5npA-00000005sYg-239D
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 16:44:50 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 00a924bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 17:44:41 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 17:44:41 +0100
Message-Id: <DHCV5X8OMDRT.2MN3IQBNXRGBD@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <hare@suse.de>, <sagi@grimberg.me>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvmet-tcp: handle TCP_CLOSING state in
 nvmet_tcp_state_change
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260316164441.180393-1-mlombard@redhat.com>
In-Reply-To: <20260316164441.180393-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_094448_859530_29C40E29 
X-CRM114-Status: GOOD (  11.39  )
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

Gentle ping on this one.

Thanks,
Maurizio

