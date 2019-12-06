Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B832C43603
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CB821823
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBOF3QYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bNM5PuzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CB821823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Nc60CEIVH3g8smj9FSZFpyGpxZsm8RccZcyPaGjuv4U=; b=HBOF3QYinGcJXc26zVdSKxeR3d
	A7q2uBCXouSdefluwmtjttoBGUGjI475MTRMg7sMbQ4c2BaJKGgVu+IPzFZPO7gNxvh54BpHNJqMv
	AGR8372+/P/2d3H6VMgDlA+jst77IujFNRjRSGo4KoVNqytaobd4iN4Kxasv51bbIX8J/4KDtctaa
	CD2tU0+EuzeLRRrt3uwU/gRHWjg6rvuThrf3o4ok/BkH88OWYCMTnYwH6GWZCl0zZg1QwcmbPo02v
	6fack2oHdx1Vi693mQ050K/6v6GtssVB7LsXK6FbfPA5CPLKwPfgi6pDChPISJ4rKihLcYBFJaPRG
	PSJh92DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idHgC-0006t7-R1; Fri, 06 Dec 2019 17:46:12 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idHg8-0006se-DK
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 17:46:10 +0000
Received: by mail-pg1-x544.google.com with SMTP id k3so3003865pgc.3
 for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2019 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=lnGLK6Q70JMt+h9IueARt0PBqvak6HcsLrjVDNLcHP4=;
 b=bNM5PuzGAq3hE4ZVJaOvIKflvlryNEZkIbmP3scHzRrD3r/QGSIV3+jeoTWP8z0HrK
 h2db/obwPaFCrRZ5zpMAgBLuqSVGA6WXy7ulJBgk00RE8Wf0dCjd3lo8oCShucYuYOjI
 YU93eZQC6RDYmdkZTXLwbdOnQ5tPzdzbIablczkfH40Brh+O7N3/c+q8KWukaO5EUYX2
 rDsvl9FsGw0ZqU7LyU4GZkbyLksenpwE9zzZ5tU9+YAJnUPo5FIxcYupTnCTCXQKI4EH
 kLLp3uwtLcIGCEy4xO3cVnSKdDxtpBTQ9tNJEY9KX7SYYsNoiJGrSgRYgUCyUEXZRZBX
 aZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lnGLK6Q70JMt+h9IueARt0PBqvak6HcsLrjVDNLcHP4=;
 b=CnBRnRXs1fYK68qXfDPIjwaGVHKTnoXq4uFxoU0jyO3cvGvHGozIfqKZbWtOdFrovN
 TEAa0oLej5LQzHKfxfG1HiHolNBB2j3qovGfHsodH9ww4Lwsu7IRTZPLFTzopp7fPEI4
 2Pw1PCPQq8EKhQfuTuy5QSLsH871ZFzckrLq0OCDt+8ZyVoT/jupgt4/N2d7FP/iKftQ
 HSHjGTMwiOQxGyRAQMujlYtQ/vBc0iBZDa/NqE53HX44pqYou55Ql/cm4VL7qOehaAm7
 xjaM8wNsvVNFERFbtkWuHp76pKAn4rl/8Vd6sk3RqKhW2XmgKaWhMXLmVfU2wLMMyIIU
 njIQ==
X-Gm-Message-State: APjAAAVGuNm7yHzz4piCatA65Q0qEs16Q8H59vgIeJ/1BO/i7IXzCv4e
 iD0BnhvAWBTPqeWmVZMKR2ErTA==
X-Google-Smtp-Source: APXvYqw7hxSz1oJ1ikKvgy42m8pdW4WBgzuxv3IdS7xyzL1BpFQWEBZFcXVIoEh0PQDOyrJJLcG0Uw==
X-Received: by 2002:a65:55cc:: with SMTP id k12mr4921898pgs.184.1575654367216; 
 Fri, 06 Dec 2019 09:46:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1475? ([2620:10d:c090:180::9662])
 by smtp.gmail.com with ESMTPSA id n26sm16335877pgd.46.2019.12.06.09.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 09:46:06 -0800 (PST)
Subject: Re: [PATCH 0/3] nvme specialized queue fixes
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20191206171316.2421-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <360fdd5a-f2ce-86c6-55e5-a15ff2f9e1cc@kernel.dk>
Date: Fri, 6 Dec 2019 10:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206171316.2421-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191206_094608_512902_77223138 
X-CRM114-Status: GOOD (  15.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/6/19 10:13 AM, Keith Busch wrote:
> The nvme pci module had been allowing bad values to the specialized
> polled and write queues that could have caused the driver to allocate
> queues incorrectly or unoptimally.
> 
> For example, on a system with 16 CPUs, if I have module parameter
> nvme.write_queues=17, we would get only 1 read queue no matter how many
> the drive supported:
> 
>   # dmesg | grep nvme | grep "poll queues"
>   nvme nvme2: 16/1/2 default/read/poll queues
>   nvme nvme1: 16/1/2 default/read/poll queues
>   nvme nvme0: 16/1/2 default/read/poll queues
>   nvme nvme3: 16/1/2 default/read/poll queues
> 
> But after fixing:
> 
>   # dmesg | grep nvme | grep "poll queues"
>   nvme nvme1: 16/16/2 default/read/poll queues
>   nvme nvme2: 16/13/2 default/read/poll queues
>   nvme nvme0: 16/16/2 default/read/poll queues
>   nvme nvme3: 16/13/2 default/read/poll queues
> 
> We just need to fix the calculation so that we don't throttle the total
> number of possible desired queues incorrectly. The first two patches
> ensure the module parameters are withing reasonable boundaries to
> simplify counting the number of interrupts we want to allocate.
> 
> Keith Busch (3):
>   nvme/pci: Fix write and poll queue types
>   nvme/pci Limit write queue sizes to possible cpus
>   nvme/pci: Fix read queue count
> 
>  drivers/nvme/host/pci.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
