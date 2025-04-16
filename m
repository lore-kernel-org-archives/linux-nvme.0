Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EFFC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5EIWptPNf+bD6TCzDb13Bmy9OoJJigove2+9RXxBVM=; b=C0BiMIg5TOX8uHsCxI/607bZ+I
	ze3WbF2y8NtPZovf1PB/FxGFB+HgIYZ/smKqOIelsOwu6++MAgX38YT2Pp/J2pzJ1afyTxs6RAaB3
	RszMTzfXS5+xMtYvdNR+4PqDUamGlsVTi7r5C+2tsOdOPII1zFob8/7dfipOyKkm4KCfY3cO3et4s
	0EI0xhfhB5jno9dzjd1I2eQWLv8yFONvK7kWg4owGRQ8bO3ANehsqzmMkHssBozwgvd7tV+HA2v8q
	2FYMLeMvUX1OW07jxTv3yRHsDr1jX8YySsMQ5lrYGb9A11lJK9Jgnd3JHc/DgKWuPvfae6wk4XYPW
	eLlZlOKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5onU-0000000Gzr4-2YXm;
	Fri, 18 Apr 2025 16:42:36 +0000
Received: from smtpbguseast2.qq.com ([54.204.34.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ziN-000000095L8-37I0
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 10:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744798181;
	bh=K5EIWptPNf+bD6TCzDb13Bmy9OoJJigove2+9RXxBVM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=aKQIDomsyJx5i+1LoVcnvbsAK+G9ov59gTY6gnoorx663WvAdoShZEQl3+OjiTi8Q
	 MevDHnbGlInovLKqeYm67CT4/uxnLKEer8YaFAOyY799GJI/d3irZFTiouA70dTgXs
	 kRIcE3DN5qWSFsl4GurtT+qXw6MNGkeGwDTWb3t4=
X-QQ-mid: zesmtpsz4t1744798176t4c2f555c
X-QQ-Originating-IP: vODOBmih/ADTIk2eoWSFJkGYoB/RsOZvdcP4f7sUnmY=
Received: from mail-yb1-f175.google.com ( [209.85.219.175])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 18:09:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16269784077073751901
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6e2a303569so4798761276.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 03:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLRFRVXQPPAjQCHq/Gdx6MsDWGm5ErfcuIBuvKYb7MZ7YAQgpH7mLfwMsv12DH2xwiLjBWsj43R6rN@lists.infradead.org
X-Gm-Message-State: AOJu0YwFp1SfqO656kSTx6vyH4oPsA7+19CpvSwT8td0r/SxhDnbLmiQ
	GqWQj9x4fBArqCBUWdoDRDWnE5rqzTGiJPNcruNURtd2fYmdlDOt0lV4alZcs+HnYNOdqQXEaIi
	jpWzLktPf/zXYrH+LSFkppjJU+Wo=
X-Google-Smtp-Source: AGHT+IFxOQerwyXR4s01cKj1FQCmW5mZBGS8EUkxg2eBy2yn8PQm4fMpJOhxMxu+WrXOTx3w5ulHOeUcX04b8xnFFTA=
X-Received: by 2002:a05:6902:2b8a:b0:e6d:eb74:272 with SMTP id
 3f1490d57ef6-e7275967af8mr1257382276.22.1744798174393; Wed, 16 Apr 2025
 03:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
 <20250416044827.GA24153@lst.de>
In-Reply-To: <20250416044827.GA24153@lst.de>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Wed, 16 Apr 2025 18:09:22 +0800
X-Gmail-Original-Message-ID: <45D187D71349584D+CAC1kPDPYiUKqRmqW=hzOyGudvUXcwxo0kgDU_j40+t7rYHsU-g@mail.gmail.com>
X-Gm-Features: ATxdqUHphIIrq227AoMvNzUOdxFn7upg3kfvytoiynDmEPipLLJsDaFiQeVe_To
Message-ID: <CAC1kPDPYiUKqRmqW=hzOyGudvUXcwxo0kgDU_j40+t7rYHsU-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
To: Christoph Hellwig <hch@lst.de>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, Leon Romanovsky <leon@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N+v2p8NjVRtQO17XdMm26L58t8bOI/3G8+MTky852CaFvY2+tPR6cS4C
	3ahXLSHM47k/7guhWVUJxHD7Lo2e/dZaRysxngzyDVSu8mi90omUZ6/s7cPElugqXwOKuzP
	2v6kAIVNHNdgVS6FdC6OReqEgmjy0rR5uQN/yOAGpeR2kBThhL8VUHughzfdDIgtYvtsMx+
	YSmo3wzN7SMh+5WaNEUwApaVbcA7c9LIB8mUp8Mv8DcLyyCDKuJIjmVvoJE1UeoW+hgsdvG
	huD9yaFDeNLQu84ePsVGu7sH8jdFKC5o9igtKRdtYrEsG2xorRI3uXr9gzw+65F51/vHI07
	/GUYfEOLc7IoMw0KUbqLqJEGNNox8mq6WcfZ6lfB54Q5o0CP2q3TInXDPUOf8G1LeXNn9lG
	fM9BjwhRXsOLveeC3Ab6sqpmlm8Ms21Ebeb1zDE/XrWGDXz1HzGkVZiHEoGFeOu7R1YFPSP
	2UJFuLJ8paVD5fUQmKoKaKbHR2cj24q/35YkFPWFbjtEhyv+nCKVRASPa7AijMPMAowbW4T
	RoNw5ZkwtlUKKo01HvaBe3iPAJxyIitm18REMf11SwczHunzPb4Rnv84dDsBfWmCWlZ8JqW
	KNNi5QACSavXQJap8qdFb/YapAzI56u7yLOKj1oH5Qfv2sajqGlQOfDnt8ebgZMiWAlu8U9
	S27dv44Bo5/uRc7siw9t9UnMHoS527flO+GZuuqtXFE1TrnVhecUlZvJpzRN8hcic8xol+7
	x8U/XL6gZISu1cJ2N0IryHjYBvpJVcY93rM1nVKHPIJK8qCgMd65JqI8r0KAYCdFb+XtXLm
	1yhqgtTDmGHZv72OLafnTDwykSAUCyYE41QEssmB9+E9lOouibM2rYj4GXgMFVKaIhZiA/Y
	VhAOLN5Pwybh68qRtB2PDVf8wPujFZPaJls45mljsh3dxLFw8o9AE1Etm4YEzQEYutL5BXS
	o6yPn6RdV5auc1Juuve9MDUkgRqAp2OpFjlVv9AxDu5eyO6qmNvPL8Uk+ddxote6ibeoCbX
	93SRIln9KfQj1Su3mWHFpxhSj9ha9w0iQVwbiF3QQoc9fAfJtdKIR+qtSqzTH7RYRDbUcsC
	A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_030956_339016_097CB8F1 
X-CRM114-Status: UNSURE (   7.22  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

Sorry for the mistake, v2 has been send:

https://lore.kernel.org/all/20250416-noautoinline-v2-0-e69a2717530f@uniontech.com/

