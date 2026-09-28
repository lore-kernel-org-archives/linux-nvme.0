Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC974CA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=; b=PMv8MKGjkDeDBBGDzWfSpuEPrG
	MM6QBZ0dW/XpWf1K74V23P08Whuh7WQGacVKQqgWY0rK7kYAeQrA7Om4bca/V1QAyS1Jf7c151Pae
	0aXUfoPSwLm0e7CUXUHpZhN3tZdRr4RVcQmshj+T8tU5vXmsHZNFY2VQ1+USUFRrOKwNH7WxzokhH
	1ecWJUXXwPzvVW4T+723eWc6qbXzZ6Ou2qTKxwfrgpuN8UMbFCq7DELTds0XGFMGfU1vOGb/z8WJg
	vDJXN5n3r6HReSzbwJEo0gj09Lwjcr6ztZETl871wAvrZU3UNekVRuYbhGDlNmYrEXmsb+o0bmtsD
	8qpUdLhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDJS-00000000ulI-3u1R;
	Mon, 28 Sep 2026 15:30:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDJR-00000000ulA-1U3w
	for linux-nvme@bombadil.infradead.org;
	Mon, 28 Sep 2026 15:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=; b=eMRaTf5iVdtaMG116Ot4P/srg4
	Os9qkz1BV0C6D0JdBs3edYAmKKtYTei+imGrpTEf1pN2NHSiTltJM59zEVubqCpaX0y1WAZW8ekoK
	m4MI76SxSYfxX8urQqkK2VTJA/iMfYkN90FOcL7FWEhSk7HVlN5gS1YENyNfhK9qt9SI2L79ktIJZ
	04yFoRwcjAL6xlA0wo7WfZJBsCYnjUXLgdyEdySkdeoTnbGs5TBx8RW+vMZgXBVGOCroD8iigsXVC
	TOYmkuxIWJlokUrW7JoodY6cAgZJSmLJZDYdFByDY5h4QCzu+kE9oNQGiEeUSFkpnkuEO4nTv1K5b
	c9sCskBw==;
Received: from mail-wr2-x1d.google.com ([2a00:1450:4864:30::1d])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBDJO-00000001d7M-2G90
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 15:30:40 +0000
Received: by mail-wr2-x1d.google.com with SMTP id ffacd0b85a97d-4887d06c669so2459647f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 08:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609436; cv=none;
        d=google.com; s=arc-20260327;
        b=Prtu9R+6Mbb6+34vyJr7Y2PazUjpWwCqr/pgF3CL5zIfen2BK3rHSJfg0JXED5DvtV
         BBnJ1SYutPKMFCsAh4v0ZL2wz8WOEeDEQEeat7BF32I4d6KyVSG6N4jxi6RP42VFJrKh
         b0BhpyAn9e7wyvxZ4peaXJxXP5v94lK9W9W7UJs8T7M4rvKClrYZjThFQYo9GZm/fwas
         kZQ0TcOKffRAfkAfPo49b9zeW6Ry0NYH77BSMuia5dGxZbSTmBsA9Kci3BKVkrLXUym4
         c3hO8/EcwvmNmjEfiTB2ubc2rjqzBwossbSDNESaIvxFfX8vgtJW7u0y57/a7+17pERp
         AI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        fh=r7A5AxANwBAZ0HrtQ23RS7cJsJ/3yOL2WufubmUuUHo=;
        b=Hua/laHsU5cMtuIejIqYxVCtkWp3IFHcft/0YoAbk9Hq7KHFKEjZIzQruE2DI7+o8f
         epk9ydLk/p9ujRDAKz7qMWR9l2FxQtG5xm3LckO0QmH1KxkAyJHaQGu836F6TKbbG2JZ
         O9dHrztJE49eraxnawTE0UcbK8bOhvTWs4LflXxQJqC1QxtgQmRH5MYX/nx8/tUUCxwo
         rjcdNT+kC0/UOub+0AITgkyR6++SqO+XeG+2fyySingncjN1uYSbiLtEsJ7yfULZqJtn
         9h8sGXvy+IZW+ABA+sIq/pcp/cm152GKwuBj0L3nnUoxFNZ7ZnAVezcEEojttPM0/oin
         2dnQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609436; x=1791214236; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        b=cFxrcVbgmL1Dn2s5cG5fFFMmLVCCPNaD+buU8emqilgbKMXDpgWRT/yK6ey7K0fA4C
         shboBRWWWMbtICJqb3jwQj/W1ZnEgv1ipm+f8v4iYHp9r6kUyUrVAnEP1EoYKmA6h02J
         Wj4rc2GckSqavi+sXy5wLJa9s44hGHOnF5vpGbIaCZvRnaMBTI8zEub5f2KB8IIrGEPF
         2r+WElwcAkmvxkRYM2KXiDoMiF/w/tai1YnldE5BtQejWgx+dHMi2RatZ2ELq7W19e2S
         4+q850NWJsZCWiXrLznhXFR2nV9ywFS7+L9INga1qY6Gq5MGsXmqhBjA+Cv+Bk45hohA
         T9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609436; x=1791214236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        b=qp/pI8hyk6Sub6pGgbvF3b56nzgpuEc1xEzf59CUv+uVc516M3sgH/CiL0YytrdcZg
         2wZSVrIVASGowF/fbyOUJDDMd4q8UCG3KuBvvO+93oW1HUqXFcc2FuQ1u89Cdo0faZ9y
         4m5kGxIjxctvbjaF1ylJ/RU9B6LHYXKOBRLf9wMImVFlCjja+2wlvOvbGMu4SKqCXqwv
         KOozzWUueMMZCyFx91G3OkvWZb33SHdbZ/8SZ6hrwj1SUecL8ORifiMuaJV/mCMv/zK5
         5NYMQRxvkSOxpTHmgZP3VMAJ8h1mlAncjqQ09U15kxrgc0ZaeKXEE4uNbOkZt9tffSAO
         AeOA==
