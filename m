Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFECC11F66
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF05261431
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF05261431
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aL4jd9XdvBOFuUZN9ccwXrxmG6cn5qRUXXD5kFOFxfQ=; b=tEM7k+A6sAPt3qlZCk47QkW8M0
	EcYxdNSGrE+1frVpr6/6+1XKpGk8dti0w1B9H/5jq/MNEU9hC+Xn4RSKa50VswDmfKwU0XD9OBVqZ
	r7jXI/GWHmRIOg6Gw3yNoxs4aWZFKi1k63zPwgAqQxixehiIiO6xhTwl19YaSVNRhWioxw15W8Hso
	aGy8myx34oqJErhUc2H2vUnhphcwB6tKH+NyFzm346epIyvgclZhx/3QfevqpGjJrqpWGkRL+nZy6
	REV4Ohz4Q4oZpwTkqCzSzQ2qp8bn+Q1TUEB1wgx+hBR4vMGi0Xul7+wDBhifK5YBrT/CGa2VqSm1o
	LdtWu4kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyfQG-00F3mw-TI; Wed, 30 Jun 2021 18:58:56 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyfQE-00F3lg-7h
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 18:58:55 +0000
Received: by mail-pj1-f52.google.com with SMTP id kt19so2439363pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 30 Jun 2021 11:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pAxmYwWjjUNWwuxJKS+gb8WM247UFByinkjRrhSt9y0=;
 b=HGAcTCI0hCFGV4ZVhKK8pbVE97BlfbcblNrhjFYWOlRjhNaJrji2oNyGxOrwyK5UIm
 l7pewEx3usZn5fzykqxQWKg5VK0dL2Ni8WzJqQ85YC8H+Yt85jwl9fEXavQf3Kmc5wXg
 d9ds+efIIB0PhAQ3mWnOIL456sS5/3ICMq8W545PCjWrXRYhGRfQ4IUj0DI1Cw+JbRn1
 gtSEFwnmrcywZUvL5oFm0wAgP5kGBfDkv737L4ye2LAhYf7VcloYqf/bLogOT+hTv26I
 3IsKTxs186jfJhSdCTTu2jG1RoUWGr6WG2Ea/pqqCUSgxj9e9NwI90r/wjL87NVe8H+x
 rLzA==
X-Gm-Message-State: AOAM530fgHEKlniMmXS0C6RyMShkJO5sVaQfgFDhDp2IMTjKMl8/ezCm
 f/GMP/QcV3IW+3K9RES+zrs=
X-Google-Smtp-Source: ABdhPJxPv9woprMTy8UdcPtmWSzvNrEWD+trqYefbyKXifMQvZrxSPP0TGQR4Ipgz1xG1AtzZSl5tQ==
X-Received: by 2002:a17:90a:65c8:: with SMTP id
 i8mr5811588pjs.207.1625079529184; 
 Wed, 30 Jun 2021 11:58:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8e5:b428:30c3:f97b?
 ([2601:647:4802:9070:8e5:b428:30c3:f97b])
 by smtp.gmail.com with ESMTPSA id w6sm329136pgh.56.2021.06.30.11.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 11:58:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To: Damien Le Moal <Damien.LeMoal@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0f8be11b-c6de-1c2b-323b-1e059c2ac4f8@grimberg.me>
Date: Wed, 30 Jun 2021 11:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_115854_307458_8A9769E0 
X-CRM114-Status: GOOD (  11.24  )
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


>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 21140132a30d..600c5dd1a069 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -403,6 +403,7 @@ enum {
>>   	 */
>>   	BLK_MQ_F_STACKING	= 1 << 2,
>>   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
>> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
> 
> My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.

Maybe BLK_MQ_F_UNMANAGED_IRQ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
