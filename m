Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:55:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79CE61278
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 20:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79CE61278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=ksjNQy42txCT0yELZPuaHiQ9g
	I6ZwhI03WDu/3bk9633EZq3t7smmL5sm0nrvIiaJ0lqqOm+iPHah9iCJF5gE1Fye1rAQA2FXQOyRN
	1wu0tE+CUI7i20hrFdjK4N9nEydg8ADdAn4afBadO2nUIStIUmgK/MacZfX/ujXT98WJHZwAskXWJ
	Qj54+R9vZHx23o3R0B6T+aKZNeGi9TBdCrIfT1XT142iGkkQfbl1EwP6rhZEeNpKBjBpfH1MsqsGR
	nIRuQEkbGn4uU5righ+eev0bhSvLmooiFwXU1rH/po3uDTCFi8CaW8LrZmOdvSbRgzFnWAERkiQSv
	QhtBZgDPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgvsU-003xrI-8I; Wed, 12 May 2021 20:54:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvsR-003xqD-O2
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 20:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=gZfk0d06lR5Mq21VbueE5Jimbe
 iwssc0yuAjwX2086qe73ioAzFXVsHhgenD9Gq6jn92WpDcT5Jm9s64ORAUMnDLhuovhpwOnLZAHPf
 8SbmE5B/7yvDDA1mtQXnCYHCqLBi1nF0TUbJ+kftjZt9DftYJBWh2WsQ27TDK5xywgzStSb37Mcgd
 ObYtd1FcLM9LEoX9kTai9uR2IzlFVtJLnF6uZ97HLLay+0qz2tNurF0Kk7MpC889/1E6Zv2OYqOqj
 XTWNVG/IkrEQTMa4UGdFewsApPxRmZpBHMti+iCGswC5V/tfdpeqRlnxl7VgS1FxWjtYLMkFCbVG9
 l0lQYFig==;
Received: from mail-qk1-f177.google.com ([209.85.222.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgvsP-00Aouc-D9
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 20:54:42 +0000
Received: by mail-qk1-f177.google.com with SMTP id a22so23073685qkl.10
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 13:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=IeElDFPENnLPXA+Un06+kn7sWrPAokB0Gc1S9Widf05y2JStKTwTZN9VmvjsBWmfQI
 WR3JAesdEuZgEFvzeD8oAj50egPertpUnNRW2m6jmIS9cSS0pUbgls31018bfIxN9aiB
 bXarqikRE+rEFZdhPXWjysNeum/AKWTYk+8aQtD1aRMgoTzO8Cw1PVERl4Uv34o9IY9R
 Yfz76G5ME7dPsgA8FiNgkC3TEDMrtIevqMcTaaWJSIg7CbwcZeYbzTaeg2Ozy1XIj64C
 UKfja3SrjESTtelZOKvUsAQ30lz0pRCviXSDtacO8x6EwPp6JYJ11xpmekieLZ3+KToz
 orYw==
X-Gm-Message-State: AOAM532r/O/icofk00/zu1hY1s9RjovzHNt/0RuTDO4Vzrbh8WvouCep
 fVOFl9oDeDpbAmsY49EV83a9LeVxAyo=
X-Google-Smtp-Source: ABdhPJw3ba7TDy9IXhuSNfnoRNLweJN6Sxi95AmyabzWqR4IojtKhY12rFTIDEHLbQim/UIuTomsBg==
X-Received: by 2002:ae9:edcf:: with SMTP id c198mr26913097qkg.54.1620852880078; 
 Wed, 12 May 2021 13:54:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id l16sm964832qkg.91.2021.05.12.13.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 13:54:39 -0700 (PDT)
Subject: Re: [PATCH 02/15] block: don't try to poll multi-bio I/Os in
 __blkdev_direct_IO
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad73f9ea-bc57-2a9c-5c32-547d188c7a1e@grimberg.me>
Date: Wed, 12 May 2021 13:54:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_135441_469230_4CB3E22C 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
