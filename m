Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5933C87FCA
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOoB0wyUZgWGX3/VU/XGjRRLsaNTQoxSLcM56m289R4=; b=s6Noh4cngniKE5YSD5rZOkQq2Y
	MThsz1PxzwH3GlOVxrJ5J/WByLEb7N/YboM5XhD0rxMXODmv976nqUA3vCoZEuUHbrvxmVIhI4XnH
	47eDtzolIYXt8WgHfZQ0IihPs6dkpi9urEx8Jv/sXuFecA/yW+hbonwfcg8SiLr9RZ2c8cXnWzTb9
	7dii+1yRkHrjcf2WFsPaQBiScd9G2QfyoTFQXkoLIUc/8n5sEjB7dmWwwsB+oTR1BCbE1gxolDfr5
	VzmlCeS0bjRRt+DHY6gGolmcSYcQQ9pIq6L85q2Roh61VfGbIesR55nI2qNOcX+IWr1ZRi0hmoUZx
	bH19TCrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXRy-0000000EOOd-0AKX;
	Wed, 06 Aug 2025 06:16:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXRv-0000000EONV-21sJ
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 06:16:33 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 800faa01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:16:26 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:16:24 +0200
Message-Id: <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "linux-block"
 <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
In-Reply-To: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_231631_858164_B46560FF 
X-CRM114-Status: UNSURE (   8.24  )
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

On Wed Aug 6, 2025 at 3:57 AM CEST, Yi Zhang wrote:
> Hello
> I hit this issue when I was running blktests nvme/tcp nvme/060 on the
> latest linux-block/for-next with rt enabled, please help check it and
> let me know if you need any info/testing for it, thanks.
>
> [  390.474378] Call trace:
> [  390.476813]  __switch_to+0x1d8/0x330 (T)
> [  390.480731]  __schedule+0x860/0x1c30
> [  390.484297]  schedule_rtlock+0x30/0x70
> [  390.488037]  rtlock_slowlock_locked+0x464/0xf60
> [  390.492559]  rt_read_lock+0x2bc/0x3e0
> [  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
> [  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]

I think that the problem is due to the fact that nvmet_tcp_data_ready()
calls the queue->data_ready() callback with the sk_callback_lock
locked.
The data_ready callback points to nvmet_tcp_listen_data_ready()
which tries to lock the same sk_callback_lock, hence the deadlock.

Maybe it can be fixed by deferring the call to queue->data_ready() by
using a workqueue.

Maurizio


