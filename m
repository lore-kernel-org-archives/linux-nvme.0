Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3940BC0219E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiHhDHGEQBKgaz2PgoZcIooxcWU0Z6BNt/oykAlJWlk=; b=h8G+fkJRJD6AQya0gInln+oENG
	K/XhrzNUyxxORsTbmEzq4WZj1qNG125QGqWWdpgSUUv9AdJ3/LSPJDDe6SR8kvCohZT8tmuq74Evu
	VrinivA625gedHLPKljmQ1v4wOPsIeMqBAsfcF/EMuCzJ2Q8nGECc5QjaF/5o+49syjKxQEix27DQ
	Kvq8iSZ0XcTSKEFvJfyx0KmeQrr+V7h8INWXauZnUke0tpr0rMcwMoVEGWXAodYDghDr1yoCxs198
	RgoyJ7dosYjDi2R0lq9ge4IeWwS4CKANfeyH3AJlvhy9R3MAhyTfpqo8q4ss3cEjEYFTqmG81oHjP
	JS/rPxYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thZYP-000000016QW-2hbN;
	Mon, 10 Feb 2025 19:34:49 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thXWt-00000000iIb-0fPG
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 17:25:08 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21fa8ca8eedso1618705ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2025 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739208306; x=1739813106; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiHhDHGEQBKgaz2PgoZcIooxcWU0Z6BNt/oykAlJWlk=;
        b=Ccuoc3We3CFFpPYwAm4jOKKCKb4LH/RAQmloSA8EmDcnEJuIjB6FSZ6853SSixDr+W
         5Z0ZGmqhkZltuf9ayQD1H6NQjd/Ia6BM/oJLqxlxGG45IaZJwoA2x8+oyDNZbgsauVZU
         3cgfAwMakiLb2rt+Bu0bDOueqDtp0uVshLR7NdvXrNlPMsraYvz7Ma2LvjCzaqPYJHEz
         CPjkjClKqAUhUvQy2tSdgJ5er1JxdHXKuJzkXj5mGkAhc9siJ1mz1G0J75pJNjuYJfwr
         Kk8PL0qRl81V0yH8DbmWFu+85494XyzFZ/2ngZ8wWw1231mqpgqIhUylBmrbOyTK0Q4P
         zwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208306; x=1739813106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiHhDHGEQBKgaz2PgoZcIooxcWU0Z6BNt/oykAlJWlk=;
        b=naoWRcMUqUADKaHg2ddagv32W8pOX9ZNIjRkQ6nyDSlsfcimCyyuDE5xX4mFIH5Zbn
         KqrH/5yMYK9VFXjg8J741ZV43HQHd6ssfi/YDVO7mE2OnwD2EgoA4U9rhAV7ParqAjFI
         lZUDQ8tsMUrjKGbVBSrS7Jm7d16vmH8WMHHbxa6NUDlpQngBaFkxtzt/CxInKm3ToKfz
         QOMwmsqpzqxf+j0gU8mqWxpsLEjKObml3lMB8VYIX/onCXHK5ve/E5CGTkVHEG9kwoVl
         Bvk3IAJoWLWO6M8B8nLoIVD5O/jj856qvAtZSU1nhoI0F54moTM3HRmat3kGjhnwwZHw
         Qj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUNLCVXLj0BdZQFxTexaVDp2uPu+Z5omppIEVO6+Ri2JvzchJD6F5Kiybsh1KY4+sUuP8DoAbnJhx3z@lists.infradead.org
X-Gm-Message-State: AOJu0YztrytVU6CRhXfIJSTMUPU+jslbtD9cVvWKpcotXEWxETrFIQM+
	G/aRhZw0IkScYXwqnOU+VmT60Rv22ko3OkUNQkB29VobVAST439i8GrZ4/Oq1umduWRWmOjM7Fo
	eCkw/HBVsNE8XiALVe96jWshUR7jkm+ChG0+iUw==
X-Gm-Gg: ASbGncsRxBCYuE+RI/32YO4p6FYx1mcj27OUGcZJTcacKeicpHcBddmbE4xcdGsQSh/
	rKw/m6WpO9K/inabrQ5bDV87uqKIl2yQx9kGdQBnskv/m2hiCcm0w5a0Rh0SndzYsmeRrAyk=
X-Google-Smtp-Source: AGHT+IEucDmoU7uRoUcUzInTENWREnMD4L1AyE6xcdfr+RGfCaLMUeRX+royuye7P0fqaQr/ICee4T7+MJHFpc2xSMA=
X-Received: by 2002:a17:902:f787:b0:21d:da9e:1465 with SMTP id
 d9443c01a7336-21f4e771c03mr81754695ad.9.1739208306035; Mon, 10 Feb 2025
 09:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de> <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de> <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me> <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
 <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de> <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
In-Reply-To: <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 10 Feb 2025 09:24:54 -0800
X-Gm-Features: AWEUYZn8c6zrSakAY3hcSFiGE8Sm0IPAE1CQT-nVVZsAnpFS1UgYjiv8pRgN3ls
Message-ID: <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_092507_238731_268362FE 
X-CRM114-Status: GOOD (  17.97  )
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

Gentle ping on this patch. Sagi reviewed it, and I don't hear any
additional comments from Hannes.

Thanks,
Caleb

On Tue, Feb 4, 2025 at 2:20=E2=80=AFPM Caleb Sander <csander@purestorage.co=
m> wrote:
>
> On Sun, Feb 2, 2025 at 11:20=E2=80=AFPM Hannes Reinecke <hare@suse.de> wr=
ote:
> ...
> > The PSK identification has to contain the host NQN _and_ the target NQN=
.
> > So you need to call gen-tls-key with both in order to generate a PSK
> > with an identitify which can be found for a connection attempt.
>
> Got it. With "--hostnqn `cat /etc/nvme/hostnqn`" added to the nvme
> gen-tls-key commands, the discovery and connection succeed. I see the
> same behavior with and without my patch.
>
> $ nvme connect-all --transport tcp --traddr 127.0.0.1 --trsvcid 4420 --tl=
s
> $ nvme list
> Node                  Generic               SN                   Model
>                                    Namespace  Usage
>   Format           FW Rev
> --------------------- --------------------- --------------------
> ---------------------------------------- ----------
> -------------------------- ---------------- --------
> /dev/nvme1n1          /dev/ng1n1            d95671fe6e0ebf8c199c Linux
>                                    0x1        268.44  GB / 268.44  GB
>   512   B +  0 B   5.14.0-5
>
> Hannes, is there any other information you need or do you think this
> patch can be merged?
>
> Thanks,
> Caleb

