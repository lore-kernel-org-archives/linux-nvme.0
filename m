Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476CCC87FDC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jjOGfiqox+GbJO//HIGL34I5/7yd3Mqh5dO5Vkk3VXY=; b=2UiVkfhp52Pj6M4gPKCp1JE36v
	EF/uJtiq0+l1vSdKMLLN67V2vtU/Q0f7bjqA4B7gIQGOPdXMPehddcsJPKKBtnKKYWAmgpxQxo0to
	0Na6iZsRaHgEhnA+LcUGoC1vnANlr43LRbCIQVCcIbY/uULkRyyZAJyRy0+wyYZMve1/9RSokDbja
	SktAMgeNWkhtqYutvHf2dwninQBbKpZerWwWXaWER0aRiZB93J2KsimPtuGlahZ/3otnzHnIiWrVM
	92zctQqH4tJ7aXFcVyPECUkwU4YgDBfbfOUD1HUMtDecnMOQWpc/5qv9QrKMbs6BFwu4RAzrx1U2Q
	5XKQ8ghg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7co5-00DDMc-0t;
	Fri, 09 Jun 2023 14:09:37 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7co1-00DDLY-2t
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 14:09:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FE84219D1;
	Fri,  9 Jun 2023 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686319765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjOGfiqox+GbJO//HIGL34I5/7yd3Mqh5dO5Vkk3VXY=;
	b=giVeX0ai7Xm8EPf7zSvbLKm5EDGGxFFk6gN07lE1HAemfx9NnO9n26FzkhmqLwTOkIcQia
	/OB2/Bph/ASBK2STk82nSklNPXVdztxCHlpytBrBoYoqP0k4HUgXsh70nUtuMQinHYA8vX
	UvckKR80iZ9pjZLHQMlATxaFO6Igkdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686319765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjOGfiqox+GbJO//HIGL34I5/7yd3Mqh5dO5Vkk3VXY=;
	b=jWaq4cqNv471UfnIDsh9AAlcX+m4ljKGsWWZJ9Jawpc+ZCvrwxib0AJj0mM6pX45frVN1L
	FtaD8ZjKzdToO8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74B6C139C8;
	Fri,  9 Jun 2023 14:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QNQDHJUyg2RoZgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 09 Jun 2023 14:09:25 +0000
Message-ID: <b7bc4336-d65c-c229-044d-9f484d129ac8@suse.de>
Date: Fri, 9 Jun 2023 16:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: nvme-cli/libnvme: Controller reuse policy
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rose, Charles" <Charles.Rose@dell.com>, "smith, erik"
 <Erik.Smith@dell.com>, "Farley, Douglas" <Douglas.Farley@dell.com>,
 Keith Busch <kbusch@kernel.org>
References: <SJ0PR19MB45449814FDC4D1279E8FB0BDF252A@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR19MB45449814FDC4D1279E8FB0BDF252A@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_070934_084061_1A7B89FC 
X-CRM114-Status: GOOD (  49.92  )
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

On 6/6/23 21:49, Belanger, Martin wrote:
> I came across an issue using nvme-cli/libnvme. It was suggested that I move parts of the discussion
> to this mailing list.
> 
> The relevant info can be found in the libnvme repo here:
> https://github.com/linux-nvme/libnvme/pull/647
> https://github.com/linux-nvme/libnvme/issues/648
> 
> My question is related to nvme-oF-TCP, but may apply to other transports as well (I'm just not an
> expert for those other transports).
> 
> The question is: How should nvme-cli/libnvme compare existing controllers (in sysfs) to a candidate
> configuration to determine whether to create a new controller or to reuse an existing one? >
Well, for persistent discovery controllers we should, right?
That's kinda the point of a _persistent_ discovery controller ...\

> Background:
> 
> The configuration parameters to create a controller are:
> 1. --transport
> 2. --traddr
> 3. --trsvcid
> 4. --nqn
> 5. --host-traddr
> 6. --host-iface (TCP only)
> 
> When trying to configure a controller, nvme-cli/libnvme scans the sysfs looking for an existing
> controller that matches the candidate config. If a match is found, nvme-cli/libnvme reuses the
> existing controller instead of creating a new one. nvme-cli/libnvme compares the 6 configuration
> parameters listed above one-by-one to determine if an existing controller matches a candidate
> config. Some of these parameters like "transport" and "traddr" can never be NULL. Others, such
> as "host-traddr" and "host-iface" (and maybe others), may be NULL when not needed.
> 
> Currently, nvme-cli/libnvme does a "soft" comparison for "host-traddr" and "host-iface". That
> is to say that if an existing controller was created without specifying one or both parameters
> (i.e. set to NULL), then the NULL parameter will be ignored when comparing against the candidate
> config. This may result in nvme-cli/libnvme reusing an existing controller that does not match
> the candidate "host-traddr" and/or "host-iface".
> 
The problem here is that 'host-traddr' and 'host-iface' are linux 
concepts, and have no equivalent in the NVMe spec.

