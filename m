Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C607C83F26
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jt9i9pYNaUPdWqWFZBWx3OQRKjFtfE1AH3cdfO8jcA=; b=a6BF7rtm6sIJOCAjt5jCBJrt6i
	ihUiPXQp6mHqjr0N+c4yZ5Tnl0HmDu8r2fjBitfpiqx+jzWRc5DBZJF7JJHDZ7Bk2Tzb42ibhv/xD
	3VfR1AfSxnSenXbqs+88HGRo9zo9wDmpJgD7jwv0rahjGQINnHNmSV5UzpZJJ4f+2LvV0Zs9GRooO
	nPSXztbuU9qMVRRNcdsKvADlufxk+fhkc4z2pW7pl/Yu4a/nApbir8G24L7SzUpdtCe7sJT1BEwI+
	YrcvwtGm+mUk79YuaWKjU7Lj5LZ+93eWO0qvP7xYXsWHNsYW9pXawAnjFfIGDkUeZTILljzGCPy6V
	75baA0aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uezNv-000000083Z2-25ai;
	Thu, 24 Jul 2025 17:05:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uexXU-00000007oVb-3Gvi
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 15:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753369638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jt9i9pYNaUPdWqWFZBWx3OQRKjFtfE1AH3cdfO8jcA=;
	b=f51YeT1nkeJFp7WJry8qbHXQKKzEk69DVYgkLITH5HfSa9r73e7hoYDnQ9k8eSY8C3Ggb2
	818Sc8ZX3HBZ8PUkn6485qkosS9mnQ1OCqAppBp0HklMhWtxfS3mmi7Ue1KUJfvFHemOAK
	HsUObPTV+u/D3DePmQlicstr2El6Fac=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-xUvF_6mpMkObjBkJpw4l7A-1; Thu, 24 Jul 2025 11:07:16 -0400
X-MC-Unique: xUvF_6mpMkObjBkJpw4l7A-1
X-Mimecast-MFC-AGG-ID: xUvF_6mpMkObjBkJpw4l7A_1753369635
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32e157ad381so7289331fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Jul 2025 08:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369634; x=1753974434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jt9i9pYNaUPdWqWFZBWx3OQRKjFtfE1AH3cdfO8jcA=;
        b=TjhWhaG2dWPv7uY1eOxEEgdmhq509Fo3BTLKFLxgICq4W3fJNLuBDNej+Z9f2RmS/U
         0Pk9jHrWKDsJxVJsdRTcCC/9rccPvQ9N/+8BszEJbaqaJDTD4ADDh9/U/dd3CnBS/0IE
         qEaQuwTZuG7jJVp6btW/OGCYsJKlrqBewrZ4A50ngSPDfBQr+54cbvn9OPVqhpFPE5Nn
         kq5iX+r+NvUaT4nV/TplRk5NxKzhiH47aCZlbDqZ9h6NZTPa7MRxYr4W6sd39kc3DwGt
         vx02MhvbjSXaxaieWtFslI+D6RFsbfMbaHVE3CZbW1yh69QQDjHDYfDbkBXW12lObHm3
         9lLg==
X-Forwarded-Encrypted: i=1; AJvYcCVjiomgyuaEaq0LQ64uiFhZHdnrgvAb24Ij+GV/SLlBuwPlLD2Bk2HlJQSmpI+BSfIAXl3J2b5qLIJl@lists.infradead.org
X-Gm-Message-State: AOJu0YySc951VpAjdc3mzH9JXS3mUUmfYOV034HRczXP2B1nbPIKc3sP
	OLk1JL3p6b1QXaGhZWScH1PgjyCUHs9IyUsdTnFu6G6O2U80Jkh+BjP4+Je33686uAUVaPq99xe
	wa9tdbZa8uI9hlqdDmJFfvp00+EDVwmDynyVe8oQR6jZ7VoHFX05YrEUvRY1hMplOyA/Es45x7O
	nvuue7GM+3FeyaQXM0JbURMTW48nlqE7LzCd3ir3G3O6E=
X-Gm-Gg: ASbGncsOEb+z6QUcYydHbLKFG+sWto6REr1sw8LccHNUA403mgwCgEA6e+N5ohacA4C
	0949GsSbDvYMBrOTDLdmUZTX5Qpc8+R7BDbzRnofe6GgQYzCz1qPzxwwvXT0UlTbXwL3G7siZ2a
	kISWG0y2d/CaI27vvooRY=
X-Received: by 2002:a05:651c:1109:20b0:32c:a709:80ee with SMTP id 38308e7fff4ca-330dfd86527mr18577431fa.39.1753369634616;
        Thu, 24 Jul 2025 08:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH+wJ2POoqaRw4chK04UICtaUDKnfGa/omU0l+yJWs4+JwWgZpd2RTxBX3F9VOsMWRv7M60kPuJM7mM/FUELI=
X-Received: by 2002:a05:651c:1109:20b0:32c:a709:80ee with SMTP id
 38308e7fff4ca-330dfd86527mr18577251fa.39.1753369634166; Thu, 24 Jul 2025
 08:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250721021718.1159879-1-cleech@redhat.com> <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
 <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb> <c523f9c3-06fb-4aa6-958f-e49e7c5477e4@suse.de>
 <c0af190a-3e46-4203-aca9-da1017d2fd2e@flourine.local>
In-Reply-To: <c0af190a-3e46-4203-aca9-da1017d2fd2e@flourine.local>
From: Chris Leech <cleech@redhat.com>
Date: Thu, 24 Jul 2025 08:07:03 -0700
X-Gm-Features: Ac12FXxvivSillzr2HqB2baaGijDx7gzI9VNUdWsQstzDnp-Xf2hDP8bxys5uOQ
Message-ID: <CAPnfmX+pHz-i8YTydL362oq9ko6eihmaVV8ApMBisR-c8=acLg@mail.gmail.com>
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Prashanth Nayak <prashanth.nayak@netapp.com>, John Meneghini <jmeneghi@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SwH9E2TkRJ1I6tjoBop45PSkyL3MhzOIXc1_QrI_Ld4_1753369635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_080720_892361_75539FE4 
X-CRM114-Status: GOOD (  12.62  )
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

On Thu, Jul 24, 2025 at 7:35=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Tue, Jul 22, 2025 at 08:27:21AM +0200, Hannes Reinecke wrote:
> > Ah, the NewSessionTicket thingie. Yes, that's completely pointless for
> > NVMe, as we _never_ re-use tickets for session re-establishment.
> > We only ever have one session, so the use-case of several short-lived
> > sessions doesn't apply here.
>
> Not following the discussion, can you either nacking this patch or give a
> reviewed tag? Thanks.

Hi Daniel,

I believe Hannes has given a reviewed tag on the libvnme patch.  The
discussion on the cover letter is about future work on the kernel
side.

If it would help I can capture that tag and then submit this as a github PR=
.
Actually, I think I might be missing an explicit NULL assignment on
the declaration of *str to keep _cleanup_free_ safe?

 -Chris


