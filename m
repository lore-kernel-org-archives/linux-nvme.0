Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4519DC432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 16:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1117A20803
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W1/SBfTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1117A20803
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HlBZ6U0GBlZ9XiydtGuMkPeySNe7qJrZigKjEA8I34E=; b=W1/SBfTL9HrgX5nmL7lR7Z6Bt
	ximmeG4iTBnlJ0oBaJgKuLigARkebCPPEqLda7KGx6bU3zFbM9vZfEc2ho6E4WowUwnQ657jkrOYl
	G/IaBMjk/UKUnNQIX6aYsrFgWlE3wqnnUeXdYWIwgjjiISEuKrK8xs6itAukB+bFrSaGGC7wEgzqH
	qtQSqMGg3kwHfQdLQBx67Fr9Zkf2n+sUB3ktovwKFRhRfz09HlP9jCalgZ9E4N87MPbAd+hopwl/x
	p8R9IJGDUb8aLOpApW9DuOlBvpOz96mc39TezDMM0lY0B5qsygHoPreQYYAuLqNq+do8VGKHnKDYE
	QrvNXwL0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icAiv-0000dH-Tn; Tue, 03 Dec 2019 16:08:25 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icAis-0000cc-KA
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 16:08:24 +0000
Received: by mail-pj1-f42.google.com with SMTP id ca19so1696284pjb.8
 for <linux-nvme@lists.infradead.org>; Tue, 03 Dec 2019 08:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFS6NwyAyZXfqtvE+KSOavZX05oTFTPRu3h3j/7KSjk=;
 b=H0gMfxmziX9DjWHPGtJDwUlmnmDQLVTh3JqioSkQ7mwOv8f9XYU79N92l+mD7ifr/d
 OAPwabFbVjhK8imKY0mt+8hz09DrJpB8i1RZBpqdIvfUSSCkPaToudPjLRSaU8bOP9f4
 yPPf/FHg/V1T7eJ5kvJ+5OU9A8rEEmE+pHoIO63gXCWL8lQ3ZDKVoi5vDOAwwmc2sUSu
 mOc955pYTFlj6CgzjgcufI5k5dJZvT/QX5Xsp864dL7vDXCaOT3xlseg48aFIgFlXUQH
 JUy1o8OESQW9wNiQnGjOyw3qRQv7kwRD0Eobe6aWfQjWw3AxswviDtMMd5zya4PNZzTZ
 QzRg==
X-Gm-Message-State: APjAAAUwJhgfFIyRRV1LpDL3GTlDoLCteNd5aI4Z/Kv+pOraOO4c4c68
 VdOU43K4nxw4jZvawBIKUNPgeWlS
X-Google-Smtp-Source: APXvYqxZpHBanJ8PHClslMZ1lcLCekRWftOF9Xrsyt+ILAV0gMePd/RpOXDhcckrXQGwl7P5zhHb+w==
X-Received: by 2002:a17:90a:bb0d:: with SMTP id
 u13mr6449916pjr.100.1575389300488; 
 Tue, 03 Dec 2019 08:08:20 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id k24sm4153763pfk.63.2019.12.03.08.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 08:08:19 -0800 (PST)
Subject: Re: NVMeoF driver & Reservations
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Talker Alex <alextalker@yandex.ru>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <92087051575042507@sas2-7fadb031fd9b.qloud-c.yandex.net>
 <114736651575042639@vla4-d1c3bcedfacb.qloud-c.yandex.net>
 <BYAPR04MB5749D5699EB15878C41F4BA386430@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <962eea1d-e89d-45dc-9b3c-6a4606927a0b@acm.org>
Date: Tue, 3 Dec 2019 08:08:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749D5699EB15878C41F4BA386430@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_080822_665984_DA57A7D0 
X-CRM114-Status: GOOD (  17.24  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/19 2:07 PM, Chaitanya Kulkarni wrote:
> On 12/01/2019 02:19 AM, Talker Alex wrote:
>> Hi!
>>
>> Is there plans to implement Reservations support in target driver(from NVMe v1.4 part 8.8)?
>> I see that host support is already implemented in nvme utility & driver level.
>> However, I haven't found hardware on which it works - target driver doesn't support this command and PCIe drives available to me also.
>>
>> So, I'm wondering if anyone begin to implement this feature at least on single target level.
> 
> Yes there is and I also have testcases to test this feature from host side.
> 
> for target I did start working on this but stopped it since I didn't
> find proper use-case (or a client) for it to justify the effort and
> code getting into kernel. But if you have a legit scenario or a
> use-case I'll be happy to work on this.

Hi Chaitanya,

If you would be considering to develop test code for NVMe reservations, 
you may want to have a look at the SCSI persistent reservation tests in 
the libiscsi test-tool 
(https://github.com/sahlberg/libiscsi/tree/master/test-tool).

Bart.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
