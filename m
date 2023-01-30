Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF20C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJuNEe13y0+A5mAixQMK194sp79qApFydRMvu0db/sg=; b=ajiH2HgLayj5Y9xWGEDU0Ex4HJ
	bok5DtEwE+5660keoRHF2bzYLXaJEI7+klkKYF23yWplW4oydGFgQ3fpZX2NHSxCsDyQSIhnwWFWv
	X25s/iIqaA338NeenBkryhmeL7wlXQBzA2PpsnVL3UhPK064kcm5YjThCP6TSN4gAt1JE75L4knr6
	eQv4BIE1sDz9AESvC6yJbewCdDzLSbBN2e1OMva/NjgFthemlOkymE7p4Y6LWxuDCm2zDZUB9TzAB
	naRW2FZlL/cQV5dE24zhnfLbOH88vNKyRLGsMNSDekgKwuCKCkncsWvF/hvyWIs/mnEa77pnmogI2
	Jm/YtVEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRAK-0034jK-19; Mon, 30 Jan 2023 10:13:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMRAH-0034iT-1l
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 10:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675073606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJuNEe13y0+A5mAixQMK194sp79qApFydRMvu0db/sg=;
	b=MOVlwaV0viQEDPl+oyI6k/BH2R3QFZqf/Ei42i0az1OwFdeeMcAfhFq6ogmM9YDQFaWDY2
	GaA9To9ssNFe8J4eRB6mJt7DP08OTvU+6q4+LYx5SbjU1fV4kNpWZWz5Ocpa2mSQTFGeWd
	stI+yR8GN1pHELtHnz29LBocmRSWGhU=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-zhw537cPN1GfAk2tijhVqA-1; Mon, 30 Jan 2023 05:13:23 -0500
X-MC-Unique: zhw537cPN1GfAk2tijhVqA-1
Received: by mail-vk1-f200.google.com with SMTP id e7-20020a1f1e07000000b003e6d12b4aedso3952615vke.8
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jan 2023 02:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJuNEe13y0+A5mAixQMK194sp79qApFydRMvu0db/sg=;
        b=iLNnqkjnwB2HNthAQxdZFQEcrEhu0Q0DN5/Z/9KYUVBW+m3hj2KXtvJyRwehU/Fsgb
         7/7hqUWGJutUuTswe+X5FjhuXvCoy4+CTdZW/LO2eAOISNhx8ggFCh/rSPqPCzYtPiDd
         5QK/yvG77x35fvnLAkSNkFZJnb56dc/dlozfmzCrRZMeGzizn/DXt9HqciPEJTswrliO
         uzZ43kW1TIBYeCxMrZO4YHvgPsVmRImPNzrpdYkuVtkk9LuzRLXixFi8zWC87ycSY2fQ
         hxeYZ/XS9iTO1ZYO4x2S1Rv83l/kX0x0GqxWk1V/X2z7Y3o8Mkx1ttcDdyBpE+oUyWJJ
         n85g==
X-Gm-Message-State: AFqh2krFWYMxuE+IihURRKiQGKSf9TpQtzmj/yrL4wrih4q0JalFfQ/B
	/GJjzaq9Im9g1xAu4YG623ZsyxKjuyV3O06WhXG02HhdE7KAT2CgiOxu6qcNYaqzXVX/6zXJgXd
	JdohzxJAxFU1MXooGG3sayioN/90yUof1ZMwy8APB0YQ=
X-Received: by 2002:a67:17c7:0:b0:3d3:ef73:b726 with SMTP id 190-20020a6717c7000000b003d3ef73b726mr8045127vsx.22.1675073602624;
        Mon, 30 Jan 2023 02:13:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuHiw2klM8bRgb5/ocws/J5h6ztm+orQAghm5FNUJ0SdJ0T/R0RSA6vOgXhjIsXQbnd4kmWbqEABCkHpYMy/Xs=
X-Received: by 2002:a67:17c7:0:b0:3d3:ef73:b726 with SMTP id
 190-20020a6717c7000000b003d3ef73b726mr8045121vsx.22.1675073602367; Mon, 30
 Jan 2023 02:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20230127154237.349113-1-mlombard@redhat.com> <Y9eWenmquvfp6UwI@infradead.org>
In-Reply-To: <Y9eWenmquvfp6UwI@infradead.org>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 30 Jan 2023 11:13:10 +0100
Message-ID: <CAFL455nk3E=nT9J00uckNjAHKLUWm-cvCt7N2LcCtsZWpstxRw@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix potential invalid pointer dereference
To: Christoph Hellwig <hch@infradead.org>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_021329_189075_A6E35CD8 
X-CRM114-Status: UNSURE (   8.95  )
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

po 30. 1. 2023 v 11:06 odes=C3=ADlatel Christoph Hellwig <hch@infradead.org=
> napsal:
>
> nvme_alloc_io_tag_set needs the same fix.
>

Yep, I'm going to send a patch.

Maurizio


