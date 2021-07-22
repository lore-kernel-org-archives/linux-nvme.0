Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E1C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 20:26:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE4760EB1
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 20:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AE4760EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Vy807PLPy6ItBE0amTonK44FzssMhUc7T8WsAuJgG/c=; b=g+DE0EaK8Oau+Z+p7aQ7qFHvR4
	ah00lP9Lj3+Qm6LHONQXDvoJRPb8/JUqhwkslFgOJuMm8pdaRGgcEP/e8dWHBM4zwubyIadW67PSq
	7Mg61jG6z72hkAoIkhMn/7Jj7dIieItbFRJtTX/z1lP2p0V9SEWGkiYAcqtMKf6h5ieIziHDZkFvP
	/MzR6f2FdC5CVreVLGFRWJcvw9pvWwTwF5tvx8Mc4V/hLY8/oHxZHFIQWxY0ur2OZ/sg33REV9EaI
	i+i1spFJnxv+PGe53M4BH0Er0vTrKVCEN/QplRwCQDEvZDP/JCcUcPVh2/4cHoTFJuH9CS39bZrVM
	h0eC64OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6fGT-002h8x-Gw; Thu, 22 Jul 2021 20:25:53 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6fGQ-002h8D-Vd
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 20:25:52 +0000
Received: by mail-ot1-x32e.google.com with SMTP id
 a5-20020a05683012c5b029036edcf8f9a6so9467otq.3
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=77vPTsrHg+AlqkSv0c9UpaNnxNWtgOyY/NiB3HvMNiY=;
 b=dTfDMiYbNhs8xTsw3ZFsNcKbQaY5+vXaaFPMar/OAyydu4oVshaP7NmfY/D5w4fK+E
 aO1DJHApAF3UsF0GWNF7JMDveSUGDuuCDZqEZVrLsO5YtTr0aGqbACj0C+KSPZ07dICW
 PW98MPpVgRHr96tj7WgC/Rb4G6WvJQfb9abWa6GvYvX7M2QNpiRlK6loCU0mPRnptAKB
 FTDTm85bQJtF7H+I7f7x+mJM8EXMTVNUsRIzG4X+UMAcpCX5m/mh2W9Vb48WaZi5ZDDJ
 0spLOWz/5vSuwj1PxoQ6ME4ayQ4psVCt3yEaJNTaum7VKGhSL9i55eLhHA47fFuGc3ES
 /taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=77vPTsrHg+AlqkSv0c9UpaNnxNWtgOyY/NiB3HvMNiY=;
 b=i7X7NrSzeXcnqq0ohsuN1P5xVIIpnsEILrC8E2+lcVn5ydqC1i0d2tAzJWciQ/aNau
 Zf4qj9J3tag5MwxWSI6U8TxeGlZfiUXeBvrm1unR0EKOHb02E/KlE0DJ5IJR1h2n/bnU
 3FWBDYiNgRyoHx0K/CwSDAZULAOsH2aU4e+NZ+U5rFjlFhZkR+5BpTn8fg5m4rWuysa5
 Xlbv77oU7r5WscQkX9aIo1DYSfqeXh8YhVNIXf6c0ejNhYBYILLAng0d6lqF3Fd3eOmm
 7xlw4993tF2X1j+5Z2dIn+GMYuFGAgodxxzkCEkeMBMm+ujaenYznvBky9DZzeuu8wga
 G2UA==
X-Gm-Message-State: AOAM531UpeggwrpYF3g/GdT3fqK3eFnl6ImUD7DrgiUXdMhf+JjrbIe6
 sYTjWsBmryPNo5FgN9VPQVNBIvLqnxpW3A==
X-Google-Smtp-Source: ABdhPJzUPRGbTELnznbn4NmFgCdI5a80mGbRI2mILC+vNpGoMbaEaRDKz0H5Lo9dWeCbNcRwjQi1HQ==
X-Received: by 2002:a05:6830:19f6:: with SMTP id
 t22mr1032552ott.32.1626985548993; 
 Thu, 22 Jul 2021 13:25:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id b70sm2901338oii.24.2021.07.22.13.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 13:25:48 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YPm/cHUBGJpVOS4n@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fdf64cb-13e4-2114-b0d1-8f4cb4ac450a@kernel.dk>
Date: Thu, 22 Jul 2021 14:25:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPm/cHUBGJpVOS4n@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_132551_143740_88A3BB3C 
X-CRM114-Status: GOOD (  11.29  )
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

On 7/22/21 12:56 PM, Christoph Hellwig wrote:
> The following changes since commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf:
> 
>   block: increase BLKCG_MAX_POLS (2021-07-17 13:07:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-22

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
