Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314E7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqPQR1lWwHi6baWl3mBvhbrgPcQnRjAjniMZNMM9OhM=; b=sZLyUDnX76f9a/TUlE6ige39Jc
	f+UCdRroLzhjIncFzM157FBXYGUkCgXKui5rqiZNZCoBp/jfEFfv1dWluqiT1znujtFXnJu5EdIoM
	N1baQDOYP7E6LaIsCBs1RRUm0PQTdd5qiC83zx80iAJ5tx0gWk9tPNf243Vn/C6BKTYgiIB7cXlqK
	tTPxRci5Xgfrb4ZAOVOBsOrJ/Du/umrkCFTGJEPYW7bxGth9QKWXL/vqx6raTDDqpt+FTmmJLX1Q5
	JT2XtDbjb+9ii4NAy88dBUeXMDmbOLYgx+jLiwewPrVz2DEFURmwcFp7CPqL9XPV4fit9jZphYBby
	vbd1QLYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLfC-007OEZ-1R; Wed, 16 Feb 2022 14:52:14 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLf9-007OCm-50
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:52:12 +0000
Received: by mail-pf1-x429.google.com with SMTP id l19so2320998pfu.2
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bqPQR1lWwHi6baWl3mBvhbrgPcQnRjAjniMZNMM9OhM=;
 b=GVDgcXm20r5gBQuiMvPl1O/t3dOZJrVCQSBv7mqp8J253nLU4SBVCe2r695TKmnmGd
 CIl6ys13yMQK7sD9eOlva3Mccf2LGKGHThaybsugHeyZMxJYqi+rKVhmEZ2/gf4gyMRK
 e1GN53xqy37Fq8275tuh23PVdqUeSjay3g2y0UezThXr2AxTdNHP7Z1My9WG48rhwbxQ
 sanXfBAzKDt1ZAVlgkbj8eYKuQ4/5EwtOV4hxy2DexBf2xgnzKDjrI4qQkofmnS+WxVE
 PFjb4x2B9xsIlG4nx/gWPGfe4AYrBSioDDMkkZrNpcdt276fofoS8EwLN22EWdDwvYnG
 6QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bqPQR1lWwHi6baWl3mBvhbrgPcQnRjAjniMZNMM9OhM=;
 b=NqQghh+4ZLS+q0UWp4RpqdY4rp35uqeYV2r8w1nV4tA6N+9YLjMg8BcD9DO30K49/6
 FM38GrwQZARFoMM3aIdwC3mXh5VHY/j37laUBIrM/0a6B5qtELEeyVQGNlV8cttBGe6+
 Ins89mM+rNKdUpQzhLNY1t4tniIlyCLHzsyAJavzlzRYvDNT7DFt1G/WZlDSRikp/DZM
 WWw83gkHZ1siZh1NUpB/tsKXAlls9fRGVtRc146mR93u75W4gpny/8bICSGYjdQflszh
 CP9K2OVVF0WcHequ6frsBWu0W5jz7089/UUR3wKP/Ix/nDxxO5YCMdM/l7Xldy8kxUJ2
 wsEQ==
X-Gm-Message-State: AOAM533W11Na7mZ1rN4PtPRxATkhC0qAb4qHknUmaE1YqjG9G/RiqT2x
 TSAu3RUrFxrwnbJmFoGAYhm44rfriUsSZ8Se31s=
X-Google-Smtp-Source: ABdhPJwyMyf+gB833VsT1ujUQzFaseIWP8AxGYsdawCRSSZhxMA37UjKnfFQ0kkVbCQCWJ5hHLbhOa9u8GL83FoeVmE=
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id
 b11-20020a056a000a8b00b004cd60304df3mr3521758pfl.40.1645023125259; Wed, 16
 Feb 2022 06:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20220216141220.4162670-1-hch@lst.de>
In-Reply-To: <20220216141220.4162670-1-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 16 Feb 2022 20:21:39 +0530
Message-ID: <CA+1E3rLD3eZOqtJA16NZ=skb87hPk74=aLPV-M3t5Yng6oZ0LA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: don't return an error from
 nvme_configure_metadata
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, 
 KANCHAN JOSHI <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_065211_222005_92A5D9F6 
X-CRM114-Status: GOOD (  10.31  )
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

On Wed, Feb 16, 2022 at 7:48 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When a fabrics controller claims to support an invalidate metadata
> configuration we already warn and disable metadata support.  No need to
> also return an error during revalidation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

-- 
Kanchan

