Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874CACCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=; b=pEzw8ROnZfwxGWjCX4fsb/IwTk
	OXLZrXqry6N2YsTc3oFs+OmuVjdcbmHvxjHHDItXuszQU785unaD09+DHEX1SzeDbAVqR0EpoRHTB
	UtLIjzeNn3QadigUoZovTnodny+AJKGu6IZScwRQIbAwn/qecpEb2VR29X9hSug9tp6RAQiT+us4F
	DqRVUVf6sdkdmFqOH0VqsPc/ViWrCzSb9r0de5FNjl64gwUpNUHIULl/4VIBsHTwdUSYJ9aH2fQ+V
	e255hpgMDIAaCMt4PYJ1g1G/vVvAMGaDoxNOTuxgbw4Fk5t5pxZIp6OupcEAjGsys9Uod4zMCPPP4
	rrNOe50Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjZZ-000000091HN-43PE;
	Mon, 03 Nov 2025 01:41:29 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjZY-000000091GR-1Z7L
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 01:41:29 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so934860166b.1
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 17:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134086; x=1762738886; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=;
        b=RVm0FIMIkfo5NZ1Fuvker0UHw+dtPDqJLCack8MECqXaMMBDuzV9H+iDdq/pbdNnE3
         j/di+uBN9T8C7F5qF5TD6erlTX8SSYstidqgOS0lOfugPMs5FU/IMdyt2Sm9xfzkTK2b
         DG7K569mKr6uPyPa04Es7Gl4jdIcPwIzVbFIshvglM8B6ctl3OyjfWSwGKwB3AQGmN0i
         zwcEYUujAN88/cfBQd6utf93SOaWz0yaDlTxaK/s+6tJBuGVbtIpCPUEL62qCXzKuJG4
         DDb72o0tXlf9jHkIlPVHpQ4hTRipqaKvE1m0VU+ECRNIZ24Qr9K0Gn9kXd+y+IAbg2XZ
         mXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134086; x=1762738886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4JpTIJcUWICq0RhXYTLqHg0HVddUn7fLzFa6IMM6wY=;
        b=DiwK9HIPsx2TJsOFF8uPlWxGysWDFvi4GwWfQQ0Mqn2u4jForXSo/DK7fWOXQgy4R2
         5vu/l0Ijywz/6KeCAoUP/mWrFE+UCle1kQMQ+Qm4WV+JhsVqSbHCHO74ngisOBcyuFUM
         zmVZkBpYC+OwQzajNJJQV4ufIPvP4GoAH0HhXygcPEHbTcEn6BRncK179sB7r63n/AcI
         X9l+xkl1LzMURjHuRCk/0zED3JIY/kkxWom2Wpo3TzD8eRTdMQkT8QJN96MSY7G8MiGJ
         59E73ephIeIKRwjc8CCr8xxdv+mw2yq954Mr9rmxQSfE+1SV9XoZ1EqBee0PP5VZVzeD
         8hOg==
X-Forwarded-Encrypted: i=1; AJvYcCXxnwmD8tOJKGp/yGkR84J0ybi4qflGqsCcqqLucKvYgSFKN/HZrYdfBzpuDYeI7XnWpvApcxBW2Hia@lists.infradead.org
X-Gm-Message-State: AOJu0YzIMXf4XfqkAWF8dmbhie4I4Tf/TTGLSApMY3G1YQG9CTxBw9h1
	Qgqf+uqzzwQenDfyZG8hWO+lTAXGVB360znw3hkr8Iujo7dDtpIcqnnMReMnJ8c4Qgae1wNdYOC
	phUIcGJywUonFZLVnx6bZuvyuvbJ11Fg=
X-Gm-Gg: ASbGnct8TcKV1SKqvZAiIZyfSWyDo3x29DF/PD1Jkgvi+bXY3GtTWJ2PrnjQA8RIB0A
	9xkXeyb+bjT+IW9DGztCY1qbIovtNZnDWODbGN9yRzUyK+f7WRl/CVznjB+jJ/z1Ie0BY8H/m2+
	JJNglfgtxeYonHJvjPn0B9M8wiGnUuTvBujreoATVdazJVsM2JSmV/tNC6SXIJx18yA5HoQvkW4
	cL98T3MXyVed3FGldY976QJvUh3i1IW9eed27kttCk/y09QJymAMf7FcPc4LTNZIbLOwWqMoiNQ
	5cAYaQlRc7UQB4Q=
X-Google-Smtp-Source: AGHT+IE/eyF+U0mcVSVOCFn90kJhZxf4Zfg890G+o1Tfzad3V+RqDT+rlRzvp5279x6ptqJdKuJ4hl1LR6/bJWnRls8=
X-Received: by 2002:a17:907:7209:b0:b6d:ba71:a17f with SMTP id
 a640c23a62f3a-b705212b184mr1771429466b.18.1762134085841; Sun, 02 Nov 2025
 17:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-3-alistair.francis@wdc.com> <20251031140310.GA17006@lst.de>
In-Reply-To: <20251031140310.GA17006@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 11:40:59 +1000
X-Gm-Features: AWmQ_bkDRF4rEu0p3e9iqv7N4UGnz9O0eQ4ZvNxXnHXSrGn_2_G0UVFLViI15VY
Message-ID: <CAKmqyKPU8j-D9T-dLNfktf9EVQeA8-pdneOJkscN-0JM0UdEGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_174128_425982_CA9700B6 
X-CRM114-Status: GOOD (  16.27  )
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

On Sat, Nov 1, 2025 at 12:03=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Oct 30, 2025 at 01:51:13PM +1000, alistair23@gmail.com wrote:
> > Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> > part of calling nvmet_auth_sq_free() on success. This means when the
> > host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> > check for !nvmet_queue_tls_keyid(req->sq) fails.
> >
> > This patch ensures we don't free the TLS key on success as we might nee=
d
> > it again in the future.
>
> I initially though we'd now keep it around for the lifetime of the
> queue, but I think we'll still free it from nvmet_execute_auth_send,
> right?

Good point. In theory nvmet_execute_auth_send() can free it, I don't
see that actually happening as `req->sq->dhchap_step` is always
`NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE` for me.

I'll add another patch to remove the call to nvmet_auth_sq_free() on succes=
s.

Alistair

>

