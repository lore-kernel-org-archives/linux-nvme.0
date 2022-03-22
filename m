Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3060C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXnVAd5Dg58XZV7ozlPJH3bb1ZFXNHXWwnY3pYHF+pk=; b=kZwnxYX11A1BSfM6z6v/mopokh
	DreNI1wKfQYcD54ENkScYfg7tzaxmC69SUwSEjHnFieKuuPBuNddhmQ902/jDhX+l9KRIpVj2YdLf
	IlnbBeehAVrMDzKEMXLUt7oKOzZl9ma3eI6G54OpV74edgoSacJ0LmMb9QAYGhPcqL+LmLBciiIz3
	Ib+VKy383p5oXtPnyp6e0OR65gfOUlJgwGD8bmyktWZ4I2qifhsdVsMWPzml6xhXU9TXTsPpWy7wJ
	2p0eORKa9/bV/gUEpCi9EC7NVyEXSnaoqG+5MTz641Ex7jWKD/KaxUAjnSyhlXuJZ2XNYkf68OviO
	C0jhBWBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWgek-00BZ2k-DP; Tue, 22 Mar 2022 15:42:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWgeh-00BZ28-GG
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 15:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647963762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXnVAd5Dg58XZV7ozlPJH3bb1ZFXNHXWwnY3pYHF+pk=;
 b=dgWhYeU+Vw1uMp0iuFtyyzLY2eEQNB/8VDLCwfKkt/16cj7JEgY4N2aA81nuPVFxXMegVG
 ngtJwnvvMEfd0dcfZs+WssUUWsViieyGlKFr0HkdCBis0I4+1K52fFrwRIDJx9hQy6NWKA
 gf6LEe5c9Iou68MIqcuCBcrmQ4jcURs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-WF-9_lYlOZaqmNDJ1PksnA-1; Tue, 22 Mar 2022 11:42:40 -0400
X-MC-Unique: WF-9_lYlOZaqmNDJ1PksnA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2e68c93bb30so5751097b3.18
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 08:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xXnVAd5Dg58XZV7ozlPJH3bb1ZFXNHXWwnY3pYHF+pk=;
 b=hLsvG5VwmiatpB90Q0u56DDAfkcAlD1p69j4Y2DnUBFj9/zSatitNBA+5DbtIPky54
 Tw9TmfcKlYhPnTdR+tKob465SMFfovpaoa1pyWLUx116NhvQ20zkbShru6ImJqs7ZRD6
 RcimNWX+oQblh5DcexaHmEWDfUy8VvbsT9rwrZSEQZ+6mnNQPPN/3jAjAXB/pl2ZJ7bO
 /9SVIqx77Fnsje08GNcEU+NyKvpB4rvonW4daHMCRZPhJ044kietDgYv0Hj/qsOTQbrb
 sbQLKORJHf4w+1BCIy1Ea4g0Ux4sQsCw2Un9+3ZJsM7sMdN3TFFUhj4Rm2aNEmhFrXjr
 Us4Q==
X-Gm-Message-State: AOAM532fXYzQJXUmauFtGWjXZoSJISwLDoipibwVlsOwa5avFesNFXaA
 7dSCQ2PNsH2dvGT2oWuv7NoYO3IwKQDQmVF9XABexYlaVKARZCOc1OrjT/00uf8cxs/NZqHT2L1
 Z+Is90jcHWfdFOwdlWl2lMzcnTcW0YHLlmJCqmo4KzrE=
X-Received: by 2002:a0d:d143:0:b0:2db:dfa5:e376 with SMTP id
 t64-20020a0dd143000000b002dbdfa5e376mr31783201ywd.218.1647963760272; 
 Tue, 22 Mar 2022 08:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Gslh6nkVyDPcHXTMDkVC56STbDP//cKIlP36U2vqWrCrhr7QvwjsVb8CtGgsgVpeBYtX/ISD4l3UZR8wPK8=
X-Received: by 2002:a0d:d143:0:b0:2db:dfa5:e376 with SMTP id
 t64-20020a0dd143000000b002dbdfa5e376mr31783188ywd.218.1647963760134; Tue, 22
 Mar 2022 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224304.955072-1-cleech@redhat.com>
 <20220321224304.955072-3-cleech@redhat.com>
 <20220322111743.GC29151@lst.de>
In-Reply-To: <20220322111743.GC29151@lst.de>
From: Chris Leech <cleech@redhat.com>
Date: Tue, 22 Mar 2022 08:42:29 -0700
Message-ID: <CAPnfmXLS6GXDb1dHdjTAUzMUjYkv=nFXougxW=qZKTDnGg6g2A@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme-multipath: break endless loop in
 nvme_round_robin_path
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 lengchao@huawei.com, 
 dwagner@suse.de, hare@suse.de, Maurizio Lombardi <mlombard@redhat.com>, 
 John Meneghini <jmeneghi@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_084243_638920_196E42E5 
X-CRM114-Status: GOOD (  10.23  )
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

On Tue, Mar 22, 2022 at 4:17 AM Christoph Hellwig <hch@lst.de> wrote:
> Shouldn't
>
> 1bcf006a9d3d63c1bcb65a993cb13756954cd9c
> Author: Daniel Wagner <dwagner@suse.de>
> Date:   Wed Jan 27 11:30:33 2021 +0100
>
>     nvme-multipath: Early exit if no path is available
>
> take care of this?

No, in this case nvme_next_ns never returns NULL, but it also never
returns old.  In the kdump I have, there are two NVME_CTRL_CONNECTING
paths that are returned over-and-over.


