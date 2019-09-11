Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1485AC5ACAE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F052082C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VKMTt223";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPrkHRbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F052082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A0ZVkmQDX1J5AQThdylfxrjpIFhUk3xOLcIJYl9QIGU=; b=VKMTt223VriO7U
	vwj4PuRGnzbLUHGeV/FbMrhnXDKza02E/6mjMD+YCK7eBWDrx1opp1WLA0TjcW8HHUm6NUMzTkWgJ
	FzrY9I6ZZUx9/iycfbexyHrg2egjwYqszMQyKUjQjBiYtLyDAuxO/1NYycLTA+12HZ7aWZeBoaPCu
	E5/M2bzSmPYPDIXxreT9POS7qQuScYohF/OOxlnyf4kfxF1jN1oDJkwnHOICj6Lzjqx6W0jeIqe/n
	61GFwAkndIwTqDzwa3J+4jIjEPPwIVXfCa7R0Kxpin9HCefX6bAj0e3t5IN+4Y/e1E+zLxvAvmbw2
	6G7Es9ku89nh5Qt0//5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8A99-0001EF-Dd; Wed, 11 Sep 2019 21:27:27 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8A96-0001Dv-FN
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 21:27:25 +0000
Received: by mail-lj1-x241.google.com with SMTP id q64so11026604ljb.12
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ocuE3lfB2VdShvrv8Jjt67rALqQRW9A8FCccv4uW2jU=;
 b=nPrkHRbEe39Ut8LbfUOvs+n30/TRBBN1ha3AI0Mq451uupxo+Z9PsodnAo+7WAUnwY
 TzQTRvOSeaBEa2ILoogE17VovuByTCrht84YLuMohbpfqgfNy35M16SjIpsizhTRMa+f
 FX147dvhOQIwqqpY4kDR7DumqPtbbFW/jmvGHVR+FUtN484bJUiAg5PY9F3xNKw24VWB
 gsLIWtXT9kgSrYIEULalHDY35ahjdC/uGO4JQLbTgbYOkMf7hYyP1rdT7M9cpiG3SNgn
 qVOf0SFg9MxeX2Lak5X5pT/HJnR+3FM+ifhkDMwqjpwgBuA90mkgTaUXBnvoiAiNSOcf
 I2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ocuE3lfB2VdShvrv8Jjt67rALqQRW9A8FCccv4uW2jU=;
 b=d/fPi75DVt5KRUdatMTwg+FsLklzK9o3sufHSrVdpg3VIxdm7lKQeznp2W0QK34uSr
 UCL7GYoCBQCb+6hFiQmFOVy0iQcvZRaqzP37cR5aE2M+acaQw4/eR3M/bTfoeNzsR2IB
 S2ldYQhVBtncKIQj+b9+CkhsthGwgEpkxPNlN/AxyAJffVwOPTwpeDlT5oviPHPLT7+y
 woeW/7heYROgSFRtXYbzRRTy1TxMu72G2iet0TEEN2BRv275STzGb3wF672M/1D4nt47
 oHPj+f0YKFuz4D6lmNCXvUpPC+Ml1HFoTiC3R1g/OKhT57aEIvKX+M/2JgWwJrv/DLEx
 Vd+w==
X-Gm-Message-State: APjAAAX1/5Kk2lkznsz3ZoB+33DFgI5yzCDXexHw/RKGT+Dq/I7LVBqt
 NEoEpGWKt8Cv934B4gDmYlHM8WNMFT5qYhHoiw==
X-Google-Smtp-Source: APXvYqybZ7v0olv+TJL6fPlc9Hrf+slZdTLE9RxLUHYs7RPHVK+boyb65eLJG+B2yfuSpIUNw6bsRq/4qiLRI0gaX/I=
X-Received: by 2002:a2e:861a:: with SMTP id a26mr18956406lji.163.1568237242901; 
 Wed, 11 Sep 2019 14:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgivvhQ=tOOuLjY=iwBVCKQhmmjpfNDa1yJ5SreNQubw6Q@mail.gmail.com>
 <4581016e-b421-e794-e603-807d37aa1bf3@grimberg.me>
 <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
In-Reply-To: <CAEJqkghexeFHwaGkNUp+SmdhtU6Mf8cZ=Kn9pfrUkX3hEz-MOg@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Sep 2019 23:26:56 +0200
Message-ID: <CAEJqkggdu8FD6D4CL+4TwzfeMrLY+DY+qfHN0o7mQbbPdGvRsg@mail.gmail.com>
Subject: Re: [PATCH] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_142724_540494_61CDD12B 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Mi., 11. Sept. 2019 um 19:39 Uhr schrieb Gabriel C <nix.or.die@gmail.com>:
>
> Am Mi., 11. Sept. 2019 um 19:21 Uhr schrieb Sagi Grimberg <sagi@grimberg.me>:
> >
> > This does not apply on nvme-5.4, can you please respin a patch
> > that cleanly applies?
>
> Sure , just tell me from where to pull nvme-5.4 tree.
> My match was against current Linus tree.

I send out a v2 against nvme-5.4 branch.
http://lists.infradead.org/pipermail/linux-nvme/2019-September/027144.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
