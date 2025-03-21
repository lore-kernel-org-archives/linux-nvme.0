Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1305C3600C
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98i6jddSp1LUQoUVE86JTvhDACCODQSOsoi4JvJF9ns=; b=vACP/FLKaycD2htEvw1UnDxWqL
	6I2dZoHaOheS1hge2slf1NccmGVp+AbHgTVYgVEGARDpYNpnfkGIUjctx/lHY0ifJpIl6oSmC7Snj
	wF1C4isTsCVWTOkpd3H0ijW9UPUFImSePfqzEXINtQB8vtOAJDLu+GfAnxkBJcGeeVN801mxd8pYa
	xpEQPZSMrzwiqWHTTrNorLBQjzeJKf7ZdU/ZQPO8LB5IYlP4JHfnRdotuKeaYQ/dg6gYi8TctFd2e
	qJIREdH/48VutJFcsI71xPAxxONSaPPYwfE4ZmAEspQ29eNAEZfW13eRoluf0ppaZ4+Jiw6y7w+mT
	l+6IwpzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvizA-0000000GAPw-0Og3;
	Fri, 21 Mar 2025 20:28:56 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tviuH-0000000G9iL-2umR
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 20:23:54 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso520599166b.3
        for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742588631; x=1743193431; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98i6jddSp1LUQoUVE86JTvhDACCODQSOsoi4JvJF9ns=;
        b=EzSk+Q9ifJ8WLqh2/S3DJ5pH5CmDeOH+01ba//3j86rgLVKNewGCyGz9UD8B7ovK3q
         1UB8gjNPMaEqGMHjTD6DAL/Hm2Ko5p6tBN4fG0LZfiVTYLhoPQoa/RCTLxfneSI30BT4
         BgibvLdpEXKGvzEbMCQZdBb3n/yu/9/jkl8YbI4sCWWyjoZX4RkxjzX9qFf7DxIF/vIC
         3oayaKY1urQCnoNX5DjUJxwWwMWSR1Y8oIBEaSQw/L986GsDtC3N7ZABgjoxE5TOAZT/
         qGeFYZD1NWw9NHipgXk1v9xih9oaCrnPHETF2Z50t/VPEEr7eEgJe1Jg2Pfrzkxsm1Ap
         Cknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742588631; x=1743193431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98i6jddSp1LUQoUVE86JTvhDACCODQSOsoi4JvJF9ns=;
        b=dJliUNUEJtTSdKDHH3R4SrTXcZyD0qgLgdvxU1osoP3NTZwebiZWRsYOrKThMAlx7w
         DDebfC0eJ+jLvs6/fsqOCTQlEgER/dQ8DQ5sV8RPmuH1Qo4n6CTLriS5wD2hK9vDElb4
         Aq8bZInWdr1S0uV+qny4muQ1hb7UV31dBCy6xSef+PEB1oYI/c+bw/0/MK6s3d47JQ39
         4yfXZTlSd6JzDbbIzSP1MAzEeEZln1Fjwa58SlfV4TfCDcPPKFRarybAgD6NJ48r8xm4
         nXHf7X7z2u0rzVOBJIqc8vauNES8HNtQ0D3IODHMQ3YloByu7I1bqpPmrNVyicslHMl8
         x6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4k8ZVSMniZc7qfJW9uW9BzgLr/SlZxvpZQ0abOfCaY7bvto0hx02x4ajJlcSCLe3lErhUBLmAn/L@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4/JzBeWyzFGOV5orx16m4WkWyUuN6mpH9d9X7EOMrtkjUqhbf
	awXf48aSfAe2m25uxdSZd3PnYr4mJzRCidJkZOUjA+9P10WF6b8u
X-Gm-Gg: ASbGncv/ycjeuBqJKyq5B5LWBPAQuOwU3JM9GUp5SQ35o5DZOTgUzet57yXvWmY/WTN
	qIZ4xO8e4qwIRyiliSKLKufW361uk6JsCRRs2wwD1Lc3Qpz7fvCq8JQUMdEzNwzX9vKPXHyIF7+
	8kjdnbVreRNtgyPfuExF08BbdAlEG8ghmdStEh+3zJ+l23VdPUnGXzIs1C+TlmRWuW3K/wFwzSj
	wqezHi6LVb19cSY91zA4ZmwtfrqWV9vwfTC9f1u2+UNAy+rS6UKseuG9us90FwIPy/gbF1R7GTi
	hHWIhB1bIspw+6asbKx8FHX5MXZB5NnLDFpK9edWfqJjirMRBkex8A==
X-Google-Smtp-Source: AGHT+IHUOzcwaXlpNWBFMCvXm29GsUaXBZabenP63aTlTLUFy9HWP8Is4hA3JffnNo7TVQo1z8BGCw==
X-Received: by 2002:a17:907:3e8b:b0:ac3:d0e4:3a9e with SMTP id a640c23a62f3a-ac3f251f1fbmr460422266b.43.1742588631294;
        Fri, 21 Mar 2025 13:23:51 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.236.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb64b06sm210671766b.94.2025.03.21.13.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:23:50 -0700 (PDT)
Message-ID: <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
Date: Fri, 21 Mar 2025 20:24:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
To: Caleb Sander Mateos <csander@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_132353_754976_0A48CED2 
X-CRM114-Status: GOOD (  19.57  )
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

On 3/21/25 18:48, Caleb Sander Mateos wrote:
> To use ublk zero copy, an application submits a sequence of io_uring
> operations:
> (1) Register a ublk request's buffer into the fixed buffer table
> (2) Use the fixed buffer in some I/O operation
> (3) Unregister the buffer from the fixed buffer table
> 
> The ordering of these operations is critical; if the fixed buffer lookup
> occurs before the register or after the unregister operation, the I/O
> will fail with EFAULT or even corrupt a different ublk request's buffer.
> It is possible to guarantee the correct order by linking the operations,
> but that adds overhead and doesn't allow multiple I/O operations to
> execute in parallel using the same ublk request's buffer. Ideally, the
> application could just submit the register, I/O, and unregister SQEs in
> the desired order without links and io_uring would ensure the ordering.
> This mostly works, leveraging the fact that each io_uring SQE is prepped
> and issued non-blocking in order (barring link, drain, and force-async
> flags). But it requires the fixed buffer lookup to occur during the
> initial non-blocking issue.

In other words, leveraging internal details that is not a part
of the uapi, should never be relied upon by the user and is fragile.
Any drain request or IOSQE_ASYNC and it'll break, or for any reason
why it might be desirable to change the behaviour in the future.

Sorry, but no, we absolutely can't have that, it'll be an absolute
nightmare to maintain as basically every request scheduling decision
now becomes a part of the uapi.

There is an api to order requests, if you want to order them you
either have to use that or do it in user space. In your particular
case you can try to opportunistically issue them without ordering
by making sure the reg buffer slot is not reused in the meantime
and handling request failures.

-- 
Pavel Begunkov


