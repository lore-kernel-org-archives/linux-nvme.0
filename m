Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AI+saO6QVAOqn7QaqHqy3BYE/mMXq7dVIByCyV1Tk3E=; b=TMxnOiD4mL+53PvQ0aeKW5Vqhm
	vdTrmlF6w91CIdiiuotOiFWf2J0Nkp1EMmCsA7Xzfut8oHWG66Eujd6gZknE8nh/qI5hhMt1Oci32
	Ilh0afP47fh3AXw2zZeEf6MOZZA+1fAw8xpiKxH9GRoBQAJ2wHGPr3W0F0bHoYz/dAOhjFFbs9k1C
	XE68jkoE9xibm8N8YkHqilTwo4fNWWCAJInulh4a5BHaPRAl+4GBoLKh8oOQE+bozrWAzUAxATsaY
	VfL1FvK/Wn7lGiG5+qwuRvpKlus1ghZOjfw4al57eflY6hyYkIrxuwegZ9XAOPvM9cJLXx8mLsmT+
	LCQToFMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzIco-002WIb-7y; Mon, 20 Dec 2021 13:22:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzIcl-002WHt-DK
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 13:22:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BB40212B5;
 Mon, 20 Dec 2021 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640006561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AI+saO6QVAOqn7QaqHqy3BYE/mMXq7dVIByCyV1Tk3E=;
 b=OIir11YLvIF+lH8cg9qJHCN8CWRkTHJRJL1Sl4Xt/DJwt9Umzlm6XZ3jKaZKxwfuUyIV6q
 Cb0ahUMoJg6cRrzxN8F6bB9yh58kGpgt/p9TiVaGz99catn3EWNzcLFjzM0ow+3X3sQGga
 XIvJbGeTzePj7tKkizbtm3ZHEGSKk24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640006561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AI+saO6QVAOqn7QaqHqy3BYE/mMXq7dVIByCyV1Tk3E=;
 b=Rtu2iBiarUc1V8oK91Q7smmdc3T2ikfXdtYjbODfq0FyFXxOkE4YZQRZHnqxNG5laqXk9F
 BI4LRUqOztiu10BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6163313CA1;
 Mon, 20 Dec 2021 13:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CfcpFqGDwGEaegAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 20 Dec 2021 13:22:41 +0000
Subject: Re: [PATCH] nvme-cli: nvmf-connect@.service: Remove matching from
 default syntax
To: Martin Wilck <mwilck@suse.com>, James Smart <jsmart2021@gmail.com>,
 linux-nvme@lists.infradead.org
References: <20211217193232.29034-1-jsmart2021@gmail.com>
 <b7bf62931bd6d45128595646a7eb637a89d216aa.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a5750368-e74c-6f48-126d-5ec26cea0d86@suse.de>
Date: Mon, 20 Dec 2021 14:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b7bf62931bd6d45128595646a7eb637a89d216aa.camel@suse.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_052243_626995_E30D22A2 
X-CRM114-Status: GOOD (  24.25  )
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

On 12/17/21 9:43 PM, Martin Wilck wrote:
> On Fri, 2021-12-17 at 11:32 -0800, James Smart wrote:
>> commit 53aab69a0add added the "--matching" argument to the systemd
>> connect script that issues connect-all to a discovery controller.
>> When
>> this argument is used, only discovery log entries whose target port
>> traddr's match the traddr of the discovery controller will be
>> connected
>> to.  This eliminates the ability to do referrals by the discovery
>> controller.
>>
>> Revert the commit so that the "--matching" argument is not default
>> behavior.
> 
> Hm, I guess you have to do revert this if it breaks referrals.
> 
> The intention of my patch was not to suppress referrals. Unless I'm
> mistaken, a referral is a log page entry that lists another discovery
> controller, on which then another discovery is carried out. The "--
> matching" parameter was intended to ignore log page entries listing
> ordinary (non-discovery) subsystems on if their traddr didn't match the
> discovery controller's traddr.
> 
But this does assume that each I/O controller will share the port the 
discovery controller.
Which is not mandated by the spec (even if most arrays currently 
implement it that way), and it's certainly not true for TPAR 8010 CDCs.

So this is not the right way of approaching this 'problem'.

> I still think connecting to those entries is wrong more often than not.
> In the environment I was testing in back then, IIRC there were 4
> discovery controllers, each listing every subsystem on every
> controller. The host would try to connect to every subsystem 4 times,
> resulting in error messages 3 out of 4 times. With --matching, these
> errors could be avoided.
> 
This issue is a direct result of the NVMe spec not putting any 
restriction on what the discovery log pages can contain.
They might even contain entries not reachable from the current host port.

So again, the concept of 'matching' ports is wrong, and should be 
replaced by a concept of 'reachable' ports.
We can easily figure that out for FC, and it should be doable for TCP, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

