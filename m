Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F74EB64D7
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jun 2023 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cRFQlbQSjSvXnae1FmcNPyyeh1Ke3ddaZ0oZprj09L8=; b=4QWsl0p+HEbkVz
	tYM7cNhuB2WCupV5hF9sJBsIxT2V/LTPNwOxV22aDw7/jkbdsRAlSj2kZerBM5ISEuBtrLu99Hby5
	4wsdO8p7jL59f6M+sFmyliPdBIlP8PzdnUOBJXK49S2QdqYnB1+yieUFReHnmGaUOcqdc99LclcdO
	OyVrH/jsBuh+Oq1cTB3hZBQOCUjV35gpn/HM1HT32OJYh0ABykgMhby0DVaMqSf0becLD1GLweNTO
	V6thW+1xoFpr1dGuu9SYj90Eus4FIooxCJ+ZGYeAcG7JKwxV19BNTx1kSWe+XP7tKj9kL5IBwwRse
	GMIBi5MOgz+AerVtEcmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDqvf-00Aqrv-2l;
	Mon, 26 Jun 2023 18:27:11 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDqvc-00AqrW-0H
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jun 2023 18:27:09 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qDqvS-0004ns-WC; Mon, 26 Jun 2023 20:26:59 +0200
Message-ID: <25015200-c433-f20b-0257-64d66b34930b@leemhuis.info>
Date: Mon, 26 Jun 2023 20:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US, de-DE
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, "Clemens S." <cspringsguth@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 John Meneghini <jmeneghi@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <martin.belanger@dell.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <8f4e6d32-55b3-9df5-de91-1afbcb30ce13@nvidia.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <8f4e6d32-55b3-9df5-de91-1afbcb30ce13@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687804028;ab8e1220;
X-HE-SMSGID: 1qDqvS-0004ns-WC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_112708_284910_75C12464 
X-CRM114-Status: GOOD (  13.72  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26.06.23 17:39, Chaitanya Kulkarni wrote:
> On 6/25/2023 6:15 PM, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> [...]
> 
>>> Only one drive, out of 6 is usable.
>>>
>>> These drives are rather common datacenter drives (Samsung SM-953).
>>>
>>>  From another Bug-Report (https://bugzilla.kernel.org/show_bug.cgi?id=217384):
>>>
>>> To fix it, please add two strings in pci.c
>>>
>>> { PCI_DEVICE(0x144d, 0xa802), /* SAMSUNG MZ1WV480HCGL-000MV  */
>>> .driver_data = NVME_QUIRK_BOGUS_NID, },
> 
> Please send a formal patch I'll be happy to review it ..

Huh, sorry, but why?

You might not know this, but Bagas is somebody that helps with
regression tracking (many thx for this BTW), so he's not even affected
by the problem -- and most likely is neither familiar with the code or
has the hardware to test the quirk entry.

Sure, asking others for help is fine. But from what I see this is
something that should be handled by those that developed the culprit.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


