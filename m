Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7FC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXp+e/8ZlpcQN5FQo7iwO9NTQnG+9sMluTZb2M+MXrc=; b=siFbceJdNAQe6ALIc1TEqioNVz
	VH/9GHZD9TKQYJqXqm4ZXHHyfF0WfM8hcz/wH9LQVMocX6vsfcJNDAW31iCV8E1ciL7nt7GEj6LpG
	BNXIOSo8Lp+putPNwSCZsfX1KdwTd2vCeeWNINevGqbJSGluflJ3cAhnPuOlhwFl2Pl0F8Qa4O3UB
	Tq+6w+czPJ6sLUiRpRla4i3+LfwqhadKFDxT0fYvGdcAsHShD/5zrf1GEYYZGrA5JmItOEAMWuR8w
	1ThRV8LjOaz35njQRGr0EcgtAxhkkZBoBtqij/2hviXBvl8jGp7upkhCsZsV/sjAjdpxppvof8t+Q
	R+JsjNBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDZ7l-003bVf-MS; Fri, 28 Jan 2022 21:49:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDZ7i-003bUM-7g
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 21:49:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21FE21F385;
 Fri, 28 Jan 2022 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643406576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXp+e/8ZlpcQN5FQo7iwO9NTQnG+9sMluTZb2M+MXrc=;
 b=s5gfm0vyKaAQz07A1aEi950h7NwrFEFlvrz6NYyBlTxYJe0o2Dvpuy57hpsor3EJOxrwJq
 7QMftfQfTK79khc5kVTDtf6ownhv0LXQvR197BgZ10x0JKHLUkaSbXBCIPh2OPZLrgG9gw
 NSl+/Y/uTC1590aV50gxq4AOk5wO52o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643406576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXp+e/8ZlpcQN5FQo7iwO9NTQnG+9sMluTZb2M+MXrc=;
 b=i3IiUAoJkGNt6l4nxE9m8UaYZfgd51MGuRbivP3P4ipFae0XOFXp5LisCnCJzvYnsO2nSW
 4Yx5LZFeJJ+WRQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ADE813AA1;
 Fri, 28 Jan 2022 21:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OgBGI+9k9GF9cAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 28 Jan 2022 21:49:35 +0000
Message-ID: <37587400-076b-059f-f163-fd90babde443@suse.de>
Date: Fri, 28 Jan 2022 22:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
 <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB4544136C4622118DBCEBFFA1F2229@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_134938_466230_F307DF43 
X-CRM114-Status: GOOD (  27.50  )
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

On 1/28/22 18:55, Belanger, Martin wrote:
>>>>> Wouldn't it make more sense to delegate explicit registration to
>>>>> userspace (ie libnvme/nvme-cli), and leave the kernel out of it?
>>>>
>>>> It would. There is no reason what-so-ever to place all this register
>>>> stuff needs to live in the kernel. We have a way to passthru commands
>>>> so it can and should move to userspace.
>>>
>>> I wish it could be delegated to a user-space app, and in fact that was
>>> my original design.
>>>
>>> Unfortunately, while testing I realized that the kernel can
>>> autonomously reconnect and user-space apps are completely unaware of it.
>>>
>>> For example, let's say the network goes down momentarily. The kernel
>>> then tries to reconnect. Once it successfully reconnects it doesn't
>>> tell anyone about it.
>>
>> Then add a uevent on the controller device-node. From there you should
>> trap it and do what you need (exactly like how discovery log change events
>> are handled).
>>
>> BTW, I also don't understand why the host needs this reregistration on
>> reconnect, but that is besides the point.
> 
> The fact is that when connectivity is lost and restored, we don’t
> know whether changes have occurred on the host (e.g. maybe the
> symbolic name was changed while connectivity was lost, etc.)
> and thus registration must be reapplied every time the host reconnects
> to make sure there is no stale information at the discovery controller.
> 
>>
>>> But let's say the kernel does send a signal to user-space on a reconnect.
>>> What if there is no user-space app to receive this signal? I'm
>>> thinking of the case where one uses nvme-cli to set up persistent
>>> connections to discovery controllers.  In that case there is no app to
>>> send the explicit registration on a re-connect.
>>
>> This argument does not justify adding functionality in the kernel that doesn't
>> belong there. If we were to follow this argument we would be placing
>> everything in the kernel. If someone wants this functionality, he/she needs
>> to use the tools required for it to work.
> 
> Ok, Hannes, Sagi, Christoph, et al. I got the message loud and clear.
> Explicit Registration does not belong in the kernel. And, as you suggested,
> the kernel needs to send a uevent when it loses connectivity and
> another uevent when connectivity is restored. This will allow userspace
> applications know when to reapply registration (if needed).
> 
> I'm not a uevent expert (at least how to send uevents from the kernel).
>  From what I read, there's only a limited set of uevents defined (i.e. add,
> remove, move, online, offline). The nvme driver already uses the
> uevents "add"  and "remove" when nvme devices are "created" and
> "deleted" respectively . We also have  the "change" event that is used
> when there's a change in the Log Pages. May I suggest that we use the
> "offline" and "online" events when connectivity is "lost" and "restored"
> respectively? Please let me know.
> 

I guess we already have that; cf commit f6f09c15a767 ("nvme: generate 
uevent once a multipath namespace is operational again").

When multipath is activated (and I guess that will be for nvme-tcp) you 
will receive a 'change' uevent whenever a path gets reinstated.

So that will be the time when an explicit registration will need to be 
reapplied.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

