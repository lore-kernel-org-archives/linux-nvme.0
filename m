Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDAC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA5A206BE
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgXQP63p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DTpxaxoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA5A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=adlA7NyhFrPk1mMLu03hqjJSZeGFEmMTThtQpZjj578=; b=YgXQP63pMMQxYjzDhLYwx/Xxz
	G5ywv3xvA3DnGxsuhqpeNGAMQtyBcauQWD3ozDejEQRJkjodzmaZxxPf0mQ0kPeg64AhO5lCNgxIM
	bLOa7RKn++wOwIZDqj05UOAUSejhdJ73xnvFLegyGtsqvKIPPTyPvZQMI9ysZAW9InEDnqlpoPVXh
	UqvISyUxGsTNgJ3t4AoX011FiWHcWDvqr6V5fDbLmepczTtjJBURYFUdA/HvZSKiXVxlcVx2pIQtc
	hmtZ8eB30Z98MEuSChkwDFtrWSpm9O7lfaxA8vLVj8DgxRteD7nn1XUwZnJbkHCj8ADCHaEZd6ORg
	+69QnrJ/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGqw-0007Qd-7o; Tue, 30 Jun 2020 14:03:14 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGir-0003CQ-Rf
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 13:54:55 +0000
Received: by mail-pj1-x1041.google.com with SMTP id cm21so189692pjb.3
 for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2020 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
 b=DTpxaxoBrlqgFtIm8yAQMb341OyK/ndjEYjXK9tGbhGBwisW4MOxBHZ4AF4FDA/02m
 FE1IEvNVNRcPVI4EfkzNjyzKc28vzwvcAXCPa48q88z6AfYJyEqtZavoB08GtaqwIFmZ
 5msOaC6bHwT4f6NJcL2N48MYAird2/Xlj5iei4yfkZKl2Jgrru0q2OyYJkjRAMbDQ2kB
 VDXDrxP8KF6sFSMpn3AGotfAimtzX2YLcVXjs0JutM1wEqD7nRFwq0bLMjlwHPYp5odZ
 e+66w2vtmERdrhz2mTHMd0mWQ0ZRTEcZzcd3acmnQYyNunRekXJ4MMVmPw5lJJ2ybCJv
 oP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
 b=YOsP4uGao2zLZ30JSd0qZexyk58GdC+pi83AM5ZqbkH3pUFg9qdnEmvlonDD9NF1j3
 lLzIZdEEdFo8EyGkRJqW/FLiy6UwteDltQ6b+OVQkY1YJ2IH1Hn9OpcjlpuNPg9nHhli
 oda6JqM1GCvFydBneQPE6nBdBErvHlBCLdMG7cbx77D100hmLIEJKxWls3udqPhxqOBe
 AvFnDk6r54T0H6GNhYrgqh9AlbxtjcjMfDbylzew3oSNEEdnABDRfXOPp3NAFl8q2SD7
 QTqIsBlg7dg07P6eNaG81ruUri80nH6RHM5ghzPoW8knhFbgiSUrtChF70mC8QtddruG
 cPig==
X-Gm-Message-State: AOAM530HVKeidRP45qWKwBGZ+iDZbKGqqyq5C0PgIx1apdgsaruh5mpH
 a/cp81VFGlptZjpp11GiNqdCoQ==
X-Google-Smtp-Source: ABdhPJyz40Dk+a8U1c/CjzUO1QAZkxXoTvB1Z5x2Pa5jkubAyLo6SdeOcTzcPuLBVyj9atcxDTr0Bg==
X-Received: by 2002:a17:902:ff0c:: with SMTP id
 f12mr18122209plj.254.1593525289171; 
 Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b?
 ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
 by smtp.gmail.com with ESMTPSA id l12sm2722675pff.212.2020.06.30.06.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 06:54:48 -0700 (PDT)
Subject: Re: [PATCH 11/20] fs: remove a weird comment in submit_bh_wbc
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-12-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <70e8de25-4e26-9c00-1492-e433ebfdbc90@kernel.dk>
Date: Tue, 30 Jun 2020 07:54:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-12-hch@lst.de>
Content-Language: en-US
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> All bios can get remapped if submitted to partitions.  No need to
> comment on that.

I'm pretty sure that comment is from me, dating back to when the bio
code was introduced in 2001. The point wasn't the remapping, just
that from here on down the IO was purely bio based, not buffer_heads.
Anyway, totally agree that it should just die, it's not that
interesting or useful anymore.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
