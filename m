Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F4C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:57:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6718611F0
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 01:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6718611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DySN1DuW+n2AYOmqTlNppcpKhE00WDt2luPhNbx+WAo=; b=lPZhG8BhiJNkijVCx/Y/9wlj2
	Iv1ToqDf2YIoPcI+mTUbkQCN6j+2jKvCl6F70Y1pqaibcl4HiWl/wYkCyw0Iy0xQw1U3SRrO6Xkvm
	c44fIDMk6V/MrnhUYsUUH6dauyEVrO25rEGGOThNRXyj5OfzEbPGKHkYxaK0dyo2b+ARW2U+dTI8j
	m1mOnpr2WmCwK1btw1QC5DNd8NEAGvFJSHz6rb92qhwr7NwiH0wVkSZSzgRwwcNP0qKwPIw40AZRh
	ONSLUd2ez31Fpm6DqqNwhw7TEbgYmHDBahhT9qsmmE0IYeQ8zsjjmCf5PJ4yw9wS+moyntb0iUcGp
	sS+sz7QAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laqV7-006fW8-HQ; Mon, 26 Apr 2021 01:57:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqV6-006fW1-7f
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 01:57:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6HEg/Ddsftly7/3yRUEs2qLA5+xUFCZApQad+9OPs/Y=; b=nZ6k7jMF7hT51MHIGspzmDx0Vb
 H5fq61AWD+q2keBjFQbU70rLZxCQ5RFMwcrfgH6pQUnxCnEeakt6IdudoO+dyec+1GJ9kAZF/i8pE
 mWMUR+/YgL2wFC5m+JebkLTDo3pk9+H/Wpq0tIANm9q6bJtMA1W14W9l5PcIv1qOtDMqNfzhfy46R
 tEfSadlPiOci9l6KDjaibk+33iZYZDVwjs/wmIJmjaOeRgTP1Qc/OG/ej4QSHHVcao/O0G/i4lIkT
 /HD8PaP8hMph8MX+WuKP3+S3vrDGpOs3xWKCS8DgFtyg2J6qBoeZi+Es3LzevkD+YNsbYEgXHEPF1
 ImQ6x1xQ==;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laqV3-00FgfT-Mt
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 01:57:26 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so4248218pjh.1
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 18:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6HEg/Ddsftly7/3yRUEs2qLA5+xUFCZApQad+9OPs/Y=;
 b=FZxuH9e1xfcZzjx4JdGS5f9CEy6RU9TILL9o1XtuHkJJhlaM7naOCIoyY6bvlOrzRB
 mS25q+HBgejFxpbUMNXooxU7OJPngA3f6THOPfk/w53C7GgINVhdJlVgKsONb0mG9YIc
 TbCJCKlLytlBRceSa8GdltK6cpvVIsRKh8AGrMIBQYk76MLVgn/P0bKGO7fdAYf3f2+t
 0Tly3OAjte1rbgDOelBj307bz3pw5XBDJfq5TNrtPCFLu2bfMe77z0rR+2AwsqowoBZx
 pRQtMTngc83KPJmZSn053DJf6Qbu+KdGD4Bf3jo4/pdIx6E+GhJeKN6/ApEjsU47TCmQ
 lvdg==
X-Gm-Message-State: AOAM531jMLwoJx96UEvGeWlK7SUfl9cnFffqiYfuT9QoOMoBdaqJbAg0
 Onn49j7/+NGAdOzr9oERkzI=
X-Google-Smtp-Source: ABdhPJyZilykJIV4HMDyE83hi7h3BZxEs7dCPfJYWuizazoZ0MILumlUOVaQeM72OAnEpff7bvNQag==
X-Received: by 2002:a17:90a:cf8d:: with SMTP id
 i13mr11564066pju.53.1619402244598; 
 Sun, 25 Apr 2021 18:57:24 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id b21sm10719230pji.39.2021.04.25.18.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 18:57:23 -0700 (PDT)
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <YIU2BhuYZAAgonN0@T590> <5c1ef3ec-dd6a-4992-586b-6e67bcd1a678@acm.org>
 <YIYVMQmAZgKL2qdP@T590>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <56ae9ca8-4e17-0d82-8ff2-08973e1f4693@acm.org>
Date: Sun, 25 Apr 2021 18:57:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIYVMQmAZgKL2qdP@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_185725_774553_F81E1E49 
X-CRM114-Status: GOOD (  15.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/25/21 6:19 PM, Ming Lei wrote:
> On Sun, Apr 25, 2021 at 01:53:16PM -0700, Bart Van Assche wrote:
>> On 4/25/21 2:27 AM, Ming Lei wrote:
>>> 4) synchronize_rcu() is added before shutting down one request queue,
>>> which may slow down reboot/poweroff very much on big systems with lots of
>>> HBAs in which lots of LUNs are attached.
>>
>> The synchronize_rcu() can be removed by using a semaphore
>> (<linux/semaphore.h>) instead of an RCU reader lock inside bt_tags_iter().
> 
> I am not sure you can, because some iteration is done in atomic context.

I meant <linux/rwlock.h>. The functions like read_lock_irq() that are
declared in that header file are appropriate for atomic context.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
