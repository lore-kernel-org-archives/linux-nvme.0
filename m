Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=; b=n806JjUKxwjgfnwYlv9TnpVeYQ
	gJNKGz6IqpIbQb849eVMr5jNTd2zquCZd60QQ/hdhGsIBc8Fu3u3mBB92gWIVBeWH9vMXocU1Rd9l
	exXDNL990yHWAJwkcuC07RH26f76PH0NQ+L2Z2b8ThC8rzk7Du5tXQxCZCNKDNRSKceXVomiyDisL
	uTkI7JLfhuJbjAy27EFT8R/wB5Mavf6xqU4n1/dd4KtHVmbjOopSow4OKdGig2095+ChCBkD8dSoX
	8dTko0SCRS8XUIetYrHRMoUlWQngradcsavj4ZuRv6CVQsBjwK4deqKNoWm24iaPyCPuWrM8sIEeh
	MrQS9WQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpfCU-003fj5-C9; Tue, 23 Nov 2021 23:27:46 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpfCN-003ff4-Vp
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 23:27:41 +0000
Received: by mail-io1-xd2b.google.com with SMTP id k21so803841ioh.4
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 15:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
 b=280Bz0k0OYWwkdgLxOgZ/yknvlsY35nBXX/FIA0GJh2OzyEIkxt5dpnuKGk0CYLcq5
 TCs4l/IGtMPPRvIkfh7gH/pGmvzlVs6NvyJ6w0hdoNhSV+OrMcIQ3v/8q1lQ5kw8U6Jo
 YJdu23zpP/HXsN9JN5PLPhkmOp7O5i/Dl5tvuU2dAtz3FXIdr84ljg79VUvjuJ9xMmSB
 G3mOJRwlnaX+CHGjYsLwiXdPsGNQDhV56Wx0xvgeY537pwm+O7xdFZ5lNODLLwNyTH6s
 54nHv7m6oEMU/8qeYijxiOpI/ELZH/jkBgHWIgtbAND6MJO1j/yuAGZFGzgb+3joCKwm
 Z4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QK7s8+9xG61FVO2zA5Bp0/YiBESGtxu2Fq+d76cy958=;
 b=5DivxznikwAD9slY0g9nREDU94oDn2efThXU1vQsjWtZuH/oZivouK72OybUOezWfi
 9zapBd4OG9YDzhjChtYIVz8s5Ef/cr9n4Ap3gRqLihWc0mL1PkwLji5sVkaskGwy1WH/
 MRd+lWx25lQEnU5CjIUqHeqDqW5NBRc4xAZNtx102BwW+9hxyxgR1USTy/NTT04oOYQS
 lQR0hcK67bhDu+e00dpwKvzXokuUJphi0bzW1JItDiDim1ytVsYlbkA5XFVsixuKmJOn
 FxZI+3kytFm6drA8n16j5MCxxkRsSHLfcVffPpKBn2HD0Ra0l8qCpsKQ0FwWrWVAbE6J
 a3fA==
X-Gm-Message-State: AOAM531JMQc9U545SIgEln6Rht8TGVlh1d2oQhKdolxwrKDIbtgcCBUK
 /DtD7nqDc+7qU1dfFAHwiLLV7seuctga67VU
X-Google-Smtp-Source: ABdhPJwCLJjwK3aKbSmDRGjmTjIcEDCwjg5vNWeo2TaKak1MQec8VtkkIaTJqJiEgLX5uA6pCl1ncA==
X-Received: by 2002:a05:6602:1604:: with SMTP id
 x4mr10349425iow.84.1637710055352; 
 Tue, 23 Nov 2021 15:27:35 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id s15sm9869112ilu.16.2021.11.23.15.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 15:27:34 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To: "Kenneth R. Crudup" <kenny@panix.com>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
Date: Tue, 23 Nov 2021 16:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_152740_071187_7C26B643 
X-CRM114-Status: GOOD (  19.03  )
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

On 11/23/21 2:05 PM, Kenneth R. Crudup wrote:
> 
> (Please forgive the SPAMmy nature of the To: list; I'm not exactly sure whose
> subsystem this issue belongs to, so please trim as appropriate).
> 
> I've got a Kioxia NVMe SSD on my Dell XPS-7390 2-in-1 running an i7-1065G7 CPU
> with 32GB RAM.  If you need more info (and I suspect so), please let me know.
> 
> I'm sorry I don't have a better description of the problem, but I run Linus'
> master branch (and sometimes I weed out problems like this). I'm current as of
> his commit 1360572566 (the 5.16-rc2 tag).
> 
> For about two weeks now every now and then my block/NVMe/...? subsystem comes to
> a total halt on writes, and I get a system that can no longer issue writes
> (reads/pageins still seem to work) until I reboot. SysRq-S/U/B still leaves a
> dirty ext4 filesystem requring recovery on reboot.
> 
> It happens at random- twice today as a matter of fact- and there doesn't seem to
> be any particular action that causes it:

It looks like some missed accounting. You can just disable wbt for now, would
be a useful data point to see if that fixes it. Just do:

echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

and that will disable writeback throttling on that device.

I'll take a look at this, but most likely not until start next week...

-- 
Jens Axboe


