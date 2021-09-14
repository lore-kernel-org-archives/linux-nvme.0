Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3603C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E66B610A6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E66B610A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=LqnU3sYGsewU4M882piIR633s6
	u3+EmlcD3VUwSCwiRSIJqEXiYRHfAKTuwop0FmqfK2ixtr0hkUgRMFGEn8HQRuXH1P5WLCBztUnRM
	S3uhZOAZMW9uLz7Y60p6z8pc9GF2ecbRAZL6qGT21a/oW50GYNVtE8rsNP9kawdCWz+qgPRFmvo6K
	j+tAZw+DnyTe0vH5eUm9syzC24cdkJPnr2HLo0cba/QGihKNUvloLsv2kSfV66zvx8B9/B8SEIBfS
	ryjZEVGShOTCtNjltbShJ43mshrDJHRRJvA+E+QNeLOO/IRm8WyLk917kKshJpMdXii+rD2bOaH8T
	z4yu5lxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2ir-004RFd-9w; Tue, 14 Sep 2021 07:19:17 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2io-004REN-3z
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:19:15 +0000
Received: by mail-wr1-f49.google.com with SMTP id i23so18549583wrb.2
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 00:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=XNDd1z6MrgEGad6L0T6H8vbbboWl4nsumwf74CcK2mIdYO6OzxYj6XSFtcICllradY
 R3tD2lOg6Dh60XoiSGsUPS3xmztEvETUmWeqaHoI/WvEF2TlJrFx9RjUdD5u6ipJ2ekW
 4d1KFDcw1v3b940dhu/5oCRmBxZQkKzJdC5EqL3z3GZ2mA0k6fcrfJLvpWEtNosLfyQW
 x4ZRVfCW078w6r1PxBXgNYrgkKLJhfRADr872VZ79pJw4zAmidbfB4ghOAVT3zdrp3pG
 A48zJ796Qps5n/hu9kVh79HmaC24Kgyu9htf400aGoWCWsnOXIlcfjUDWTMH0H5b3Ns8
 AP9g==
X-Gm-Message-State: AOAM533GklXTc95joxOx7rMGdwgq8m7NuG+FA6gjmY65jAcEVL+xJu5s
 Rrl68INQ4EV1jHY/CcLYHIpBLnESXk8=
X-Google-Smtp-Source: ABdhPJxR799W7iZRWsnn/gvqBdGPd4O8oQj1ua+YcV6wiwAcLEmqUJdizidlrmz1Tsb2uOZU2cGpxQ==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr17055511wre.419.1631603952058; 
 Tue, 14 Sep 2021 00:19:12 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o26sm261015wmc.17.2021.09.14.00.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 00:19:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: flush the integrity workqueue in
 blk_integrity_unregister
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0057deed-40b0-b86b-e4c4-fbd77b45bbbb@grimberg.me>
Date: Tue, 14 Sep 2021 10:19:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_001914_203856_669944E8 
X-CRM114-Status: UNSURE (   9.61  )
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
