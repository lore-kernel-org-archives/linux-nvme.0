Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3998C7EE26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 01:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rpvH3mrkshJDSMN5A0mtlzxXE9ldvfKVi9Vobk53dQ4=; b=C5i9oe2VCiLO+CBg1okW0bY/Ko
	QDVwrylsYAby7j98MyOnN01hm2AfcyVLiFZfoNV8vrSg2evs4VRhCk7IkdKBfatEqh+Dd4uEAjH75
	g2VLawhtvnk829RStQKDwnN61Rvbahb4EDYWqJr6hkkhOecoPNsEsGKj7us8K8Q2iWim0ZwLfGC7J
	RvHjWDa5nmJHRokwG+uqaZJyD82XZsBnGNFJNZx+3UO/Z5FgEy1gSESYXZWATm6CJreqUviaQGwnC
	dy30cVA5CqMGHfHAqySyTzQILBAozjqAAmNwthQCJmVJaf/5NMCxRtY32gGFjOWP1K5PASAbNgqOu
	9UjYQx/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1GiO-008ZWD-0u;
	Tue, 23 May 2023 01:21:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1GiK-008ZVe-31
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 01:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684804883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpvH3mrkshJDSMN5A0mtlzxXE9ldvfKVi9Vobk53dQ4=;
	b=JuE2qBsQKEOSAkI5tSl/2sYpqlhqHfzYey2BZbyoG2lanB9dNvIlDRmh52uVxLgUdTYATm
	fAizefedftsjZJstv6sMCfwtn+yPN7suwtpoIrzZdLSUIj4me1WmQhBodKtyHP9+CFyq1d
	1K287JpLQrXJuGW3WIz5aRTX0744+Q8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-pgkAkMOENmK9dovRFRuKGg-1; Mon, 22 May 2023 21:21:21 -0400
X-MC-Unique: pgkAkMOENmK9dovRFRuKGg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af1589c75aso29443561fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 22 May 2023 18:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804879; x=1687396879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpvH3mrkshJDSMN5A0mtlzxXE9ldvfKVi9Vobk53dQ4=;
        b=HkLQaljJ9vjqX4o5F4njQPoTecMgtrKXN0mY+JbWt1Wzwyj1qKPiMwe7gc4fzybAgZ
         lEuquBh1UlynKSWt85mKv0c0Z5w7RM8UwUe1iym9eP9OHYGuXI+WD8qF/DHO1DysYNCX
         723S493qPsjAvS6IttIAQP0Y0oWuqNafAk+P4dBJbHtY7LCPsfXFMJSyd2ez2Ba9vSSR
         xSbiFfQIDTc/KzgColwxY8zT8LO6H6XwLo1dGhqAqxrQqKmc+GrHEoz2L130DH3bqkIy
         wGvEKJdIXPrkhJ2QoFo5NlECIUKa70lXyuyuSzYrUWo910xBrIWS2vJyUflBL3kj7lrv
         iJSQ==
X-Gm-Message-State: AC+VfDxQ4EzSXy9yzdCdELQARD79G2K/kBlUMgsx1LS4TOZGF3eGZpYg
	U/YvccDCXFFlt1RQT0x7P4m1vtsFBnVaaqtUL5PbCG7nsSmfG4TgFcDW/Gr+rFbHFiJm4OxbPO/
	EyDKe9TGehcvBh+HI39M99z7yL1xowwbpGiKKsIg7xKk=
X-Received: by 2002:a2e:8456:0:b0:2af:1d3b:accd with SMTP id u22-20020a2e8456000000b002af1d3baccdmr4896186ljh.33.1684804879507;
        Mon, 22 May 2023 18:21:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qv2BE4sruiFe5M5P8mqq5mbU7wnjNAHC2O1dNpT3BJb5VEdrKFIUogijMJ9UOpuy0zR1DK9jS+/hqa4EWcj4=
X-Received: by 2002:a2e:8456:0:b0:2af:1d3b:accd with SMTP id
 u22-20020a2e8456000000b002af1d3baccdmr4896183ljh.33.1684804879214; Mon, 22
 May 2023 18:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230522215347.2031483-1-cleech@redhat.com> <8066e1d6-3197-6127-00b3-a3a2b8eae369@nvidia.com>
In-Reply-To: <8066e1d6-3197-6127-00b3-a3a2b8eae369@nvidia.com>
From: Chris Leech <cleech@redhat.com>
Date: Mon, 22 May 2023 18:21:08 -0700
Message-ID: <CAPnfmXK3F3W1bhC8Bdn2X0bGdnDs+tJBcCVGV7kvxNgiXsr24g@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: fix dhchap secret memleaks in auth code
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_182125_072209_7411E768 
X-CRM114-Status: GOOD (  10.78  )
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

On Mon, May 22, 2023 at 5:16=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
> On 5/22/23 14:53, Chris Leech wrote:
> > Re-authentication through the sysfs interface without changing the PSK
> > will result in a memory leak. This was tested with blktests nvme/045.
>
> I think it is already fixed in nvme-6.5, if not please let me know ..

You're right, sorry about that.  Looks good in nvme-6.5

- Chris


