Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7FC4363A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 13:30:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D76208E4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3ugxzI2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VCC09/Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D76208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9rKN4maVZa/IHFOEiYzfwlqWFu9CINgDzqNTtrUYGWk=; b=f3ugxzI2pAtxPaoYdidPTi6Ig
	jm8ZkMR31xO14Zi55rPtHcGnPcFSafp8h6xIfhEoFY9AS8EklTpz2I/ny4w9snUt4pyrguAP3TuK7
	JOElc7f2bHt3CGTr0O7OmgCcI/rk5I+t+ERHTZmAp3GdpYy8bAAbXnvPjmt28qnweAsAIesJB3Mze
	h/kRayBMkw44ad5lECEGQxor+F3/4P7jSquoOb+tBvqNQG7OeQ9cFovHM4MuNR36yZrEgrcKLjVQ2
	L6zkopcUPSPaoTIDJKIcobjXs9Wrth9IJWYbHdiBmk2lpfr46AzwExAuY/EXVCpQxzq3EAWvsa6n+
	szZdCaGYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVx8z-0003FR-IG; Fri, 23 Oct 2020 13:30:09 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVx8u-0003CY-2E
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 13:30:07 +0000
Received: by mail-io1-xd36.google.com with SMTP id r9so1767240ioo.7
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wo33AF/eHl++Ndc4RAiFaBKLGpgps3aqCkCP9OF1aaE=;
 b=VCC09/LmkVAnukssUgfSBi9Djclq4e3kv/XMUshDAlsoQ69J8XkKZAX9jI2WNNlMUW
 dwL/b/GwFHJUnhzQZXDig70fEoCpibkUN395N61QZIfEtV5XwQeFrzDcaFJCDa6fh2OR
 /3k/Wd8/hjBunCvL2tzHWybkz/xNPxSa5PrF55R1t0F1UAsU8PN3OVPSh3EwtoS8z52o
 ip6cLFED0Gu/vo6ENfa8cyDwdSCXhqZ5lGQk2+NZJjUK7YHoXBm1+KlW+xo14QasyTO+
 eSWHnEGC1uOqIw7+TIWBmGi8MR73CRoREgSIw88/jT49jS6bO/ZwHwM/ivu3UCWroYdZ
 4WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wo33AF/eHl++Ndc4RAiFaBKLGpgps3aqCkCP9OF1aaE=;
 b=pQ2Ox0tYY/K9axSSWSzem21OPGr8S5/ZOGr5WaAH76ZHfo/w7orX7oMeGN5SwMyIjp
 M9HwRPYwmH3WcoDQ6uyFKZEQVIeFJFjL+gbrEaucNzsTkHgY1bxLx/iNKl6sTXH0UWkG
 Ohc3iSbFj8h2KqjUYYqmhBk9rnyx+Kmivoe/uyRmr/3tNqDMjCPSY/kCIOM80m2S/K2y
 dUROfjen57+RiWuXNOiWxYk6TwaReH85lK3hmX3VziCTxrFhha2q+8ji7g3sGE8ZHNX8
 q7ph2femKoW6wD5M0lKktDFcuJ6ejmyPhh+vx33lhmilQoSYJx/ppwEZmXx0ZqOqZJNf
 63bA==
X-Gm-Message-State: AOAM532pCqRcH6j/IbsJs9phw+xCs4QMApCgyLEiyo/8+3wyRM8jTq+8
 2JqF5JD3dbb5/lk2/T+uawMh5KK3kqn71g==
X-Google-Smtp-Source: ABdhPJzi8cVQHujhSxpuIjUe0YPPRanj0p5gTW6m5d+T4mscJHJ1ed6v9ixcli+/EXwS+SxKKuPc3A==
X-Received: by 2002:a6b:fd08:: with SMTP id c8mr1580771ioi.16.1603459801254;
 Fri, 23 Oct 2020 06:30:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id o13sm781343iop.46.2020.10.23.06.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 06:30:00 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.10-rc1
To: Christoph Hellwig <hch@infradead.org>
References: <20201023110035.GA3504312@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e3120d9-7c08-1aba-1481-118131a459b0@kernel.dk>
Date: Fri, 23 Oct 2020 07:30:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023110035.GA3504312@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_093004_251512_38F2B89C 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/23/20 5:00 AM, Christoph Hellwig wrote:
> The following changes since commit cb3a92da231bcf55c243d00fa619ee36281b0001:
> 
>   block: remove unused members for io_context (2020-10-20 07:10:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-23

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
