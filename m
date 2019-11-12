Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4BC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145ED222C1
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USQTCnlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145ED222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+SpIaS0mmqs37OjEgldWn4AwowQiqIYo7b9omCsJ0fY=; b=USQTCnlRnLOMbchGf5fBKxSz8
	prLFgFzm+jnCf/xFALwVk9sjjzJ4S+xyE8u5Fg4I1l+MPwQ5y0BjmXR8h7s4HFmrg5BMADsp2mEyv
	Vg8dOP54vJEZCoMEm0dTgJs71pjbd9WyGppte/rT4wEi+z6E055Lw1SWLnPw05MkyJ6hT8adCGfeO
	yQqxGeRKbmskQtj94D8Xxqgw4UQD2XparT8ZVkT+BzOscXelZ1yCXhGFucz3GbeiuM4AfuCxU1rA5
	V4LPJ/eBE49dBgxVzLCUdB5fjn2p88RQiet94ouHGRkKFP2R80vBnE2Zwv1WeuBC+4I3KYXuG2ZrP
	TDVEYSYnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUb47-0002Om-2x; Tue, 12 Nov 2019 18:38:59 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUb44-0002O7-Og
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 18:38:57 +0000
Received: by mail-ot1-f67.google.com with SMTP id b16so15212305otk.9
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 10:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2DssCvPwfJrqVlP64tcwfFjaMIov09kZepmIDo2nBvY=;
 b=MP96dvhIM5EDzBcVTNXhMCHNwqMrr35e3LVdVg3mPFScpmQAH7AMFjGBAOcmkexdgk
 8jYxT0Ecr3AGwOPlQW4dgUg78Rnf2r8wi/2audb8vpP/qz7rhdy+iMzAGVJi89KVis8G
 wQeHHJMnMGweC52DXdeOV9X8NFOwywAz4emXKZr/4muD9Rd/EC1H8Ss2i5HrvDWGdguE
 O1kCF3LdEAMkuIWcbrv8eMNf75hey87SAXLFK1nCQiYdQ8ZCMidyRQ60mQ/ZyDCdNh+L
 9kEzsPgdIAAuglDVJ9XSO3iAVVKZKIUuc37T6gQ0pYAy1OYwyCszAuXclN84LbWkiV65
 Tn7Q==
X-Gm-Message-State: APjAAAWix9n3XOXTGsoMZkczIjFiMzw7m7Y1laMyIAzU25PiRtWoRwvN
 pECakFQNipXLzF6TmjeFVYhjNr9E
X-Google-Smtp-Source: APXvYqwOwlLcXFuBMU+sw0Y6kR2ySnB2LC69WuOWehPIZ2vhIJ3Tf/hTZtkK/NE3AqJeLfO5o2Q0QA==
X-Received: by 2002:a9d:5914:: with SMTP id t20mr25423806oth.344.1573583936069; 
 Tue, 12 Nov 2019 10:38:56 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id u143sm6276627oia.14.2019.11.12.10.38.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:38:55 -0800 (PST)
Subject: Re: [PATCH 08/15] nvmet: Add metadata characteristics for a namespace
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-10-maxg@mellanox.com> <20191105175937.GF18972@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8fece784-eaa8-f5b7-fafc-09e4e01de7ab@grimberg.me>
Date: Tue, 12 Nov 2019 10:38:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105175937.GF18972@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_103856_801704_104B5255 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +	ns->prot_type = 0;
>> +	bi = bdev_get_integrity(ns->bdev);
>> +	if (bi) {
>> +		ns->ms = bi->tuple_size;
>> +		if (bi->profile == &t10_pi_type1_crc) {
>> +			ns->prot_type = NVME_NS_DPS_PI_TYPE1;
>> +		} else if (bi->profile == &t10_pi_type3_crc) {
>> +			ns->prot_type = NVME_NS_DPS_PI_TYPE3;
>> +		} else {
>> +			pr_err("block device %s: unsupported metadata type\n",
>> +			       ns->device_path);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		ns->ms = 0;
>> +	}
> 
> I don't think we should report these fields unless the transport
> actually supports metadata and PI.

Agreed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
