Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB46C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0F82075E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0SozKiU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gx3WkAn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0F82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S9ADAoyvxtHSGuQbdeGE4YJmI4reO15PS1zsIuk9DVE=; b=i0SozKiUSistp9dQqShzC+LFu
	1t6BdQdI8RG+1y+lnMzd0GD/YbFaX12srz8U5J8CUtn89FtjEHeP4llnPsbpBuSvTGPLzbMWPRUfw
	SuzKFSE92pvDTXAby47gLaL0X5gEF2QcFm5wGvNCC+9o2fooZl570/F49ly5J9T+yrQDKJC0PkPlq
	5EGU2O9a/Cb4JRTz4W+vaIjV3xJ/vrdFy0KmHoJrpO3ModvqQvXj5sR3r1IqelQDNOeka5EiV1R/x
	zdsUuNjtJbPKo0KPuU+Ykkxo/jcCdgG/s53Q+Qdxl5Dul1BOzTZckMKrdo74FkDb1qdfkd+5Y/mzW
	9sws3jIgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8mbS-0001jH-4f; Thu, 20 Aug 2020 15:35:46 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8mbP-0001i6-6d
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 15:35:44 +0000
Received: by mail-il1-x142.google.com with SMTP id r13so2024226iln.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PxqJ+KF8eoddVjwmOfVLMrEOv7rCZfLqXLoNuUj+Zlk=;
 b=Gx3WkAn2m+9rZYeJ4Yj2+hdg/EPV01H8G+7/Gsqhur1h6k0KOFYJbYKLivEr0k5xgo
 oTf84GKs0mBt92dxmGAE6bvtUI8LAAD8zJ7nDQd4XCZlztd3gmbtZ2oI5XMCTUa0okWW
 0CchrZUt8iw/MkXiuD9NhXNyzg7/rwRWUWayK+A48usffsv8JHWCbE0YRuT7Nm/sPBgR
 YcZAgskjGG/YX1X2Qmve3did5048r2k+SYjW6Zk4kwBBA+9WwkBR+kOd4E+PCbzd98gp
 arEPDuqYAO2ULaDiEiVkhb/Ieg7bjTZcZggxnrFkzFBKcaJZo9lpcYNxid06tJktNpw/
 weFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PxqJ+KF8eoddVjwmOfVLMrEOv7rCZfLqXLoNuUj+Zlk=;
 b=Ck4HQTsUO+WjjplY/qvOqwHJOVTNbOI6IyuF8DpEl8J86B4nZ3CZ4r27p9A2Yyb96c
 XYJBErwielV5Y3jisxFw6/QMG3mLFgd3IUxZiXnNzbrszEd5m2w6biy5xawnjkJZF9FB
 VzxnuV6ALQUpZIeC1rOCJ1/IJ9lCKHK/FxnJ+IBRlyi6LfhJzm34qzWQMVckcqbK+AUZ
 TMNTFZUZP7+aCydH0bvZ628z/aKqjInLpsGU8ypjJgM0at4L2Z7HYSDmCB1OvzK+fmbz
 SIMb/Dp0/YqfiPesWG93bRi6HIsdGwqSdiKP+nFuCLv6Wrx8NIPKB/EFz1dgHo5oPOqt
 3kGg==
X-Gm-Message-State: AOAM532w6h3Law62CmPCWkVUVEQx+4S3fgg8ZNkfNK4AofSv1F1FSnoo
 YSA3R27rZDF7SHRM+5IjIww/fQ==
X-Google-Smtp-Source: ABdhPJyCloxNG7waNd9sWsZwA6ta0Vff204AhHHDxwrSM9UwR/2kdEHIIpqsrahxt/2SIObwmiFzLg==
X-Received: by 2002:a92:99d4:: with SMTP id t81mr2984047ilk.95.1597937739765; 
 Thu, 20 Aug 2020 08:35:39 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id c76sm1897226ill.63.2020.08.20.08.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 08:35:39 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>,
 "Ahmed S. Darwish" <a.darwish@linutronix.de>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
Message-ID: <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
Date: Thu, 20 Aug 2020 09:35:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_113543_378160_B61DEA77 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/17/20 9:58 AM, Jens Axboe wrote:
> On 8/17/20 8:56 AM, Keith Busch wrote:
>> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
>>> Hello,
>>>
>>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
>>> laptop. PCI nvme detection fails, and the kernel becomes not able
>>> anymore to find the rootfs / parse "root=".
>>>
>>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
>>> fixes the problem and makes me able to boot v5.9-rc1.
>>
>> The fix is staged in the nvme tree here:
>>
>>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
> 
> That would have been nice to have in -rc1...

And now we're getting very close to shipping items for -rc2, and it's still
not in. Can we please get the nvme pull request out for -rc2?

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
