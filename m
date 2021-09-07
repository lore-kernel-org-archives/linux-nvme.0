Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:21:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BC361057
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1BC361057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OPBm5QrWE08GI4GGB7yt+VZnkG5/9+Vwt/PyOd4TLnM=; b=xHk3V2HNasGFb+
	9W1qttXaS0gX5+scbfGdgY5PY5mGzMpGM4g4U6xQwiklhclfbHkJq81nuoioe7V/I0JX+C0zeA1Lq
	M2rrriHMb6rvt/m9SGoTnmV5rawnHNNrN307AgMqZVEp9wbT6WEyzabvek2c/CA3bvbSxzCjLTmOl
	2aM+usmVDm0y6wC6SKMFk55DPmIVkm9seZNuSUo+n2d4cnNg2grUa23qQKCa6O72fwIT+GT/bNEt7
	gCHrqnCGw0VpTdG22h42JygHGkrdIjLR4XUgmHTglRIRq+zhYxxhkekTWZAtCLKqStuI48s296m03
	3hr1HuA/O19oVqPAZFcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNdqF-004BDO-17; Tue, 07 Sep 2021 16:20:59 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNdqB-004BCA-Va
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 16:20:57 +0000
Received: by mail-wr1-x42c.google.com with SMTP id u16so15320988wrn.5
 for <linux-nvme@lists.infradead.org>; Tue, 07 Sep 2021 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6dgSwN7ol1yXriQkyjgfHQ3T2Kfo7tblWaLh+5UXwxg=;
 b=X5WYcDpkqGQPAh9CId/yfG8xEJmJO3X3RGiG6IY1rS9FuAN0VbAsH3HyvFcUoId70v
 nbHJFz4qdfJn1Jr44Cl5hFVssy598QRAmsSAkDFsyPxxwEx7QZcsvsedbAwHPFK00UDe
 BxyAR1F0zsxu01v16fxGcvJFAb3/7xopXJ9yE3OGMLP/94F4CVVx90cdhcUQ4UN5UF/V
 ED3hUjOIwiifS6u6K/d2e4djZqixqToSqKJo+olUIAxB5PifgHhrOeQvc8Tm6ipO3vZk
 VI3SCShSkluHI/zh/FvoAljl91Ef5oUblMPvGPZRa1KP3tAn2DnI2Q5au9RFW4No1HO4
 8c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6dgSwN7ol1yXriQkyjgfHQ3T2Kfo7tblWaLh+5UXwxg=;
 b=wBm5gwJOgXm/NaHpB3WfdwrppCWLg8X0WHfyb2hn31k9IrBjcvRcpevbALnyqRqxfl
 HGrTFiUlDEzzySn1lCz3Y90qhygKTmdnh88yvpNBmLAC+HuD86SaG177pdFPK77jW25R
 dJ+ZxxCePXz6+iUrBE7Y0hna3LD0FAyHcpLbhFtAkYGQZgUu4/UBzru/ugZvHxhqsyNb
 bAx1XHVrP/+EcRhdNIKiWfVZ5ScTSD7B0AMKqsop3eIfUDcg5suv5kcOr2vP6NlHQ7m3
 jFcQquyO2U9Rxp7r67SDLEqtJGs91ZBHAdhUGyxFlBii/K6Z/qLmiYONWRAzGh/LOMyH
 4ISQ==
X-Gm-Message-State: AOAM5301UrrsW4GyINHVi27uvjR/A7Ah0M6Dx+slOKDeLloaOLQwn3A1
 oaJSHncGgb+c7/TJwVZ6PemgyeRnrJv6htPMMyc=
X-Google-Smtp-Source: ABdhPJz2Qdte2dyhhO1EukEOIbrssiN0u5LnGHUVgbrNalxMZa6+bagqPRFD9/v3Z55vP+hfw9NTi/5oUzNKOndmWro=
X-Received: by 2002:adf:9e49:: with SMTP id v9mr19926094wre.39.1631031653345; 
 Tue, 07 Sep 2021 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125923epcas5p10e6c1b95475440be68f58244d5a3cb9a@epcas5p1.samsung.com>
 <20210805125539.66958-3-joshi.k@samsung.com> <20210907074650.GB29874@lst.de>
In-Reply-To: <20210907074650.GB29874@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 7 Sep 2021 21:50:27 +0530
Message-ID: <CA+1E3rJAav=4abJXs8fO49aiMNPqjv6dD7HBfhB+JQrNbaX3=A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] nvme: wire-up support for async-passthru on
 char-device.
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>, hare@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_092056_074756_B2FD2217 
X-CRM114-Status: GOOD (  21.42  )
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

On Tue, Sep 7, 2021 at 1:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Looking at this in isolation:
>
>  - no need to also implement the legacy non-64 passthrough interface
>  - no need to overlay the block_uring_cmd structure as that makes a
>    complete mess
>
> Below is an untested patch to fix that up a bit.

Thanks for taking a look and cleaning that up. Looks a lot better.

> A few other notes:
>
>  - I suspect the ioctl_cmd really should move into the core using_cmd
>    infrastructure

Yes, that seems possible by creating that field outside by combining
"op" and "unused" below.
+struct io_uring_cmd {
+ struct file *file;
+ __u16 op;
+ __u16 unused;
+ __u32 len;
+ __u64 pdu[5]; /* 40 bytes available inline for free use */
+};

>  - please stick to the naming of the file operation instead of using
>    something different.  That being said async_ioctl seems better
>    fitting than uring_cmd

Got it.

>  - that whole mix of user space interface and internal data in the
>    ->pdu field is a mess.  What is the problem with deferring the
>    request freeing into the user context, which would clean up
>    quite a bit of that, especially if io_uring_cmd grows a private
>    field.

That mix isn't great but the attempt was to save the allocation.
And I was not very sure if it'd be fine to defer freeing the request
until task-work fires up.
Even if we take that route, we would still need a place to store bio
pointer (hopefully meta pointer can be extracted out of bio).
Do you see it differently?


Thanks,
-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
