Return-Path: <SRS0=K1w7=4J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F747C35646
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 16:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE7A2073A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8foi4ID";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FOJEBTxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE7A2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aWJTBHBCpY4kiiGyhoJ/Mph37yM6PFds3mFs4gENcTA=; b=A8foi4ID1HE/YB
	akqm0l0U87SX3n6ZRB3rRb1rsueued+U3/U2H+kDgx1+sIyp9dQpz8l6ZASMmwPuCpOarXNdRD/+c
	6+zCVK66i5tdWysRl0kEI825qLFzQbOAxPUm/Tb8vJjUwfO3pGlYKMMN7rFjdUNwpOMsIQKVrRKYv
	uFUF/HRK9noRvp9K1hxmCBK4uEd59xNN1xuwBh3YF+8elrMJ6GtBQHgxEkxLga1r2No8fP09cyHEK
	VonycLPVbe/YutoaSpEha70PSsq+aFYcwjQOReoEm8R6N4bVM3q2unGCHcmqYUKb/n+xNR19SGr5I
	ZW8gTh8N9unldm3v7Xog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j5B0W-0007pM-7b; Fri, 21 Feb 2020 16:18:28 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j5B0S-0007op-V4
 for linux-nvme@lists.infradead.org; Fri, 21 Feb 2020 16:18:26 +0000
Received: by mail-pg1-x52d.google.com with SMTP id b9so1186021pgk.12
 for <linux-nvme@lists.infradead.org>; Fri, 21 Feb 2020 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5BuUJHKqF4AekyvCBA2sO3dMXMyfod66fkhYw6jYT8E=;
 b=FOJEBTxKeaQIR/DmJvP0ldnYydN5pu+PhgDdetNNM4GvmAyrx3TAU8Yv0RvMw22/UZ
 O7AlDC7KqZQILJ6s0N/a2OJ3hgcWB5Q+EiptHPBKYT+2KwSG4vuMCa5tJUtsY046p7xC
 r1ugbDU0JBcmb9NzudYNiMmTrba8oJJ4TM27eJqYFG3l2E28bM3g2HdqsV12fjqX/ruW
 k+m67FUUmQMkvm1wxqFp0vwwfyFcZOMv8I5QpyAskzrYXbwB4PzPMZDFp8m/dEAWD/DJ
 6vdRbR1LcZc1O+Yv2NYIGKHwYbbIrrrSRWpMMqZOBm5hLTznef9V5RO/ZeMPZ/2vwSLw
 lG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5BuUJHKqF4AekyvCBA2sO3dMXMyfod66fkhYw6jYT8E=;
 b=HIr/SFVRbdVWJzYxsab9luEctuaiN6p4KIYEKTfADuTqNY1OJFlBUCmCBv+RNvT6hp
 clt50vLu7vp6Z9Ww9qRp5ioVNNA80O4t+THD7t3q1eLv9Q2YrRv/LphIyJupWEAc/QHm
 AvITn3Yk0Oy0MrqGstUjXmUyUfTAcu1dXNnA5xMdAP6rbhM2XlT0wBTwTd/QyAhm3SVX
 kfd/4p2I5t7f2WPh1SyEdCx3WdqKbtf5srQHooe0PFxrHQcO8vZdALMCVqG7XLQfzVIV
 /f2bKHrsPvN2YhY9Xu8FWNKZhYRD0vuKXRWhs3wBz6uw1HEwp8ozOoY2PbgR0ni94A0F
 Wl6Q==
X-Gm-Message-State: APjAAAVJ5MU/c3A8Iz0dV4eoWkkJlKCFR5weUVbHRQ5MNpNjZGVDLIQY
 PaioR9i5wG5tBoHPRu7yI4nkEfyhWnk=
X-Google-Smtp-Source: APXvYqz9wi2Dj6+rcbxPmtCuCuGwjLg5x+6u3TWWme6RqKsSC86q2s9e6MnOWE/R+Q395SpkCU9Y/Q==
X-Received: by 2002:a63:8f49:: with SMTP id r9mr39628083pgn.190.1582301903165; 
 Fri, 21 Feb 2020 08:18:23 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:91ff:e31e:f68d:32a9?
 ([2605:e000:100e:8c61:91ff:e31e:f68d:32a9])
 by smtp.gmail.com with ESMTPSA id j17sm3289275pfa.16.2020.02.21.08.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 08:18:22 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.6
To: Keith Busch <kbusch@kernel.org>
References: <20200221145652.GB15144@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <39df9a6f-94c6-e5a7-06f4-8d91df3c4565@kernel.dk>
Date: Fri, 21 Feb 2020 08:18:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221145652.GB15144@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200221_081825_004621_461530E4 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/21/20 7:56 AM, Keith Busch wrote:
> The following changes since commit f25372ffc3f6c2684b57fb718219137e6ee2b64c:
> 
>   nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info (2020-02-14 10:12:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.6-rc3
> 
> for you to fetch changes up to 3b7830904e17202524bad1974505a9bfc718d31f:
> 
>   nvme-multipath: Fix memory leak with ana_log_buf (2020-02-21 23:52:25 +0900)
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       nvme-pci: Use single IRQ vector for old Apple models
> 
> Keith Busch (1):
>       nvme: Fix uninitialized-variable warning
> 
> Logan Gunthorpe (1):
>       nvme-multipath: Fix memory leak with ana_log_buf
> 
> Shyjumon N (1):
>       nvme/pci: Add sleep quirk for Samsung and Toshiba drives
> 
>  drivers/nvme/host/core.c      |  2 +-
>  drivers/nvme/host/multipath.c |  1 +
>  drivers/nvme/host/pci.c       | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 2 deletions(-)

Thanks Keith, pulled.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
