Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F0ACD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=; b=Zg6LMQsMWLw+dsc/2mNbxA7dFO
	15Zguuj44y7fcdIr86+bWUdIKy85WrA9ESyRFcc4ry1312kiV3bFhgOp45U6PaJusGvOieIvKTFI1
	rFOdUjOSR/7+A+DOQRCTy4bE10K7ZjkmD3tdE2BHExEPc24FbWuMz7ft7BhSnZj61iv/WUZa/bOml
	W9354weKKsC6Mgn1OB3LWv/OQ4iGoQGBO+t05Q5TziHBS2jq+MlkjaXT/Bl0kxmGEHS8waBFugSf1
	20PzwIoguLAb6GSN/5/XfgeRbh0ToHIQUve154EF8viWDNnDawUWq/SHtVLl6NDRpk1ejHMP2W/fX
	mWXrQjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZpej-0000000HMhy-0l4x;
	Wed, 17 Jun 2026 12:46:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZpeg-0000000HMh7-2CVS
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 12:46:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 852BE6BEC3;
	Wed, 17 Jun 2026 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=Jv09Py2ibb2p76U7tmPO6+JKSHL7SQZmzF3SYhArTiW2XhZ+M8JagE4d7TJkER4UQBpext
	H8rESEB1Wyeur86OrTn1p5z4wNgD4u5mOcDiWY2ODdlXI0cldBwIjCCzKqLehUlpd9LjEv
	A1GQVcfT7ASW+/4gdoJOAXhXpgLppn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=aEkVkCnjmONgIOrsz+7RFhY4T3LNrFHSzXDNmFiH0Ay0zzNKlycPeYARg/kk6jGc5MjHnW
	xK8FX+3CQ2mKfWAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="k/VUKwPW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WY5tz4vW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=k/VUKwPWFCsBWCFJ7R8I6LF+OBDgI9fX4Lp5oFPo+igv6wYOpjqTI/7lEdoGjvEgUghnm1
	55dY7Ax7ODe+ZN2ft7c4GVdpdiULSnwwngiOVm25dctotN8Rsennvxkk2dsr4oBUWwqxoe
	t+wCv9Fz5Tjl0+yp9NFVVhRN0eZM3cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=WY5tz4vWM2UUy382LmDPSIyD7BWC+Vl4UH5Tb4Z4Gx/JES/mL9O89QA33bxJrakiZkLifu
	gQ5nIb437qZ9xuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C0F779A8;
	Wed, 17 Jun 2026 12:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cB8JGAuXMmqaNQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jun 2026 12:46:03 +0000
Message-ID: <51b505e7-ee2c-486b-b93f-3b5175f55899@suse.de>
Date: Wed, 17 Jun 2026 14:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] fs/configfs: switch to get_tree_keyed()
To: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-8-hare@kernel.org>
 <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 852BE6BEC3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_054606_712050_C8BB4218 
X-CRM114-Status: GOOD (  17.69  )
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

On 6/17/26 13:51, Christian Brauner wrote:
> On Sat, Jun 13, 2026 at 01:14:36PM +0200, Hannes Reinecke wrote:
>> Switch to get_tree_keyed() to instatiate a new superblock whenever
>> the mount namespace changed.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
> 
> So I wonder what keying superblock creation to the mount namespace
> really gets you. Imho keying the superblock by namespace only makes
> sense if the whole filesystem is tied to a namespace. For example, the
> mqueue filesystem is semantically tied to ipc namespaces so tying the
> creation of a new mqueue superblock to the ipc namespace makes sense.
> 
> But configs isn't semantically tied to the mount namespace at all. It
> encompasses a bunch of different subsystems that might themselves be
> semantically tied to different namespaces. The specific example you care
> about is nvme tied to network namespaces. But there might be other
> things that tie to other namespaces.
> 
> So even if you tie it to the mount namespace you presumably still need
> to filter what subsystems a specific configfs instance will display to
> each accessing task based on the namespaces of the accessing task?

Actually, I'm only interested in the namespace ID, as I'm using that
to lookup the corresponding 'configfs_super_info' structure from the
xarray.
I _thought_ keying it off the mount namespace might be the 'done' thing,
as otherwise I might presume future use-cases. But turns out that
the mount namespace is pretty much an internal thing, and really
unwieldy to use.
So I can easily switch over to the net namespace, and let other users
to fix thing up if it doesn't work for them.

Okay, I'll switch over to the network namespace here.
That certainly keeps sashiko happy if nothing else :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

