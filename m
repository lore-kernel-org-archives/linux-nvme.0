Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A5FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:07:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E809B23370
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E809B23370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=HEpy9RNS2a0lS6irjMSy3tnCA
	c3586Klyk+J1QXy8sp833Df8XdJ45maKtxcgq+HDGRR7pTXaNoRMpO95xFROLcm2iTy9Yn7BekfQ2
	hosc2ssxgRj2RcynSUp0j3UlQTdXcC9swsaXfBnxvP8HZjFbEUevANaWaTTZ1AHzzK00QtkfEuWhH
	twpyt+yAvgDbingBM0qvevStedZf12S35QHLlbxgzoI743gpKFPaykmAQW+a5jeuUglkYVALjsbFs
	WFvIkRhjtjtdzUioO/TT/Ad37VnstQrKTL+MJ6wmi/aZzb2NiWGGx3SnooMCP1BA3grBTHDfOoi85
	PllUNIKug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoHl-0006vj-7J; Wed, 13 Jan 2021 22:06:37 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoHj-0006vB-Ca
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:06:36 +0000
Received: by mail-wr1-f50.google.com with SMTP id r9so187125wra.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ubopvlI1MJ3ZlCDV0Tq0QgctQobf+NcmsMob09iLTmB/Z3Q6S8tm602w88IdtXam44
 nDfcQ75ZbbWtdVJwoqborsIVMQWmvhxsyM741YcZu9LP94wC71q73UnKhhmOLtZQ+AsV
 mOUkWlwXE/Po4bkr8m0soZeFrOt6WD+L1GolOJryPn+sCtBXhQcZY0z7uBYflRJyRSqE
 foKtAbe9x5EVHPxwxaNvr2xDBMZajuJGZY9Hjro7660614pBJy5569O30rq1liDVp1vD
 Bza6aGmueLyotHN9xdhXFUGl58t4Dn7B1+K/jfJpiseSPEogP/MNqrKIkoWHtmhaK77U
 G0aQ==
X-Gm-Message-State: AOAM530ac8vIabPVUmDwoAFJcuCjFMgHcKzmpUC5tIY9gbv1Gz9ozHIP
 5wUDF1OYw0G+hXutSauMp/QrNGXarU8=
X-Google-Smtp-Source: ABdhPJwfqgfbm8k2i6w2CX37jOvRvgMEeCa3cELWBoxtjrf4IetjAqsERq1/psl4BgLzaL9tjMsF+A==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr4642122wrm.293.1610575593783; 
 Wed, 13 Jan 2021 14:06:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id j59sm6630069wrj.13.2021.01.13.14.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:06:33 -0800 (PST)
Subject: Re: [V3 4/4] nvmet: remove extra variable in identify ns
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
 <20210112211410.24742-5-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37d3d6e0-bf01-4da7-072f-d99fde4294bc@grimberg.me>
Date: Wed, 13 Jan 2021 14:06:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112211410.24742-5-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_170635_454804_1B92FC54 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
