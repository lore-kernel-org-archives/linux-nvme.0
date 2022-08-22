Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D597C28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 05:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqovIxZ/3mSylc5rFsiQs3Xa2j6oWieFuhAH1I8PWE8=; b=4qZI9nGfyUcD6AIA2ur+auLF46
	/SSClrksm9x7xunagOqu0MvSdjQRbA/5RsO9RSWbpyyrh3Zm7DGjeLL4MRlZm/3SGa6OofQ/A3GYl
	AVSK6Og9xdJ+JZmgATkBdUL6Cb2epvHhiXT4o45G4D2rJU9b33BFC8lkS1JH0DLExPOyufOQogfeX
	ncBSGwcfmvpJ9UDuen9QPR3+Qc7ImXhbC2n/JrKRj2Z3vzuqkUJpKZSEFmJFHt1BsRMfDZcub50Wj
	EwuvncimJPqUk8txGiVGjZPP/e7Tbs4D6NI9kLxbauTSEqMCeA44VqQ04q7g+fuHvEoA7OlwvvHoO
	WRgYS5kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPzkF-004vaJ-Mj; Mon, 22 Aug 2022 05:13:03 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPzkC-004vSH-Ok
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 05:13:02 +0000
Received: by mail-ed1-x52d.google.com with SMTP id t5so12334862edc.11
        for <linux-nvme@lists.infradead.org>; Sun, 21 Aug 2022 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XqovIxZ/3mSylc5rFsiQs3Xa2j6oWieFuhAH1I8PWE8=;
        b=Sfw8aaZM+4mGOtXQS53EorPhlU3Wby982Uak8OqCEx5HyqCImzxqVfihu2+tqsdO53
         wNP/1ajHGhcqEZY4ig3Gi+QA8stLY7LAIDRcrrVNjzlRX1XTb7s0vo/e2DAFSINm1n34
         6R1xwdxHb0UrPL6Dn2F+r6hsF+zCOL+beDTxzy0+ACcTj/di22ddRH0JrC3qcKtht6qN
         1BKAF1xZiQ8bcEX5ptgjrIQ25T46lCtxOm193U7KeTxPLjRcfRdO0qwQIiusKO9IB8+0
         WHp5vi/Z0CZ3q50TuEXjzjydhJn8B8bzFFkFyLXAoitHFEM5X19HNx2o/WUz9m414Wyj
         BYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XqovIxZ/3mSylc5rFsiQs3Xa2j6oWieFuhAH1I8PWE8=;
        b=gfGlgblTkefjU+MuMrIhVYHAxKMPm4KL7UMwsUZowtSx2ze5mZe6VqD9cI+D/tea02
         VgNtyqrSXp66iF81uFlAz6J69/8NE5pN1ifnaV8MJUwC9S5cFVh8q9ApsU3zF9RrEhOV
         ONUiZ9TE+AYzTWMyOdvGefvIsBIS1YrO6rMNcVFtwbKXaROkY7TRf/5WsPsG8/TJJ3Vx
         FNCs8/QwISZx2RdRTmJ/dylxoU6ET3UXa/VgFLowWIrTgnoirCkYPejzFIeW3HjfJqLt
         RPw0wufrtfsT/I3aZL8GnU90Dv7oimfebeJSBiCsQ6QO+YTYnCQ6jUvUu4hempOkvyK4
         V6UQ==
X-Gm-Message-State: ACgBeo2su/KO3s6CllotpJCgZQckTn9Uu5O2wXqbneWSWlZGXl94x3O/
	ruT0NJsKnP4XFH2h/lc/Yi/HzYBsshNQkK/HP6R7WA==
X-Google-Smtp-Source: AA6agR5g+9sEwO0FSnEqOm/9KAo3YoUA0Dl2S7qNgtrnbHs8TFvrM+v16zarP/laWa1jKUdGC+Ycp6k+1T9WJwZWZj0=
X-Received: by 2002:a05:6402:32a7:b0:446:e17f:111c with SMTP id
 f39-20020a05640232a700b00446e17f111cmr826449eda.95.1661145153873; Sun, 21 Aug
 2022 22:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
 <20220821055745.GA26064@lst.de>
In-Reply-To: <20220821055745.GA26064@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 22 Aug 2022 07:12:23 +0200
Message-ID: <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_221300_880044_F664E842 
X-CRM114-Status: GOOD (  12.03  )
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

On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Please don't send me just two random patches out of a series, as I
> have no way to review them.  If the patches are independent, send them
> independently and if they depend on common prep work send the entire
> series to everyone.
Hi Christoph,

As mentioned in the cover letter, the bugfixes are all independent,
for each of the drivers.

I will wait a bit to see if there is other comments,  resend as you
suggested later.

Thx!

