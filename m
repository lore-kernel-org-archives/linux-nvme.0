Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528E5C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 03:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxjlVWBz0YBNjsqh0xqts9Zgk/zM5ETAEguzrHAlIOs=; b=u214k/3EhwCPweIWyCpMTdcjfc
	OBUJP3d6x1luTDVEPsNkz0Tin2hTIRf4kj/zuSrne5+gf/TKYjsOngI3dNrVjsm6ro6fGm8FbzhM/
	Hj68Ak7gqaK0JyBO4qSmj9ncslIYtLuEYmS7+WNS7qJ2T6FwUdrtKKUnxzOvi6yENdVtnGC35ArkV
	S2oJxgc7+H+U0lnHKeu9a0pn67NViqdHCGEjy/AHT1XTXl7975dzR+0YrFLXkQgJcxXGy9Q6ndVeL
	2KtnkDkPYw37fg2ZugVqrYgetSl2nhL3ylxtUGBJ+l7VqYZkx7/Xo5XDd22rZMzzjfBdOMuU88JwY
	y34bgdrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzqqj-00Ewyj-1d;
	Fri, 19 May 2023 03:32:13 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzqqh-00Ewx4-00
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 03:32:12 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae852a5330so439245ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684467127; x=1687059127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxjlVWBz0YBNjsqh0xqts9Zgk/zM5ETAEguzrHAlIOs=;
        b=EkN7Bhs+S5/vynsAilMYj1SpYSd42oJmGk0cRN2R5LNliB+QGed95eT0+/iCrWEeEa
         uTX9D/ERWg3lc8rKn86th2r9ZEaHYZvqoQi2wK2mp9eCNpQBkY7wAQHUeyzvXk13ubPX
         4KjYig+/Ghgn6lJ2CoB3fiiu2jb1Udgjrkqe/Fz5vwOdPlzsAk/xPEMIqqeTsd5iYWhC
         lavZoRRqlCI1/4eLD2EPlLJqLW+0NAckdWL7zQwi8caY6+oHHk4fHOQduZKL6aNrtrE4
         SCTNDbwzJMMYRbx8qwnCAGy/kQPo4ZCEpx31N4yOV4YyWnPwUnswpWMNuPkvYobmzNwz
         AIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684467127; x=1687059127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxjlVWBz0YBNjsqh0xqts9Zgk/zM5ETAEguzrHAlIOs=;
        b=f2I+mZh1ADxUgPd2vWW63pYO1u/mcDM90ynEOkPcPKQD7ar/sHcRv4nwZjHZSAiFxa
         87f4aqBpnqHL8dKPogFlIG+q0jYdMyFkzZ+8bQ79E6kv7GxotjB4xJXSOl1UIIRcd/Kq
         8kIOQR1AX5IYyRNbA++vmT/Dd0LPMLhbSnfJonph6JZzuztAFEj0+n8AePNEaEDn681z
         bK7uTXGwAYR6xu40YL30Av8ABlOCERlYX5Y0iiXAYjiyU3vWgZhB2coMw+WxEGvHVlIC
         GT0q2Tk/149Z96LanKvEn/ovowZAg+XPoqXI1DSrhIxFM0NtjjSLUmLLwLLBeVQd6GrE
         ipyg==
X-Gm-Message-State: AC+VfDyo5jMlS1e5MG8W1/P5SNy2epA/yZZON9rokGYH8CCZQvdPfBUg
	R2lR2SXEEz3a8JuPSeVf4ur50n+pP1TeaU9J8cn91OzuJiweNJLY
X-Google-Smtp-Source: ACHHUZ6WUYEfmvRTiTGdK5Jaf9b0vd+Mc7OJyPPv5IoklWVk8Zswz23M2xRNzYAtOg+rb864V+O3hXqPSLUrr9G7tIA=
X-Received: by 2002:a17:903:2310:b0:1aa:f53a:5e47 with SMTP id
 d16-20020a170903231000b001aaf53a5e47mr1663829plh.16.1684467126550; Thu, 18
 May 2023 20:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230517220915.7244-1-irvincoteg@gmail.com> <ZGbfE7Wsief3erBq@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZGbfE7Wsief3erBq@kbusch-mbp.dhcp.thefacebook.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Fri, 19 May 2023 00:31:55 -0300
Message-ID: <CALL+9ejmXB3dtwQmw_hSUEvCTRrjk+b_aMvkNzdaLpdn3FVphw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-core : remove redundant check from nvme_init_ns_head
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_203211_045530_E403C493 
X-CRM114-Status: GOOD (  12.78  )
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

I found it from inspection

On Thu, 18 May 2023 at 23:29, Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, May 17, 2023 at 07:09:15PM -0300, Irvin Cote wrote:
> > -             if (!multipath && !list_empty(&head->list)) {
> > +             if (!multipath) {
> >                       dev_warn(ctrl->device,
> >                               "Found shared namespace %d, but multipathing not supported.\n",
> >                               info->nsid);
> > --
>
> Thanks, applied for nvme-6.5.
>
> Side note, the very next print says this path was to be removed by 6.0,
> so we're a little late on that. Did you actually hit this condition or
> found it from inspection?

