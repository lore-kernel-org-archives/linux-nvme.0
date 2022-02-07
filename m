Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B920C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXD0jESnnK12cdBXFNZGtkxUHkpdjn2dlAsihzEuSmI=; b=1FzysFbvg/yihFUPilkwBlXmdR
	K44f+DOgTeQdCiXbJny/uDoT1tAR1u2mS1k85Ha4j8tTa04vy5UWwpN+RUjgYePj6p194+CYgepqz
	YpH00Xl6E1nSZtH36Aq56DzTKbCMoEFp+wj6uQJwlSdupZhkV/KxI9g17cweKRcZ5pkqytuOM80tz
	KeP9iuuwEcQllht6/omBS2kF2KZR7+b4UDyT2LTovpqh3LbPkZRY6dwsgibD0NHdUxJzkf1R2+rHq
	D+IAft1T1Ng8bxTwZmQoTjEjYgfH43Eg/AgjTTtTouCiR1+3f6vQCCaH5Y7Th9WXDnKJxU1Nq2r4Y
	4R79qHTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH3dc-00ACt7-M6; Mon, 07 Feb 2022 13:01:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH3dZ-00ACsl-Ed
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 13:00:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ABF1210F7;
 Mon,  7 Feb 2022 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644238854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXD0jESnnK12cdBXFNZGtkxUHkpdjn2dlAsihzEuSmI=;
 b=S3ZEJNg/VQ6IKMELQ1dCmRJPv5QABM4uGr8zKjVAbSwHeDtLiaw0nKdCmf5MLRurB+M7zg
 5syMd7CoKSLDv/kvfIZpcLerGvMT+7dafF4Gw+lDh2Jpi4xsWH+d8kKFLohXSd11AYNBkJ
 nsV1VO0r1X8NhOSc1vYamxALJxWE0v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644238854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXD0jESnnK12cdBXFNZGtkxUHkpdjn2dlAsihzEuSmI=;
 b=PgpE1pnW6bC7Ygt2zlzI5izVcm+/hXAh7ZsaLDvOrP8zRRuNxy092HbdQJ5x0bN8+F4wvW
 pfziLuKzwgpHkRDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B92A13B9F;
 Mon,  7 Feb 2022 13:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hHAQFgYYAWKzEwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 07 Feb 2022 13:00:54 +0000
Message-ID: <285e28aa-4297-4f29-e8c4-25f8222b85a2@suse.de>
Date: Mon, 7 Feb 2022 14:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220207100005.34404-1-hare@suse.de>
 <93fb8e2d-3edc-0753-f71a-34c7ce054c27@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
In-Reply-To: <93fb8e2d-3edc-0753-f71a-34c7ce054c27@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_050057_662005_DCF5F7BF 
X-CRM114-Status: GOOD (  21.50  )
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

On 2/7/22 13:37, Sagi Grimberg wrote:
> 
>> On large installations the ANA log buffer can be exceedingly large;
>> we've come across a controller with 49 ANA Group Descriptors and
>> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
>> And this is just to validate that the namespace ID is _really_listed
>> in the log page.
>> So to avoid an overly large memory allocation we can leverage the
>> 'RGO' bit when retrieving the ANA log page, and check whether the
>> ANA group ID from the namespace is found in the ANA descriptors.
>> That cuts down the memory allocation, and provides the same result.
>> But to be on the safe side I've added a module option 'ana_groups_only'
>> to switch between modes.
> 
> Hannes, why not a sysfs writable attribute? One can add a udev rule if
> it wants a one-shot all controllers...
> 
'tis a bit late, innit?
By the time we manage to write to the sysfs attribute (which, out of 
necessity, will be a controller attribute) the controller is already 
present, and the ANA log will already be read ...

> Although maybe that will bring us to yet another attribute that is
> unstable until the controller identifies...
> 
Yep.

> I think we are getting more indication that the controller device
> creation is sitting in the wrong place...

As mentioned earlier: main problem is that we need the controller device 
to initiate a controller removal. And as there is a possibility that the 
device initialisation _itself_ goes wrong we might need to tear down the
controller even before initialisation is done.
Which currently requires the sysfs attribute.
If we manage to figure out how to do that without the sysfs attribute
we should be fine.

Not that it'll help us in this case, though.
The only way out of _this_ issue is to pass in the configuration for
controller setup, ie adding a new argument to the fabrics configuration 
(eg 'ana_groups_only=1' or somesuch).
But I'm not sure if we want to go that way ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

