Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92FEEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 05:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TonyGlZrPLTfaA/nGE3oSsXI8nFtOJ8w/o5RAeOZAAw=; b=m4i+YUBWHbhie7GCv8qQm+1iBT
	W4Pvv8StqPdyhDXSi+bChaBTyxn92A8ratEJYLOlzpJH6O90qn4exSM5iCwACDwpXjvg+gTSwr06n
	XxgJvhgZP6zL255BKsls0/kaErMYrI9zBVbL6w4fZR5MkoB6f035SJR0aQJx+NhY3SCZ54+FwKsu6
	n4SGoJUVLIbmc/Pc36X2I4yRQX87P1L5FpvT1Y1EGwU90jVDFDB0JGJz4LlgHQH/xZxf7P40Exf4u
	ob0tqv8cAWEnnsy7yxyEWCiCICVNyPeKPOy9pGhiw3jKhucmmaTkUCRtZf3xkkqeH6A/qurTLqWtO
	2OaM4bqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJpMf-0023OH-1X;
	Thu, 13 Jul 2023 05:59:45 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJpMc-0023NQ-16
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 05:59:43 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so2112325e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689227979; x=1691819979;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TonyGlZrPLTfaA/nGE3oSsXI8nFtOJ8w/o5RAeOZAAw=;
        b=nwW1SQbH3bX5iVluDTu625cIH6qOiTFEpMh7/NHoHeubKCR6ldajfreHD3crgVtaKl
         gJNN1v01M56knNU8LgXG5Fe0aTj+LWDjD3o5jaEjUa1vnI1SzqKxWjwsic6/9UU49uZY
         LFU8C11eO+9M4zdGW/Ywawx4sO/wg6I33/1tGPwUM54z4exaM9oJvdivq8Vv5akeP32A
         WJvJ0PVujUpFKJcN78qCP+e6tsbEDj2IcOdbOjy31ah9eLCP2y4Y+UakHL17pCNvf8Ju
         PUulnwIMjFPcIZP5XHrUL8LMpLQtvY65WjGPUEeSNYASQVzlS5kUJ/ItFHa3h8Sd7vM5
         oP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227979; x=1691819979;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TonyGlZrPLTfaA/nGE3oSsXI8nFtOJ8w/o5RAeOZAAw=;
        b=EaSfEbSrOOc/Luynt8cIpw8Bl80qbQVFuaU6S7uTbrrpNS3A+HRUhK2TAcMBXALOHk
         E4jQOd16TvqkDuOR0YVx9S8ie5PY2nRPdT3RxKWp8RefvPROAgoufFfOM1Ec0oR4nVqh
         ACvnV3Nj0vF/809HfMZuWb8kpVTHudDxzOQbofhQOBfXQvC+1BTlaqkTVc0GfnNksxld
         3l432Cx76lMTIrEH215zDg0XJ/cRTYP5tZLXg/TjhSgOqBLAgJ8ELlNutYsx2t0QN77j
         1ehKdZWYtV7asHnEmUeogRTVBVRJ37lBRlQFLesnwnEykP86e1DdRRYDBZY79536wriU
         3Eng==
X-Gm-Message-State: ABy/qLYeaBKSzLGX0KMx8XQi7QOfEfXyuAFC1ardvnR9Qcmt6Xxp0E+W
	bHtsnzPkeS8wJ5uAi0uQFlqgugvIovM=
X-Google-Smtp-Source: APBJJlED7Vq9rOXUbdrXtYCHP/Df/58CDfglI/owsskIfYVf6B78MwAKnJXfStqtPQ3ISqkXR2boqQ==
X-Received: by 2002:a1c:4b18:0:b0:3fa:9e61:19ed with SMTP id y24-20020a1c4b18000000b003fa9e6119edmr479684wma.23.1689227979254;
        Wed, 12 Jul 2023 22:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8ac:4400:515d:f19b:9d70:d3fc? (dynamic-2a01-0c23-b8ac-4400-515d-f19b-9d70-d3fc.c23.pool.telefonica.de. [2a01:c23:b8ac:4400:515d:f19b:9d70:d3fc])
        by smtp.googlemail.com with ESMTPSA id f11-20020a7bc8cb000000b003fa98908014sm17441619wml.8.2023.07.12.22.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:59:38 -0700 (PDT)
Message-ID: <16fa03d5-c110-75d6-9181-d239578db0a2@gmail.com>
Date: Thu, 13 Jul 2023 07:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Anuj Gupta <anuj20.g@samsung.com>, davem@davemloft.net
Cc: holger@applied-asynchrony.com, kai.heng.feng@canonical.com,
 simon.horman@corigine.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
 <20230712155052.GA946@green245>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Performance Regression due to ASPM disable patch
In-Reply-To: <20230712155052.GA946@green245>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_225942_383274_E6A2C7BF 
X-CRM114-Status: GOOD (  13.53  )
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

On 12.07.2023 17:55, Anuj Gupta wrote:
> Hi,
> 
> I see a performance regression for read/write workloads on our NVMe over
> fabrics using TCP as transport setup.
> IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> 
> I bisected and found that the commit
> e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
> NAPI poll") is the trigger.
> When I revert this commit, the performance drop goes away.
> 
> The target machine uses a realtek ethernet controller - 
> root@testpc:/home/test# lspci | grep -i eth
> 29:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 2600
> (rev 21)
> 2a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Killer
> E3000 2.5GbE Controller (rev 03)
> 
> I tried to disable aspm by passing "pcie_aspm=off" as boot parameter and
> by setting pcie aspm policy to performance. But it didn't improve the
> performance.
> I wonder if this is already known, and something different should be
> done to handle the original issue? 
> 
> [1] fio randread
> fio -direct=1 -iodepth=1 -rw=randread -ioengine=psync -bs=4k -numjobs=1
> -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> -output=psync_read
> [2] fio randwrite
> fio -direct=1 -iodepth=1 -rw=randwrite -ioengine=psync -bs=4k -numjobs=1
> -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> -output=psync_write
> 
> 
I can imagine a certain performance impact of this commit if there are
lots of small packets handled by individual NAPI polls.
Maybe it's also chip version specific.
You have two NIC's, do you see the issue with both of them?
Related: What's your line speed, 1Gbps or 2.5Gbps?
Can you reproduce the performance impact with iperf?
Do you use any network optimization settings for latency vs. performance?
Interrupt coalescing, is TSO(6) enabled?
An ethtool -k output may provide further insight.


