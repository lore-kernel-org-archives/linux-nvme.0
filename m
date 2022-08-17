Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756DFC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVMCiEk+A4c+kqJFw5Jb0nwzc/UspXelbSIOACaw1vs=; b=Ihk6iFNlCFNIcE6z/e/8moroXX
	PchliT78/79rYUwrO8PfZ2ZcV28BWFXezjELTgcLazmaALHpDvjmzwEMK6GUqUWaw5H2Ng6aGBr4c
	5yelxx70I8/Tq1+N+EfVNHPXU3aZsT96bCvrOp/1xnunRVhmGah8+prH7XT7F9VeRKlAndMpwOoAH
	EQdfJpwvoy9FfC6ifcet4zmcTwzsVxdSDec6jmSdBFsfj4UpfCa/mBPq1AqyWE7IlWELT/VewM7VH
	rRTxzuPbwYM9I+kll0UwGUBeU67lDLkgzh613NuqfmGwAZymV9HclaCKj6Kb6wS2DTLLVPMTISqwM
	EvqzUv2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOFb2-00HZ1u-2y; Wed, 17 Aug 2022 09:44:20 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOFay-00HZ0V-RN
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 09:44:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so691917wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 02:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=aVMCiEk+A4c+kqJFw5Jb0nwzc/UspXelbSIOACaw1vs=;
        b=pZW/P+uNB+U1IfYzOpTDLAXpf0blYdKxP+9jGOfmP1xIr8052UKfTWdd8R5FsYiuus
         uX5/jRp1PAQ8R0qqUAJkhZiexmAfThPGt1a45bJQvXkzD1McsRodROHTqMg5cNiipWD3
         oZdcRNeTwKdf9pc+UCDFQC4lt0F98T1Sm4ugLcTBWX5pTHgm/urUKeMJKUKEs0NO8m12
         /r+B5lgJE/8gstwns0ZjQGTvKm9bd6dI2qWYGqTBf7EuzV5pJkdU97uOJ4dHy7KMY547
         o54rAKrDES44/5+Ou2p18bxQqK9CVoxB1A83AJSIL+pLYFA29d1KnphOYaFMgj7Hb93g
         bKQQ==
X-Gm-Message-State: ACgBeo1nUGv4CRsooPUh29eVQXmLOrqPk0tXoYDTnxo8AVQK4iCYelZz
	Wka3IKvEwnza7Gf3keVgOYs=
X-Google-Smtp-Source: AA6agR74ePA+XDQzrtfqZzQO/yTSw7tCdII0WQN48k8WZBTN3DqWK7+fhFhWvr+djBI9CoPJiFfFVg==
X-Received: by 2002:a05:600c:b57:b0:3a5:3c06:f287 with SMTP id k23-20020a05600c0b5700b003a53c06f287mr1522776wmr.148.1660729454251;
        Wed, 17 Aug 2022 02:44:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b0021e519eba9bsm11893995wrv.42.2022.08.17.02.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 02:44:11 -0700 (PDT)
Message-ID: <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
Date: Wed, 17 Aug 2022 12:44:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_024416_934969_698B600B 
X-CRM114-Status: GOOD (  16.95  )
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


>> Therefore, I have two questions: am I right about thinking that the pages
>> mapped in nvmet_tcp_map_pdu_iovec() are allocated with GFP_KERNEL?
> 
> I think you are correct.

It is correct. It is the same model for the linux scsi target, sunrpc
etc.

>> If so, can anyone with more knowledge than mine please say if my changes make
>> any sense?
> 
> I think it does make sense. I like the code simplification, though this use
> was't really paying the kmap penalty since, as you mentioned, this is never
> highmem.

Yes, its the same code-path. Would be great if we still had an
abstraction that would do the right thing regardless of highmem or
not like kmap provides though.

> You should also remove the cmd's 'nr_mapped' field while you're at it,
> otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().

Not remove nr_mapped because we use it to know the iovec entries, but
we can just remove the WARN statement.

