Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B58C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=; b=vF4cMFOZSEpmK4g41DhLG63UY5
	f3ZPWS9sJAuLjHa2cKXPLBVdgS5yMYHOKE4QBV3nfvHD9rTRxEllB3V+dgceuD4ny+3SJOW2L4HuO
	VAjFNDjdIs0Cpxo6pC0LlH4v0lexOxkE5oR59625luBnV1ZjhY05bwPlvgoapJBNpfWHmOzjEWHhG
	oomL9d+pUArAaq2K3JrPkuoXFRpEnPD/t3i2c99HNfK5wFG2u9HU4F+y3MxWdN8IQZnP0OgxhCbF2
	P5weWPtORlcr1WscKUX8KrmgC7xiqXWC9UiCXrQfNkLD+nlSvBNLW5kdi+7p9ZWo0no1p6l89sbnp
	VM3lvBkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hTP-00000002wKm-3S9D;
	Mon, 21 Sep 2026 17:06:35 +0000
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8hTN-00000002wJt-2DbE
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 17:06:34 +0000
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-482f63546c5so2547706f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 10:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790010390; cv=none;
        d=google.com; s=arc-20260327;
        b=jVM0R8m37q5GWGhcgz+BvfbRnED5fwSRaTkxxShNA4NF2QlLYo+rU6SBnKnJJ1O7Yc
         Ba9jnc8kVO58t7KbanaAcofIM5B7w/vmxvm/McnJ+4Kscq7jm02nUX38m30TXHSfwuaC
         K7sNGDnspuiBqA0vIiJOGqZbFG2tKeObiU2kDD+DlS1ahHgIYWwVfqegXGTyAG1To0Fl
         EXOFIe1bJlONLDP17VPmVww4fD7gsMJQ9rAFZAzaC5mE0YXzpePwZqFJ0oIlSdsT4qCo
         3JqyMrHHU7mA6citVTz8lfl9/2SPuMZyKvfOibr6BMrPt9HJnyCcmpcDRG/4hOyAsx2R
         mLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        fh=r7A5AxANwBAZ0HrtQ23RS7cJsJ/3yOL2WufubmUuUHo=;
        b=NoNW24FKDVicaeyPlr6WdW2uFwxYnbdQODR8b3zxdVDPZ1uHFGTX/nK8qi19BXGMB7
         54sASwWKpG3gkK3orTgzwD88p8SxdovrDtf7sQPbIgzqpNzhyaA+2eH0c9d0iM70oqFi
         orerCGTsKE+o63mcewI0nl2ES6Gv5sQZDK3NVj7J9fFWtINvKjMI6wshKL4MjfLKzjrr
         2w6scaOcBE8kW63Dpqv7A27AP60uWwKxzxxoyqRNSvClDIaqH1YcJTAEUmvwW11wJPPA
         WLT9HoYkJQbtkM5GNS4SeKZv2ol6Fswm/6wm19io0CQADk4t84aDIjr+YPnpsndUMpGU
         Xv5w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010390; x=1790615190; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        b=luuD6L6NSlptYmesmcwmrWPsk4SZDUF73jV6zhNvrIDKj47xHy81jrNl0Ox5LjGnUh
         YkyCCQbvj6Krjke/MhIg+IzxQnpv1F9DQqdXYJNbChoYL+XstDkeWdFq2lSE3bGMzXj5
         yd/YWBxIxRVPU67M+J2cQ0Lg1o+w0odJzrStycpQvgEbTJTo9jnr08+6eScmleujluDb
         84ziqU5saXl7lEDoYFXTePolLAkyuD/jCDsY+Dbu6jzNm5xfi0chXe2gUtFTA6YUxIGQ
         NWevTyNc4WOt/oSTXco6LorY86u3WPPKwmbcB1SrMnOW0XbMxMvGtRTdXGioL9e3XXOG
         euLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010390; x=1790615190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        b=B9+Yi8NwhlC2nBg13r8Ho20RcmGQPxxzPIFqHGvAfGpPRxmtBhl2Mhzt40BAaNvree
         W7fDBZkzbfd4mKWiYpKezGyymxWK3oOD7cv0LnZ+tuJaK8K9SboQwIkSPiYgIEi4334n
         Y82/APmYjbYNrVGVEgoLFbLiFWTSM+VBtV0OzXtQH5+azoiMN9s9mOLOwAx9ZswYCmuP
         7XU8oE6GeDLomS25+2K3D+dJRiAbSLhCnUT8VMfc3ziagN0JqGtXF/P/OmkiFl9Vh5If
         II98R1uwZqXg+CUtLBngVPeih0KeYDvwnESPm9HoOIIDaqtmaiuugsjxPIvYGCOKGzwh
         CrTA==
