Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA19D78779
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/yyPh2gYADep3K00l78HVuhtV1AcQLAqad1spZDG7E=; b=aLnA0ekNdasroI3nxZrxV9nQdf
	0GsGo9ptFGqNjaaK8tAxfLawKJ3rfdCVKEYuYPm1GoDeP75IN68yQugl6iVcJZCh6zJpoMaM/Efqw
	vJMB3bfECJW49e95cXWWixgCv1Q/upqSEviDHEcjf5ruUcRTh9CBBBM+YPvWnHrBTX5jwh4OcIRyu
	bZSQmYpSsmWvKqkNgAvj4U0hhMaGYNh+D1kX9FhbXJ5+RLr27Y9EzvGlh2lb+uH5DqgXhcLNA+j+n
	MuAbdon99gA4nLnKW6UcwxvmmEH5r7DnoSUtgJAmvQowaip1eeoMraOddhiTSo2EAkslGkmXyyS21
	czj8PHPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE8U9-00000000FSt-0gjw;
	Thu, 21 Nov 2024 14:48:45 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE8U6-00000000FRJ-1I0e
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 14:48:43 +0000
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-71811707775so495935a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 06:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732200521; x=1732805321; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/yyPh2gYADep3K00l78HVuhtV1AcQLAqad1spZDG7E=;
        b=BeJf/9q2tNE8PdJ3XGqTrrq2cq5dSQ1Dzg5JZ36JL/GL8+vF8eeIP9AqyVJFr+GZvo
         7/kbPv4UMWHLTdrowrGdpwntEjN/VyZFokk8RqKTv7AHVakcMY+8ztc9Pp2xQ47gUHBG
         k/29VxNvH77ftIKTV7GbD7OF4GczuBwmtgFyu17dgduHJ8xAQGBFQqqnHLbtb6a4bTMr
         xQMEXdN6Ij4NI68letMMDZEfXR44HK2EvvpQZ11HQY76YhS5U9HTLqzITFJfRpX2V/B8
         SQ5o2etqPFs4wuVHgTMoZgfzfs4l9SDHFzfhwqka5iVKaZulVLT+tdefqljEvOzLX4oj
         J1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200521; x=1732805321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/yyPh2gYADep3K00l78HVuhtV1AcQLAqad1spZDG7E=;
        b=kg0slZn7NzEt8tSCvS+v0mkQi3/f8+b0ywpw3d8ENUzwwPMzfJ1zUONmE/o+YKMH0o
         pCPK+NoYT9pnNfsq+JoWyXwaoXVnoI1QA8YEdarACZH6Ouh4ORgdRnC/1c+3a/wyYovq
         HmItD2mrKFGRWEwyp+y7Z7Xswpnpi0bNZ3u9R0W7uLTthlQzIgJJvPlrP4/mqCHUnXrb
         1zTyS/SrpPmRAp03qXOiOZYw2X8lvqCX+NZJHCyzbPkWmZWUkDpVLYxdDyTl+y+FCA3y
         dx3jp5gRqutqMF5IgcKV6Ns9XIv5DT628c/lw89rT9KNN2ozJYGAtpyqw75DsXzz+BPq
         3o+w==
X-Forwarded-Encrypted: i=1; AJvYcCW2W0TH/6pkqB8aBVxpKHljrzLEPb84zVMLTIndYhSk7Wc8ZQ29FmOqomuF50MoKu+26YMoRB4JXG6h@lists.infradead.org
X-Gm-Message-State: AOJu0YySAFvqw+vSfEPdGD6zJD7/xuaxF1ERanpO288WUr03g3eLXcxI
	+YENcqJkKaUxibwG/Rdp/a0qNl9OH+uWmP9C5YnJ/527hBaqT2Ip7BORYjBlb0w=
X-Gm-Gg: ASbGncuc2eNCZzaYsMzfHS7ELMAIGonGCq/pOEnlRLzuBiBKfrcGrTeYVRt6O6bMJXI
	bOdyq0Xk+Xsisu+jckEMUZiDGjffh+ySKXsizTzE3GiP9wx7Tvg8aXVU3s9WzMALqEa1WTUwfgu
	dyiJltiYKUfXL0mnBMV4KrrtGjxUlo2iAfPBmD7/TFbHqQinoBN5Z3QWA1lfk9ra7sxXEWDLhyX
	6e59mQXVAo6W6+hhWQuD/gygKiYZXcA53uwtqJXt3Ru7A==
X-Google-Smtp-Source: AGHT+IF3WISUvOR5rP2S/JXDHKW/JnR6H6H6uTHhtXKPM58Ro1f2seFsCNDFThU22eEt1VyFmpXGbQ==
X-Received: by 2002:a05:6830:6e85:b0:709:4757:973 with SMTP id 46e09a7af769-71ab31c0cd9mr7422132a34.23.1732200520971;
        Thu, 21 Nov 2024 06:48:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a782138b5sm4471379a34.65.2024.11.21.06.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 06:48:40 -0800 (PST)
Message-ID: <2d7aac9d-8c47-45e1-a058-35e1de80db22@kernel.dk>
Date: Thu, 21 Nov 2024 07:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121045714.GA20680@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241121045714.GA20680@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_064842_348009_1B5A1B98 
X-CRM114-Status: GOOD (  12.46  )
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

On 11/20/24 9:57 PM, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 06:20:12PM -0700, Jens Axboe wrote:
>> There's no way that commit is involved, the test as quoted doesn't even
>> touch write zeroes. Hence if there really is a regression here, then
>> it's either not easily bisectable, some error was injected while
>> bisecting, or the test itself is bimodal.
> 
> ext4 actually has some weird lazy init code using write zeroes.  So
> if the test actually wasn't a steady state one but only run for a short
> time after init, and the mentioned commit dropped the intel hack for
> deallocate as write zeroes it might actually make a difference.

Ah good point, I forgot about the ext4 lazy init. But any test should
surely quiesce that first, not great to have background activity with
that.

-- 
Jens Axboe

