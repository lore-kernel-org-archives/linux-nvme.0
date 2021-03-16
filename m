Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:52:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D485650F4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D485650F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VJsY1ESF/oct6Ca3+VmQHzSXtd+XbbQBgjP9gnGwm0A=; b=gS6GG9yuYZDgnfMAM4zRGRnvZ
	XLXG88Jw/r5YoWxEupalRoRFEo233OIos5fOsfh76wt+oYnqMLbDttHcODRbjrCtIlw50SrXsp92Q
	I2GtIhYKeGJJ/kTiRxQznZqBL+QyQG5e//gt0zOhAf0sFLs8xqJoD6LYYy1GRlxv/FB3REltlJz18
	iEAv3Cu5IAd8w2dmYQzDD2cb4Au6cgTFNsTO+z1/txqw+vkYo9tnd5VUygVwzpMwgcPlLSeom0ID1
	LUoRdvqkbmfx+4F8qbJ5U6LkhBEZojXwR3Mwqci6rCsW/8LnpNynYDZ8xt/z2VReSe04HBGhsMiyf
	cCNjtxR/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBz0-001930-Pm; Tue, 16 Mar 2021 15:51:46 +0000
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMByn-0018z1-AJ
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:51:36 +0000
Received: by mail-il1-x136.google.com with SMTP id h18so13127507ils.2
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s/EAT4HSlydRSIq9ygRjoznh+BfLxK52S7wifqI3MLg=;
 b=YrOZBTAV5OPMNIRTaBHuL9LjBP2Y8lr1OttSI6Dgm0S6Jco6EyTMKwd6FvtORZI09j
 tJsA76C5uOgzscnC+9dQyY6ck/w4Sj/hXhGYTy+79I9fgsFv+kYh9D6SCzVNoaNTbcUt
 lu8S3lbwbKpSYQiw/SMC3tQgTwxJwEuu7oP89snXh85HK1o+QPQImbcc8nwN+2UEu3jP
 zjiKx4Vbpczj+SS8Lcir1bKO5Ty4PwhvfT86nfI6zIHy9lGjvfV+HjIZK/qSfGCWgP1y
 CIUbz/Rzml8mMaOekkq7eb9eTDeLEweVYUeCyLA7VMOrvrnfUOy8OGZFYQiuPbRC1LM6
 TFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s/EAT4HSlydRSIq9ygRjoznh+BfLxK52S7wifqI3MLg=;
 b=IrZDXReSlJookOWhLpTFyp3t6oWnIlHr2/hpWuJxAF8wiBYARW9+zjlvGfMdeTE1bP
 ZwAgQiGtqvSk9c226Mpdb5h+WWfXVD9qf3PKwolpy/OBo28Ud4eZnj3H2C1lu12hGsrV
 PyFlJVCKE9xldxmBFzahSMswbLGU9HgIEbMAC/xi93Na9T0sD3GasIr41vzT5JzweLFy
 Xii03r8pDUzIDlekFco3axUeV/vavuqBzFpJ002usG9jBdYwmgsNhmcKzLRHjRPow6mz
 DitGlFJ0kHT4R/5MY7o058wa6y26KSTr/kRZMrXdba8+4Rxg86hLPBQ/Ugz134l/L4fV
 ZG/g==
X-Gm-Message-State: AOAM533fIEqQqLbwemIkuaIlZhyQvCrgcMkV3Da+SHsdRLKl6LUdcpB8
 MuDwS5mx2V8uk2tW460F9MUHRg==
X-Google-Smtp-Source: ABdhPJx+wvouE6WL3T10Cm/gOgsUdAdb26zeTKoF7+N6ZniYzPfKm4Wwh2DT8ZJ1ppQo+t2sbMFs8A==
X-Received: by 2002:a05:6e02:1688:: with SMTP id
 f8mr4187663ila.110.1615909892060; 
 Tue, 16 Mar 2021 08:51:32 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id t9sm9645667iln.61.2021.03.16.08.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 08:51:31 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/3] Async nvme passthrough over io_uring
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 chaitanya.kulkarni@wdc.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, nj.shetty@samsung.com,
 selvakuma.s1@samsung.com
References: <CGME20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b@epcas5p2.samsung.com>
 <20210316140126.24900-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5476c77-813a-6416-d317-38e8537b83cb@kernel.dk>
Date: Tue, 16 Mar 2021 09:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316140126.24900-1-joshi.k@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_155134_761172_F68A2BD7 
X-CRM114-Status: GOOD (  12.33  )
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

On 3/16/21 8:01 AM, Kanchan Joshi wrote:
> This series adds async passthrough capability for nvme block-dev over
> iouring_cmd. The patches are on top of Jens uring-cmd branch:
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v3
> 
> Application is expected to allocate passthrough command structure, set
> it up traditionally, and pass its address via "block_uring_cmd->addr".
> On completion, CQE is posted with completion-status after any ioctl
> specific buffer/field update.

Do you have a test app? I'd be curious to try and add support for this
to t/io_uring from fio just to run some perf numbers.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
