Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEAFC4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 18:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2230611C1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2230611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eo1nZ/TtJYG4UwIZYdzfQPXKQDisMe0OHJaU7jUQxbg=; b=PhE9JbYjcfsdLK
	tJZig0BC4e0EHCXgZx0N4W81jhetsYp71Y71rDhCFMowVdNY2u5fnJ9qrFE4pmDuBf3M4PRwcVlhD
	fjUekZfRswsFfAacex3iLtRvUvFbcNR9vVYJ/pWSeEa3rWkUyiJdsctN056PyKYrd9446ftybnxN0
	KsdpYEt+K4rQcCwuovo908k6jJ3OmnHgEpzNIX/8/+U5O7q/wsb/EI/ap2dFcWEO9kZEQsNMTwRbb
	LdBpio5L2AyzXVlxH29pVcdsQjioHkoMyVq6N8SulSBHwMkE5D1NRVT+Ak69WbF5appsFfTo7kVa8
	6ItKqeKmQFuOvhGYl0sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw82e-00BjFW-Rw; Wed, 23 Jun 2021 18:56:04 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw82b-00BjFA-PP
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 18:56:03 +0000
Received: by mail-ed1-x52d.google.com with SMTP id d7so4977505edx.0
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ps3a0R5fiiwP5c44eO3C2gpuDDsThYP5cxYaMVLIbyo=;
 b=NbAIsV6RxKdFvvgwzVyCN/O4PQu2+4LErUMNgt3jJ2N+OVq/1kzvs9bETy+iKP71YB
 AQO9o1jYTRTRpCd/Sv8jcCLrWFKffhO4QGqcn+RL+VItEtHhE24xp9Vew4EJKjD9DIuG
 A08mxTM3GzGyL5nZywpMNC5eslEYegj/LP8eQtBMsFAWEirBfGow3rfM/3pYhrsE7ykx
 EGx5bNPB6C7+ZahPEYDQNmYsguejAPku7vuyMS6+bKdwqGqfo6HFHv9qRG17vT4noRKv
 nuAV1sGVIWVPG4zJ56wFjfp7kUl3O48d2Zan5wnmGGAfsyHXj0KVSC5u/uofn8ejK13q
 8ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ps3a0R5fiiwP5c44eO3C2gpuDDsThYP5cxYaMVLIbyo=;
 b=mB1KiLmu5WFYddauRaBw6Yzk1pX1I7KhukxIE9U4ZfSFrRYPWFEk+14ZYUnKljrlwg
 /tHS17qeIZxdMOppf/ZfpTCP6j/YUBjGZzk4AqUIq7oAdo9qzEWFjWdjtmIP0+sLE/SS
 TS3K9dxomjN4IKQTKNn5zMfReI5qCbgRC+457IMsEQIcKBWS7gvw61IvzUrqAYzBxJ6L
 l8635Zqewg607/5cok3i3PXG4t/Hib7LgqQW9ACQ1cKKNqVjOW98CEUbZs2tTDsToGn7
 jI6vGz9YvRpDewvmkeet2YJ8NCMIKJ1AtGpd+jHa1VJOwUrtwhGzy0I3bwtt8HRPTmyW
 vDlQ==
X-Gm-Message-State: AOAM533SipXmjieLaG50gCCzRp6yXTkr4WZBNaZQyey9XxAjeWUWbJsQ
 ISzX1cSJua4PfY4l/pVWw4l5+K/unFLLa+H014Y=
X-Google-Smtp-Source: ABdhPJzO+A8MejnA2gl9P2VRF6ngaUIIay+Rm//oAxzEDzT1/d8sd/QreixXPtyTFoFjE+S338VI+XxkE4q7SpKSXp4=
X-Received: by 2002:a05:6402:524b:: with SMTP id
 t11mr1676923edd.327.1624474559588; 
 Wed, 23 Jun 2021 11:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210621051046.28783-1-smalin@marvell.com>
 <20210621064528.GA5906@lst.de>
In-Reply-To: <20210621064528.GA5906@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 23 Jun 2021 21:55:48 +0300
Message-ID: <CAKKgK4xuLbQpoPvCbJWS=xzLkUvcFoC-V71O_pDTsnUTi8brvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] NVMeTCP Offload ULP
To: Christoph Hellwig <hch@lst.de>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, kbusch@kernel.org,
 davem@davemloft.net, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com, prabhakar.pkin@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_115601_879757_9286B301 
X-CRM114-Status: UNSURE (   9.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/21/21 9:45 AM, Christoph Hellwig wrote:
> This seems to lack drivers actually using the infrastructure.  That is not
> only completly not acceptable for merging code into the kernel, but also
> make the code impossible to review.

We will send v3 together with the offload device driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
