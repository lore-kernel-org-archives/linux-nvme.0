Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED1C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 04:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=; b=g8SI5oMfhHwAnKUSn6UThSqHig
	8LWpf7Nx016c5qFeDx1ywl+r2z3ZXf0HoBEXf8auljxgU7Xu4FOEIzgVJUUA3xVaPBTqEtoboqtyy
	gAxMnu4SISGeJtguRHY6SZdPzmXzMAZlmt7vwH7JB/na5c54/vibgxurh+L0ZoAqlE9Lu2p/oXKTQ
	vbK/MyJXPlPpaQfxSK52XVQaYL4lBJwcwNTMvMIuc5AHgJV/fJuAjZeaECrz5t2PEL9D/jJueCUZH
	mIaRyb3L/uEi8z5cEfLl197J0xpnqnW7moyBMCeM8zkzQWzAJrFXFg5DmuHpV9pWWXQypblIfEMiI
	246/3qSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHFPK-0000000B0Mb-0XOz;
	Wed, 12 Jun 2024 04:16:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHFPG-0000000B0Lh-3g1e
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 04:16:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718165774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=;
	b=dY7RJp+VPxOwN7ncJzUSv4p3neZoHFP/PAeA7Mwj0oqVyv0/MP0ARbseit0gpEFI+gdZ1G
	HbwWVhUeobRwooY1ckE54wdP9ovECzc+PdEJAmF9yAAHmZEy5ufVFIlCoZE2r4+Phv17ZW
	MeD6CCQs2wDCa5XFdL+Bb6A9wFqabxE=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-W33qVibdNseHTDQ4S5RkqA-1; Wed, 12 Jun 2024 00:16:12 -0400
X-MC-Unique: W33qVibdNseHTDQ4S5RkqA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4ed00f3adbcso4239e0c.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 21:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718165772; x=1718770572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJdZ1NK1r7xH/DOlwYXo2NjXnWh3k3yXqMsrzOUJ6Vo=;
        b=Ga2ISQ5vyd7Lt6dSSSQh6ydhh0ge/bXQ6N020qOyXR8b/pyPx3xzKgIt5BF7P8liai
         fSDlo9YFuhxeOgni7HmZHmARV/9k/tvd6G3UViYcjTDPonQW0cI4k+MKmtqVw09fFnOT
         oDfCc/Jj8Mq8a7s4RR1w7KiythZN0Hq2vQrR4YRLl5FPvfH/EvMiTG68ztwMPsRMS4jg
         sTdlkRzf94ikCNjNwHoT78d2b/RG1YQ+71tHYIUiawdmggqYM26c6kvLNa2/H44F6hsb
         A89x7xUQQQNkCQQ6/Fj2lp8I2XC++dzuxBJ10xQHsGYvUiabns13gu08gchHgo6ZQwUD
         f9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVug1EO/JNqftP4nTaCosdh2qnXyG1OkWe5ufnkGSUHiMCk4cX8sNqZZY7wsCel3+hy93+LpazPqdGlJIvyFuiSdMtTiDBCcab9Ke1yh6g=
X-Gm-Message-State: AOJu0YwAXM1A0Ft7AB0bPiAc23gRTeehSodOFNk6C5QCK2dvcIPuGx8U
	BIMFj0D07rQxpkvSMkHn7sJxCxlzPFcURgZGQel9EdxGtyzv9VtxCJTEcCCuH1p6U4XKIED9Tjz
	nxVRHorBLFykcOPhfm0wZJostvdTYnr6Al2E0uJWoqLLRDSLz3SE7cJlKEDs+/oN1EKJbce0/Au
	90YQDefMTy5xiwqyuy09pFxMxLzYIB3lwttfgiWMw=
X-Received: by 2002:a05:6122:905:b0:4eb:2012:f5ed with SMTP id 71dfb90a1353d-4ed07b8a29fmr837891e0c.1.1718165772034;
        Tue, 11 Jun 2024 21:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgf/PBHKG2XAoTeJYfg7b0HqVAZBlUfdW3oAoNADQ9WSfMNyU9XcQ8GsoKL5eBU4edRo1juf4oVSQcQ1cMPtE=
X-Received: by 2002:a05:6122:905:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4ed07b8a29fmr837878e0c.1.1718165771741; Tue, 11 Jun 2024
 21:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240610111927epcas5p1bb534d0a093a9d1243a78a6a93065df7@epcas5p1.samsung.com>
 <20240610111144.14647-1-anuj20.g@samsung.com>
In-Reply-To: <20240610111144.14647-1-anuj20.g@samsung.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 12 Jun 2024 12:16:00 +0800
Message-ID: <CAFj5m9+X+A+yVBxWutKuCaV0gxEhgwhyLJDt2u65BEZU98gZ3Q@mail.gmail.com>
Subject: Re: [PATCH v3] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Kanchan Joshi <joshi.k@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_211619_272862_9EE2D4A5 
X-CRM114-Status: GOOD (  10.63  )
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

On Mon, Jun 10, 2024 at 7:26=E2=80=AFPM Anuj Gupta <anuj20.g@samsung.com> w=
rote:
>
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


