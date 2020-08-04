Return-Path: <SRS0=RvWm=BO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6541C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 15:37:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1051207FC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 15:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zwEy/Tqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1051207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jGeFDvcc/KXUCHUYEhCqo/qrbklhiVO1E/aF7nQ9FI8=; b=zwEy/TqgirWCP8AFOQ5PfoYTL
	NIqsjL4/4gCqXESTiYjrU3AK+EKPXp50vL4wt+OQ3Pil/526qGZZvYHjaSEVpC5oaORQYwrkwAJ9/
	jdEdq8s7xsjNR/J86FsLdDf9cDGgRNUNPg6282eV2LRzHCMQplFAyv2dojiuidHkXNdZmjOxCNySw
	KdOnRq89k2f2hZrUArmt/gtH7LFG89y2mXtaKvZreLBsG0vuiQj1JjpCz7hOSZNFj2/BCARkQIsYL
	e67I6+sHGSfPosNf02ZxH55xtOPMLZ/pHGsgTTOIopRS+ocWH9YVSZerhMhS1zsh54tG79IqJM3EP
	GEnmWQ9kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2z0W-0008NW-2d; Tue, 04 Aug 2020 15:37:40 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2z0T-0008Me-Q1
 for linux-nvme@lists.infradead.org; Tue, 04 Aug 2020 15:37:38 +0000
Received: by mail-pf1-f194.google.com with SMTP id r11so12626170pfl.11
 for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2020 08:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W0s+Ay9vLHZkkpvq/j1ntxHczOmQRmqaRsOXDuy+8tc=;
 b=uTvnBAFHeCdfGWeKpp5dFUsCIFyJH+/1Pzo8lopYGRKmfw0Td9nR9mEirq7ipReFsh
 arw7FsxEBbr6rQkJIlKnW90ru9U2cwzq/B5iOLusXrG+3REcVUBaQp7OQKzWq+JftNp9
 jxWrCjUjijM+LXj4upojaryLiL8Em+RRy7v9e6WrPYNUCUccr6WCEtifYYs0nnJ4J1ww
 acgMo8DFON+Ryg/zFPWTA/ZTHxwe9oDGX3o5lBGiFmrKHKifJpOuWCylfkpaqholhKDF
 gC/bV7t/y4oguL7+4o4Cp1leAx1D9QJK22MnEZ29E2a6pjJZp6HMRwDDEkGa1VbUa6mo
 +K0w==
X-Gm-Message-State: AOAM531309TcbXkIYXdfHULIMiIamPe3LjbayLrl41ZVXoB8dLMiC/wd
 RrbAiNCLEYI3103r0fvy2So=
X-Google-Smtp-Source: ABdhPJwruxxH9JIfDK0ehFFeis8nSyJA6seDm5YVGJSglncBQbB2igvKj0C9HILue7w7gbIkoJYjrQ==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr21677027pfu.121.1596555456497; 
 Tue, 04 Aug 2020 08:37:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:812c:bdc4:c26c:df75?
 ([2601:647:4802:9070:812c:bdc4:c26c:df75])
 by smtp.gmail.com with ESMTPSA id h23sm23556249pfo.166.2020.08.04.08.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 08:37:35 -0700 (PDT)
Subject: Re: [PATCH rfc 0/6] blktests: Add support to run nvme tests with
 tcp/rdma transports
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <BYAPR04MB4965B184B6FC82243F78A569864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <291dd03e-1b1a-b965-775b-753ebe469d77@grimberg.me>
Date: Tue, 4 Aug 2020 08:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B184B6FC82243F78A569864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200804_113737_872370_3F1437B0 
X-CRM114-Status: GOOD (  14.19  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> We have a collection of nvme tests, but all run with nvme-loop. This
>> is the easiest to run on a standalone machine. However its very much possible
>> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
>> tests with a new environment variable to set the transport type $nvme_trtype.
>>
>> $ nvme_trtype=[loop|tcp|rdma] ./check test/nvme
>>
>> This buys us some nice coverage on some more transport types. We also add
>> some transport type specific helpers to mark tests that are relevant only
>> for a single transport.
> 
> Thanks for having this done, overall approach looks good to me.
> 
> We can get rid of the rfc title and start the reviews.

Next send will not have RFC, but review can start with this set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
