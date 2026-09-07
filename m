Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8CFC79F9E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=; b=uuIUeYQPoWnn/I+AUqXnxbjqWB
	vi9KOexiZTGiDMenJlF9qv67zK+Hv2z8NjLxms964bUFYjNcXAyJ0inrbHpTSJuU42iSNIwSi6t1b
	AlXvk37DP1eulZHigX7sDQRq5i6BD3p9pb6zMDD6aRYrFG0tWOd7ERcBElwfBtYbkMhyqPDsc5mC4
	5zC6JusdcT+jpYB4NOWaMA0FtHyzzlWFgMtVUmHKahgUYWKXc+vyFcH1Nu/6IlMgCyOMaLv9EZCZe
	aEKaQkSli6h9zpvj6px7/NZ8CP5geoG/PoEebTRfn2mYIfrM69G0Uh36Fjf4uJmc3T93as3NB88oS
	Qz316RnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3iV0-00000007pfk-1IlW;
	Mon, 07 Sep 2026 23:11:38 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3iUx-00000007pfO-37kD
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 23:11:36 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so20434845e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2026 16:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788822693; cv=none;
        d=google.com; s=arc-20260327;
        b=GyIleJLeVMdq/w0ECikdMmGPOXQ4ieJUOkhnQJAqTkQeNvKNZ3NSoGe9eodKyfSPkJ
         /q6lvSQnssuqkeMluLCIbld5DW/QDxCETBseorYTUw9UMkVgUBn1I0qbjoJVVUbsDmnD
         XtU83a7BQGHOWHBuUlw7QtPRrWJojn22hwOXYMXpoUa3tFk37Kh5wf0/4kIQBErj8miJ
         6766jhKoQzw8LWdSgnUUOnzQgqR9fn5r/l2MQhMdGgGXy/XCvmAiCkmLTroKa0MAYSrA
         VYAi5sS9eyoKgKb5bwTBneVkvm11UHOJrfW8/M8M1HWHJA+n/Hv7Snbqpzl0mBCmoNe1
         j/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        fh=1+EZC3KSu6PztQDOasIGFAa7xaaZ3ZUT6WJYQSe4LTQ=;
        b=GbNDI15lBe3uR6U7FnEZibJoYabx8m2eRkzTbZLWTeHVu4yJ1myjtqbgY5JzOXOLXL
         PW8XCa2s+obXGF/adbJMHZtptiU9LIGm+VDiCeAlx9PMwNCuRqj5WGHska/gQTJdoeue
         BtG0WhQIzxkgEpvkoSX0sJ0VZZApANx7UK1e+lk19G0dBqoCjbPziAMSU6IzHmP3qYcp
         GSmrPvZR8WoKR1kwwGn2SEH42/9IPOWZeDzBIvCJLyWbHEl4Zh90hMZTg3S77sl9ddeu
         gDbTaGa1g2j0pyeK/6gKx+5v2qNzLfxsxqIM/oZLt/RsY1PZWJZpNtBAMjWtbKC531dO
         MQ9A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788822693; x=1789427493; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        b=R/LIqz6orfCWo5Jk+dKCAOZtCI+OXqpj6PfyfDQoh6dXjakcx3bR+mafEAPI8+CWBc
         2eJXxtnPs+pQ+tAGfdAAUEnYTLP9jnpN5/6Ui34M5wUXCnJ3FzhIGAPZATv2Ouw/8P2G
         jyau9kHD1iuX0AuqyUW5rMvPWv2uv+nXYRBuUN8TjfcOO9FQDIKUdjk75gd8uG5YNkuc
         gcFtw+ZsEgi4N7Ru7rkFeXBa2y0sopYIjekHvPU1dGKqJf9MIJ1CHiuk0K6H8QAjc/dQ
         Nw/gRN94LTcXrz3vt8Uu6xfnk9lEoUILfP9T8/EnEl2zE/8bRNxG/3hfDN8sJnnVFJ4r
         06Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788822693; x=1789427493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqYGWCrCxac5SzvL96KWqfYKXYEqviRZTXDmQqhana8=;
        b=ow2+z2jQ42l91fdtBzbbf4abD7XYNYVSc3Ixdgm9DHeJEBbeQ/tC43rVShWJSWFMGT
         KhLqWNEFuYDvZfwujLCd2NqMjvFXnhD8biy6pG1MVkuIZhj1ouTz8t+b+TF1NnOTVsGo
         ZxoxvzsaeVxsBKfr3zVHHH0iz0yTI2a0eFOdbRi0uX5vFKTX6qs8KQiZiXMBNLD4vE1E
         Tmh9iHgbitqlnsICdUWRzDcdf68bKY0GxSTusfPL2zxPYsn3uOVdG0xLkvF9FR2Z9Vsq
         M3NdKnITWW2CCA17DyDAs5kmM8cFA3y0F3nl64sRbXidwn7vx7hR8Yk+jQBsuxcMj+By
         +JdQ==
