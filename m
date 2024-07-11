Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35AC3DA4B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jul 2024 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKWCWTTVQoClgLKrkg7foAPSQlOJ8RIPpyjZ7FmXw0Y=; b=rvXR4cy+A67jZULkJIzdEt1KkH
	4QWdNmQHQq8JMqZYqowuCnjDMi5S8Uq87Ix2kyCpZ6vHgTjboLGXLWIZyDNTShIOA/Rf9s0vekSLQ
	W9qznwXR4Pq65sLUJy5mIhDptBhMSc7LuPUQc+D89BEPSlf6cGZKTLIKnK17rfBgAxm63f+rPcXQw
	gaZ31CUWZUnvGJptphVELnGd9IeMQNjWc+Y1tCi6VButnbAOEiTWwXWlLRMJIN4Fm1uyNqRMd8Eek
	ZYnjBKxYV425XdzV+i9xhgf2RqTrny1mqEVGTVDdvbP0Il15edlQ8WWaKpwJgVkWleyJ/rQ3KY1rF
	NSYmZO7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRzBJ-0000000F9rS-3BVN;
	Thu, 11 Jul 2024 19:10:17 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRzBG-0000000F9qm-3Puz
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jul 2024 19:10:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WKknd3jlWzllCRr;
	Thu, 11 Jul 2024 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720725012; x=1723317013; bh=YKWCWTTVQoClgLKrkg7foAPS
	QlOJ8RIPpyjZ7FmXw0Y=; b=HevVribMMdTwLS+nMoB6WgPdVX+ZHcg2LEPdiGyr
	shHgepd0CtAHgPA51dgcU2JVBPRG3SuEGm90GxWpFEyW6Yv0DwRZ09cdR5Q8Q5ln
	tooLAsfOuT19Wbu/nyJO4AEAUh1E/0mWhpn6kSZgoWxXgg8fYnv4jGSh44vyZsbc
	/MtVh5apVIRjKX1UdrR84JeP205R5bDDl55QN4qi8HYpMSQ7LSHvuJkrH7RdgZU7
	l8d/SvbcmrLcLqt8dCfaSVQQ/GaG+pMNd50g25ZFWUgzJw9CQpOHh2Mdm9H8cTqR
	/7jvh3jlrSt2OMUhoALoMujtn0mUaVtt2jtqK6c0sk/fgg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SpTKEcg_acx7; Thu, 11 Jul 2024 19:10:12 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WKknb6KzbzllBdl;
	Thu, 11 Jul 2024 19:10:11 +0000 (UTC)
Message-ID: <76184984-3ca5-4df8-9c54-f803ea9d5499@acm.org>
Date: Thu, 11 Jul 2024 12:10:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix the instructions for disabling power
 management
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240710231805.10481-1-bvanassche@acm.org>
 <ZpAr89uectd_fTzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZpAr89uectd_fTzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_121014_908838_3790E717 
X-CRM114-Status: GOOD (  13.13  )
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

On 7/11/24 12:01 PM, Keith Busch wrote:
> On Wed, Jul 10, 2024 at 04:18:05PM -0700, Bart Van Assche wrote:
>> pcie_aspm=off tells the kernel not to modify the ASPM configuration. This
>> setting does not guarantee that ASPM (Active State Power Management) is
>> disabled. pcie_port_pm=off disables power management for all PCIe ports.
>>
>> This patch has been tested on a workstation with a Samsung SSD 970 EVO Plus
>> NVMe SSD.
> 
> Interesting, didn't know about that parameter. Does this actually aspm
> too, though? It looks like we want aspm policy to be performance for
> that to happen.

Hi Keith,

I don't know the answer to your question. All I know is that the
settings from this patch are required to make the SSD mentioned above
work reliably.

Thanks,

Bart.

