Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61976C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=; b=ClRuD5I07h0T+8lxOusUwVo705
	mhwRtdBDnHXmtw9UyhNvLOg5tIQ33z8gWatcmkgZG0aZQat2/ojHbaJ47boZ3w+TU2wNl/5Bf/MjU
	AZYICkAhORsf8aORguZYhPJoEbyHjBYs5qZ5bkypvjia5AiqvSDPzCaWPjcTZGNUDmWgATh8UtOw8
	LO7EDusDjbsLbW/MGGFXWwe9drz0a8FdcORI4eJbKuBsJn4ufEoZkq4h63WWq0Ccg4yB9UKOeBWFE
	JOQcepxhnlygHgH4H35BkaszsL44ObKwDUsh4pBMoNF/+X5qQptmwzXf1WPIa9XORtTfgStgylU5/
	yTnGwCyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7BhC-00Ahaj-4D; Mon, 19 Dec 2022 08:40:26 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7Bh9-00AhUb-9I
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 08:40:25 +0000
Received: by mail-pg1-x534.google.com with SMTP id 36so5678505pgp.10
        for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
        b=x3TU33kLDcq/fKKT5qEHxp4k2dRmZICETK7MtPkScTvO3f4q0zn/lKiLXv5/E4poHh
         ohcn17PYGrtMr7icJoKrtIh1wNpyHZrW8qXbxXAJuCD7Cu60bPhfFEtBZJrqAqyzdZ4k
         BfpPqfxo/eY7Rbs8thLo2rI+w4ExHV84kb8cnzQzgyXEO9j+fLgl9NqWIjcv/UOfM6MJ
         h2r8rSKyhv6IS16fz9VXUNe70HAEbgY2CbzOb7K0nchnNIyNmEnZhm3HNK1umwI2830K
         AkAG9tBUOawIoOK8pjc76Mc9/yazdENIRmrWYKP3MSbdTk6aBVOaXrXuTXaUl8TYmmWh
         sZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
        b=5IfA5kzQGsTfsvuTBJCUYIXwVE8hzIANx/OJ1gbk2pRQ24J8q1f0bAMwQVYCzP075B
         eqg08xJYtTPOerbOXWqTJSMeKKf4KKptM3V9U36o4OVTgT3bW4quMCjV4AqRsZiUMjIM
         dbTFSmdy5JUUTpNAqBpLe+Y5XY8CFz2XniMzAQg+BFSqFkprYiumz/NoGHvkDikCBc4p
         52gSEKoYA7/7UGJJKer7to40aLyArYe2jVSMoKHaiea+ix+01wIppTh9TosBdg13Ew2K
         lQqOlE2frduVhJEPsSTzjotT6jSP9mg7wlYIuYSyxLpku+pqVh7W5MUqZRqAge3E2SAW
         wF5Q==
X-Gm-Message-State: ANoB5pmVT02d5piHp/oCgUbO9+Fzj0rEcxlsNYCGf/pQQlfYN9tKKRQk
	gjg6LGCXUv2stfjU91yt1GEpIcCyvVpCZGfAGiWFmIt9ximGMz6l
X-Google-Smtp-Source: AA0mqf6fHrB24kpKRZtxJ/jl4cyycBpONCwoE9u9Hwo5PX1mANCykQgJBY1PwHfLY1yPaXCstzW+unZ0wtSJyelyLd8=
X-Received: by 2002:aa7:9acc:0:b0:577:81cb:4761 with SMTP id
 x12-20020aa79acc000000b0057781cb4761mr9183983pfp.46.1671439216472; Mon, 19
 Dec 2022 00:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <20221219025404-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219025404-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Dec 2022 10:39:39 +0200
Message-ID: <CAJs=3_CWQ3T1O5RofstwkczpgoJym5X4xBQmdQCtt573sHUOKg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_004023_365216_FD544D74 
X-CRM114-Status: UNSURE (   5.70  )
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

Hi Michael,
Sorry, I had no time to create a new version.
I'll do it today.

Alvaro

