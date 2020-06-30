Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD854C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BB3206BE
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucDVhcBF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NpTXHg4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BB3206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V8w87prhnE0nf9UrkkhABxQXiIdGE5JyIkKgHxAJD1k=; b=ucDVhcBFaYW/XvQ4r0skOjQQN
	JWIrWzKxNgQDSB2XCdlKDlpGA8qbG7CNQ1Ciw5e+n5VQak/qpp+dB+qTxo17hZhoAfg/CZjpcksNk
	OeujwGFsvztqh8qouBMTDPRm0lYsc6cIJMS4d6oux/mbdTcSJrlQJ5SvtdphGmSlTXuIG92L4uK3m
	YSyi/LpOElsV42Swi2tBr2gU5CBKXHV6FGSo4ffMLnIjFxN8AiLPH4EXP9seSpASi7HSgLreZzYos
	OU7lgP/t7uIJ7i9QDeeU2v22rfPHFJZfLUuBiQYnLhtgJemUeUfzPl4m+nHKTjRpcSm3u9AdPBfr8
	kkZdkyF5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGr9-0007Wn-C5; Tue, 30 Jun 2020 14:03:27 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGlS-0004lp-R2
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 13:57:42 +0000
Received: by mail-pl1-x631.google.com with SMTP id x11so8504477plo.7
 for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2020 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
 b=NpTXHg4eLKIDB3B017yOQCnwb3dBSkBllVoAHChdp1FGoCyQ19eq1VXevMLSrM/lhD
 bQk0yrTpC1Irq2MNTGh49jfpD7zqgiVbJtqJYeruoqyJ31uUsOmkXd433JMWP+NtSVov
 ZzGBWe4xhNJRj47E5aARYY/9uUmyXWiWjg1l6pljN4nXRLoWQN1OJ6HHzWlN6uNS1Lvc
 bcrSTvkHyH7MDnkYvBu1O0JOQIAWVJgUutILN7WG8Di8qKlewR28Ariy+ojttBxfAl/B
 FxzoT9uIuyEQaP+UAHq4/tgN7PJVGPmfXaxyS6AW/qEEAuiLEhHfUD+LyDQfCVGwqwpj
 3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
 b=pZSAeWb84r0yPV25Jq2QC+XL/XsuZFIhbp2eJM5Wt0xVl5KvV3e1aEABbvaeHhfUCQ
 IVLrswIj79MoN3utkjvgSeRxhgJWdoKCFlxSGd9RYDObZx/s+GWoMw9uylmKM5BlyWhb
 Fel3IfAGzB9uwrGjUxHV2bdY8Kk6rxTcfYlS3ps293kvwLSyS+R1ehHp5WuRkwGHdZBc
 2h5QNPnkXn/eTDFVpvQvYvlU7QmpVrPAGa5keCOTmYjcG20vtl7gDUohz2BLnQE3z9e1
 2LTF7eHPOsUI+JD8AZSKZhO8KT3JdmFNLJt98lg8TM/VnzJxnrm3U75VIwszJeJIEkjW
 bGhQ==
X-Gm-Message-State: AOAM5318jaCTBk4tcKTIVgMU8ho7ktXlT99D/18lxah2EJkkUrqN0p4j
 dnCiq9SZZryxbhfOb2pbIulcVGtGObJGCw==
X-Google-Smtp-Source: ABdhPJxkJrJtaSOyTXzA8zW0V7qLT6cuFQyL+FUGsc5/cLMGVxoMFOJShXuR+F2LWbUj8PAuD022LQ==
X-Received: by 2002:a17:90a:ec13:: with SMTP id
 l19mr20004827pjy.81.1593525452289; 
 Tue, 30 Jun 2020 06:57:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b?
 ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
 by smtp.gmail.com with ESMTPSA id m140sm2896019pfd.195.2020.06.30.06.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 06:57:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
Date: Tue, 30 Jun 2020 07:57:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
Content-Language: en-US
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Looks good to me, and it's a nice cleanup as well. Applied.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
