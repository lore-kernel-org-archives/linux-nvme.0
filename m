Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC0DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fVndOlXJqJd979kieplvxiXM/JaHGBg6vQFdeCNUz8=; b=1AEdtBC4s2a1jVPVTgFPTiX+Za
	7YPjdR/j7To2zCHZBCm1ByeGSNkSMpDEelRVwsrnst6t7fy/MjmPqjyfm8Djaju4uJKUbE4jlu3Wk
	4UlAT+jbCevTcoD/90a8VW+K+YEPis6AAmDi9frONFyE8Il3yfmwwEi5neYsB7dG7IdlV2zcznkPF
	ctUjioQVA+9lm01aDXPZeF78T71PTDJEn/sX/Dc2zOF8bEoPA0+FuYKvUl6JHnOIr4sP6jlN1c5S0
	yyfNbZvlmzjtT+sku79pBVihKouWzU91BPZmlvo6VcK/KaoVeIEmQnKIOJX2qHcen9hlOIuyMHwmv
	QbXKzD9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTpHm-006UMP-KO; Mon, 14 Mar 2022 18:19:14 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTpHk-006UL5-5y
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 18:19:13 +0000
Received: by mail-lj1-x22a.google.com with SMTP id u7so23123513ljk.13
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7fVndOlXJqJd979kieplvxiXM/JaHGBg6vQFdeCNUz8=;
 b=BagW69PkeXTRL6hqswtUtlLfYVJLt+XItvKTC2u5jVa5FnN23pO/GEQj4BkxUpwpPF
 H9eMkQBImNLuy3zQVapLBfqxVVIOAodw/zKSahmsURAiWyLkcjMjsj9h+Xuky8LGvoDf
 kXVhHHRwykJDUB2Sno8FQLYWPE4SwC/vH5kOTQlI/U8+Dj8kZP5cMyQxdAizy7Z+40JI
 cE73atXBfyEzaluc+37TVW+ss+pt6osXH4yFQG92yzd8Eui1fws1rnoiIRpMLeYsxyOX
 M+nbMscPgY2x4bXSOzRJEpsoBvvIqe2TU48LyBLNPwnE1JxvR/PnU7YZUwKGww0nKAPD
 EdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7fVndOlXJqJd979kieplvxiXM/JaHGBg6vQFdeCNUz8=;
 b=gXigEMnLd6vM6pPY4BJI6px1q2qwMXY2JmIhoLDjluyCOJwixtMpZOZro044ovWrkH
 RTceXGgIP8DzZokwDKvTYdiAVeEmyrb5TvqjdMddq5M1+9cXJOqQbz5KQcXm04JnxBwT
 PQ/jjZTU0N/b3XXN1Fbii+uhIqoGbN00ma3vTMbIyFkdmJwHNUNG6WeIzVyh++Iffv/I
 TpXVbJLwSXCPh/bNn33NsSDRkIi001nQRCiW40Ubbzg3wzoMhjs/kp2V+E1ZlBNEAFBh
 IzCVZz5BcxcqBurwrKlVpYOb5HBrEwAWS29md6Fnvy7KYacSlj37Mq/7phMnlPJwmmhM
 EV+A==
X-Gm-Message-State: AOAM531XJr+dKX+WbGoeBPL2JT47i/2VG4/K9mUaac6XK1wjifZXhXql
 udSlMqZpH4uH8KMVkhaCNYmdu7GjeWamgClWryo=
X-Google-Smtp-Source: ABdhPJyV9Q/Oyg2T1KbYTiQ1l2Nl9hOAFzmuE2Vay8VGsiTVI+nXxEk2zzSRNFXp41eOl7Rdlpa6NXuZbJ3vaiqrPIo=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr15017686ljw.408.1647281949100; Mon, 14
 Mar 2022 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152718epcas5p3afd2c8a628f4e9733572cbb39270989d@epcas5p3.samsung.com>
 <20220308152105.309618-13-joshi.k@samsung.com> <20220311064847.GA17728@lst.de>
In-Reply-To: <20220311064847.GA17728@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 14 Mar 2022 23:48:43 +0530
Message-ID: <CA+1E3rJshMVkLwpAQwM1L6L_xcrK9drKP+rpcrfizYuFsQOGjA@mail.gmail.com>
Subject: Re: [PATCH 12/17] nvme: enable bio-cache for fixed-buffer passthru
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_111912_241956_6C8C554F 
X-CRM114-Status: GOOD (  13.17  )
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

On Fri, Mar 11, 2022 at 12:18 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 08, 2022 at 08:51:00PM +0530, Kanchan Joshi wrote:
> > Since we do submission/completion in task, we can have this up.
> > Add a bio-set for nvme as we need that for bio-cache.
>
> Well, passthrough I/O should just use kmalloced bios anyway, as there
> is no need for the mempool to start with.  Take a look at the existing
> code in blk-map.c.

Yes, the only reason to switch from kmalloc to bio-set was being able
to use bio-cache.
Towards the goal of matching peak perf of io_uring's block io path.
Is it too bad to go down this route; Is there any different way to
enable bio-cache for passthru.

-- 
Kanchan

