Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8BC433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 01:56:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975A22075E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 01:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MJySw/AO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pWwD6oEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cE4u7czjsYYf8wMAU6D/+y1xlKDB72XEfUTq11VdbO4=; b=MJySw/AOFECUv9lrzGYur6/6T
	7u8WDPVNfzNJtqQWapOIByVSpC6rYoMWccVLUI5dgcjilWFNiBDiNBh31fU4nXGFTDc22osp+MoLR
	ZB3BXHPuiGR/4mlCT2K3pD8ks6AdC3HDxeirKkehFHMr3kVxJS6tEzpxKS4jwH4vxnZhK0iYUBGAY
	OUUKaGO0l0OeCjq7yvxLxnS5KQ/SbCPeP8WeiykSRQJp02XA8A+o/9RJmEX+t2nyZzBTG/3K/uAaG
	LyLzuC2xagsKHiMxgYSw7axDcZj1vgpwQ6frCNHzNdL33fE6O9LLQva7H8AglTXlao5pDUEWpxX1T
	FTgmn87qA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8wHg-00010Q-3f; Fri, 21 Aug 2020 01:56:00 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8wHc-0000zb-4C
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 01:55:57 +0000
Received: by mail-pf1-x432.google.com with SMTP id m8so297483pfh.3
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3L4uLX3QcIpXcWfcIGw/6i5kDxjG2jxAeHYrEzCblm0=;
 b=pWwD6oECt+faU+jSTRS5eyq0bjuaul9BrlMx5tB50cZ60i5ZCAaYIGPowIe1ey+yvE
 P5/Wjc8TGCroTJ/RvSFF9e00bhkEZF+YV2d6PkDqUNwfGO9phIy45dY4eJl5DK0oC/WL
 zaS53r8YeuTnp8NMagDyJDWjfZPSstSgb7wTORE7vRnP/4GotO0juA0xFXMa0J7ua/LZ
 Wu0fnb9FCOs7ZkA6qx3HVkpETilHXdJdgBnJQYInviZl/xBaovj235uN6j17Iss0VP1M
 24AVftMFXsFuuWiPsS+rB1O+l1kk6/UwQlA5n8MJubH7SVfa30OiVCBavJqXkfs5SozE
 iBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3L4uLX3QcIpXcWfcIGw/6i5kDxjG2jxAeHYrEzCblm0=;
 b=MtTQC8CcfrnBzGOurBCK+537agw4WzXfmCb4Rm2Dn6dpVU/6a4I55uL3GvGoKY9Ulb
 68gG4b+r21CBU9mrP/0IuJro/c3STSve0dvYQ4JPY93cMsvxjYvzBzwCfD2fJS83AnYo
 xZQwvs3DJuMBr0sdMDudnBa9dBGluc6h1GMwPQr8+I8pKEOMVhc9DybrRofsunVtMAr0
 UNYkbB4/NNFYAxnIWLxsovalZVdB0niTvAq+1FcbSJY0K+1HNJlrkTzDALH9yaWFJ7W0
 9MuR3xNPe1oTuJID8lZ8k731WTf3wl1Rdw6BCSOZukA2+2+as0Nrzk59quyIHNubvAZQ
 ZIXQ==
X-Gm-Message-State: AOAM531pupcvdz1IjiSuWSXSZWXvn0ChtFy8l6/zB7WicN1OhR/VqnmD
 viyys7jz6Uuny18SEAr8I1b6Vg==
X-Google-Smtp-Source: ABdhPJxfjpUfH40k0pWH2oPSRVd63a6AXZ//EwvbZjZtcZBiCrf2m6fN2Q1BQg2K/9MJRtCZgEQ7Cw==
X-Received: by 2002:a63:e1f:: with SMTP id d31mr699727pgl.262.1597974953389;
 Thu, 20 Aug 2020 18:55:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id t25sm312302pgl.60.2020.08.20.18.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 18:55:52 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9-rc
To: Sagi Grimberg <sagi@grimberg.me>
References: <20200821003015.682013-1-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e3093c6-2508-bf9e-aaa1-b5917146b998@kernel.dk>
Date: Thu, 20 Aug 2020 19:55:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821003015.682013-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_215556_993431_4CCF3144 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/20/20 6:30 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> The important fix here is the nvme-pci boot issue reported
> by Ahmed (addressed by John).
> 
> Other than that we have:
> - nvme completion rework from Christoph and Chao that mostly
>   came from a bit of divergence of how we classify errors related
>   to pathing/retry etc.
> - nvmet passthru fixes from Chaitanya
> - minor nvmet fixes from Amit and I
> - mpath round-robin path selection fix from Martin
> - ignore noiob for zoned devices from Keith
> - minor nvme-fc fix from Tianjia
> 
> Please pull.

Pulled thanks!

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
