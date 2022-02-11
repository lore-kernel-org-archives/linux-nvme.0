Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5411DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v/PHqfYBLAVHGdZLg91Q7L7ejcn7aVkN/IDZa5OsGkw=; b=eJgjwolbK31yibSCZXXAf/PN1F
	726e9A1k0GEd/M82QzFES+lUkR75HYOPU+AjgcBoaqojni/TmGmbb+DETJNWcUkrHiJgiIFcLXraz
	VgkOU2dzdHJ5CifZf+rRTgO7tzTFu582HIb1HNfjJM+19/JXfwMROx6egcxPmxR01XJ0HPXUJ60r6
	6RAjFJXAqmpQdWuOqpj0NqnZxYXBwGIoqeP9FMmx5s9ZGccmpxdX3qhrF45RCW7hsMc/Cj5L3X5rI
	o4H4wfNVdHolY3kyW303hQAhl5YVWMxeJM74pze6jTYi2LE8kYIRjQ0+c2wAQKUgPsTBdervoSPOG
	VpsLlAKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIe4Z-008s94-B5; Fri, 11 Feb 2022 22:07:23 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIe4W-008s8k-LU
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 22:07:22 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 t14-20020a17090a3e4e00b001b8f6032d96so10070702pjm.2
 for <linux-nvme@lists.infradead.org>; Fri, 11 Feb 2022 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=v/PHqfYBLAVHGdZLg91Q7L7ejcn7aVkN/IDZa5OsGkw=;
 b=h5aQ9wJ6lwe1iQcrjD9NWtEGyZEhTu3LEjOU6/X0lHrICLa5DVPbNnkBupTQJTmj0C
 6OoOr3PrJSdQ5xZka+oxyXNso6/oXKBxRKNV4MD3xOOCCF/9o469mA3qA6FMFdZtarET
 WBXWdcZ9fDiCZubCv50Co23n+JiEpLNaf7444=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=v/PHqfYBLAVHGdZLg91Q7L7ejcn7aVkN/IDZa5OsGkw=;
 b=Z6/lu663JqZTMrgCgxhd1xLiTthtNCZTYj5REI2FazgikHWV1POgUjVx0+4C13KGQ6
 RHNcaYuWPhgBG10iMJqMkgmX4hxPXb1MbUaXnz3/hI+kpT7CGTd/f0AOyzZH2a62ezbC
 CLpCzTiaJ7GWIJHwXGzv3VaO2Od6x9jJ9SupjT3WjU7NE2eVyz81AO49e5jxqXAe2HBa
 98jGm8wY9o7lb/LRzZU8r8Z7kVxyVAb6VObwr8eXvPfAnaZJU8RdKe5lcgEV6uYKo03C
 GnosH3zSNZPq2RNd00inE5eP4LAacX97lxvPym2DMDxa+iuoF6bbLUkWTV1NnK4P02lf
 FT7w==
X-Gm-Message-State: AOAM5316Kq/bEovE00XobHIOCi0R+vFcLAn6IO/OH2hoHFOJInKUnblk
 Q2MV68A7V7sC6SxuL4ySBrv7rXC/H6lgIOryheHpsCdmEYDYV9P8oQpfFU8A061UU6tcRyfVpL3
 oTMgBUfxavikWOJ/JeDCk/KRiM17T3JZNaOQysGCH/DwuOztFd9YGZCr+VykjtIqjK1XGEWOlk3
 KvJtHXUicrITwv
X-Google-Smtp-Source: ABdhPJwDF8TFbm1pnjLPHOGmw75r069q369RU1qMltsjaxCIedK7aC0ehoAhzcdq9/+wR1FHXvZipg==
X-Received: by 2002:a17:902:c101:: with SMTP id 1mr3490659pli.6.1644617238320; 
 Fri, 11 Feb 2022 14:07:18 -0800 (PST)
Received: from dev-ushankar.dev.purestorage.com ([192.30.188.252])
 by smtp.gmail.com with ESMTPSA id y20sm9328196pfi.87.2022.02.11.14.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 14:07:17 -0800 (PST)
Date: Fri, 11 Feb 2022 15:07:14 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: Prabhath Sajeepa <psajeepa@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Native multipath across multiple subsystem NQNs
Message-ID: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_140720_831462_133CA7DE 
X-CRM114-Status: GOOD (  11.53  )
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

Hello,

We have the need to expose the same namespace (considered the same due
to reporting the same unique identifier in "Identify Namespace") from
two distinct targets, having different subsystem NQNs. In this case, the
native multipath implementation in this driver behaves differently from
most other multipath implementations, including DM-multipath and the
implementations in other operating systems.

Native multipath: Does not consider the namespaces the same. Two block
devices are created, corresponding to the two subsystems in play.

Others: The namespaces are considered the same. One block device is
created, backed by paths to both subsystems.

The second behavior is desired in our use case. I want to implement this
behavior in the driver. I can think of two approaches, and want some
feedback on which one(s) would be acceptable.

1. A "direct" approach: add a parameter, which, when set, will result in
the second behavior - paths to namespaces are consolidated purely based
on namespace unique ID, without considering the subsystem.
2. The recently ratified TPE4034 Dispersed Namespaces feature provides a
means to get the second behavior, and a lot more. It requires both host
and target support.

I look forward to your feedback!

Thanks,
Uday