While it's easy to do a 1:1 consistency check for a simple 'connect' 
command, it gets ever so complicated for the 'connect-all' case:
There we'll have to check each discovery log page entry against a 
matching controller in sysfs.
As the discovery log page entry cannot contain any of the 'host-traddr'
and 'host-iface' components, we would always default to create a new
controller for any entry in the discovery log page if the original 
connection was specified with either of these arguments.
Which clearly is not what we want.
At the same time we cannot re-use the arguments from the 'connect' 
command to the original discovery controller as we might have 
encountered a referral or the DLPE might specify a different transport 
altogether.

> Why is this important?
> 
> We now have support for booting systems over nvme-oF-TCP. What typically
> happens during early boot is that a controller may be created over the
> system's management interface (i.e. the default route). The management
> interface is typically a slower interface (e.g. 1G), which is fine for
> booting a system. However, once the system is fully booted we may want
> to use a different (faster) interface (e.g. 10G) to connect to that same
> subsystem. We can force the new connection on a different interface using
> the "host-iface" parameter. However, because nvme-cli/libnvme performs
> a "soft" compare, it will conclude that the existing (slower) controller
> is "good enough" and reuse it instead of creating a new connection.
> 
> One more piece of info (to make things more interesting):
> 
> When a controller is created without specifying "host-traddr" and "host-iface",
> the kernel will decide which source-address and interface to use for that
> connection. The interface is selected by looking up the destination address
> (traddr) in the routing table. The source address is selected by retrieving
> the primary address assigned to that interface. It is possible that the values
> picked by the kernel will match the host-iface/host-traddr of a candidate config.
> However, because they are not exposed in the sysfs, the comparison will conclude
> that none of the existing controllers match the candidate config (when in fact
> there is a match). This is one of the reasons why I added the "src_addr" parameter
> to the sysfs (kernel 6.1). For TCP connections, the kernel now displays the actual
> source address of the connection through the "src_addr" attribute. This can be
> used to identify not only the source address, but also on which interface the
> connection was made (by doing an interface lookup to find out which one matches
> the source address).
> 
> In conclusion, we have 3 choices to solve the issue of matching an existing
> controller to a candidate configuration:
> 
> 1) We can leave everything the way it is now. In some cases, nvme-cli/libnvme
> may erroneously conclude that an existing controller is "good enough" and not
> allow someone to make a different connection using a different "host-traddr"
> and/or "host-iface". We may want to document that behavior so that people
> know what to expect.

Why 'errorneously'? If the user has specified 'host-traddr' and/or 
'host-iface' we'll be selecting a controller which matches these 
criteria. _If_ we find several matching controllers it means that the
search criteria are insufficient, and obviously the user didn't care.

> 2) We can change the code so that nvme-cli/libnvme does a "strong"
> comparison on the "host-traddr" and/or "host-iface". This may result
> in duplicate connections because an existing controller that was
> configured without specifying the "host-traddr" and/or "host-iface"
> may in fact be assigned internally  the same "host-traddr" and/or
> "host-iface" of the candidate configuration and therefore could
> have been reused.

I don't think this it a good idea.
As outlined above, we cannot have all information for the 'connect-all' 
case, so we'll always end up creating a new controller there.

> 3) For the case where an existing controller was created without
> specifying the "host-traddr" and/or "host-iface" (and therefore
> the kernel picked those automatically), we can look at the existing
> controller's "src_addr" attribute to determine if there is a match
> with the candidate config's "host-traddr" and/or "host-iface". With
> this, we are guaranteed to never have duplicate connections and we
> will always know when an existing connection can be reused for a
> candidate configuration. However, this requires doing a lookup of
> all the interfaces to find out which one matches the "src_addr"
> (the lookup can be done through the netlink interface).
> 
Hmm. I don't think the is a different case; it's just the opposite
of case 1) (ie we have insufficient information to compare the existing
controller with).

I would shoot for having a 'lazy' check, in the sense that a 
non-existing setting host-iface or host-traddr is an automatic match
(as it's not specified, so clearly it's not important).
That will allow for persistent discovery controllers to work
'best', and at the same time to allow for the admin to override
the default behaviour by specifying all arguments.

Cheers,

Hannes


