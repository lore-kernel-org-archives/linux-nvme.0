Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73782C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:05:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B0F206F4
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DB8c6szB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RWZig3lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B0F206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Znfvps4xleHhRxA/CW1zcFNwUDBxJszDDChpX7t5EbY=; b=DB8c6szBps4HhCkNx/AE0plZW
	mxumirpth0D2eJjbDO1vUlESCjMkG9mBk0+Cbo+EXA4qzpB4CkUE/4oEaM9PZr4MCdznv2mWviFV1
	h/uDrpJ+ptenw7iX1XIWs5QREii2cHXekSRJwgpN2egCkWhW/38tOFNGKGxgy6dT56VV/0TRCQmGJ
	AcxYx04HmyhUKv4siSx8rP8YDn0rvHJdHknkXlBnpgyyrceUXXI9S9FPcjexNM9d0alT97JeVzy1n
	iNtQsuRXcl6+P4CTAF3fJTUYOfa9y96GBG68biBOOZjw8jtks5tKsPE/B6lFhSyB7klHm/OhWOAnt
	JZJNQwkBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGnQU-0001XC-JF; Fri, 11 Sep 2020 18:05:34 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGnQR-0001WV-PF
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 18:05:32 +0000
Received: by mail-il1-x144.google.com with SMTP id y9so2005899ilq.2
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uYxBs9oh8IzQ8lccaaOwluN8MjJ4R0eXq85ePUW60Vw=;
 b=RWZig3lWG69iU8u/V4NBhqpp88RNlVnvzeRtUwKSc3dTW/x7NTlKDuKFplyuWq3rgm
 1F12UZRhR0YTQf5G0zDBsaJ0cr68ppFOrv8c8ZsbDaiA9+DqKHrAs5akTrJHxyKoKD7l
 4cYxxrTmtIDO7DyviAf7dg1fpNNGMyGwsOxnfxlHq2RiZj/5KaQgD+KJltHmwb/h3qER
 YraLO96fVVpFmwdVD+GAwo+ePNT6TverRjfc259KGTZDfUwKiZaPWAx+mI6PwBxneeqh
 F77nTAQKKvj3LbTvTAB+dlReO1df2ATxY/kr30zTTfwnfh0bnnf2r/8mmpNeIhggEzUw
 5dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uYxBs9oh8IzQ8lccaaOwluN8MjJ4R0eXq85ePUW60Vw=;
 b=oFvCGwngDBkdEj1kWMbEVwtUaqZfTuKsVMQ1BmQJkcOK3qr9cP6ze78Fmdp0kOxACl
 KK9pjdtnNlM9dLSCUr8BBIzuxi2HA0DaY8HwLzG/KDVNxsCjOdFrvVLRNAOrF3GTGnWP
 xPLZ8QQu5jyLp57xd/KUqDqjW1LmExuWVTyBo3lz6WAoO1accCqZqvsfbPS1lAr9krlu
 wkP84fcdw7MUzTElox94gkw9264rChiE+C8QaM7MNPgnYi6b8w/j0PjDXgI7rWHVoGU4
 kzZtg/IqfxiDACB6JeF2woOGFaYammF7w+i+UVjm8SkK3ZP1LvP+xo+6L6bgA07iHxR5
 tMgw==
X-Gm-Message-State: AOAM530EUwwSCOrOCx+9CUBen7j0Xcx8Neh60bWB4OTJDTSfd+wo/q+o
 sDIDOutWum/IewhetPKC18nZ0g==
X-Google-Smtp-Source: ABdhPJxAUft2jW7eFBIb0ujKzO+cmm8v0KkScoPn+IbSxueeqSHx7Z0WkCep0dRDtv2yfkd35JEdjQ==
X-Received: by 2002:a92:194b:: with SMTP id e11mr2754962ilm.43.1599847529979; 
 Fri, 11 Sep 2020 11:05:29 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id e28sm1660895ill.79.2020.09.11.11.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 11:05:29 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
Date: Fri, 11 Sep 2020 12:05:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_140531_833091_CA71F064 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Bart Van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/10/20 8:41 PM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.

What is this series against?

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
