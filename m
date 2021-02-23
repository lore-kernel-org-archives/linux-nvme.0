Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD86C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 09:14:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD7864E21
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 09:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7864E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zxx4NMzgHNBTDwECha3U3uuax4gjHOGZLRmX+UA9m8o=; b=e4jwul/2yBpccocdfVAJ6HApA
	9VeyMVz6vJMCmGH+CrULchP0KxPn8yeFwPk8EKnxotT+HSssTtGtUsua+s7Nblak8+fuORm3AAdNj
	y/enqu6gQiErtDF5Q/VYtrHRFpR/ROynb4qKdIoEtM2uCh/fp3va4jr2U8zsip8qpQiKDKR5CjQ3A
	y/IvPy9SdmybVe1iHkubaNTOkjb8ZdnzVjOiujZQBt5OgYOUS0uQqjzc5mI9xNpXre00SUxyPmTzo
	iekl2/aj752cuPHZs271LqN4rameYTvLQlCxTeAysGcap1LuwzpfycwbUAq01JuSAvgHshKnqbD8E
	6I5bcWPzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lETly-0002XA-Tu; Tue, 23 Feb 2021 09:14:26 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lETlw-0002Wj-Ht
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 09:14:25 +0000
Received: by mail-ej1-x630.google.com with SMTP id k13so31576330ejs.10
 for <linux-nvme@lists.infradead.org>; Tue, 23 Feb 2021 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b5MtT/ZdRPwH3IHGkszx0Ejluf/ndHyk503G2Rm9ils=;
 b=GpmmQZlnXzGD1kHuc6Kv9xigy1sJuXWH3dZqg5Vs99WFBxoTWCU3/K2DIiXLQsBorm
 ULOdBhuPEWDqrfccYAmsLtGjShSlT2/jstrlSPytLEjFi9HQZyjGdZuEDSinUPb+5vJI
 HkBA1eC5zA1OJUnBCMMn/pM+N1kKZesZh2Rnca8nG11WiF7WKycWDgBdL7NRxbnc2WZ6
 uf/QXhrDcViYI9wwlB+U2qXnfped8ad53tAqxuE4VBCYre+hx181ANfb8L7B7vMI3ABL
 MHQUAezy7X8WjIH/kMEDknmITMqhlj4Ej93MbWOQLMYU5NLjTWNAL6xX07PzRWaCbakk
 6R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b5MtT/ZdRPwH3IHGkszx0Ejluf/ndHyk503G2Rm9ils=;
 b=XPYzBMK/BbZkf9lbQmGNfxEO70229JxtTvt1Xvwqfx0HYzRHEOME5KoxE4yF6UtSlh
 /FK0SHPYe2cgeFy+J8XQNe0WRr9+riEfcfdGTG5icanlNqd0WSKxi6XVIPz1sTaOAqv5
 JDyLlR0OKkfzvxTNBWQMOOtcWV599eFag/2behzwN8u66Jobv/HU3Hh1trqBTLf/iPHo
 zaOg88YC62lgvwffFDEe0LOW94B5Pp17hx8AqgPJBu66ZdidCnWf9XxiHt3SK4kRXJg+
 6stTb327csk6fkzP9TvwNRJKagGO0ycj5To6Ru6GwlgSKX3ZX3OL0uwyAcA4k3gjDSc7
 kDKg==
X-Gm-Message-State: AOAM5321WR670WRQWGkpjT/mw4k+WP8F/5lm6wIdo26D4IimVK0MaKnV
 oKizSaheRveSo/PQRznmcFOk7BZ9DdCciD/7obo=
X-Google-Smtp-Source: ABdhPJz4R4ZgmznPz2GNNWvnywZAr4uBgUpJfEA7xJHHLpa6gxqaLqhgwSOdWYHkRTdp4nIUPMj6SIo3LCG1a0yXTfY=
X-Received: by 2002:a17:906:2a06:: with SMTP id
 j6mr23964456eje.164.1614071662110; 
 Tue, 23 Feb 2021 01:14:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <20210221235248.GZ4626@dread.disaster.area>
In-Reply-To: <20210221235248.GZ4626@dread.disaster.area>
From: Selva Jove <selvajove@gmail.com>
Date: Tue, 23 Feb 2021 14:44:08 +0530
Message-ID: <CAHqX9vbG-cB0h25y4OhcdOEegn-_E=HwHJtkPFGaurEF9-KXPw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
To: Dave Chinner <david@fromorbit.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_041424_639543_9E814BD7 
X-CRM114-Status: UNSURE (   7.23  )
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
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, snitzer@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 nj.shetty@samsung.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>, joshiiitr@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dave,

copy_file_range() is work under progress.  FALLOC_FL_UNSHARE of fallocate()
use case sounds interesting. I will try to address both of them in the
next series.

Adding SCSI_XCOPY() support is not in the scope of this patchset. However
blkdev_issue_copy() interface is made generic so that it is possible to extend
to cross device XCOPY in future.


Thanks,
Selva

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
