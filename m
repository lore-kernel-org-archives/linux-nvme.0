Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B165C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ndd7w08DJfKf6jnDYi/L8YoxxT3mLVwsG83pvOZOq9Y=; b=CwMLWRoecdW6KscBlnc+hs/cEx
	LgEXSV7hCQ9dhGomn0KmBgqU/JejMqj7NJPYZDRkcJI8oBzDzNUR8cPonzSOOp5MNi93ja1Gfxr+O
	K+7ida00gRtHVDYXeePY42T6sr8/lX85xtpfTajLmV4U8F7wLI5df7R/1dNzfHMv7I0MY/rJmgnc9
	ibvBH4TiN084fSKlYB/rag81caXgLkRn49LQkaj00ui33ldX5pQadiI+XGfoFnGlWOvT0ddl/8ung
	BE3H//ripIkydaCATzBaVUqcCMVyObN8xvNE/7Fu9nTZakHkXOv86fLCBEh39JpUnqpgrhNgb/Vns
	OmZOTHBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNY2-00000005Ek9-462u;
	Wed, 26 Feb 2025 19:58:26 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNY0-00000005Eik-01my
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 19:58:25 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3d2af701446so1840625ab.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740599903; x=1741204703; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndd7w08DJfKf6jnDYi/L8YoxxT3mLVwsG83pvOZOq9Y=;
        b=2JLjokAk6Yccx4gWO2yB3C/Hl+oFsWBPXFe9VXryua3HYF4PWLnPEqfOHlol2szYg5
         54ntSDVeiZdiT9efWHtSAliyndIx70wWQnEex0igaRSEvJ/cBRudfGZwRt8XtFGiAFta
         cS2Ho2QWl3+heiHwJXv92g81NIhwXsiCU8x8wBw9LusA27IaYvKa2XsxCgHZwR0O2ruX
         agPNcPytC70FaJ2fklbgHdFS54oWh/7ITloau6eIazad9detATBL1yeIINqy2u7+KbD5
         PZGFT3522rrV2wliIbI31p5KS2awlyF1WobZ1BaxQNvfPN9Q65dUhfAgz5SJIFxLG59m
         r09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599903; x=1741204703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndd7w08DJfKf6jnDYi/L8YoxxT3mLVwsG83pvOZOq9Y=;
        b=KGMYQdgp90+zlpB/u2pKtqbBLaXzpnwg4FOqtJR8PJCHyf6F2eEEBCaDZMHspNy0yl
         XxPvyc6lUBFXigFPbXQxl06qFLgj+jgekoYd4jMixitlSohSXBQnGsha3ux9GmOzSSH4
         SlgyDxiEX8QgOh0y21kpdrVD9GT1U6Gzjo+JzW8W8UZ8s0ACXwT7YzFjLnmEKZh9n5cv
         LwPCWMw5nhCE/5HDivTpYwFSqlXivUM56KEN/FM3nBLYbwmUX5XwlnHI64AUC6+k96eO
         06Nv4ivzBc5RuX4DNpSyflWdDmz9mPbwby4IIgcDIWJVTMf5VT+xemHeJ32yqyw8bryX
         xjjg==
X-Forwarded-Encrypted: i=1; AJvYcCUkxtIQRqBj2TmwvmEFwGOn2eydVzVRwvW/1dngG9cVeXKUkSxU4ENjaRoZKAoIGLvUmi7D/vY3lR1u@lists.infradead.org
X-Gm-Message-State: AOJu0YyFaH++bkrxlp1XT1gLZL8oJcltrkpFon/nLDNZlzrobIF4N8ZQ
	k6hvjkRePoXFPdukAp2kcrcXSDsZQ9it+hrgY8m1YE3QoPyzhdZ+jOlUuLZ+p+o=
X-Gm-Gg: ASbGnct0mrpJMVLIgvIaACLHHW2ksObA5Ll8Ut8mo2c4a2n9tD/wxhl0GQkotFSxEGy
	oHpD3jBBgxcTJH41lZDJHVrtLF02xRPk/VH0Ai1K/0EDLlXD2dvFmROxQXuNIRIqxb0cDhk3yLH
	Nu115KhtSRJZAxhv4NXBDdH0XrwaZFYd2cSOfolS8QQ2VJCyUSmYR1NasmKcqgKSwtme3yNW8LQ
	8eoEOEQrPqvY+fUU4NnyVYHdpKuf05nsRbgO1Uaag2feswkYrhBqPN58bqQzX9IXskUDZ19Cl8h
	SwFGyOAAXQV/tb2P5JF1jg==
X-Google-Smtp-Source: AGHT+IGnsC039ohXWBjqBuO4K8YxxWd3QQUk7/Zi2UK4xWUHzax4sA2PzQVHkm4u4n7MbFbgw+t0qw==
X-Received: by 2002:a05:6e02:160f:b0:3d2:a637:d622 with SMTP id e9e14a558f8ab-3d3d1f4f176mr59581675ab.12.1740599903028;
        Wed, 26 Feb 2025 11:58:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361ca3590sm9477085ab.45.2025.02.26.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:58:22 -0800 (PST)
Message-ID: <5f46cba6-0a11-457f-8591-732f709e7fea@kernel.dk>
Date: Wed, 26 Feb 2025 12:58:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
 <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
 <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Content-Language: en-US
In-Reply-To: <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_115824_051693_86339C3F 
X-CRM114-Status: UNSURE (   8.18  )
X-CRM114-Notice: Please train this message.
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

On 2/26/25 12:43 PM, Jens Axboe wrote:
> Ignore this one, that was bogus. Trying to understand a crash in here.

Just to wrap this up, it's the combining of table and cache that's the
issue. The table can get torn down and freed while nodes are still
alive - which is fine, but not with this change, as there's then no
way to sanely put the cached entry.

-- 
Jens Axboe