X-Gm-Message-State: AFuF++lZhZ+zsx6YSuPZuvwoM324jVxHY1yXO3bvztzMGJz+hb5jWkuN
	k2h0PXnIVIhM3YSU0Z28oHcMLz/z/f8+aICDpxnoOXNd+rnVoSpqO3qE/jrUFPWGyInRnDEfbZ2
	5uqj7f4q7VUWL+F83eYzWFvs3uZRAQOxILHK4D68=
X-Gm-Gg: AYBFou1ojgyq6U3cyven/egyp0Msu9l3osB534nms+Dibkgodl/S5r0ck4zbSbxsBYD
	dH3RtQkZSu69MUlyFfX0SM6tGK+LAj3eRI+LURMVqQTxzVnWtX1XW7f10pZcNPcTqLi0+r1LxQl
	TrO5V8eX3T7a03FOWGquVnlVYVMx/S9CSdIJipNh0jzO7rtFUZcbvxMVx7CitNDqSitrZjD0byo
	82RZgyHkPpJ0qXXpIyPWL8vSNZ/gJ64WpzIUvVq9NfEX/zo2ZCZ6Kjo1gqghil08tQTWpifUMq8
	cq2DH67aJM1JBZFfIzWiz8g/AG+DsrHJgMr6YcJOVmUuKGIb5XfxG5sfXw==
X-Received: by 2002:a05:6000:288a:b0:487:b44:a561 with SMTP id
 ffacd0b85a97d-4871e21231fmr16437625f8f.10.1790010390061; Mon, 21 Sep 2026
 10:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me> <20260912053921.49151-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260912053921.49151-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 21 Sep 2026 13:06:19 -0400
X-Gm-Features: AcwNN1UxlKOlhAl4RVco_AYxwNupTP3xOjulgztmGStoHgdH5AIdgx-VsINsQOk
Message-ID: <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_100633_585877_198342A2 
X-CRM114-Status: GOOD (  20.47  )
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

On Sat, Sep 12, 2026 at 1:39=E2=80=AFAM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> A command that has received all its data but whose data digest is still
> outstanding is stalled in NVMET_TCP_RECV_DDGST, where
> nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
> therefore skips it during teardown, leaking its submission queue
> reference, and nvmet_sq_destroy() then blocks forever waiting on it.
>
> Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
> rcv_state after that call.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> ---
>  drivers/nvme/target/tcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index e59810175262..3bf344b184e8 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct n=
vmet_tcp_queue *queue)
>                         nvmet_req_uninit(&cmd->req);
>         }
>
> +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd &&
> +           !nvmet_tcp_need_data_in(queue->cmd) &&
> +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +               nvmet_req_uninit(&queue->cmd->req);
> +
>         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>                 /* failed in connect */
>                 nvmet_req_uninit(&queue->connect.req);
> @@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct w=
ork_struct *w)
>         nvmet_tcp_restore_socket_callbacks(queue);
>         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>         cancel_work_sync(&queue->io_work);
> -       /* stop accepting incoming data */
> -       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
>
>         nvmet_sq_put_tls_key(&queue->nvme_sq);
>         nvmet_tcp_uninit_data_in_cmds(queue);
> +       /* stop accepting incoming data */
> +       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> +
>         nvmet_sq_destroy(&queue->nvme_sq);
>         nvmet_cq_put(&queue->nvme_cq);
>         cancel_work_sync(&queue->io_work);
> --
> 2.53.0
>
Gentle ping on this one.