X-Gm-Message-State: AFuF++kmLL4RNjgyYNW3Lhr2bY24acnZuVstC8sCsAKw+XI9p5ym2zMK
	CTvv2QS66DzDPIBIKVjFkvpTbW5HGfvJXJUdJqivom1qbsuBkJE6EK7/tA/6fWloi4KvJUbrSC3
	AFJanvI2oTKFmym8pB68NcGccMehaUgN8Itq5
X-Gm-Gg: AYBFou2leha9/DuQ/JmnnmR7Z801zH5ihlpHbwMalF2U71otM0D5gcMni4XeP4cNSqk
	oPx1jwHjsjMhE1AJ1jNXjGRgUBjVtbHcL+zJ+n7NKukF6MTH6HG89eVA6xRbSuAaWeucjYif+ST
	aBhQQiQOGfROOCb9+xidl4QXJaCskLrI4YAoqyxflZLgWuDk+2cQUqYF3wI0low98IOyvCDUCx9
	q2o6Eo7nJ/FEWyJJEMynBsqfDLchY0h87zWL1R/yveovafQ7ylCLqXszAspds1roin98DMN/H6B
	sDvgobCOp7np+kdgwJF48w+YR6EMfxEPBoLT1lLo8y6iwQ==
X-Received: by 2002:a05:600c:1f87:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49d0827e5ffmr138059395e9.20.1788822692868; Mon, 07 Sep 2026
 16:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 7 Sep 2026 19:11:22 -0400
X-Gm-Features: AcwNN1Uw95u448KfGp18iNkp5UImmKlHY0LryViVoABxOhMY6syB8F7R59l4fMI
Message-ID: <CA+ysrSLTfXxt2EsbU0o3BehqS1nCtjDfR4wOUUJ__6LOhYSjSw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>, security@kernel.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_161135_808743_FE55BE18 
X-CRM114-Status: GOOD (  24.00  )
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

On Mon, Aug 31, 2026 at 9:47=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> With data digest on, a command that has received all its data waits for
> the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
> so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
> teardown even though it still holds the nvmet_req_init() reference. The S=
Q
> percpu_ref never drains, nvmet_sq_destroy() blocks forever in
> wait_for_completion(), and the nvmet-wq release worker is stuck.
>
> An unauthenticated host on an allow_any_host subsystem hits this by
> negotiating data digest, sending a write's data but not the trailing
> digest, and closing the connection. Each leaked command wedges a release
> worker; a few stall queue teardown entirely, and with hung_task_panic the
> box goes down.
>
> Drop the reference for a command left in RECV_DDGST from
> nvmet_tcp_release_queue_work(), before rcv_state is cleared. A command
> that failed nvmet_req_init() never took one, so skip it.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> Assisted-by: Claude
> ---
>  drivers/nvme/target/tcp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1640,6 +1640,19 @@
>         nvmet_tcp_restore_socket_callbacks(queue);
>         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>         cancel_work_sync(&queue->io_work);
> +
> +       /*
> +        * A command that has received all of its data and is only waitin=
g
> +        * for the data digest sits in RECV_DDGST: need_data_in() is alre=
ady
> +        * false, so nvmet_tcp_uninit_data_in_cmds() below skips it, yet =
it
> +        * still holds the reference from nvmet_req_init(). Drop it here,
> +        * while rcv_state still reflects it, so the SQ percpu_ref can dr=
ain
> +        * and nvmet_sq_destroy() can complete. INIT_FAILED took no ref.
> +        */
> +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd &&
> +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +               nvmet_req_uninit(&queue->cmd->req);
> +
>         /* stop accepting incoming data */
>         queue->rcv_state =3D NVMET_TCP_RECV_ERR;
>
> --
> 2.34.1

Gentle ping on this one.

