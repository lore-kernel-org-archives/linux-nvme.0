Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E3C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wVtKuj/N/KEwJl4OfXeL0f9ssGQzB0xHZZv1GqdNz4=; b=s27HA+VhCZDMHsoIpPA1kqwFWh
	XOXxhutjevo7SQXNrNezP95fnfRlGpCkRHcm8xYb5cC93h0DQxXVr2dLPGuzwzre+g8YRRT3RwgkT
	GRfQIzLDo6Z5lnEtlK/rK6wcJLn2VEQCJem7gtW/XlDBEQtKwzjc9DwlzYy24TZSqewaNoaJgu6TH
	S/gTM3Q5mBHn9i4MzbjjGbSAl6V9nGqlejtCpNHtpsJPPIqZoy3Pb0preOYFjRZIcBCjir+SfQD3z
	TMzJRjj12XaZhpwgmcyazEDsB8mzyU0XUMf4RK9sQiap89ONbG7SKvmcweoOTYGaEKuUoM695Uil/
	Zgbdvb1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbNYg-0000000FDK7-3Jjc;
	Fri, 24 Jan 2025 17:33:30 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbNYe-0000000FDJf-0Nvn
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 17:33:29 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2f7d35de32dso547202a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737740007; x=1738344807; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wVtKuj/N/KEwJl4OfXeL0f9ssGQzB0xHZZv1GqdNz4=;
        b=cn/h0AEmvQeSwXHLLYCwzn7vqwa4zVQ1vTL8Jg6qmTsHqpbr1rZaiRsAdojce8SnYi
         9QsvPyHXdfQhVyWpV3Yxh31tg1sPQtoZn8bJs6RT3wUudegR5GAcigtkvQrTGQsiKB2+
         CDMMayqkgqvMUZd/AcKyPtxtJur9oBULQzo2evqb7Rrm3NCQwiU4UDdYsodMO5QwKn5F
         ZaPPmCJc0aqBohKf+Q5n7SvIOV1Qt5HJbOJwItFScBDrNFCyG80LNKqtmJOS1upUHa6j
         go+IkGBz1gkfM2Ak/r+ufvnYUm7Iv1MjNWVxuI8Si5arG191sNO7WnAucWt4ZsBpC6TT
         i0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740007; x=1738344807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wVtKuj/N/KEwJl4OfXeL0f9ssGQzB0xHZZv1GqdNz4=;
        b=jwgFXjghgUJkPu2EUAGXZZp3K9/sOFZo5Rj5kDBJ3ICF+VpaXoxIGx0kcM/2yxT6Ze
         Vkxh4+oXx6km8UZbHdJ/u91laQ16MA9vabyZPyXS1Fc0fJnEGZzlphMfFc4J1PqifBV9
         ivbkXGaICVZ+Bsntz5dletlGvlHYJtatAvR6pyEq7nI7yrdK/e+Nsgt4b0KC5t0PnKvG
         RAsG8OeXFFdkIDOmFvLHC299RmTh7x6q+M1w0NhTjbW4GGTNc2H3jZryWpF3gC9wR044
         KK/dpqAg6MX2WjT/ivwsWyXTW7Wrgz6JLKnxXGoQUEcjsZhGQ5oNugQ8FLiqQKfD7QHA
         qXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTA562ZjryC0yWeRGeKEWV+hYP1K1Ad9L5US8ev0EGZIsK4lbl/B0sE7mwRA7M43c0NGWIKdp3xGoN@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7LoTm8+PSeBYgDkTH7cS6yTVs2j2ddbfXwA+HMJGDm53tZTCX
	LhVpw50dc96FNyZH/2CC0JrAte/EwpFIrRIc5A9+jUs6a5PqiiTJ1RNuke4/lEXMF9Uzf8Lg6CZ
	WT5NRn97d4EzLIy97rzL4r5ZKHvayOrCLG/yrpg==
X-Gm-Gg: ASbGncuZCcJpenF8RXvjEJ1M7ZmzcmIXwDLvHciLOeZYVfngmXhfP4Ps781L6BhumKY
	8uXsj5kIE9CI6W7ZlDJ70V/Qzd68ji7ChVnTj+9Fk0/yRp3pGJZCBVtM3g1m47w==
X-Google-Smtp-Source: AGHT+IG9pBY+eUViGwSYjG8/xpzHh7csHbEpkqwh5MePR2i+lYA2ZtEDDW9r/pbKR2scmX+CG+7oKQbuMW9AeUHEFf8=
X-Received: by 2002:a17:90a:d64b:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2f782d8663dmr17101646a91.5.1737740007200; Fri, 24 Jan 2025
 09:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20250123224941.1359950-1-csander@purestorage.com> <CAFL455=TMmKVZPtnX_CBF34+EtfMbq37OxQAFGJuW_u1VjEQsA@mail.gmail.com>
In-Reply-To: <CAFL455=TMmKVZPtnX_CBF34+EtfMbq37OxQAFGJuW_u1VjEQsA@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 24 Jan 2025 09:33:16 -0800
X-Gm-Features: AWEUYZmmgPnofWcUasdtI1ChzMlVw9-oQ2r-5T6VQVUqYmKGuykkRT7Xr8t38Zc
Message-ID: <CADUfDZrjXYH-42Q1-M88CmYo1fTi2Hu_66=vk8G3Gjqpuo+rCA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_093328_186682_34391986 
X-CRM114-Status: GOOD (  12.25  )
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

Good catch! I will send a v3.

On Fri, Jan 24, 2025 at 12:08=E2=80=AFAM Maurizio Lombardi <mlombard@redhat=
.com> wrote:
>
> =C4=8Dt 23. 1. 2025 v 23:50 odes=C3=ADlatel Caleb Sander Mateos
> <csander@purestorage.com> napsal:
> >
> >         ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >                         iov.iov_len, msg.msg_flags);
> > -       if (ret < 0) {
> > +       if (ret < sizeof(*icresp)) {
> >                 pr_warn("queue %d: failed to receive icresp, error %d\n=
",
> >                         nvme_tcp_queue_id(queue), ret);
> >                 goto free_icresp;
> >         }
>
> There is a small problem here, suppose ret is a positive number but
> smaller than sizeof(*icresp),
> you will print a bogus error code, then you "goto free_icresp;" and
> return this random positive number to the caller.
>
> I think that if ret > 0 you should set it to -EINVAL.
>
> Maurizio
>

