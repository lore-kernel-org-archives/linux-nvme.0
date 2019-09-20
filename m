Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA0BC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:56:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8352086A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uYNMaXW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WLfMal5wKOblJbZ65Jptf8Ib8DGolm/B5AJqTxxl+Tc=; b=uYNMaXW0NCl3hAkBzw/w00Z4J
	egguXymjSm6dor82LTWatlyvbEZH+akoSf+F0O67vTm+3poLHLOY7knlr6WotrpmD993NK/N9d9C2
	OPPuCYDRE73C9TXYbgZolHbygJdwjEPXJA2W/73jwNAfGASJdDfR5QZO9+FtBT16dYFYW4kuNRDcK
	+0nKRCnCcBeRUpavsIM93EWpvxmGjkrLvBlTRQ48vEUBSZjbrS92280mKWUmwmCj2EYhm8gco7KJF
	DIzLgNp5Uf0ca66mKqUcEUlv0KR3vK5h500ih3mMxDKlG3P0grJ97WwBFW9px74jB8aoK1oNdFt5o
	SOi3TZYyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN8r-0007b3-Ir; Fri, 20 Sep 2019 17:56:25 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN8p-0007ai-8B
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:56:24 +0000
Received: by mail-wr1-f48.google.com with SMTP id r5so7612323wrm.12
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 10:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ory0BzVdcLtUAj0WRWh0vQl5QPXWALrk2oxyxNoxVqU=;
 b=Sth40ZltFznmuKWKWVb2fZjvtFj3Mr1l03dCVx8qRnmgaFAUaOMmr1pq71ESZNZ9A0
 AVr10NHZH26TRi4yADRbkhi5pEXKxGH1qKzIK2u1BLoq/1Y0eIuGy0cfWQA8YPG42GIL
 KJcNRconVi1mn95n7i6SAq1v7CEWeMWSORwZSCmtADDhCw85BDIzj1Qbmp3U+MIJbqJd
 dN/gqvSuhdlZCFCr95qo/TAmZ/mgcaqP8t4lxXYNeWUhBtDUcm+mX/hBnGAla0pz5iqj
 o2Vs66R6tYVAx0xHDaLeh5DpOJ7jXawrqQ2ofSDRA8u7Msvnn6M7l/i9uCPplWMPHAZs
 YloQ==
X-Gm-Message-State: APjAAAXtIA28z3rqFNIPmTgzkuVdEVvh209RNRfl6xf25ASYLGSCNC1f
 kjpTCnkOTtBXnMqz1zV3QFDzUrWd
X-Google-Smtp-Source: APXvYqz/kIpJyqEIJWRjAPkWgOcnZh9aHf5/fHVcDuwje/6NwwFqbAViFBjSDOPiWVEeM6sj/x/meA==
X-Received: by 2002:adf:f949:: with SMTP id q9mr521955wrr.382.1569002181978;
 Fri, 20 Sep 2019 10:56:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 94sm1605507wrk.92.2019.09.20.10.56.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 10:56:21 -0700 (PDT)
Subject: Re: [PATCHv2 1/6] nvme-pci: Free tagset if no IO queues
To: Keith Busch <kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-2-kbusch@kernel.org>
 <d6c5e276-6479-89e6-4a59-5e950ddf2fe5@grimberg.me>
 <20190920175351.GA97854@C02WT3WMHTD6>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <85d7dcd9-5b26-dd5c-9b39-1dcfebcad1ee@grimberg.me>
Date: Fri, 20 Sep 2019 10:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920175351.GA97854@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_105623_286856_4C15D0CA 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> +static void nvme_free_tagset(struct nvme_dev *dev)
>>> +{
>>> +	if (dev->tagset.tags)
>>> +		blk_mq_free_tag_set(&dev->tagset);
>>> +	dev->ctrl.tagset = NULL;
>>> +}
>>> +
>>
>> testing dev->tagset.tags and nulling dev->ctrl.tagset?
>> why not check dev->ctrl.tagset?
> 
> We could theoretically use either. I don't see any case where we've
> allocated dev->tagset.tags but didn't set dev->ctrl.tagset.  But I
> just kept the same check we had before, just moved it into a helper
> function.

Yea, just looks a bit strange now that its in its own function.

Not a real issue though...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
