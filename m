Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D82C25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjsimaRPHb7UJxQbmkfEwygEbKDMGRjJaOyop2F5HwQ=; b=neJAd1givsQhGP3GqrsS/Br9DC
	Ozj9MmkBQmDNBRx1vnG/07mCuzKa0HEwXUMsa0q7MLPKbiaLV9yNOoxXCvdfL3nUK2OUfE+nhRIJf
	gEmHJZ4zLhhtzigoHLMVbSx0uDSnlPQlGU6edwWEKi6dYGgBjbp8Y72FyHawJMKsF13VZCJI7OnDv
	peBjIivuX7j1hcb9ClSCOVaslsFicXNzK3CofOYzW9vv/zAzGzmgHtedoul4gu57eHNZB9ooHXyEG
	vhf9DBchpS8npjQZWfVEFmH6jH+yJwhMorbfo75Oeo8aYt+qFKUG9ZHYCVPg0myIppPFpHvwO08o3
	xW2H1rBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Di-00EeQ2-0D;
	Thu, 26 Oct 2023 14:20:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Df-00EeNy-2s
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 14:20:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5458C1F74B;
	Thu, 26 Oct 2023 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698330013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjsimaRPHb7UJxQbmkfEwygEbKDMGRjJaOyop2F5HwQ=;
	b=SDz/ZfmB6e5JgYNn+V39AjYqH+N/AIPngMWzZCQMuJkAJKqN383LoPyawhlpKPgJqvFVMl
	w08Wdsia5BwH0JgQGULAwb/OcR9FRwPCCI9mBEDakxlZSqkXg+FcCuKOq9w90yaIpHVLzW
	MALf4zx2o7K+BYKEz3A2qvgIPBo6ySQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698330013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjsimaRPHb7UJxQbmkfEwygEbKDMGRjJaOyop2F5HwQ=;
	b=m57HtoNIp0cUB4H+OBMJBIRBty0klNaQCDf/t6m44a/1hVTquNS0+1SCr021FIJif/RF3q
	7Fos/N/RiisJfLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 426E81358F;
	Thu, 26 Oct 2023 14:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2nvYD511OmWwUgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 26 Oct 2023 14:20:13 +0000
Message-ID: <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
Date: Thu, 26 Oct 2023 16:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_072020_082679_1C64B5F0 
X-CRM114-Status: GOOD (  13.17  )
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

On 10/26/23 15:37, Arnd Bergmann wrote:
> On Thu, Oct 26, 2023, at 15:08, Hannes Reinecke wrote:
>> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
>> index 244432e0b73d..96031016079f 100644
>> --- a/drivers/nvme/common/Kconfig
>> +++ b/drivers/nvme/common/Kconfig
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>
>>   config NVME_KEYRING
>> -       tristate
>> +       bool
>>          select KEYS
> 
> I guess that's one way to address the link failure ;-)
> 
> It feels like cheating to force it built-in even if
> both target and host support is in loadable module.
> 
Arguably.
But the decision matrix really has only limited choices:

Host Target Keyring
n    n      n
n    m      m
n    y      y
m    n      m
m    m      m
m    y      y
y    n      y
y    m      y
y    y      y

So we're correct in 75% of all cases :-)
And before we trying to figure out some weird complex kconfig syntax
to get all cases correct I prefer the easy solution.
Plus it has the benefit that the keyring is avialable right from the
start, so you can pre-provision keys even before nvme is loaded.

Cheers,

Hannes


