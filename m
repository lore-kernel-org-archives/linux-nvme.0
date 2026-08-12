Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1DFC5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=; b=2mGzcCO7yHH60JgTE3UTS4KLvI
	eBmbK/ViHVOpJszjB8rQMterXx2QGeypdMt1+Af9R7paII7SEdKlYOHfOzZdhz52jzTiryMvfRTqK
	TVWJ2nuWYelvDG80T3S2ta+/TgBCshwf5qGvZZEORBF0hh1rzLzO03Vd1FsU2NITpiicJRB++LFBn
	qPP/82vB6EYFHKXxT0v2xviDtm3bJwLWc7KKb7TfaKkWRr5AwvJh2F75S62C0Q1z9tYkviOgranfs
	OtqIvjhHbYlibr+K/UF0XVc6B2OAplDpie5XXnkt2wv50tp/USDnzoI6usrKDrbmQkYYhIkOv3Oqg
	wzw/zJ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6gX-0000000FzH1-3f39;
	Wed, 12 Aug 2026 10:59:49 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6gW-0000000FzGV-1SyP
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 10:59:49 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso945572a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786532387; x=1787137187; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=;
        b=aPOg4aJC82EEzwc+J7m6vdRDs8AhA4jIFsJ+SMPGtTkECkGwulVWLg+eowfDxT3fo8
         q8PnVFXlU66sNB4ghs+x24sltf56X8gp0uzi8RfyHIYx2uGqh9bNgVK+OCtqSF1U0JQL
         D5xADsHrXlFs1VVuqfm0Nq2tMP2NbhE1tYYCzCk1Jmp0QhCxFqpoDEpqZ/rF7GzYB24S
         bdsFaKtSM6TyCsi4Ghw8+9MUgNcPK2lzJSxb7UEx5USGZxIDRxA2yMYgIuZNsv4HnGF/
         F9348tsnPdnjRO5v5jLNYY4m8w1ZA2SDkH32y064FRYDxW/qJ/LyoTOU7zkwMbbyu5jd
         bIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532387; x=1787137187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEyXLqcxbr/SLsSUNviv8nzjhBE4ozvJHxIITTWu9ww=;
        b=KfH8WaNqMqM3uaedmPf5J0/WTVIlliwsZKgUENi06gZj5xpq/qrBq6+ASCv0ZxwV9x
         5DqIOUtht0RNJouALwYOIyzqzf5fB+Vw48ckY0OmaMwE6HGYQ1NzolTSu3o7rfW8TVze
         3k8do16/S4J+3SWynqn6PFlrXhBVyURcRjicUgCa9G9kG21G0+8jMPZL2eRnFacgabAr
         qq20eNmt5BuymVnIkEKMkccQEs+AzCBuxPVH+iBw5wGZU+noWDH5YtSFm00rnKikxaWc
         By1l+pPUBdInFbTuOSnc36xng2kf5A41Gv/iEt6ulfZyMfJAXMoReFyzY+izRJGx21iE
         REbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgSqGG4ZnoWxrvEsrd5TPC4Dl9uS1kC4/Zcv7UvL2dVNi+fFls1QfNLplsK0DEQuM3cle5YYAe7d7D@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1p2TAXX7AVk6hZpXa8PvR4phpPPlRl/glAEZI1ssM3m2+P0GL
	HamEXV8roJrL429tDfGhOQLo+q0oUb6v0od8tidlGGzv+cJv2M/XtECA
X-Gm-Gg: AR+sD10yWp+2ng8lpNSEcUNGlfBlApkYTzT3mg6K5+8H4bNF7qLvqerX0q4b4bErlTF
	WXsqb61kAl+acmaGxXnWVuu7dGMdHzc/0Jh20TSK2yEpSaVFXn4Y4qPWKaVoV+on7nkYC5g2X6h
	hynvZX0jYbceo3sKpmZwdxqQQ+nbp04jpDUWuEXE3EoAU6qE/vqS5MlerMM6a5asu0WSYa4blgB
	4fnAqykPCjGavEbCL6QNIL6lyZ6NHYnpHVX/gfOXE14surEFDmNUWa1S8hqdfKo93EVZBqHlJde
	l5W3qemS0/mEwPp2E3PrZi/Ao/WnWLagAJXz3/lyPGBTiakE46n44C53gdtg39cKR2kd7CcnM+0
	Ble7v1wJWfyLZIBBKGQ0mfYkP52sybqivXf7zuzyB+RcMU8ODpdiynyhIXRh3vKc8M4/BuNpMjz
	jV33twLZ8aipf1C1cOFMgjFy0SpFTsyuaRJlBQr4v2NywMmBAO7c29Pc4+XUJDBntf3Ia60lg=
X-Received: by 2002:a17:90b:398c:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-3930146a70dmr4046826a91.17.1786532387416;
        Wed, 12 Aug 2026 03:59:47 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe55a7desm966989a91.4.2026.08.12.03.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:59:46 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: cassel@kernel.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Wed, 12 Aug 2026 19:59:41 +0900
Message-ID: <20260812105941.55577-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ansfMnm1WntoQRi_@ryzen>
References: <ansfMnm1WntoQRi_@ryzen>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_035948_407579_8B891851 
X-CRM114-Status: GOOD (  12.65  )
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

Hello,

Thanks for the suggestion.

> Wouldn't a nicer fix be to change nvme_fc_ctrl_free() to look more like
> nvme_tcp_ctrl_free(), i.e. something like:
>
> +       if (list_empty(&ctrl->ctrl_list))
> +               goto free_ctrl;

I am not sure whether that would work, and I may well be missing
something.  From what I could tell, nvme_tcp_create_ctrl() does its
list_add_tail() last, while nvme_fc_init_ctrl() does it before the
nvme_change_ctrl_state() and queue_delayed_work() checks, so on those two
failure paths the controller is already on the list and opts would end up
freed twice again.  The early goto would also skip the ida_free(),
put_device() and nvme_fc_rport_put() for what nvme_fc_alloc_ctrl() takes
before the list_add.

I am not familiar with this driver either, so please correct me if I have
misread it.

Keith suggested moving the existing clear from fail_ctrl: down to
out_put_ctrl: instead, so I will send that as v2.

Thanks,
Rihyeon

