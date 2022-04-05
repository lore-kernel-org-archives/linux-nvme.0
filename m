Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4055AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SHfmQ1kJdNO2kkSn9puZ+tx3OduiqCzYa9UflCPowkU=; b=pyj69UOjYLB0O/wxpypHzgCOhw
	Gms/AVsca8o+ztYvjRJzUekluLUtmRzX4PQnqYzbyZe4K4BI6sj0zJi4nDJU91Ctc7tPxt0z8WBlJ
	Ri93EkdNnAsn1BX21MUuP9FT9RsVtOmaVQgATjuz80L1JL/XD403hx7pI5IsDWcay0KbYJmo6QaT5
	jR3/JorW2S1mVw0MBufVGtZ1L9n3Y7s6sacl9ZncPaECSyRfz80zAW+pGEB6KbPKUAPkwSueePOSN
	falyNYzmofAGA12Rwj12BDExuvKJyt7lxmVPQCegfy031hNEdaZH1OITCPF5iTCWhEoXBnUudbqOG
	i0ddytAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nblIi-001kRU-R2; Tue, 05 Apr 2022 15:41:00 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nblIb-001kOO-Cc
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 15:40:55 +0000
Received: by mail-io1-xd36.google.com with SMTP id z6so15678646iot.0
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=SHfmQ1kJdNO2kkSn9puZ+tx3OduiqCzYa9UflCPowkU=;
 b=XriHKiEYmgcnCAm/NJv70Z19tG9tVczVNnXbqhGT5cKXfhju3CeMzd8LpZkP/43sNc
 Ns/b+3oCUENC8zbq1WRl5myylvShSEk9A7DhDMoDAlnwhdMk+Gldd2bN7XpGDkJlyBXO
 //ewe4xnJH5aJQUI81sD5cPbZOlgkno/OUE01TV/I8aRuNo56FzA9tWiWNCATg53sQId
 baZVzB3x1f5Jw0wSAalnnWMeGBoZp8Y+Hbmfmf0j9NGQ0CqKKp3juUYeynxnKB9v5Xio
 ZEKhwbmrCZ01iSXNBK0fsWFDnHRLD6rl9NXN2ATkq9SQ6z3o4F/CJ8kIIoROW54QKcdD
 Stlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SHfmQ1kJdNO2kkSn9puZ+tx3OduiqCzYa9UflCPowkU=;
 b=wCsOUOHqjJs9+VXEG02/7DgCafa7FkSgRuqxxMO0BgX4ro/HtkQTCqCzeBXXhlctke
 cRmr4PDXaIy0CWT27zOoQP9W3C944x0ljXPvIHSlu57E7m8KAp/9VEbcp4dJ5na5Ibvn
 NSMJNxHMa3fMKtl5dy7V1cKctgLWV6PblHcV5WxgpjRFKmCEiXDFZnUZvgj5uYHUGoQC
 X4++jXRQoxbiYTFTcfiKEqyziD44yXqvC2NemFb8HZWHti/FuF9iPG9hnT/3ytSZPftW
 MXv7AmCfQtQY9ZaYdby4pYU+wHT1f+oHvRMIljgQz9yRW+znAyPUBstySJyXBBIc5mwa
 npKg==
X-Gm-Message-State: AOAM531bOjSxcxEAELN20uQ0n9iihkeJL+uQNFb4MepeRYCOXnZYGDY4
 aK7GlxOpGSUWsJxHLwKX2vkF9gN0P+dRBw==
X-Google-Smtp-Source: ABdhPJyBLjmYq20oBQVKQx2jlXPdOSgx20dhiha+1hLzhSfFmg59nY5XRVnCOYYDtlNFnwGW18ZkEA==
X-Received: by 2002:a05:6638:2611:b0:323:be52:bb0e with SMTP id
 m17-20020a056638261100b00323be52bb0emr2400345jat.232.1649173251259; 
 Tue, 05 Apr 2022 08:40:51 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a92d18c000000b002ca3ac378e2sm3926799ilz.76.2022.04.05.08.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 08:40:50 -0700 (PDT)
Message-ID: <51171191-943f-b9e4-b78b-674834de00b1@kernel.dk>
Date: Tue, 5 Apr 2022 09:40:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 5/5] nvme: wire-up support for async-passthru on char-device.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
 <20220405060224.GE23698@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220405060224.GE23698@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_084053_688095_F2133E59 
X-CRM114-Status: GOOD (  15.35  )
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

On 4/5/22 12:02 AM, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 07:55:05PM +0530, Kanchan Joshi wrote:
>>> Something like this (untested) patch should help to separate
>>> the much better:
>>
>> It does, thanks. But the only thing is - it would be good to support
>> vectored-passthru too (i.e. NVME_IOCTL_IO64_CMD_VEC) for this path.
>> For the new opcode "NVME_URING_CMD_IO" , either we can change the
>> cmd-structure or flag-based handling so that vectored-io is supported.
>> Or we introduce NVME_URING_CMD_IO_VEC also for that.
>> Which one do you prefer?
> 
> I agree vectored I/O support is useful.
> 
> Do we even need to support the non-vectored case?

I would argue that 99% of the use cases will be non-vectored,
and non-vectored is a lot cheaper to handle for deferrals as
there's no iovec to keep persistent on the io_uring side. So
yes, I'd say we _definitely_ want to have non-vectored be
available and the default thing that applications use unless
they explicitly want more than 1 segment in a request.

-- 
Jens Axboe


