Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3807CC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10496193E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10496193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6H9w2q7q78229vCpvDPHMIXwa/7XiYkGNzwO5dn5A/Y=; b=xvdPoDWXG5+OdI
	H1RmiRvDUswelpB/lxNNK+IQVq5iuv+ez1eI//kCMGifpj/lws70D0wUSDU9X1mfo1Pwu0Y6hI2aE
	jPrBamL31KEGLUDfRMjewdnneRL3y3EUi8CS/0uXU2j4Uz18CZlcULEVETYk8VylXOZjtDp6v2hWe
	ovtg7a+eZKmBlwMLo00TZHApeVlVzbd9XU3KZRKhqytaet/OmrbSQyn4xWleDQIDAm9gJNvgF0GHZ
	Dh15i7Hf/v2trDWCqWjSqBR8NjVKFWUQUz2wS/iWwLO8pD+YS9z5ypISJc85+bWEa1dxxo9W/iqPz
	U7qwEIDu0Wk+Xq6QAgpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QFW-009IEM-24; Mon, 05 Jul 2021 15:11:06 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QFT-009IDJ-Lk
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:11:04 +0000
Received: by mail-pj1-x1035.google.com with SMTP id
 cx9-20020a17090afd89b0290170a3e085edso159354pjb.0
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BAUij3khHjdlA/D7PSItDddYeIJNFfB+gDUP6xOnar0=;
 b=qqAzlxSJSq3cfMwqTHe1AA2KK9bGt7BIE4sFHzlv4JcLzb/52STQndbW7jEhalsA+Z
 l3a/p2rbxsclKddne6nEXicYGLOX5sDh1K9UI3XxF5fbkEt+l40sf9lMvEUrllu6Bptw
 VsZXtmuGmXF53nJy6hlog5KpHKC02tPmvDGKRlYLjSUIavaOkglnntGaIg/jK86UEDw8
 UeI4zVaiIeWSsJp0WzsFndurRqubGXQT3iqRdasGATYn+bleHpJRws2rIpxDjDwuC+LZ
 7YUnyMiy2CjzcupmiaUpnM4YlVgvNlOSgj0G7GhGN+NyFaWKcpCsv9sQ6XKl2UP95oEC
 dosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BAUij3khHjdlA/D7PSItDddYeIJNFfB+gDUP6xOnar0=;
 b=pDTgCfltdJ7iS6cXr0KYs8hRMa+VQBrHotuGOfWAoTyiNG6n2s04R3k6Q5KbhymBK/
 h9TIYIR3JoOgCksNKSsp4FMCTn2AfQLV6S9l3j6+jvXoasH+okJe5ukrKXxW2hej64ZE
 +eQjbIRYnKz0nGFLSsl/4g9pYEgZSjVtM8BwVgsbLDNXaiMG3JMebfLzl0j0Ittcop9m
 r0wGgRBlrLTjKMd20pBknLE3v2ZdYOZ3rObz0cc+botjKwGd5PyJlosddflmpIovKVpF
 mWFbyHB7IZhtf+j9m/qrdjvBcRLjeOR30lfcCDSyE4Ati762gtUQg/Er8L8JUtlRUcPK
 Fb9g==
X-Gm-Message-State: AOAM530NsJPcJp3lxtbrkYfSx8T6GU9sgbHaAQXDhyf0F6E3P+g56cSJ
 S9Tq3I8RQgNyn4/8/JBI9dGjScTTIAsfhNcHCKU=
X-Google-Smtp-Source: ABdhPJytNxY+FZ+iRFzZ7qU3ag9uEC94rax3gX+C40CV0lN0nr9s+k6Qi1TP3OvWqdRYGsTUD7V8R62mgjse30w1+B4=
X-Received: by 2002:a17:902:aa0b:b029:128:eb4c:15e5 with SMTP id
 be11-20020a170902aa0bb0290128eb4c15e5mr12614781plb.45.1625497862927; Mon, 05
 Jul 2021 08:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-5-pkushwaha@marvell.com>
 <20210701133600.GD18548@lst.de>
In-Reply-To: <20210701133600.GD18548@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:10:52 +0300
Message-ID: <CAKKgK4wF9c-bu+t7B8wWEQwEhYgCQxZU+RapsF7cVCDP64Rexg@mail.gmail.com>
Subject: Re: [PATCH v4 04/20] nvme-tcp-offload: Add device scan implementation
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shai Malin <smalin@marvell.com>, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081103_793030_AD94DA0E 
X-CRM114-Status: GOOD (  10.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 1 Jul 2021 at 16:36, Christoph Hellwig <hch@lst.de> wrote:
> > +     mutex_lock(&nvme_tcp_ofld_devices_mutex);
> > +     list_for_each_entry(dev, &nvme_tcp_ofld_devices, entry) {
> > +     /* ctrl includes the destination ip, source ip (if provided) and
> > +      * network interface (if provided).
> > +      */
>
> This is not the normal kernel comment style, and also incorrectly
> indented.

Will be fixed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
