Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D112C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptUvXWnHFTEjd8NLf2/MtTjEjiATPRukf4apEyvnHzs=; b=FYZp7uxJmyOxhJESw1R30Wn1TJ
	6zmKigzVb/H5N642yYF4sWKvgQ7R1Ru2LDlwHBuwzFH3BcVt5veK/8mhbQNn0hkHknTxY5cY8+9bn
	s7sQqjXllNMGn2p+BYkmr5WS9mAkPlkWYZJC30Kqn+3R9wBLD2TnN1+RhwtIzmmReXTI+N5IydiYH
	xubpcnlWe/7N7GhsiGucXUuV0BePwp0tYRgwEa9YR/ddHkov7eOLNVS5psMOQpKBsstvGo00y5Ldt
	qiPErDetmiQUTRGcumhEWDd/Ga9y+Zpnmd3NsY0HS4CbJtLG7rsYSFtUyseYqdYZZMVRie5l4xIRp
	s+FaihJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqLxv-008eF0-8A; Thu, 25 Nov 2021 21:07:35 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqLxs-008eEQ-DG
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 21:07:33 +0000
Received: by mail-io1-xd30.google.com with SMTP id x10so9000036ioj.9
 for <linux-nvme@lists.infradead.org>; Thu, 25 Nov 2021 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ptUvXWnHFTEjd8NLf2/MtTjEjiATPRukf4apEyvnHzs=;
 b=Ok1P9w2zeGVzIESIN4pPNTb2gePDrh7PkYcZc61pXluqLnkbyJtwbpgeFvFvsUDFaY
 3RcmLQvTLVR75p+AnQUD+cZ2DErpBjnestkr5fCc2JHJNnfiGaihVrD9TeYhiApsqzOK
 /mOsM9N9SXmWgcLZuEFKuynZJHKkMOfkSW/5ryenYLoCn6I3424ObrgiSY9YzwbSFfRO
 kmmrGcTllfpSj5RhWT7YjPm5HDm4cToQPO20haFOfaYHC9XSn1rLb9hyO1es1fZO2ZzC
 VjZ+sIM0dRXq/RWRiqaBSfaFruCQLjV19xv+RRd0wshHosLmai6Bwbpf11nfPPekqXZz
 dx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ptUvXWnHFTEjd8NLf2/MtTjEjiATPRukf4apEyvnHzs=;
 b=noq/GvBH9UM6zlbnX2k9eQL/8rNKzK/Jggax40DiVFeVThbo4l5garUDlaBy4uHtU/
 Xkwlq6YHgRq2P24gExtlWmjrsHCnNtpYVV9TZhG5lnXj9QEwCFd+LZ92faDcsLGRfUPR
 j3BEGL5KOYOtts9Az/x2D53keIlQ2J5x8U+/zXRV3CHn+rfqscs5WQ6no40oRFu1fm41
 Wc1Xp+VHJYftFCj4Hk2y6Su8eQyatPflm3dkJdYyQyw7rjjNzNoSCI9xDDcSzP8frgCu
 f7L1NE2iTXZ8SoBNNBxpkr1d8yTVv4JHpyXjphIASUR6oRk0+7NXVFQWtUAjgajQfe0e
 t3bQ==
X-Gm-Message-State: AOAM530dC64PEw4extqU5Qrx6ZJRrsFPUFLNkNyjqcf4D2wvMtzDh0+G
 bMHW/XXDHzJ7C5gk5KIUtzfqHtGd4WC1cPmm
X-Google-Smtp-Source: ABdhPJytq9NfIBEXIegOGelrfmrArxCP5Vbnt6AUGHXX+T5C6V1sUA6iD/NmIKlHSz8tfc+R5WgM8w==
X-Received: by 2002:a5d:9ec2:: with SMTP id a2mr30507116ioe.44.1637874451048; 
 Thu, 25 Nov 2021 13:07:31 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id m5sm2088428iln.11.2021.11.25.13.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Nov 2021 13:07:30 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Date: Thu, 25 Nov 2021 14:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_130732_556252_DEE713AE 
X-CRM114-Status: GOOD (  12.01  )
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

On 11/25/21 2:05 PM, Kenneth R. Crudup wrote:
> 
> On Tue, 23 Nov 2021, Jens Axboe wrote:
> 
>> It looks like some missed accounting. You can just disable wbt for now, would
>> be a useful data point to see if that fixes it. Just do:
> 
>> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec
> 
>> and that will disable writeback throttling on that device.
> 
> It's been about 48 hours and haven't seen the issue since doing this.

Great, thanks for verifying. From your report 5.16-rc2 has the issue, is
5.15 fine?

-- 
Jens Axboe


