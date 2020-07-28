Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55842C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238512074F
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="voJQsTK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238512074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IhhX6IHQ9mJ8V0IvQPmnVFJiChgTGjr7gKKcdCXwhY4=; b=voJQsTK4A3BIQl7lgsjH8ZuWW
	2srWkDSvHacHrpCvwVZI4DVb8AJanuiWVfl+9M3blRkWCyuKITuO5K1R02rxKT2/HFqi8QAsdhiz5
	+JUi+HxSM/SP/HBQWlL5hFj/hf/xcT4nHOJL8mUYYGn8dnYjVPAa5mUyzOPs+fRTCOnJnpZCQcBYa
	M30tisTrFiM+OSTX5sjOVb7/4SFt190pWZSzSXdlI+0/05942Ubq6JEJhYm4Rp09BRbg2aOPjgOhu
	RmjO+3xhleFw3kHgpqsTRM2jsShsMhpuofuDZh7AANM+pkYG2Rmoc0WpyrLGJXv4OyEPeBFKq6Yhz
	6zMz33SxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0SRw-0003nQ-B9; Tue, 28 Jul 2020 16:27:32 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0SRt-0003mj-HU
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 16:27:30 +0000
Received: by mail-pf1-f196.google.com with SMTP id y206so923025pfb.10
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 09:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7mzsRoWEHIYBVEu0W2IKFP46FMrCD6vM0K0+nRG61lk=;
 b=UAp+mk0Al2wMXCOirabKgKM+uDAQwc5yd5OhWylXG7WxuaTWYJ49M2/rWY0ffujF9W
 kY1bv70XdPLHwJuNyNDoVZR66cBWtZeOxnuzlUkW7OH7wHmaLHvAT88yDtm1JSAp0d+C
 Hm4PR2Taobgr9xnPoMdLkUmlru66mbxtsC0ZdFiRDOlGJfTHvx1onDs540hO5nbeWFZ6
 hwKvwA3hh6pbE9MtpQzIOKmkNvNRm6bJAvFylqA5PUTXISSIDCKh+Fx1BgkvNxb1WxUQ
 H+kURGkj4geMyF/6U4lI4q99rKEbVv0sucaoazHlS/mXlH7K7qO76RV0fZAkmwV3+g4d
 KxSQ==
X-Gm-Message-State: AOAM530gET9vKnIgD+NTxj9TZoh/4iuuqQpNk3eQnd2qMZjEiB8nMiEV
 xE08NYPK5OjUW9db/u2iVc8=
X-Google-Smtp-Source: ABdhPJxxkCh5yDOyAW1Y0Kl6jIAaO/QgK1V90hvfv+nTbG4KAPOPt44yhQhzOtRYboKpd1r1PJvloA==
X-Received: by 2002:a62:7c97:: with SMTP id x145mr6709103pfc.155.1595953648160; 
 Tue, 28 Jul 2020 09:27:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id n25sm19626442pff.51.2020.07.28.09.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:27:27 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect
 fail
To: James Smart <james.smart@broadcom.com>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20200727080926.30776-1-lengchao@huawei.com>
 <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
 <c129a034-ca6f-7323-91d4-8a899ede7777@grimberg.me>
 <c229ca6e-646a-372a-2526-ad90e2da1abf@huawei.com>
 <9e6242b2-fc04-632d-0ea4-7ca877c5da2c@grimberg.me>
 <1288e338-9e92-eeeb-6f7b-86590c6e1a4c@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f10304ea-3955-8692-9324-62901e729115@grimberg.me>
Date: Tue, 28 Jul 2020 09:27:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1288e338-9e92-eeeb-6f7b-86590c6e1a4c@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_122729_800750_2840CF8D 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> The io will do not fail. If work with native multipath or dm-multipath,
>>> nvme_rdma_queue_rq will return io error, and then multipath will
>>> fail over to other path and retry io, this is we expected. If work
>>> without multipath, nvme_rdma_queue_rq will return BLK_STS_RESOURCE,
>>> and then the upper layer will requeue and retry. Surely there is a
>>> weakness:the io will retry repeated every BLK_MQ_RESOURCE_DELAY(3ms)
>>> while reconnecting. Because controller reset may need long time,
>>> and nvme over roce is mainly used with multipath software, so when
>>> controller reset we expect fail over to other path and retry io,, just
>>> like error recovery. If work without multipath, we tolerate repeated
>>> I/O retries during error recovery or controller reset.
>>
>> I/O should not fail during reset, mpath or not, period.
> 
> except when marked as an internal io (one used for reconnect, or maybe 
> an ioctl) or marked for mpath.

I meant normal fs I/O, from the user perspective.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
