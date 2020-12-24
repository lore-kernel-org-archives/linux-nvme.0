Return-Path: <SRS0=K5Lp=F4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE802C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 01:51:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702022256F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 01:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702022256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XibDegzme143c7BMaCWKKTIbKyjz7i595gLAZwSSjYc=; b=wJ8ducCKl5soeZDZY3icb3C/l
	Cgh7nApFyudJuJxxwzE6yd5MPs9l+uLT/fYZpQdtwuPI+ESUNDRMa6wj+96nBZT2VIaZgXBi7Mph6
	1Xk8xhW1L7aZR2O6+4xpgx8wCFpc1TlrvKhbis++q4WyTlx8TF+uOyruGqbLi4Ibnd7wIaO+Cr0Uf
	DEKnp7OPrJqXSvpNXY/1h3ODeEz45BGr0hwXgLJSkSc2KYaZg0bzgM7tOCVRE3bDHebT6fcFM6RZT
	ei1F0hMr81Rapr+OLPgrEJb8bLtpUHvux5U4eh5wvaAUWPeUGZ0uXzZy8qvdNll0NuUgcw6fWjGgO
	T9DV6yrRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksFn0-0007RI-6D; Thu, 24 Dec 2020 01:51:38 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksFmx-0007QO-Ua
 for Linux-nvme@lists.infradead.org; Thu, 24 Dec 2020 01:51:36 +0000
Received: by mail-ej1-x62b.google.com with SMTP id q22so1621634eja.2
 for <Linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 17:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2/M0k26H2KQkgXsyeslV9svon8Kbmn2P6Eo8qew82eY=;
 b=YSDJKVTwBpGT4pUPBts3wuMc/YHVxN+FMqsFw36k1Z4KLRsCd4zGlpocHMR8l7Bbfx
 kSiLNgQNDbSzSlcFyVs1KpZtWfLoLvQkptLdwW+Pr/R7bR8j8+BBLU7UXmtZ0nNDF49w
 wg/ot/bNaTRhqWEV8BuKLZF32jhArmmk10hO2LPmKWsGUo0h9JrpvaI0pfeujna2tKtO
 3UjaXwAClPVMgo6kJeHh0BsmcI+aLX1Mc9Y0g97W6s7bZObAgY2ppkHLJAQ7AqZMmH0M
 rTJjYuqKiTXZ83mRUYlVk+KDO7X3L3GZNfigBv0V8dDLT0AI/xqhs4MC8PrjxCdC4HNy
 l/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/M0k26H2KQkgXsyeslV9svon8Kbmn2P6Eo8qew82eY=;
 b=Q6jdFpI5cFeNAVc/rE3KGLAuocxDnNd7xlAth/A4ypoXuVhFF5i3GtYC4ngrscjEBv
 GU2B1tUFxhbjZnPdHKwD3KuAQ8evczF8jrKDmqcBJHzzM3IIXMxlcKTQEDODt2WIloZ2
 j7iMYI31nbxxO+FCMfSQwDiw5XaHu22L4wxEWEyTbGyHsSj9n5pNJYiGEB+SNKKty/5I
 s7dehBCmUI0oAQ2xajeHd4phFAv/K/k47iG3EHy8ymJRWriU779Eusuxhia8ErJlfsbh
 cBYxCy02Vbhe4YA1XyL5rXcCuwMqZZxCYUuy/ucTRi+GjRz0W8M2fAstj9mrcU8tN2UF
 zovA==
X-Gm-Message-State: AOAM5321WBlrUiNKhv87XjFBpN3MQy4ZLq3cf3dZWF4+5uhYRi0FLLY4
 3Fc1E6ZJeYeBZLFiOqfnHcNX5IRwzvjtubdlxNAA8nuqaEU=
X-Google-Smtp-Source: ABdhPJzx2IBovcYAnQWSDZ7GqzFWRXcIIILVm1ue0fKxupmJtSD1rSj6GlpQBaM3dL4ptWNgC8ve7UjrLPVtThrYJQk=
X-Received: by 2002:a17:906:cd14:: with SMTP id
 oz20mr24469477ejb.99.1608774694458; 
 Wed, 23 Dec 2020 17:51:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
In-Reply-To: <20201223084332.GA30502@infradead.org>
From: Hao Wang <pkuwangh@gmail.com>
Date: Wed, 23 Dec 2020 17:51:22 -0800
Message-ID: <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_205136_086761_33735F3E 
X-CRM114-Status: UNSURE (   7.47  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Okay, tried both v5.10 and latest 58cf05f597b0.

And same behavior
 - data corruption on the initiator side when creating a raid-0 volume
using 2 nvme-tcp devices;
 - no data corruption either on local target side, or on initiator
side but only using 1 nvme-tcp devoce.

A difference I can see on the max_sectors_kb is that, now on the
target side, /sys/block/nvme*n1/queue/max_sectors_kb also becomes
1280.

On Wed, Dec 23, 2020 at 12:43 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Wouldn't testing with a not completely outdated kernel a better first
> step?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
