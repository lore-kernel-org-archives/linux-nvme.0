Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E39CCA470
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erzsNOhJYjArM8j6Efz0Rkv5OHx6MKiQG8qPEOdCBmE=; b=yuoKGVeRzqhUHErd/aOBm1XD8w
	K9xhWdfioa63ofFMViG7i+/CUnsAtPPCW3dRVGA03APfDHEIRsQMbT3h8GhKzVd53SkKI0n0IpUAB
	t+Lt4XLTJPpeLMNP5mGDiFbL7KgpSp7cWEfhqGYt/aIRcfE4VeqRmNb3z56XMK1aoBr56me8Z7/Ux
	MpRwtha8YYwAb4xRrY2YNOkymhAHMd3Pi2h4+62bRaUuMKshytAEG3+nAhsMNoI4m1Ioj51v1pvZH
	ZMwfJ7I5vxsF2QgqYkcTfvAWhGuvJZgCo/xsuRri5DJAdvp8OwOhOzRyQFcoUmdbqW7v9vpFvBdGt
	6W6HSHTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v619z-00000001MBF-32UW;
	Tue, 07 Oct 2025 06:26:55 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v619x-00000001MAo-1tRE
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 06:26:55 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 7898268e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Oct 2025 08:26:48 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 08:26:48 +0200
Message-Id: <DDBVK80QRT7V.2R17ZR0TPDAHO@bsdbackstore.eu>
Cc: <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: remove a redundant line in
 nvmet_tcp_release_queue_work
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Tomas Henzl" <thenzl@redhat.com>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>
X-Mailer: aerc
References: <20251006175910.62721-1-thenzl@redhat.com>
In-Reply-To: <20251006175910.62721-1-thenzl@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_232653_905985_4D56830C 
X-CRM114-Status: GOOD (  13.28  )
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

On Mon Oct 6, 2025 at 7:59 PM CEST, Tomas Henzl wrote:
> cancel_work_sync(&queue->io_work) is called twice, remove the
> second instance.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
>  drivers/nvme/target/tcp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 470bf37e5a63..a1d0f6b18b2c 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1577,7 +1577,6 @@ static void nvmet_tcp_release_queue_work(struct wor=
k_struct *w)
>  	nvmet_tcp_uninit_data_in_cmds(queue);
>  	nvmet_sq_destroy(&queue->nvme_sq);
>  	nvmet_cq_put(&queue->nvme_cq);
> -	cancel_work_sync(&queue->io_work);
>  	nvmet_tcp_free_cmd_data_in_buffers(queue);
>  	/* ->sock will be released by fput() */
>  	fput(queue->sock->file);

I am not sure it's safe to remove it because io_work can potentially
re-enqueue itself.

The second call to cancel_work_sync(), after rcv_state is set to
NVMET_TCP_RECV_ERR, should ensure that no more "io_work"s are pending
on the workqueue.

Maurizio

