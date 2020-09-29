Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD8C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 19:07:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCFB20774
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 19:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HjHdNDdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCFB20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yupOVHa2HHjHsONfX2IZl7v43JGRIR5iy2f5hbYsopk=; b=HjHdNDdbU8F09JIu80OcvOOnR
	jAzZiGCMf1orWm2bGmuGpmNpsdsfliDBcAD8QNUUlxHqtA3PIJQ09qmJcym6yRywwJThMKw/43O3w
	YT6eExU5+6eWFeGnb6xhFl4QS1TRC333brlrwrjIvMiBXlu5SOXVRXqO4cOfVOEhyR65lme+p26Ie
	P7FDSsJd8CLOmTXw2i5YGi7nDonbMb/8p8wjFnxRPQR2l6gdCAISViV1/Vt2b67w1yLG2NoFZzIYd
	nz/wn99q4+ocqKVYHZTE8vyJQyx5kiRHDacbhI34w8x4K6lSdjWkuoLe1eA5wAT46ZlEhEe5kGJ1h
	M5+vjXxKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKy3-0002NW-Kn; Tue, 29 Sep 2020 19:07:15 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKy1-0002Mu-ID
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 19:07:14 +0000
Received: by mail-pj1-f68.google.com with SMTP id u3so3179238pjr.3
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 12:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YMRpc0jNxekchtEnSmHR/fkqfa0ynBV4JISA9pUasjg=;
 b=jSwZHlAzQ6sHj2b+iXEOP/aEnz5qHWiV9Yo095QFfl9rAqkau5e7lIfRxbouHg5pdy
 gy54yTZ6LOeLHQQzxcWTiGnYre+59P3Ht2WZZszjG7NkqxYWHXO851gfklIouZFrgJXt
 9Qd3fCF4jUFPix1K2bBZZuSxoOrUYAJZjcYki5zYoCprWNwGE4bZnzX8SSmXhIXGEXtY
 NbAVSAxr5BJ22EPrrr1M1swavd4fDRpUobNbmPkyvIYrf80fi1h0TtdzKHef/RyFj1GU
 wOcMOiS466ngv+yaUeGj+tMAN45o0OVQnTS50Cm6TnrsZznf0+wESCNUhbzqf9QrUwP/
 Vsfw==
X-Gm-Message-State: AOAM533Kn6UTMAePk4pc6GEP/JNhjCJbBrvD3BXSeh/xE0RiZNmNbu7l
 Ck+h1IgCWdnub4EfVAv41H0bDN8I1QA=
X-Google-Smtp-Source: ABdhPJwUEr7dzXttkl5A36ctBECO8PSeUvcyYPED7GLybFlyDLG4DmeXG38h2kWf8oyJ9E/+H92A8g==
X-Received: by 2002:a17:90b:80a:: with SMTP id
 bk10mr5096775pjb.53.1601406432545; 
 Tue, 29 Sep 2020 12:07:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id q193sm6333624pfq.127.2020.09.29.12.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 12:07:11 -0700 (PDT)
Subject: Re: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
To: Christoph Hellwig <hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-11-hch@lst.de>
 <39b98188-2803-2f49-e225-8d3fbe3bfb1f@grimberg.me>
 <20200929183214.GD12948@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e6c5bbb7-ea1a-b449-541d-2c8317ed462d@grimberg.me>
Date: Tue, 29 Sep 2020 12:07:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929183214.GD12948@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_150713_610571_DF699DB6 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Ensure that there can't be any I/O in flight went we change the disk
>>> geometry in nvme_update_ns_info, most notable the LBA size by lifting
>>> the queue free from nvme_update_disk_info into the caller
>>
>> The queue is frozen on the queue logical block size, why should
>> we care about I/O while ns->lba_shift?
> 
> Because we use it for all kinds of calculations in the I/O path.  By
> moving all assignments into the frozen queue critical sections we
> avoid all possibly inconsistencies.

I'd think that it would be better to never use ns->lba_shift but rather
the request queue block size and keep the queue freeze span only
that mutation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
