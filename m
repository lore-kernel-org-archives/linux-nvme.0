Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3BAC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 05:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=; b=axyueN8D3UuxVKtksnj7iWLiDf
	+RW/NTLi2a95z5S6u382jrSIV4xbq0sEzGFWo/zGqpFhkjvJm7XoPBZOAlUhKZllJsu4ltiwtwIuy
	WL3B1Sr+GnY3gYrytH7KNsQ19a6LK1fdo227U6Wa/ugmdFiMAT+rPd+b2r+5t6Zxvbbqd9Aq/it6/
	zZdAgVKjEYBrob9Hjx0nNIjsik8jC80wx1hnVJdK0W5RUwaveG7wOvjygxP0BOe4kUb1RnV/myYY0
	8NOkI4IGZEnXdUsyp2RCOO6yLqm8eTNTo94+k4iG138iamQzxS5jJ/qW48HSU3pGP3NIAPXISI3jt
	xbMP45pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7Fo-00Bvxm-2k;
	Thu, 07 Dec 2023 05:48:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7DY-00BvgU-0M
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 05:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701927993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
	b=Ou1eulSyabayFdautSHc5oxVnhnZ57YhHzXu1sFulzqCmqtAh73+Ir7nAbtOeeObuTIilg
	nWIK0hS0Yj0TER8oExh2yQLjLPPp2Y5l685flujCp4dgJDqhu0TOnFP1Bwa7EGG2TmNWJu
	IbMT9mq2z3S0rD01UctOOKEEJJModyo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--Uki1oNNO1W4cK7XuKOuhQ-1; Thu, 07 Dec 2023 00:46:32 -0500
X-MC-Unique: -Uki1oNNO1W4cK7XuKOuhQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so576427a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Dec 2023 21:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927991; x=1702532791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
        b=Ow6mVb26pcEM2m/YjHAUhw4BoHa7hkVTOGnhv0leVsbkZeLNJijzCfFOMHyl1jNAxW
         /Yq5MRlyV1u9n3FZqOGZ+YFMc/NuqMMPTLBVMT6edBoKlwnIUlMOWTzeI3fR1VW8Th1F
         IS7qp48daA4niHNKO+FqSpvXcGL+7dxxPTzrOwLfWBtReMNjdNXP4WHe/qhm2WfgyDni
         pozUulQ62k2EbEUdmOm/XRXPsFR3Jkk7SAxJt0ExkubPexVObgnR5JHfPLBLFoXSNfMk
         CJ/4LrMb+HWNu6l0z7y7SOLP05mZk7Wte6UEbOE/WdHPQhrkVB/HEG2DOMkiYT+dYukp
         RtQA==
X-Gm-Message-State: AOJu0YzPWH3kmqJ9rzSFUTrAtFStgccV3349mwg8S25oUxP3pBsGVObI
	Ytt2e212i4ArlqHUKEPGvlxxamZKU3w+pNSMQ6Olozq+ko4LKIwx5PJyjPL5nZXNHqwiVaIwa02
	I7GhesBEE6q8pNP29Wx6xFovlnkcU41fKABAu0vJXshc=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id gc11-20020a17090b310b00b00286bff2c41bmr1876739pjb.23.1701927991099;
        Wed, 06 Dec 2023 21:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfgjoIKpasl0QD67eKC09rD6Vvob1+V2GPMTPFb8/kThT/w3JyyDRtZYtlMl19xjCR/LXa/IPCZwYXFZnNus=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id
 gc11-20020a17090b310b00b00286bff2c41bmr1876711pjb.23.1701927990817; Wed, 06
 Dec 2023 21:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-6-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-6-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:46:19 +0800
Message-ID: <CACGkMEsiDbZcCAKDxK7hQ=pqWM-GHG2UaKRGM264ozqKVwZRPg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_214636_236246_F64A5F9F 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 06 Dec 2023 21:48:53 -0800
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

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

For vhost part:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


