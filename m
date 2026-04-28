Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A26FF886F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 06:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TSk36XRK3Jk2IKqr5MmN4Zns4ZrjmXWo8e9VE2gLHVU=; b=l86KHQ1W+aNXvkGAgMGXfSp4/d
	gLgCFtNozTmgB3iEGNSIUCLiH9qbqI0bZ9QCUP/8Gt+TVbCyLWsYzIhqXOTgvjhhcz6XU0hEwwzFq
	MQOeypk5DerA94JzRle9HYPYicEdExJB/uFrqIE45/zDE8tcQp2c7iwjUKnmxd0UwOYNtpeljlpdZ
	3/JmlHO+DXpOjE1OL4BnGyE2mNMPKugQNbB+CrwonGthXBYqrHWc/75PbZvpjHQ4sOyB6i6FvzOw/
	EYzSyw3q2DjYt124NOEYE2NAE3sE9fOzmcXljqy1dNeY86qyIiHW67tcs1dRL8mN29T9VzS6vL/6G
	9LyLSQLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHbc7-00000000c0F-18JD;
	Tue, 28 Apr 2026 06:08:07 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHbc0-00000000bzi-1pK3
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 06:08:02 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id a6a8655b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Apr 2026 08:07:57 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 08:07:57 +0200
Message-Id: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
Cc: <mlombard@arkamax.eu>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
 <gregkh@linuxfoundation.org>, <security@kernel.org>
Subject: Re: [PATCH v2] nvmet-tcp: set a default MDTS of 2 MiB for TCP
 transport
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Shivam Kumar" <kumar.shivam43666@gmail.com>, <hch@lst.de>
X-Mailer: aerc 0.21.0
References: <20260409060835.GA6389@lst.de>
 <20260427004406.2971227-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260427004406.2971227-1-kumar.shivam43666@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_230800_815480_22C24DE0 
X-CRM114-Status: GOOD (  15.34  )
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

On Mon Apr 27, 2026 at 2:44 AM CEST, Shivam Kumar wrote:
> Unlike other fabrics transports, the TCP target does not set a default
> Maximum Data Transfer Size. With the configfs MDTS entry defaulting to 0
> (no limit), a remote attacker can send a CapsuleCmd with an arbitrarily
> large SGL length, causing sgl_alloc() in nvmet_tcp_map_data() to attempt
> an excessive kernel allocation that triggers the OOM killer.
>
> Set a default MDTS of 9 (2 MiB) for TCP. Admins can still adjust via
> the configfs mdts attribute if needed.
>
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> ---
>  drivers/nvme/target/tcp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a456dd2fd8bd..d09c81d07a1d 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -25,6 +25,7 @@
>  #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
>  #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
>  #define NVMET_TCP_BACKLOG 128
> +#define NVMET_TCP_DEF_MDTS		9 /* 2 MiB (2^(12+9)) */
> =20
>  static int param_store_val(const char *str, int *val, int min, int max)
>  {
> @@ -2067,6 +2068,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *np=
ort)
>  	INIT_WORK(&port->accept_work, nvmet_tcp_accept_work);
>  	if (port->nport->inline_data_size < 0)
>  		port->nport->inline_data_size =3D NVMET_TCP_DEF_INLINE_DATA_SIZE;
> +	if (nport->mdts < 0)
> +		nport->mdts =3D NVMET_TCP_DEF_MDTS;
> =20
>  	ret =3D sock_create(port->addr.ss_family, SOCK_STREAM,
>  				IPPROTO_TCP, &port->sock);

Ok, but what happens if a host doesn't respect the limitation advertized
by the target?

The spec explicitely says that "If a command is submitted that exceeds this=
 transfer
size, then the command is aborted with a status code of Invalid Field in
Command."

Maurizio

