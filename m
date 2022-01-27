Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E457C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfTDtl2FY+unX5a74POkXos4ZovktzcqvFEaCyr8wYk=; b=xKyZ4WxFuHTpKhwd3MuHiGasfu
	c/Daa4DGI8WBgSAtNc0PeIcc2V4peI0phIBbaikdSPmwpAgDePGT066WOy/E+pWKLGdrVogE+5f6B
	6jeWeCevz+xmJalNM1IXrrIbn8Js1iBJWNytoCaRD2wUIi1UnWH1bFFbo1pYqVvgplkQt7U4Q6Sxi
	l1g7kEmiMmco87VzHGAHftlsg99yCljht+qsNJSAOof0ALyvhUMm1hDtTH/PWkCgvt+pNHltjkN0R
	eps1OdVzwlc3DCTLrTMImcS32reTjcicv3WngbIMeBMR3yxDXOy8HAuyI4zfDwENGdlSvS6s5AARc
	RTfPs8uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD5ks-00G4LP-1M; Thu, 27 Jan 2022 14:28:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD5kp-00G4Kg-C8
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 14:28:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6501A1F3AA;
 Thu, 27 Jan 2022 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643293681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfTDtl2FY+unX5a74POkXos4ZovktzcqvFEaCyr8wYk=;
 b=JGSCWwjRs37/b5ICUyFyVUAglSmvyAg8bAhCN0k94q+4Df0qFkE10JTYQSLOv7SPi/CbVY
 4KgXHBPIbrAEYnCQfmjFslD1ZVe+1QubWLomEYd0xOBUBXXTjbOhAx1OkHu+gKZhhyiUxA
 XSXrU6Ou+suWfn0E6ayL3P95QFXXDUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643293681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfTDtl2FY+unX5a74POkXos4ZovktzcqvFEaCyr8wYk=;
 b=3DM3SIRSEaiD2CrcgucM4yUSyEkyi6BZ/51qZdDP23IQZAYEFauVeyLR/r68TG6WJ7I4To
 abELuG7zwThwEwCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44A3413BF9;
 Thu, 27 Jan 2022 14:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNF8EPGr8mE1QQAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 14:28:01 +0000
Message-ID: <ced52407-bf65-b8ef-9de6-a56e7a2c6385@suse.de>
Date: Thu, 27 Jan 2022 15:28:00 +0100
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_062803_586747_BB7102C4 
X-CRM114-Status: GOOD (  22.73  )
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

On 1/27/22 14:30, Belanger, Martin wrote:
>>>> TP8010 introduces Central Discovery Controllers (CDC) and the
>>>> Discovery Information Management (DIM) PDU, which is used to perform
>>>> explicit registration with Discovery Controllers.
>>>>
>>>> This patch defines the DIM PDU and adds logic to perform explicit
>>>> registration with DCs when registration has been requested by the
>>>> user.
>>>>
[ .. ]
>>> I'd rather like to have the TLS bits in a separate patch; they are not
>>> strictly related to this issue.
>>>
>>> And I have a rather general issue with this: Is it required to issue an
>>> explicit registration directly after sending the 'connect' command?
>>> IE do we need to have it as part of the 'connect' routine?
>>>
>>> Thing is, the linux 'connect' routine is doing several things in one go
>>> (like establishing a transport association for the admin queue, send the
>>> 'connect' command for the admin queue, create transport associations for
>>> I/O queues and send 'connect' commands on all I/O queues, _and_
>> possibly
>>> do authentication, too).
>>> If we now start overloading it with yet more functionality it becomes
>>> extremely hard to cleanup after an error, and that doesn't even mention
>>> the non-existing error reporting to userspace.
>>>
>>> Wouldn't it make more sense to delegate explicit registration to
>>> userspace (ie libnvme/nvme-cli), and leave the kernel out of it?
>>
>> It would. There is no reason what-so-ever to place all this register
>> stuff needs to live in the kernel. We have a way to passthru commands so
>> it can and should move to userspace.
> 
> I wish it could be delegated to a user-space app, and in fact that was my
> original design.
> 
> Unfortunately, while testing I realized that the kernel can autonomously
> reconnect and user-space apps are completely unaware of it.
> 
> For example, let's say the network goes down momentarily. The kernel then
> tries to reconnect. Once it successfully reconnects it doesn't tell anyone
> about it.
> 
> But let's say the kernel does send a signal to user-space on a reconnect.
> What if there is no user-space app to receive this signal? I'm thinking of
> the case where one uses nvme-cli to set up persistent connections to
> discovery controllers.  In that case there is no app to send the explicit
> registration on a re-connect.
> 
Hmm. There must be something I'm not getting.

Either we have to re-register every time if a connection drops, but then 
the patch to unregister once a connection drops is pointless.
Or we need to explicitly de-register when disconnecting, but then we 
don't need to re-register for connection failures.

Which one is it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

