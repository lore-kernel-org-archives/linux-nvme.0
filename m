Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC47C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UE3hniQGCsIs630o54C9/tJnbA+j6SzkBWCO12D2YII=; b=l7IJv1AJWld9zwxm0CGDu0ecy9
	QTM9lhiItgtXrC3+7RC2kV6JaG/BL6zZEVG0EpLsETX0k0uzfcLtSVaTTzdJI/wPZhrt7gmHiHvtt
	7ekHPY1wUwkhk+po+kRahyzrqLql7XARyeb2o16p8lD3/8gv9+dwZ3tmzJoNvP0UK7G3WkRe+laom
	rig4onMo1zQUwurAkv6HqS9HwsW2I+Qe5QpFdHgf7LXISGKHpZmHvX/XVhmq3LE5e2k1py7TrbHZN
	qiSGibchGJGNDrvwlsW13PaIyODDP/LtNTcuX0lGaBjm/DiT4FFz+7LN5sX644TLH1+Piu5l8+z8j
	2nx4670g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3RI-0000000G6ZJ-3rrP;
	Mon, 03 Jun 2024 08:53:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3RF-0000000G6Xn-2N3R
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 08:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717404785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE3hniQGCsIs630o54C9/tJnbA+j6SzkBWCO12D2YII=;
	b=KmFzoyutzx2e7bPkk4Lsbdo7LQVHHeoWEn8WyKWc4Ks9Dl/F3EXSQt04iXB8I64jg3i4wn
	D6L5/+LhHIl/VFTtwNrDl1jojR/MCximkmTeu7JBAayvPzuFT/sK0ZSgdLJq2SwZS49hFb
	GUt01NWVtfVmlVrJONWv41wq9sqiHkQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-vq_J0908PVK0H0dHYL2WjQ-1; Mon, 03 Jun 2024 04:52:58 -0400
X-MC-Unique: vq_J0908PVK0H0dHYL2WjQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48beba4bc51so165764137.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404777; x=1718009577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE3hniQGCsIs630o54C9/tJnbA+j6SzkBWCO12D2YII=;
        b=Vrfrz/oqkHAqcC7gUHmPtBEqkymXU60WSyjLY8H9EzETnpmqTdRs3OqIHhCv4jNt6v
         xjwKR5AclnntuepcOuvzl/yR55gk2gDNkFqcXuYgrK+/OA5FYY9iDBIOgjlynC+9KcQv
         Gf7kxWZunY2uOllrFhGXszqLNugWy7RLVHN/6zrjJOGdOzQsJJBqCSLSq5CLHgHRofTu
         TaOsamUniOgyQgEeB9jvPIiMYaptNrJVNcGF+5gcfONVuZ7/tA6laD7eDCOsAfZUB4gD
         m/Ct7yV24IJKPfcRvUvpAZZSfd0iyXZTLWEc1hXUKbJ09UyaD75bMt92GFXeAweD9ijE
         3ubw==
X-Forwarded-Encrypted: i=1; AJvYcCUZZzQwAACxVqDR4BEE1OKVxjolvf5Vll2rhoTs1w4yWC7q9ShI1R8ypsmr0jYCLsY0hjGM/wXlWVJ7ux1I8BHd/yIS83ppkCt45wGCVi4=
X-Gm-Message-State: AOJu0YyuX0Njpbt1YfjtIukoONaIioyoeUcCbjvBQwPrhvqetqaon0wj
	iU6cgH+sb1ocM9FpB8Y1jzA0cU8u9ortY111BaV1FN5IQqzvB52/MGUVWWdXZquNSPGUfhY+W7U
	gi0BYwDiaRQfGfJUk9DiRIQDd2imQqoqBpF41/RgYJE2jmPMAH7jH2qwEuGgwOGaLG9Z3nyNuG/
	kn1KYfysAhuk3GeeB8MJZJyU/HaLq8w5PIGsNJ7HCS00WMY/M=
X-Received: by 2002:a67:ff9a:0:b0:48b:a6ec:5403 with SMTP id ada2fe7eead31-48bc20c8ecemr7614481137.9.1717404777495;
        Mon, 03 Jun 2024 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt6ZmqSpx2QGqmE+Gng+Uu3QbDyZwrKNZzYx91vDXAleU2bf4C8prPoj1NJdi3Yn/FVGT+5bELzz0Hxu5VeMc=
X-Received: by 2002:a67:ff9a:0:b0:48b:a6ec:5403 with SMTP id
 ada2fe7eead31-48bc20c8ecemr7614466137.9.1717404777179; Mon, 03 Jun 2024
 01:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me> <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me> <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com> <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
 <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
 <ZlngkgSTK6IPcVc9@kalibr> <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
In-Reply-To: <8058afc6-8272-42fa-a024-e477a29148e1@suse.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 3 Jun 2024 10:52:45 +0200
Message-ID: <CAFL455na13RH=6x5oFbFWUccAXenVUBM9QVzAe2A=4Q9e8MMMw@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Hannes Reinecke <hare@suse.de>
Cc: Maurizio Lombardi <m.lombardi85@mail.ru>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_015309_875727_C4EAAC62 
X-CRM114-Status: UNSURE (   9.51  )
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

po 3. 6. 2024 v 10:37 odes=C3=ADlatel Hannes Reinecke <hare@suse.de> napsal=
:
>
> On 5/31/24 16:37, Maurizio Lombardi wrote:
> Hmm. Don't really like it.
> We took great pains of moving then entire DH-CHAP code into its own
> file, and this patch reverts it and is causing the DH-CHAP code to be
> littered all over the place.

This was just an example, I'm not asking to merge it.

I just had to find a way to make it possible to call nvme_auth_stop() even
when nvme_auth_init() has never been called without crashing the kernel,
moving INIT_WORK was the easiest way.

Maurizio


