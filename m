Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D17C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=; b=CKWYhqRQu6THCduB+Z7wYJjg7R
	77X6jLlD/LDVPQzZipsJ8YyCqA2DCAEqZg9SRJyzlJegIeZKXEu1QNo8/ifznkNMOOwuBz6SmH++c
	SJqAYp7+qs5OzpMSs/WBwSTBehZDvIFZxI/HvP1bBaqi2OL3Q8SvSzeeSGoAHIjtsfhHqLEtBU3li
	asjS7B9744Xs+ucCnSqugiMEjDYi0ENp6NDG0l7AlL0CMi0bepd0tT6SxMdx/ZCDm2o+chC45ysGW
	2NzSEZIlUzMUIK2JNvk121YYtlObNi/WMBu1WZao6H56y+2bVDRHdi73Onokum7KMzbsKmVXnL1kB
	Hu0Fq0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts00l-00000005snC-1pGc;
	Tue, 11 Mar 2025 13:51:11 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trzz6-00000005sbA-1gsr
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 13:49:30 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-85b515e4521so68272939f.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Mar 2025 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741700967; x=1742305767; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=IC4Akn1USGGMIKUHjFqt20PBHjmYHG4CbBsWE8OzuxCl4sIX/9BJfNy5HIfbedhJDY
         eRCxpac85kHI9OHdLD2K45nqTz3bSRc98gAsPaMOjfg2JsFFY/+tYEaxwbfvCE/xbAmF
         m+AQz+zsZbVjSGI74mzQN0OdgNJeuqDjAQmEgE9O9mQ6Pk1cwHL0rPV5uJh3ORc035pD
         7UjYhKSdmMcZCr84dwotzbXa+lzATcale7JTc+m+qKRNe8WpGMCK/PaAIY2pHRE0eB7I
         HT8T5pCDaNDS38+acdGWZ+35dVNA5dRxe0+Q2YDK6+EMwc0AEbHv7Dr7Rcz6hjcRwEoS
         Ex9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700967; x=1742305767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=QokrtFQRq6o2DM5sjDOaNPiQIA0mLotmq9Bw5obGnttwBor7bOmIZCQKSmYuMsCiVJ
         L1qAFAA8ZIGQSwMFCNwOk+nrdYMJ6QC6GgzkpfWxcnh2wGMHnsBLiwklmJVQMyVCsJiP
         RWts6kdSkJz35ObAGCQThi6oiRkRz7wOZoo7H1GJjS9QwctLIBUklhW15GU8PdAyFPbB
         9FNWRUwy5A/OIKCT1fLiauVj+0RzLs0AF2SCxAzaxGLo41w4GAMhrl9c+DRpPaRIcDJL
         z9uhvoX77Z7cFHU8Tjh0j48NhVVC+x4Ll452macfON8adDo8T1tU5iYtckjv9Fw0sdDA
         SSmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPK4QNYcDTY4r50c5vEuzb4cnic0qZHL4/Z96G6OrYwvw3X89Jt2dA9U5Tv4LFqp2Hg2PjtMlQHB36@lists.infradead.org
X-Gm-Message-State: AOJu0YwIEAml2GY1HTm3KARejXWrr7fStF+Mq5arMeMdez1cXotE2Dhd
	8Pt7v3MDM061uicpM/+2wsTmUhGPj5124L9fEcoumFIHGWualHL+aXBq8RbU5jc=
X-Gm-Gg: ASbGncsy/91QokA48ORGJR+xlOjcLI0Cikr1Gb6ChGVhPVLbYX3w19xcsA5FR8AWhXN
	J98+h41f4PRHZuJ3MJTPWF/nwo0yCw0kyg2pXYRZwER8RvAXmv1dBL3YtSYwRqcR3MshYTEP78G
	qYsmNAbpcTNkBaOIC8ixTsH2MuQOtwbB0HC4EZO1Ah6IPMxSygmCQ1yFSS6IpeoXk0TvNkKtdgh
	ZPSwvHJY79cPqwV4wRex4ta/WmJ80GP54onlOkuZ9x3e9b2bzpc7xXNGUn/pZ5p8V5H+cZy1ZLW
	jqDVr5Z3/neQo+vWvP3XjHpCAOUHPDaPljFfc3Rx
X-Google-Smtp-Source: AGHT+IF9VOkMgxNVu1F60lVcFqCfcpKy9OE2LoUEIM37eUdSf+tjRuA17mWqs6+fEo7uJIQmp36ZSA==
X-Received: by 2002:a05:6e02:174b:b0:3d4:2a4e:1272 with SMTP id e9e14a558f8ab-3d441a46c62mr203305475ab.19.1741700967289;
        Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2221c1d6dsm1925186173.95.2025.03.11.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:49:26 -0700 (PDT)
Message-ID: <3369329c-13ac-4b18-9923-1a24e1243035@kernel.dk>
Date: Tue, 11 Mar 2025 07:49:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_064928_448702_670F4949 
X-CRM114-Status: GOOD (  12.58  )
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

On 3/11/25 4:43 AM, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> This series addresses the test case failure. The first patch covers the
> passthrough requests, and the second patch covers the non-passthrough
> requests.

Looks good to me, and better than the quick fix-up for the problem.
Thanks for taking the time to do it right!

-- 
Jens Axboe


