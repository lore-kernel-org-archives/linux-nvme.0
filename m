Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC643D2B921
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTH4WFQl44MZo2K8HCqfF+HKDqxdQyvMXtNA1sRPJUQ=; b=TsbeF4M/pcHavpRlglruoRYuTC
	cwpo0XZKotwYp2FnkxUfqh9v/NnMjTcrhrbBnTfzfIbIJTOnxaBEyv75NiTOAoWnFwjRT1JDoDynM
	S35zkb7iCnWamarHQfhSqxEYrAZMtgjTxmRRO7MgMVqBHZW33jfiTlDdiwoJ2pshWTgymjmKFRwx/
	OPFr/d+T4DtlDeRMK7sEujdfkncz6ElqMm5N9RGzdbu0x81gHlWfhldsrOsYkXC1O8gYaE5VTd7X7
	j7H6DOHw3DZGQ3zuJTQi4TwHIW3PonKdPu/69l6N/LN7MeR70nbh0bdfD/3xPbiGiRBS49PoIMV5R
	uyxGIegg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8JFA-0000000H43c-3pra;
	Tue, 05 Nov 2024 13:05:12 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8JF8-0000000H431-1SkE
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 13:05:12 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso5822845a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 05:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730811908; x=1731416708; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTH4WFQl44MZo2K8HCqfF+HKDqxdQyvMXtNA1sRPJUQ=;
        b=UIrvD1kCTps/eO3uKhXkxAhIjDTEb/QhQc36YEy067IeEEjnngGA05XpBWF4+fNDUp
         v3cmnva2jvjr4No+Z726slfnZbvxEMgZlNmbCOfbHpMIUVN6IhRMR6LvTk6j5TMnyfF7
         w0+rbQa5mKEx/5YbRdwmZwwXut9lnZURHz5mzDohILsl/Z8bs3vxfNf2ZZ+0knXWH0dM
         a+fBGZqVzAVffnqCxFxqr3T+Pph//k/MbV6JOhnhMGv4lBh1/MTDM3E/ML/H2KkipHNz
         SyEtzrXN4EFO1bbAM1Usslm5dp4PegrxTpODnTyJaMgIalRSeVOHdypVS45ve8INX5im
         8GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730811908; x=1731416708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTH4WFQl44MZo2K8HCqfF+HKDqxdQyvMXtNA1sRPJUQ=;
        b=G7sCIkPV7huJqlPhH/DlePEKze0aY0/ckQbMdAPpzUXBX6q15To9I4ns5eJqXImGSv
         zDKkxbEuSC0Wcuqy4uOuvyl7ceV9ClIcCdnf4eM2HGLy8yFdFkig8Axk6qbT3+Sf3YT7
         B4VkbUV0bxqdtufC9X0ziY9QbXHoexYacNz/W75JAa3srbj2QSnknygonujgppoEbVCL
         +vcfBl+Qlnys0LgXoc+lmkNBnSkG3ZbC8nHUUPJOEVxqfdfadywSqIWggk3doP5Lelio
         fpCPObduyViIsG98uLXO3ckdrrZFYGP9H2iVyn6VhubkopeGUdvSsFcSRRCwytZ72HU6
         3IJA==
X-Forwarded-Encrypted: i=1; AJvYcCVLG00ptP3Vf7hbqDR5LPxkji5wYYWDNaua59q/FKmMmarRkmgObpQAMRpkLM+2GJ1dmo+uQVDJFp2u@lists.infradead.org
X-Gm-Message-State: AOJu0YwxeVGWS9zBbJSGgtnPxGP+hwtv5WVC6acFQSD69jFQuA6fPWZ4
	lCeahkMjboPRJN+hl/gigaSoRg2bzTFPo3lbY3a+ZtwPmGnFmhKh7tGRkaMpug5ZlG+Uo05ttcI
	JjedF1I/mo9niW9BxvoIoJXDeVw==
X-Google-Smtp-Source: AGHT+IF01wR05OjwQeh992AAL/y5UPKmRBQ8OJmD/daNR7F3czK12/2t8R6t75acTlCyTboaI0WJ85eVBHqdyctE/Ic=
X-Received: by 2002:a05:6402:1e8c:b0:5ce:c8d4:c6e5 with SMTP id
 4fb4d7f45d1cf-5cec8d4ca1emr8823138a12.22.1730811907858; Tue, 05 Nov 2024
 05:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141459epcas5p27991e140158b1e7294b4d6c4e767373c@epcas5p2.samsung.com>
 <20241104140601.12239-7-anuj20.g@samsung.com> <20241105095621.GB597@lst.de>
In-Reply-To: <20241105095621.GB597@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 5 Nov 2024 18:34:29 +0530
Message-ID: <CACzX3AuNFoE-EC_xpDPZkoiUk1uc0LXMNw-mLnhrKAG4dnJzQw@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] io_uring/rw: add support to send metadata along
 with read/write
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
X-CRM114-CacheID: sfid-20241105_050510_412198_2E0BF4F6 
X-CRM114-Status: GOOD (  12.37  )
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

On Tue, Nov 5, 2024 at 3:26=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Nov 04, 2024 at 07:35:57PM +0530, Anuj Gupta wrote:
> > read/write. A new meta_type field is introduced in SQE which indicates
> > the type of metadata being passed.
>
> I still object to this completely pointless and ill-defined field.

The field is used only at io_uring level, and it helps there in using the
SQE space flexibly.
Overall, while all other pieces are sorted, we are only missing the consens=
us
on io_uring bits. This is also an attempt to gain that. We will have to see
in what form Jens/Pavel would like to see this part.

