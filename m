Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DDCC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:12:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB24B216C4
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XB/xCEXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB24B216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IAHprfJVgYpjQOYVfXsQg81nVeL/EJDqgpLfq8vLi1o=; b=XB/xCEXMVt856YCl4B+DE643v
	kGq594sAtlqDxaZnfRpdPVYeAorIva+ysbWWeREyz47HYqG1owS9a+3MnsibgmLdU6u+mBOTMe68g
	3T+I+MswIR00Q9bBSVGcg8hn3r7Q88VhMRGiaa9xjF4WgOYttli0tBW3pBVupRZSixcSmhAdM8t5c
	hwFYRuB8bjLCdFH4miUWZ3S9xqCMmoa3ps6SfJ0kQp8zTrSLVpm98LCf5UF1LgWeOl/VofCwiGtbc
	e5UwLwoNnh5ORe63JidvgANH7rpeXKUhpSCCoiyDOKM+mY83hI1XezKyTM8chGoY+uAyiSucaoJTY
	pjikX/M6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdEGp-0002Q9-KK; Thu, 12 Nov 2020 15:12:19 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdEGl-0002PB-Ve
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 15:12:17 +0000
Received: by mail-pl1-f194.google.com with SMTP id s2so2920236plr.9
 for <linux-nvme@lists.infradead.org>; Thu, 12 Nov 2020 07:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ypzV94H0yaYtd5pFfqZJmptSsWf67IW2o2OeYzuapo=;
 b=X6b+LVmy8TZRUhF5paeqBXko55w6+QWaEUtjX61v8+S2Rv01GlN9Y0GelXugcgM+Xh
 P6ihDmXu+8wRjBdDkHf4W+s1mJMZWkfZ4/gUduaj7izSsVSyIBtq99V5n21EpdTEsO2Y
 1IxGJ3ThfwABYayW5nEuQTRs0FIeUS96CzLzUSXCtf9pS0wTTpg7o7hGnRD1RAt1nMkI
 gGALsSI237SEUoFmVoaZg2J5HLIwAYQ4qdnUP9BZvG9Qe2zY/hc74qmMRcdVzFvvsxk7
 4jzvWTBCHmFbaJz3VEZdb05/AYYPjExoxbu2Oxy1eh0FkcS+1x0+H5GgLm4tamY99eL7
 DxLA==
X-Gm-Message-State: AOAM531sX3xgd/6g8R89dVS/aFXwFG75CsAPocImcvPWdC3EsxdJeShE
 MpL/xQGc+5kDFHsRe6GlaLQ=
X-Google-Smtp-Source: ABdhPJxBuNQQ2bMqbglbC0YPn4oTwpZKmcJrsexAzX/EF4QkGxC/cBEdIlPVf3P+QL2Pjsoqe3mVBQ==
X-Received: by 2002:a17:902:eb42:b029:d6:ba60:ba41 with SMTP id
 i2-20020a170902eb42b02900d6ba60ba41mr25994882pli.0.1605193934350; 
 Thu, 12 Nov 2020 07:12:14 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id i11sm6921014pfq.156.2020.11.12.07.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2020 07:12:13 -0800 (PST)
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
Date: Thu, 12 Nov 2020 07:12:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112075526.947079-4-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_101216_052303_82D85839 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Qian Cai <cai@redhat.com>, Sumit Saxena <sumit.saxena@broadcom.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/11/20 11:55 PM, Ming Lei wrote:
> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> 
> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> locking' by nvme-loop's lock class, no need to apply dynamically
> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> lockdep complaint triggered by request queue flushing").
> 
> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
> is reported the whole probe may take more than half an hour.

The code touched by this patch is compiled out with locked disabled so
it is not clear to me how this patch could affect a probe delay for
megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
caused correctly?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
