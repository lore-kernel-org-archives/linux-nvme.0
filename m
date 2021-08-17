Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F5C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 17:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77F460FD9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 17:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B77F460FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NlPH7nsOoDcHobSq2c/PkAjk9Uti3GyZXjq03GbsiLI=; b=DfQF3cwNSJUdGbUplhAj1PrIvJ
	alXZw0TiTQZScmmThQnhpClVR6jzFGvnYhTzmthKV4UJifZqNNYwIF1GuOYng5F961grxrXRIRoAk
	VJbIs+D+xeAOsH4u8vdPDvqLdtYbcZQIxZ5Lv44IYZHO5qdCx6fyGPXDAA9zRKYL9dLEyt3okw/zB
	pZ+hU9Hc9gkJFD+ZMu2mONWJ6ipOAT0MOL4U5WzKZYxm2oXSwtz/r4MlUcbTEIGEqOZeFvbuXpvRr
	PLxBTJ0Z+/MtbNRbbAHEHVWsQV2LDwIcm88HvkXGI7KJw2tNnLwE5mgED53xwLaXyL2Zm63GdIRVZ
	tit+TDZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG2fa-0037aS-Hn; Tue, 17 Aug 2021 17:14:34 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG2fX-0037ZS-VI
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 17:14:33 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 qe12-20020a17090b4f8c00b00179321cbae7so7377587pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 10:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v2ezKXtmZ+KjzYhpA8Y6VRyR3KOD/971FoOogNR18Hs=;
 b=oSkO3qGiwnJF7bgiK9Z00Ax0M0BH+rhGtiIPaql4UFRZd+frYIfM4/Uy/6tYRmRYUF
 55xFjbuL3ImpRD4jG5MtnT1YpB0K0PkM70pTNep/0U4TfdMRyppoq8BIkDaVobIvl4h5
 D9/5SJPDzonZUFLDzDgTWI3PF9UH0c5GkY4+peklebstzkVaAVJng0nFzqFaSDZHOa06
 TaJNHMnwDdHkgzgN7vKFOZpPdeTWVgJzC+E5Q5OoyhhtDMyoq291+KTcnkUqoXL/Uz0x
 kcBDHtlqEMG6wdx58Fqap8RXzrtf9vaH4tHJgTo41XIuA73lgquwCQYyfG9JrYQltzw7
 SWeg==
X-Gm-Message-State: AOAM530e8+keNF6xHvSrYVA4PVmqRHDOSy9siBNBE1JkP2O0ZDU5vM9W
 j+fC08l1TMzkrkJ/Hq0WGcg=
X-Google-Smtp-Source: ABdhPJxyRl0ks4xxfdYxuKBl/CqSpHH1tc/kfe77IZhXj/2ic6tgtgAm7bavNRKoa2tEHngKC7nW9Q==
X-Received: by 2002:a17:90a:3b4b:: with SMTP id
 t11mr4532753pjf.182.1629220470271; 
 Tue, 17 Aug 2021 10:14:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:ae3f:1e44:e6d0:4a44])
 by smtp.gmail.com with ESMTPSA id x13sm2822931pjh.30.2021.08.17.10.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Aug 2021 10:14:29 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, kbusch@kernel.org,
 axboe@kernel.dk, damien.lemoal@wdc.com, asml.silence@gmail.com,
 johannes.thumshirn@wdc.com, hch@lst.de, willy@infradead.org, kch@kernel.org,
 martin.petersen@oracle.com, mpatocka@redhat.com, djwong@kernel.org,
 snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
 joshiiitr@gmail.com, nj.shetty@samsung.com, nitheshshetty@gmail.com,
 joshi.k@samsung.com, javier.gonz@samsung.com,
 Mike Snitzer <snitzer@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
Date: Tue, 17 Aug 2021 10:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817101423.12367-4-selvakuma.s1@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_101432_058047_4F7E9E57 
X-CRM114-Status: GOOD (  14.26  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/17/21 3:14 AM, SelvaKumar S wrote:
> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> bio with control information as payload and submit to the device.
> Larger copy operation may be divided if necessary by looking at device
> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> submitted to zoned device.
> Native copy offload is not supported for stacked devices.

Using a single operation for copy-offloading instead of separate 
operations for reading and writing is fundamentally incompatible with 
the device mapper. I think we need a copy-offloading implementation that 
is compatible with the device mapper.

Storing the parameters of the copy operation in the bio payload is 
incompatible with the current implementation of bio_split().

In other words, I think there are fundamental problems with this patch 
series.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
