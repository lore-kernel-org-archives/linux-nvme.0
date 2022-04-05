Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB843C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6C8krGf7Xwvj5AYId3mQLEJhyIaeXB6zyKy+4eR4Fow=; b=Rv7VLgqe5E1vCozJbpm0p3komr
	Ua3ZqDazGBHW7MnTXeV0CxnmTO+3fXqZUIlR2K+8fwmyrHwMUlev1osufktpJPza4fMH9O5hSkbCM
	o1TRPwk+31Jp/QPuOaqQo79uuq3hcsN9LXKD270Q8thT1i/M1GP9f6cnk/NraXVJTbZmazBvA3Jr6
	BnKUx9hgl88e1cQgOG97i1xr4TrIA8NAjGfCf86jfmf4OULBBg0vYtlKAt2kM33QULZgtkIJ8FqxK
	6lcYNn+zkLKAquglOKW0HULc3+FXYWWS3/LxFp0Iq4P95mAwlHEsyZHv+QtZtZAmWWEsNAXscg7Vn
	lkDVE1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcmi-00HK7Z-KM; Tue, 05 Apr 2022 06:35:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcme-00HK6J-RC
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:35:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43203210DE;
 Tue,  5 Apr 2022 06:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649140519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6C8krGf7Xwvj5AYId3mQLEJhyIaeXB6zyKy+4eR4Fow=;
 b=LXyeEvjQkHVbGlL+sp8DOYuVpld5XuK6WFEWVLSxbmxbR4KaT/a0xjx1VYlOuBjKv7MjQr
 4kOGfIqxuj1LKxMkW3qa1nLVcyPqlBI2eQT58Rwzpp571sXDgwRE52vMzIjpRtQYdtK1IR
 tZQ5I9c/PsFDieydK3wqC0LJgoaKRU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649140519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6C8krGf7Xwvj5AYId3mQLEJhyIaeXB6zyKy+4eR4Fow=;
 b=uscCxkyIL5La1Aef2xBDgmDV0ZP5IBPDKxsJz8bJm10j8a7Vwg+1T96PkdtC0zo8a7tjb8
 8i0fOvOlyXiHmTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D21D13A30;
 Tue,  5 Apr 2022 06:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A+bZMibjS2JWWgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 06:35:18 +0000
Message-ID: <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
Date: Tue, 5 Apr 2022 08:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405061941.GA24290@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_233521_064022_65CA3F4A 
X-CRM114-Status: GOOD (  15.71  )
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

On 4/5/22 08:19, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 08:15:51AM +0200, Hannes Reinecke wrote:
>> To make it configurable.
>> Unique discovery controllers show up in configfs just like any other
>> subsystems.
>> And with that we need to clarify the relationship between the discovery
>> subsystem and the other subsystems, ie which subsystems should be presented
>> by this discovery subsystem.
>>
>> Linking the discovery subsystem into a given port makes it obvious that
>> a) this port will be presenting a discovery subsystem
>> and
>> b) that the discovery subsystem will be presenting all subsystems
>> configured on that port.
>>
>> The built-in mechanism for discovery subsystems was okay as long as the
>> discovery subsystem was built-in, too.
>> But with this patchset we're moving to an explicit configuration.
> 
> Shouldn't we just require anything to be manually listed for this
> case similar to how we configure referrals for the well known
> discovery controller?

Which is what I've tried with this attempt.
I did _not_ want to create a new configuration mechanism, but rather use 
the existing ones.
And the existing mechanism we have is linking subsystems to ports.

If we want to treat discovery subsystems differently (as you proposed) 
we sure can have a different mechanism on how to configure it.
But I wasn't sure if that's the direction we want to go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

