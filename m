Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEFC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 06:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btH9QEVreH2KmFOlI/0qZP4MnbyqjUyR9aRHtgtaxMw=; b=etGcD9RkhkX9m7H2V6dvjKLabk
	4BRo+o60/Ey9JEQLso1ZwiJtCrZ5SFQlEflzTFPSXha0m1Lzpo84YeqO4PLLMKu/1FexTYSYitUJ9
	Qyzl761g0nJVNiGUNg5YYDDuPM6yNCvZUP+nFh+jHYOSs43nx8ZGVmkExExIN37bxyaN0j4tQ644W
	hUotHG8u4s+N8qE3fOW5MM7Jic183sMBU6AKCrkPcawn0axuKawNxjlPcWfxElIoAXacrS05/R0lC
	cPgZNKIo/5mc0oVtkl/ZI4nJ7BAbvRtW2lwx+gvYEovFeUtmeQwRjO4rC8i3/le8zHxDKAdEPtGxo
	mL1SbpYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyokz-00BDh8-MT; Wed, 08 Jun 2022 06:01:29 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyokx-00BDgQ-2f
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 06:01:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BEC521B2C;
	Wed,  8 Jun 2022 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654668083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btH9QEVreH2KmFOlI/0qZP4MnbyqjUyR9aRHtgtaxMw=;
	b=ZhrRl57lSBhmUkJ+KGZFvmpQBdXkiTk3CckBYTGZQZI2joEt9lp+fRBqC8+XUbrcHPp8nN
	3fgSx7CW7GBN+y6r0KnntRck2WvFO9rrnfybgzSAaOkPMv7EcFXkTwoDS6r16qMdzw6Ems
	dbGep3v8dhIk7c+gZx116KpTLymzuDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654668083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btH9QEVreH2KmFOlI/0qZP4MnbyqjUyR9aRHtgtaxMw=;
	b=QQQnk9+hjmch0xCVSn0DqCNqbzi5Q8ztATe8g03pH85nORMl1dxkNJ0jreV3Ta7meoMxa9
	ZzbIR1M9jEREAXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E3CC13AD9;
	Wed,  8 Jun 2022 06:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +z1OBjM7oGKudwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 08 Jun 2022 06:01:23 +0000
Message-ID: <711d65c5-230f-32ab-4f5a-5594e2b3b7cb@suse.de>
Date: Wed, 8 Jun 2022 08:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/9] nvme: Implement In-Band authentication
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220527080457.90855-1-hare@suse.de>
 <20220527080457.90855-5-hare@suse.de> <20220607104941.GA26223@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220607104941.GA26223@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_230127_307739_C2D42867 
X-CRM114-Status: GOOD (  17.85  )
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

On 6/7/22 12:49, Christoph Hellwig wrote:
> On Fri, May 27, 2022 at 10:04:52AM +0200, Hannes Reinecke wrote:
>> +config NVME_AUTH
>> +	bool "NVM Express over Fabrics In-Band Authentication"
>> +	depends on NVME_CORE
> 
> Does this actually depend on NVME_CORE? As that would suck when pulling
> this code into the target driver as well.  Also in addition to the header
> location already mentioned by Max, this should probably go into
> drivers/nvme/common/ if used by the host and target code.
> 
That would mean to create another nvme module (nvme-common.o?), which 
would need to be pulled in by both, host and target code.
And really it's just the one file in drivers/nvme/host/auth.c.
Sure I can do that if you think that's better ...

>> +	  This provides support for NVMe over Fabrics In-Band Authentication.
> 
> This should probably mention that the support can be used both by the
> host and target code.

Right. Will be doing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

