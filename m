Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8DC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 20:24:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE1C2342E
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 20:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OX/GNRqj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sRYVSUQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE1C2342E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=blwuVyNJwQYK2rb1HxHPoztYhuq66/rUBE2MInQvuuI=; b=OX/GNRqjXB4zVv
	IUPba0fvfKbxhKnSLi6LuNrhSNmuhWR5/2a98iR4KArCNkAA6PkdUyqb0YdbaY+YOz7bHfO8/MGgU
	KUO/VS+uiotS9VXD8YaXNMMkYTTAzRHBg2r1sx20wSSQhiKwY+GPsaa0o6cAmRdmCd2JXCHJo6fBb
	DyQi9++JcWSQZfNskdG4g+axkpHb3VpwGgWQPeJgISXlj2VdTTith472s1B+Itn9LIPjd6PBKagHH
	8y0JN8+pZ6E4YjOAMlJjhMVYJDHloWMjIcu9LOoml6rBalEHfGQr3IfqqnB9JP/Ikuwy8uLaYxN7K
	dEpaP4BhwcUtTBNwrtcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3nRW-0007Qt-Cg; Fri, 30 Aug 2019 20:24:22 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3nRS-0007QJ-Hg
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 20:24:20 +0000
Received: by mail-pg1-x530.google.com with SMTP id x15so4072625pgg.8
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=in9aWTB7prkon6YbFcL4nw4lBCBNNJ1R4OpyxT059Tg=;
 b=sRYVSUQNEyVt8SsHijofFXAWcmVjc6Z0PUueL4EwXqcVgDUpRuRKcYAR8360pWemoa
 ecZDXnkevFnxO38QXV5hd1sJmL4bG7G6FHyaCjuaSmGuILo1+agWnD8HCwlxNfuPDCWq
 wBt1yFDJtZxDSGgkXsy3bxRSW2SNLraiIZu2m2KcSAFFZ/pUuDp36SeIAcf9dgnf2oUh
 8Ki524trPKcQD8fBXyhrWKZnFgrxBZq2aCntCcBE7USmwQT9MNHMqoBrjxaqQhzPlflA
 68mms7BTV+L8fV+ttMlJW+EI8oRT8KR+60BdJJdySTeAr2DbqKFc8crxi/aq8+t3I0Nd
 dBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=in9aWTB7prkon6YbFcL4nw4lBCBNNJ1R4OpyxT059Tg=;
 b=aB6reX2tN5NR37YuUyKIGdcgvZyU5ZQfrXxsWG15K5RNuNHtN2w4Xtwo21jhkJuhJf
 KDR3LrpC9cF6NCr0L65hvS5LWzsHpYGT2JHbM4iRhe5yB6B4fA2NkZFkpAMgruU9tTBk
 H2gJIJERMdGdRfZ1P7si3v+LSlOGb7shkH2v24DPUgtuaMGcScBTi0+d4BM6CopPrT+u
 J6O/zPEqJelXJtMFytOjZ1LbKWW+8XJ7m3HkPZoUj6Yz/LitAjyL33QBOsRM2XH4biXd
 EmMqmnxb8kfi7P7i80PoBAtkhK33PpulFbXuNHCy4DZ8O5Xasgh+kSzoCkhmPYTKt2sg
 Kxvg==
X-Gm-Message-State: APjAAAVUn0xPh/CtgH64ZJvVYebuwXJ7KVbsxWI7ZRNY7BcLraeEgKqh
 ExmqQdrGXFmcRjirqHUdF67KNrlMyV3Pqg==
X-Google-Smtp-Source: APXvYqzciNSXJWmRwZzrAE3OgHHgoI6Orlwn1U1aHca9OArrgV/hn7ggrcOwravrIcEp0CIJ0zP6HA==
X-Received: by 2002:a62:3644:: with SMTP id d65mr20455732pfa.128.1567196657028; 
 Fri, 30 Aug 2019 13:24:17 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
 by smtp.gmail.com with ESMTPSA id a16sm9158334pfo.33.2019.08.30.13.24.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 13:24:16 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.4
To: Sagi Grimberg <sagi@grimberg.me>
References: <20190830190124.11961-1-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <53701429-a0f9-ed67-4cde-d402da2814ba@kernel.dk>
Date: Fri, 30 Aug 2019 14:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830190124.11961-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_132418_648869_F7F786BE 
X-CRM114-Status: GOOD (  17.22  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/30/19 1:01 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> First pull request for 5.4. Note that we do have some more patchsets
> in the pipe, but we'll have them settle first in the nvme tree.
> 
> Also, note that there will be a merge conflict with 5.3-rc fixes on
> the nvme quirk enumeration from the Apple work-around patches from Ben
> and the LiteON quirk cb32de1b7e25 ("nvme: Add quirk for LiteON CL1 devices
> running FW 22301111"). The fix pretty trivial, as the quirks enums simply
> need to increment.
> 
> I have the fixed series in a branch:
> 
>    git://git.infradead.org/nvme.git nvme-resolve-5.4-conflict
> 
> The nvme updates include:
> - ana log parse fix from Anton
> - nvme quirks support for Apple devices from Ben
> - fix missing bio completion tracing for multipath stack devices from Hannes and
>    Mikhail
> - IP TOS settings for nvme rdma and tcp transports from Israel
> - rq_dma_dir cleanups from Israel
> - tracing for Get LBA Status command from Minwoo
> - Some nvme-tcp cleanups from Minwoo, Potnuri and Myself
> - Some consolidation between the fabrics transports for handling the CAP
>    register
> - reset race with ns scanning fix for fabrics (move fabrics commands to
>    a dedicated request queue with a different lifetime from the admin
>    request queue).

Pulled, thanks Sagi.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
