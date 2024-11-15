Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26350D6DDE3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXyAxxnKLpgZmGT3ZHAoHzNaVqLioXGnV41IMIjl6Ac=; b=Ppexa3Q7US3+VprDNTQ3Kjdhso
	Bfv0CFZB3UQWcr8PWDovuk3vMjJbAtg5O97poMMXdpCVA3ogsxwGkcQjWOxUxjZbsrFbPEAvpVyYH
	p6Yzq59uAqbE1kYfZhEGZQlkl4snkB77knLX4ykPoygJo6RkDXaM9qm0/QJyhUSR1bVCm1FYMwHkO
	IYBXVhOdWSqLSJ6sVbpS/y/boebGEQd3um1g8lCyrMEdqyk7oDWOFT62juqjzOr9PxmyDQNpigD78
	WYHFrLYVqVshFOZ64yS7qxaaFOG1COt3VregBkaeXgCboJJCoAG5/XPAcozZ7KCTnVyW3VFdtD2lj
	Wgrn8sYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBwOY-00000002pBh-2AHs;
	Fri, 15 Nov 2024 13:29:54 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBwOV-00000002p9V-26UW
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 13:29:52 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a9ec86a67feso331136966b.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 05:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731677389; x=1732282189; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXyAxxnKLpgZmGT3ZHAoHzNaVqLioXGnV41IMIjl6Ac=;
        b=ktfBRnLMBnO8RXvaT1C4+Xo7Ztqaocrzl7HXdiEBbrKt46JVKbWJODGX8n7f7XZDQj
         tnha4b6bp0FcA1E0Yxpg8rzrD5UnPe6has5GKjRWOnc3AZ2zpEVe+UR4x16xyJpd2yCp
         DyGceLYUUQLH14Hdzp/ajf4kJ1bx1CudnNFjbwhp1DoB690bD/RjXhIVmSggbOiiM4dI
         lIdACTKuLDXpUGkinX8Ei/6apbjyOdKUs3uXICE522w69MIo/GVS/apfik8/CTTBO18k
         tRtyc6hvIgov7CKRdOMqJKZsogFG/3Q+FwRfc419rOa74jp0iSpeYXQiMjg15FpoJb9V
         1VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731677389; x=1732282189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXyAxxnKLpgZmGT3ZHAoHzNaVqLioXGnV41IMIjl6Ac=;
        b=LcyGsJ6vAdslQHYMO+HNZ1/MA10eVxnNYzRgd8V6NbPbgXKkZomOg9tGPwMykBLtrs
         2W1XirgZo7mtidXyNAlnIFa+OBad/RGEcU/t8H2MxOLp4IIYdUPnHW2ZaILJKSwq+T8M
         jBPBMBB6PuIPr+k/y0txNo3rUFK/0DTxK8IFrX6s0K+O+qmOnVlVlIr1McWAlKSIt4s4
         cPMCA/JWGHe/xmyFpmvGGAXtYizjYnWz7jMWMY9Ytobi7FrgrPtf7gS8DIznPi/CTl1j
         TT5gnlKYzZ/n7ngQOUxlrAg6klQXD/q0oecJFYJrCsAUOIc5fEkM/6i72fFU/+AkSvo2
         6Udg==
X-Forwarded-Encrypted: i=1; AJvYcCWdimsSRYsy15BMiVyHRFGDjAwwnGE/6o7AIifWcd1z/rPCHauqDpTw21dAZkUDTheategd8B3xkLFB@lists.infradead.org
X-Gm-Message-State: AOJu0YwGIx386eh8QSmt7+t+x3kb2shKPKhdg3Jt8v4RzvOUCuvqE018
	pNOK20kQMPzukDOfvZZ4XbabJqqhmB/3VS0ExDlsKgthS9feCfxsSQtXTKJPXQMiP9gHixzyplN
	R8AxULbqEPnG6/2KzCqBPqp9LiizAbC50/w==
X-Google-Smtp-Source: AGHT+IGqWKTlmFq3/n12hP2Y2a/LRqzo/oZoAMzv7wmcNU8urPo976WbIba/QasmZjKbU6xrICmiEgAE4o4NmycRUDo=
X-Received: by 2002:a17:907:3f25:b0:a9a:2afc:e4e4 with SMTP id
 a640c23a62f3a-aa483557d9bmr200273066b.59.1731677388795; Fri, 15 Nov 2024
 05:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de>
In-Reply-To: <20241114121632.GA3382@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 15 Nov 2024 18:59:11 +0530
Message-ID: <CACzX3As0EzgC-Qgp=Kt67kjqwq8sqsEWDCpgjb3BFW2UzU=oGw@mail.gmail.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org, 
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org, 
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_052951_546076_D421A746 
X-CRM114-Status: GOOD (  11.85  )
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

On Thu, Nov 14, 2024 at 5:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Nov 14, 2024 at 04:15:12PM +0530, Anuj Gupta wrote:
> > PI attribute is supported only for direct IO. Also, vectored read/write
> > operations are not supported with PI currently.
>
> Eww.  I know it's frustration for your if maintainers give contradicting
> guidance, but this is really an awful interface.  Not only the pointless
> indirection which make the interface hard to use, but limiting it to
> not support vectored I/O makes it pretty useless.
>

The check added in this patch returning failure for vectored-io is a
mistake. The application can prepare protection information for vectored
read/write and send. So vectored-io works with the current patchset.
I just need to remove the check in this patch.

