Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D7BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 03:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LiRATSfcL0WHDMuu5cadiflx7Px0RGfefhFEPlee57I=; b=nJpGBCMa/CtKA84YAHcmkrMrdn
	waqqN9d4Ykaj87P7hGLeXWFMJSRr1JPPhOjWRjIsrr9Qnftm0R/2UXP/bidF/yJChgTURi15Dv/QX
	SzY4G8tOyLoGHbrUxdit/LxT+JyzjzH0u6aZwKfNDtbgCO/rK9b014+ABzPEy8ODyRBiw5GzInVtx
	diUUVsNXUsfy6lSWTwNAqcsMHKGYQ5z6fPY0jdfjz3OI+Q4bct+Q9vcCv5E8yeMQCons8vJ5ECXZz
	/r/DQq1ndie8GYBCNtWYAOpHYWW+1DsC1oDdMyh9sOk8/xtXNzd1UIj6Gvp/rDQdG/Cwzjsc5V5cJ
	pw8UsRFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzW5P-005REI-DU; Tue, 21 Dec 2021 03:45:11 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzW5M-005RDb-Ea
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 03:45:10 +0000
Received: by mail-io1-xd2b.google.com with SMTP id p23so15997133iod.7
 for <linux-nvme@lists.infradead.org>; Mon, 20 Dec 2021 19:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LiRATSfcL0WHDMuu5cadiflx7Px0RGfefhFEPlee57I=;
 b=EDKstOhUNAKb/CMJipkRosus0eVnYiD9WjmNICFPKHqAmv3lVWk8nkqwLB2994NdNW
 pIJY4L98JOE17vEppHyue7LFV1JkOCkGrFJn03fQp3HpkJ7CH6/+TbDK925xU48cVT/h
 fc3yshF9R5+9Zm4ZsQOspjlh+Rj0OnH94h/cpN4JNwdQWl+MxiqPb6coW3g1q61h+VjZ
 YOkpioqdo/xrVIlgdd4R0wdk1DX9d7nj1Km4XpGLvcl1YeK3x9yNvbsXiJqjLfKhlJNj
 8qtNOibEZ3Juq+rf1S9LzewQ0gEdX7cYzCFS/L1S1fFnLQdd0/GkScXgdrf+O8gjilFq
 kWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LiRATSfcL0WHDMuu5cadiflx7Px0RGfefhFEPlee57I=;
 b=U9SYZ+ysrFfPcUHUbgRgqOURcwWQ+lxEOibjqt39tcLOsA//ZVOteIW5sqv/4jt2BC
 rwYD2vmUra8cXGbZcWL1yRqIyDVBaojQ7uhpJ+1YhzYi6pLAswgyppqc4osbZHrjc5P9
 QnWPA+N6eN3sy+reeEB2xjB9xWaFOBHeBWriIn4qsiAKjyOX74hGOFYpPGs/wuixu+NC
 rkXiyjg6z6GNwa9RDk1JolQOTniavR1rQ+GgJ95661uOGOIYv+RZeKvB/x5grF7qGxKy
 /d1N7c1Qcwp1pqJz1jLf/+TCg8LGiTlmLv0UXcAz0iQR4k6FxxpuwJfd6GQ/pmQtK0I4
 0mtg==
X-Gm-Message-State: AOAM531OVJNn6d50UGplXZqD2SDvhKpKeAnscMS05NlLsZQVj/hzH6aF
 6Q3dHdjO6sGOo0xwCg4SXxCKbw==
X-Google-Smtp-Source: ABdhPJzmcq5nahDyyvJSGWaAasyzvTM8P9rt6FlKs+ABHdLFQiNWTeuLQL/Z3s/PHnb3++VtTid9NQ==
X-Received: by 2002:a05:6638:3454:: with SMTP id
 q20mr765825jav.77.1640058306603; 
 Mon, 20 Dec 2021 19:45:06 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id a9sm11144688ilv.13.2021.12.20.19.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 19:45:06 -0800 (PST)
Subject: Re: [RFC 00/13] uring-passthru for nvme
To: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, javier@javigon.com, anuj20.g@samsung.com,
 joshiiitr@gmail.com, pankydev8@gmail.com
References: <CGME20211220142227epcas5p280851b0a62baa78379979eb81af7a096@epcas5p2.samsung.com>
 <20211220141734.12206-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fca4042f-6f44-62e2-0110-89c752ee71ea@kernel.dk>
Date: Mon, 20 Dec 2021 20:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220141734.12206-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_194508_534030_3C3D4A09 
X-CRM114-Status: GOOD (  17.41  )
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

On 12/20/21 7:17 AM, Kanchan Joshi wrote:
> Here is a revamped series on uring-passthru which is on top of Jens
> "nvme-passthru-wip.2" branch.
> https://git.kernel.dk/cgit/linux-block/commit/?h=nvme-passthru-wip.2
> 
> This scales much better than before with the addition of following:
> - plugging
> - passthru polling (sync and async; sync part comes from a patch that
>   Keith did earlier)
> - bio-cache (this is regardless of irq/polling since we submit/complete in
>   task-contex anyway. Currently kicks in when fixed-buffer option is
> also passed, but that's primarily to keep the plumbing simple)
> 
> Also the feedback from Christoph (previous fixed-buffer series) is in
> which has streamlined the plumbing.
> 
> I look forward to further feedback/comments.
> 
> KIOPS(512b) on P5800x looked like this:
> 
> QD    uring    pt    uring-poll    pt-poll
> 8      538     589      831         902
> 64     967     1131     1351        1378
> 256    1043    1230     1376        1429

These are nice results! Can you share all the job files or fio
invocations for each of these? I guess it's just two variants, with QD
varied between them?

We really (REALLY) should turn the nvme-wip branch into something
coherent, but at least with this we have some idea of an end result and
something that is testable. This looks so much better from the
performance POV than the earlier versions, passthrough _should_ be
faster than non-pt.

-- 
Jens Axboe


