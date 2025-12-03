Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832EDD1268F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vtMfHS9a4BVt4LSy4uJrM0oL13UlcA2luRqSTljuCk=; b=HSjwxxq6jwcKQ02nGj6H0pa8Ny
	Ow5E4ArYrGSX8dxewZtz3ip9XReBF37DdCjCpqUVXmnSAFdtmDFXaet8oC6ygkfwvY96MqYs+s902
	Mlox2L19m2m7ne6qlnbG3MHbORwj+2y5VMDx4TW8qDlwIy7TINXu+TkHSLfqYwfuDMHVX7Dsf/+Op
	hsxp9SIm0iIzvDJubJd0Y+O/INZU5oFErNVVAvZ4/5Ppkfx/l8X9rklGlVhpQcqGVJZiCNgpYCEDs
	ZrJovCMuNvpwR087FMNKvJUomH11JpWYz0QyaWwETqXvdGw+2h0XwLU6yIYkSOgMjxTNyuidNQX+U
	FwOSD+ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQbog-000000060Vd-1rWX;
	Wed, 03 Dec 2025 01:38:02 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQboZ-000000060Us-2aKn
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 01:37:56 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-8804ca2a730so86420206d6.2
        for <linux-nvme@lists.infradead.org>; Tue, 02 Dec 2025 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764725874; x=1765330674; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vtMfHS9a4BVt4LSy4uJrM0oL13UlcA2luRqSTljuCk=;
        b=A/7POE+GVSsJTaE9y5Qgl0a9EryZCHAXgmuPe8dEkcuth1GX/ro/Cjx4jUyvJLYmCO
         eMze9GmHOpKeqRIqUGc4uy8UqPMrqq060g3OY/bHPvYKfyWXyhmlLifW6JcCMwH0i6Hs
         ea7B8RjaZbdXD7wVSS9r1uggwMBmoKp5hBPANwpUYk9DblrOb30Exga3MUuwZaA+9uyP
         uPVL+zlk1E3xypXyZXROk6zZ1p0jfAsSvEQqvn1NnN5Cm/31mHxzx/pHV6CfrgWnKXHs
         Tn1qj8xQx4t0HEUy26RoZtg/vwWCkE4y66XpiYwE3fcFXjvEcGPiRoPvhWTIoWL9U97D
         cdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764725874; x=1765330674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vtMfHS9a4BVt4LSy4uJrM0oL13UlcA2luRqSTljuCk=;
        b=ngc3nVaFc4qBjL2vFnt0AGcvPq6GqTcCYWiJMHhHdmo+cDrTwIqTFQBTw9DEYB+zKf
         158Zfa30KlUL1df3f8O2ngont0nWuNys0/ndzTXd+wuaC/u2yEIrrO1oh0UQIntnc4WP
         RF6VYDu81PVHOz7wv2KrpUVJ6LXPm96+5VVe3tNIYKVzqlW6D1qUFFqkGjut4Cy1Zcxr
         K7cX3bjfG36+Nb1RKzQmKxmSIzGImc0de2McA7i2jm01ahzJW6hXW97zQBUgJ7RHZ8Sf
         /SMY83KKx1xxzTAlPCET5EVqFxlNk74XYdUsJz91FCRbowUZouFx5KxIYyZCP0tt/LU0
         s5NQ==
X-Gm-Message-State: AOJu0YzaH8SNz0S7Qa0AcnqRXHh1s9mg2MXhv9yT7jUiLLgeP9POdMqv
	1Bj+8blfdIQ9C1T3HGsVbIGAPu0vpXc32TCYT3XNo1v4jEdpTfd71UQOkCUcpkL5N20CsK8DjKT
	3Zw8FQNyetVAFf64UMlyAPRThZmiJ5eU=
X-Gm-Gg: ASbGncu4/yT5t8e8Mk1gPYJsoPSUn7MQ6bZvWH66Qp/J9ZaDMlxKdAnG6q4XFt6WRJV
	stTrnlAvRcTVIavHSIP+j3QbbIhdz225zXTBU0YClD1U8VoMmeda3V0avGWYCA5nWEelHt8cXfr
	EaSVt5q5aLuha/SCYBLwsvjBpmXW2Z1tpNhwBABtECncSoe473XjcY4Ka7sGeyLjkD1hllVYfgF
	CryX+DzRZeZ+GQPl7t71L8eg8JBFkqHEl1/jTvpOepUyQBl5MlzGN7jjfPpZhiYK68OOIo0iyfM
	hqz4YU4=
X-Google-Smtp-Source: AGHT+IF7piWYfs+YfXK2ZfYwDf/kqWGXoKdIsNmgCXL6L21d0ybs3o5auSG+MujnQ2z717KtsAsdk+iJwmb5TULKvBI=
X-Received: by 2002:a05:6214:1c46:b0:880:5a05:925f with SMTP id
 6a1803df08f44-888194c55ecmr10109576d6.13.1764725873879; Tue, 02 Dec 2025
 17:37:53 -0800 (PST)
MIME-Version: 1.0
References: <21255200-a271-4fa0-b099-97755c8acd4c@work> <CAGtn9rmSq9+6o1-=tQwYGRKRUSOXkSJnCdSosNnpW0BvnxaNLQ@mail.gmail.com>
 <6440e968-a181-419b-b203-a354b924341b@work> <05b455fc-d08c-4fb2-81db-a818771b9c42@gmail.com>
 <fb66da17-65b5-483f-8d49-e3dfa38b27d3@work> <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
In-Reply-To: <CABPRKS-e9pXDyFejW+o42vRfzhy6EkUnOVxe46iZqqm4OMk4yg@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 2 Dec 2025 17:36:56 -0800
X-Gm-Features: AWmQ_blz52urqD4DZmB0A1l4bZ8KubwcIMNNvdeP_0z0lRgBn0dn307zpaGzyaQ
Message-ID: <CABPRKS-UZMwfKNCK6Mx17_MxYK-ZieKddx0N7YBM3hf5Ur=4Ug@mail.gmail.com>
Subject: Re: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
To: Aristeu Rozanski <aris@redhat.com>, Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_173755_678035_52F9EA65 
X-CRM114-Status: GOOD (  10.20  )
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

> Broadcom will have a deeper look into the call trace and will report back=
.
Providing a status update that Broadcom does not quite agree with the
proposed patch yet.  Specifically, because the crash occurs in
target/fcloop.c and not host/fc.c

    [12996.173750] Last Breaking-Event-Address:
    [12996.173750]  [<0000017ed7b594da>]
fcloop_t2h_xmt_ls_rsp+0x10a/0x140 [nvme_fcloop]
    [12996.173757] Kernel panic - not syncing: Fatal exception: panic_on_oo=
ps

If anything, the suggested cancel_work_sync(&rport->lsrcv_work) in
host/fc.c is delaying or avoiding the real issue.  And, I believe the
issue is related to the following commit:
=E2=80=9C10c165af35d2 nvmet-fcloop: call done callback even when remote por=
t is gone=E2=80=9D

The panic occurs exactly during the lsrsp->done(lsrsp) call.  Are we
sure lsrsp is guaranteed to be valid when targetport is gone?
Broadcom will investigate the target/fcloop.c module some more and
report back again.

Regards,
Justin

