Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7CDECAAD5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsNxMOf5LM72+d4kt2FeHAVCME8bs9+iFL3iEoAYK5k=; b=2zcAYcb/D73gYUDFU2K265Mt2h
	MW/oxIOE8c9kfER4WnS7fldKI2DMF1T0qg3Wr9mjDwkWWZvK1OzGKtTHmMF+To53VCf4Rvrp4gqhi
	AF4wD6y872vOnEnNpktG5qdTNHFSG3x0GZgLzHEimlRrPk4mibkt73daJrm8QdM24vhnSkBIDCfme
	OgJy0dRHyebN5BBLlHqMZgU4v/OGiQYYShUyq650d/B8MxRzS7LEkHuLnxrotb65zAmncDnWJ7w2Q
	Ev/eduzISNm9h0QDqWa3ZkjjhiUlkA8Dirx/ZConNJK+Ew4guNcRgejkFzdVr+vfbglmPciCytwTP
	jiZ+2vbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU9Bp-006kAm-2h; Fri, 02 Sep 2022 16:06:41 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU9Bl-006k2l-8U
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 16:06:39 +0000
Received: by mail-io1-xd2a.google.com with SMTP id 62so1993273iov.5
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YsNxMOf5LM72+d4kt2FeHAVCME8bs9+iFL3iEoAYK5k=;
        b=ggqTvGon1pNPipkqQEIhdDLTqBntf3tFv+VuIQXJgl7JDFNjadhaghMctdXZIliIu6
         foiBAFIQP3qP70R0mWYerMn5rrO2x/SxfGeiiyNpaw4HZSL096UXeaEzdricSX8HzZwV
         3VeyZywkyJHGfRrh9LP50qyr/GkfGkCfxQqvvLIGTgUmD8RM+kIW+qOSsMT9Bthn1A8G
         HHvH/7XyqDoIZXi1FfQjELfOIEGbalnYO4D+XszjwBPuH56PgLFzY0yeiDBUgQzAVTA1
         Jll8nIiAFYdPvJZHNeldlmPT6Odb/HFLUGb47kyi3X3ePPNyAjGZhL7sCMnTVdWlV7JP
         Ae5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YsNxMOf5LM72+d4kt2FeHAVCME8bs9+iFL3iEoAYK5k=;
        b=3plwVauWKxvfyT+HwOWKoXABvYwFWJ+lYv/kDt3SRhmdh8frc58bZjQ1sOCJZzyR0m
         ZYZpxk+N42XvnwFhrByBHqdiCV9muvqGRrpqgDUagBzE9qc/dP+iNvCdPJmhaFTFtdTH
         4O0ubX8lyKr9J/qQQ8OVreFP+O/MY5QOFcb7aasszYl3ncKVh8e3WBJpYRUp7yzz8tJX
         bxyBy092fJ+c92M/fIxym9qrjnnyxxjmZNb0GIiAHm+mPoSdqn2MF1xt9te35DQWqv87
         ToSlIU7JDwlKDSywxaRAa7NF62DqypQxt8B5q91I66WvPL/sbQpT7kxflDtDtdW8OXPS
         VikA==
X-Gm-Message-State: ACgBeo0WogACv65bOtsvVENIZW0PaCD0zT75wmrLjqBaXF2ZPw6KHk5C
	lGs+DC0Y7OULS68RkkGPm2LBBlKmPHiuWg==
X-Google-Smtp-Source: AA6agR63XMol65orTkQhB3R5iR+tt0q5or/SxI8iXd1vEyi1Tkhf4V+06eu1o6xVK4XJu8RrNi2ZRg==
X-Received: by 2002:a5e:8414:0:b0:689:e3c:308a with SMTP id h20-20020a5e8414000000b006890e3c308amr17471363ioj.29.1662134795841;
        Fri, 02 Sep 2022 09:06:35 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u11-20020a92da8b000000b002ead7a3b185sm966699iln.13.2022.09.02.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:06:35 -0700 (PDT)
Message-ID: <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
Date: Fri, 2 Sep 2022 10:06:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf@epcas5p1.samsung.com>
 <20220902151657.10766-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902151657.10766-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_090637_359544_B563C689 
X-CRM114-Status: GOOD (  14.14  )
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

On 9/2/22 9:16 AM, Kanchan Joshi wrote:
> Hi,
> 
> Currently uring-cmd lacks the ability to leverage the pre-registered
> buffers. This series adds the support in uring-cmd, and plumbs
> nvme passthrough to work with it.
> 
> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
> in my setup.
> 
> Without fixedbufs
> *****************
> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
> ^CExiting on signal
> Maximum IOPS=1.85M

With the poll support queued up, I ran this one as well. tldr is:

bdev (non pt)	122M IOPS
irq driven	51-52M IOPS
polled		71M IOPS
polled+fixed	78M IOPS

Looking at profiles, it looks like the bio is still being allocated
and freed and not dipping into the alloc cache, which is using a
substantial amount of CPU. I'll poke a bit and see what's going on...

-- 
Jens Axboe



