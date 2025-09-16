Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB585CAC598
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88wZCM/SrwLZmsYHtzhh4mBHfhvxkYG0EV5pYfT2s8g=; b=DP9aAjnGKpOMfIqeuqsGuKKTDV
	CAFhDXXJZ5hT5Y4z6qoYT7MbPX9FY+RXjI2JUVPijVsREn7MVhyAuezCoIl38LThBisvc3kGDCH18
	alnJr0CTV3WhNfDUTf+cUYV/YvToSuEdf+sE88wTn9shZGZl471n9LjrsdeJgGPIV0E3dvj/34SfT
	Tuvg8RAYhYdG6ZjXrZ1uX3/nWWyErIN0Rrn0fGfYj8s1M5DwNl3O5Ff/iExAvXUMslmVT/zbJTsk0
	3nQS8w34aVSFz4LlGQZRZl2cF5hX5myMK18eVqFMASHf7Q26uqxYrN+Jw0xOqJhIV2OB4UNudj2fP
	uH3+LS8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYsQ-00000008WxY-3XSk;
	Tue, 16 Sep 2025 16:49:58 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYsN-00000008Wud-2Amc
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 16:49:57 +0000
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id F0FB12FC0047;
	Tue, 16 Sep 2025 18:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1758041390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88wZCM/SrwLZmsYHtzhh4mBHfhvxkYG0EV5pYfT2s8g=;
	b=ZytCOCc0UyBzQBeS28n5hsExzY/6pn7H9Lv9jMV9r9GphbDGZB1Skb7dVoG0RGY5WLFKQQ
	wzk7n3103G6JMgA8JgjuIXD90Ev7UIrpPJLbmqC8vN3/64ehzdVnJ5f5HPODkPxwEjHiy7
	4wuWdHu6sMaNsoaJ7EylURJYPUBMS8Y=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ca327bf4-cd65-4c3e-b63d-7ac2b88b9cad@tuxedocomputers.com>
Date: Tue, 16 Sep 2025 18:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
 <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_094956_011724_5DC320DF 
X-CRM114-Status: GOOD (  10.87  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Am 25.08.25 um 18:07 schrieb Werner Sembach:
> Hi
>
> Am 01.07.25 um 22:55 schrieb Werner Sembach:
>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>
>> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
>> a high power consumption in s2idle sleep (3.5 watts).
>>
>> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
>> a lower power consumption, typically around 1 watts.
>>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
> gentle bump for this not to be forgotten
bump again
>> ---
>>   drivers/nvme/host/pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 8ff12e415cb5d..d677080e67d33 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3198,10 +3198,12 @@ static unsigned long 
>> check_vendor_combination_bug(struct pci_dev *pdev)
>>            * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
>>            * because of high power consumption (> 2 Watt) in s2idle
>>            * sleep. Only some boards with Intel CPU are affected.
>> +         * (Note for testing: Samsung 990 Evo Plus has same PCI ID)
>>            */
>>           if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
>>               dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
>>               dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
>> +            dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
>>               dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
>>               dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
>>               dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))

