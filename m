Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58357C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 02:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AA46121F
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 02:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5AA46121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=WiLYNBd89sckPpOWp21SG//1IEzqFqPsmXmpgLyfb+Q=; b=TPIt3bO0hH0cQv1mrA0aPihPHF
	vUGPiJkJx+rgI1b82xyhi/MUOHZui4QBb0T5Ob+3yif9HLIHJj0TEX18g1VG/5AZuYflkRIFC014t
	KbID9uZKzc9KvgcAYarnrM8Bu1T1A7MQHeAgB3qCWGuPYv/BexH/pBQPQ5xbLjvx/yz49GwWS0D1o
	2UAojnI54vGu+yz0+rRWXkn62kAbOoMAPp8hB4eJ62GoEaZqA7mnXdl8h1U4X8u1r/97uzPttqVkD
	yYWj9DH7467Z7g8RxVHPa3NzB2Iw9CxVEpoqz9HbhCLpSAfc5WRUQa8i4Nsei53T6v833m6J9WFGr
	mruHCa3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQKHG-007sqQ-Vy; Wed, 15 Sep 2021 02:03:59 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQKHD-007spu-Sl
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 02:03:57 +0000
Received: by mail-il1-x135.google.com with SMTP id i13so1269314ilm.4
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lfbBmk1hXvwnt129yEpMuT3B4Vbqd1dsVyXuZTAuS9c=;
 b=vkBY9eRS7RDyMYJVsExVMd1O7QTSKd2mYmA5VTloMhK1YkJiXeUSjNNCQYtkr8pSnM
 mCSIanIb1fAT7aWbCtl859dwygxCVIB7k2UyFD2dcFbwNIb5pjpQhEcEWdKQWNGkYDll
 Ma1tCtPjdqM0UlhNzxrUxAq9DOBBRI8oITpxVifvTPYShbN5ccq5WLq4yMLG5UXWG0mQ
 8TtGk696q9PyKUiOA3lv9eo1rmbIU6e/Roe7Bbd1yFHYe/NBSvWILhE0ct8wYsDw8zx5
 c00waGcpgzVdYqjMnw/MnZvIn91F3HBWxhncJvP8evuHT5ezS/VrAkbDYkr3qVj5xN4Z
 f6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lfbBmk1hXvwnt129yEpMuT3B4Vbqd1dsVyXuZTAuS9c=;
 b=WyuIXSU477xhIrScCuxvs7T+i6ImbSEb7XXyLQUIY4DhSjib9aW6vyvyr/Y7TqIJ23
 EquRPWRvdF7HMmZbgmM9AuxzbQBFUc5faeSadyrk4A+CP71yXcW0i6l7N5bnhYIdxnDs
 PT3T4txFqg0ywFpadccurgZALreekwNEP+pMycD999Ye8S88+mv5FKQ1hBKaSQbc9X6k
 gLbjrXvLdsEOdMGOxR1Cv/QtwkKKeoHgmxwr3tk5WsEIja7ZkkAwny23m7G+xXaG+B4D
 rvvXNSPbGBk6z1vsBKU3DDTKqkr2hVbmhhVj9KKPWbw9y53KxQD1lpLVXczvhUHiqe1P
 IiVQ==
X-Gm-Message-State: AOAM530i7og6oASFkViNwalrwghkR7CjZOJQ7vDMqMco3MkAiL9N0r3q
 q7lmRWGpBSwbTsP3p5AuRDbf1N3JQSLQ8Q==
X-Google-Smtp-Source: ABdhPJywR6KZf7KbdFZ5ajpI1VT37AnlhnZ2JpoIcsOvCgyRF4LIKXKG27hrajJ9i47y64jATrpyBg==
X-Received: by 2002:a92:d0d2:: with SMTP id y18mr10650885ila.80.1631671433703; 
 Tue, 14 Sep 2021 19:03:53 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id c11sm7615757ioh.50.2021.09.14.19.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 19:03:53 -0700 (PDT)
Subject: Re: fix an integrity profile unregistration race
To: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe10467b-e45a-7c2e-433c-f52ef9b02e09@kernel.dk>
Date: Tue, 14 Sep 2021 20:03:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_190355_985556_8B45C24E 
X-CRM114-Status: GOOD (  12.13  )
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

On 9/14/21 1:06 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a race when the integrity profile is unregistered on a
> live gendisk.  This is a slight twist on a patch sent by Lihong, which
> I've taken over as she is out on vacation for the next two weeks.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
