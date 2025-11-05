Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15820CCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMZPJGKaj34fNq4BR5xlJC2M0qhayaT97oMj/tfo/Hc=; b=LSj4K8ALldTqgxz3kXvc6Bu3st
	iwOiWc4rHQk4MwTs95Y3/mobxydsN9IfqfNegT4PuS6rbBG8PQSTuLeU4jaKDtJ7ARVmbTrw2bXO4
	6VQtRDJdzmtL6nN+4b/WO1MxsI3V2kCi7NLNBcVSj8E48fOD7Z57/2fQHtids3dXVZv1Q1FKX+Flr
	NANlwcsTLEshQjHs3PMK2NmnYgmyNOnEaqx5afx2BzAAGs2ZcGUxPR6MliJKlhBcJQkstrWG6TD1K
	7n+H5BDeHITmawV6O08vdX6DdMRnN9KXWROzDCJ4q/Q0Q90oXpPahHzfQP+YGy7LAkhH8+ccBgrHQ
	C+Qr8TcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGl8G-0000000EX06-2N5S;
	Wed, 05 Nov 2025 21:33:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGl8D-0000000EWze-205o
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 21:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762378407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMZPJGKaj34fNq4BR5xlJC2M0qhayaT97oMj/tfo/Hc=;
	b=hQpq6Xsq48UXTWIYNCJcKsG/OuSnh4OzLbJVFAdLHup/Uq88TV/OzWU08o19ZeugvC3gML
	Pj/pApyS4Jl/CnmN6tz1fGrGfyP3TiTOAjRs1zEfesjQtrrOsOlFEIWUTOxpkheY1ruHpk
	RxZusYRayFvxFX8Sumz41AwD3vdXRUs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-0joe3zdPPSuAl_YlvbDpfQ-1; Wed, 05 Nov 2025 16:31:26 -0500
X-MC-Unique: 0joe3zdPPSuAl_YlvbDpfQ-1
X-Mimecast-MFC-AGG-ID: 0joe3zdPPSuAl_YlvbDpfQ_1762378286
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63e1e96b6d3so427172d50.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 13:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762378285; x=1762983085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMZPJGKaj34fNq4BR5xlJC2M0qhayaT97oMj/tfo/Hc=;
        b=IIj8hqzbSdvIxhYNeFANt9jr8KF7uv7ePBGS3Hbcu3HWqAiNFU0CQ6FvjQSK4rzVHE
         JxhCSBm5leRpkPveMaIAKv68PjINcMsk0bCoj66kzZ/vA/UEiBrEvfaZFfy9jS0qGonJ
         30Rf6Uwk5MDGZjyn7WIGLi+pjWEoxPgMhS2qxAy5hHg7oWMTKqQbfVWz6ZgIHjJHIIOV
         gtLdCzk+pMhLUnB/ADtrBz7B8VDlUoILJg3gAwiODCDJi2avjid3tvhU2x/TwXgzBlMl
         luEKdv0/eTHjLGtklF96qX72aRtdlsep8GGLrNf5hl3lDpMDFILf8AlLBE8bonzUOss0
         BOJg==
X-Gm-Message-State: AOJu0YwyjnGUos1KA5p35zm81yxb7wB60mhRL8v+pxI3D+V1J72KGesm
	s2BZwKsmSpcWdLN8CC1gJXsV2J5iPL/EnAaUusw5PI0dt+xUgIWkWUXT0ID0koRJWfz1s42r9JZ
	0EV6qAJItIl16mkogpF18gCXc2Q4kzdDpA28sHDxEaN1Ep2QKEzzMNuai2UxTjNpKgnEQbyyvIG
	U1/UzSRVyvEOAItzcpY7FizoiVYv/maT51S1+MpQ5fW0BnLDFrhvg=
X-Gm-Gg: ASbGnctFAfB4T8403WLmNBP69HY0g1YTPkiuEpb7bjWs2PZPeHKFQIAif/Rb0nPmeua
	ixzSs5JEUolNLZ+3gC3fqZTKRuOHHlC756zWFtZutHPVEu1EfhNQBXeTcPpFgq5TqZVJFVyIr8G
	q/r//YwByj/wxFeIAT5I8M6Z/Ca4iBsUJPc8nmWmSmMerJVrlAOTErR3ga
X-Received: by 2002:a53:b10d:0:b0:63f:b922:ed8e with SMTP id 956f58d0204a3-63fd34b5f73mr3145595d50.3.1762378285460;
        Wed, 05 Nov 2025 13:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5AhxPePEeIIzMqRezwNiZYaqMBqBB2j2ivC3but/89pby8S6HT7e/lj1J/BEwTXwar395RlWLCuLCBnPpusg=
X-Received: by 2002:a53:b10d:0:b0:63f:b922:ed8e with SMTP id
 956f58d0204a3-63fd34b5f73mr3145576d50.3.1762378285131; Wed, 05 Nov 2025
 13:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20251104225939.3641605-1-kbusch@meta.com>
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 5 Nov 2025 16:31:13 -0500
X-Gm-Features: AWmQ_bmIjd1nbSBOL5YxtBsL2YY_xNbJOr8PLPZRhgbXDs8Az5Q_PPIff50GEDo
Message-ID: <CAGtn9rnm-V4Ejm9kRkvV91XAO98XF7jv9Y7Kjr611BbffikkEg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, ming.lei@redhat.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>, 
	Casey Chen <cachen@purestorage.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M9fJvYYy_6KpG6kwDNblYGHspYe4IV8-6q22P1iHaoA_1762378286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_133329_608067_1FE3F860 
X-CRM114-Status: GOOD (  13.31  )
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

On Tue, Nov 4, 2025 at 6:00=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The namespaces can access the controller's admin request_queue, and
> stale references on the namespaces may exist. Ensure the request_queue
> is active by moving the controller's 'put' after all references on the
> controller have been released to ensure no one is trying to access the
> request_queue. This fixes a reported use-after-free bug:
>

OK, so I get that this fixes the use-after-free, and don't let my
comments hold up
acceptance of the patch.  But can you explain why this actually helps?
nvme_alloc_admin_tag_set() allocates the admin_q as part of the admin tagse=
t
initiailization, and doesn't this change keep the lifetime of the
admin_q past when
the admin tagset is deallocated?  So where do we detect that?

-Ewan