X-Gm-Message-State: AFq9FYL7gUSFp1u9pheiemoNTHBmpZNsP7upOMGLG9GCM63K9Y3yZt0k
	eHM+uXHH3RQY6sDreiS0HVy6ddmNApeFwJ4+tKjvAetu/ZKv3Fm92pmuVkTTKpJktY45ZwWcvU5
	q82r19CE6oHww0w4PP1dav6hBgvFKoAebEIKH
X-Gm-Gg: AYBFou1hTZTyRPrWMu9FY0paJidB4de9Y4GE85STFC9LAk9rPq1Pig6Ok66NJxqsP+O
	VRCqplEyzHnjY5WWIkQT7X/JcqDdYua5zgBa5fmwlFcAtoYj42CFeRhwiahgARbfd6IQ8QLC20O
	MggfyNtxfLS0xWzZaY8KGY0GzN1yywDr1CahzjOaruih8CiJrjqoVf/jbb6jZi3FhD4ojPyGQGl
	tUUH7kv8b4CjykWkZFxQfhiQ5m3Vdrtrski6rZxj0LVrQonoLB03wRaEPKDKNbYYkEjOZEkcdMA
	HNGA7uadnP7dDh2KCDInnDFPA4WbSbWK7l6PGNCeeyISlcK1x5cKn/W3IQPB5AQT3G4EJQ==
X-Received: by 2002:a05:6000:4202:b0:488:8864:e2cc with SMTP id
 ffacd0b85a97d-4888864e5b2mr12975651f8f.26.1790609435839; Mon, 28 Sep 2026
 08:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
 <20260912053921.49151-1-kumar.shivam43666@gmail.com> <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
In-Reply-To: <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 28 Sep 2026 11:30:24 -0400
X-Gm-Features: AclHuK_EFO-MrMNQ8EFUgp2EHKyxJFqvC1p70t-79Pi28sirn3E3ngQLYs1JnWs
Message-ID: <CA+ysrS+xp10hJeCKy70BirjEDengQvZw_o6X6fSUAh5kVGYCeA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_163038_679449_44F4C788 
X-CRM114-Status: GOOD (  25.42  )
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

On Mon, Sep 21, 2026 at 1:06=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> On Sat, Sep 12, 2026 at 1:39=E2=80=AFAM Shivam Kumar
> <kumar.shivam43666@gmail.com> wrote:
> >
> > A command that has received all its data but whose data digest is still
> > outstanding is stalled in NVMET_TCP_RECV_DDGST, where
> > nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
> > therefore skips it during teardown, leaking its submission queue
> > reference, and nvmet_sq_destroy() then blocks forever waiting on it.
> >
> > Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
> > rcv_state after that call.
> >
> > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> > ---
> >  drivers/nvme/target/tcp.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index e59810175262..3bf344b184e8 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct=
 nvmet_tcp_queue *queue)
> >                         nvmet_req_uninit(&cmd->req);
> >         }
> >
> > +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd =
&&
> > +           !nvmet_tcp_need_data_in(queue->cmd) &&
> > +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> > +               nvmet_req_uninit(&queue->cmd->req);
> > +
> >         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))=
 {
> >                 /* failed in connect */
> >                 nvmet_req_uninit(&queue->connect.req);
> > @@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct=
 work_struct *w)
> >         nvmet_tcp_restore_socket_callbacks(queue);
> >         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
> >         cancel_work_sync(&queue->io_work);
> > -       /* stop accepting incoming data */
> > -       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> >
> >         nvmet_sq_put_tls_key(&queue->nvme_sq);
> >         nvmet_tcp_uninit_data_in_cmds(queue);
> > +       /* stop accepting incoming data */
> > +       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> > +
> >         nvmet_sq_destroy(&queue->nvme_sq);
> >         nvmet_cq_put(&queue->nvme_cq);
> >         cancel_work_sync(&queue->io_work);
> > --
> > 2.53.0
> >
> Gentle ping on this one.
Gentle ping.

