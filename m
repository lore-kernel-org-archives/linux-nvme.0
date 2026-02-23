Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7AE98DF3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBo58MstPcIWn6VOJt/tETAdemE6+yTf7c3LbtY1JIg=; b=XtVS1dDpM4DhfNF4wRil1WCfiI
	AmcOY6cdlKEt/w/FjTHyPrZCQ4Z2cVYzm54xuNzYX6Pip9NfSeKiFlxBrTqoXvmDdhsXx26pwrqs/
	iDGt8WR3jzi/ge0Y/9xhWGgzoOm8IKaJqhceF+5LgjuxAnFGMUPgFZRO/Dvmsn5mjyC1gy2+piu6g
	5ymfTfCur6xJADQfMIkwWOED5hA/jIb6TDsK5kHHboc/8fCb+StqWtAxAMobOgqZq549h5HWScOF2
	n0fJA+ZWFrynOWKTb3g+iZCkgK/+wpgKx2HzIWhoMMHdiEF4rdiTQmcv6JPYnKCcGyRka6T5hYcLh
	zdmfv1ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQct-0000000HOx5-3J6j;
	Mon, 23 Feb 2026 07:45:07 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQcq-0000000HOwS-3tC1
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:45:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 754BD3EB5C;
	Mon, 23 Feb 2026 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771832701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo58MstPcIWn6VOJt/tETAdemE6+yTf7c3LbtY1JIg=;
	b=NAWTAMmDdpziSst9NYrgHw7NcSXguCbziS3xpdMoKfZ/tjj5MvR/d/7L7+Hwo4eFTRZ1e0
	gJ+xBqb93WsavP1vVVZZpF67CfpURcHJE+68YwA/A9qG7nVOsoJxAb6HwifDsc9cDMj5Lo
	+uCUUPkpS7HGfDTqFx4gdl4nLksdK3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771832701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo58MstPcIWn6VOJt/tETAdemE6+yTf7c3LbtY1JIg=;
	b=jyuqknaIBE1P771P7wT1MvFKHFnieotVGILEGDqppL28JjEJVWXVuh2uVDpO+IviiEtxXT
	A2tc6KB1O0mbPXBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCcPEya3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pnnQQt87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771832700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo58MstPcIWn6VOJt/tETAdemE6+yTf7c3LbtY1JIg=;
	b=KCcPEya3nvUYaKVpMSt90fX2Kat8pPq9drlPKfkbdDp5SKVFnBcYiygzOrKofrrgqINdnW
	5DZmQHrrD9VwBIcUi2dBnQTAozmrbHTVB68btA9AXhAr6zWnI9LJYG9KNKkIsgRXiFh6gP
	opuBKc93zUAluJg5SQQazjnmpOdfD0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771832700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo58MstPcIWn6VOJt/tETAdemE6+yTf7c3LbtY1JIg=;
	b=pnnQQt873Ai9Y/JRQkyFVTOvCXKoF4yoEk3/MTJF5ykzFgnxeCj+QhkYpQkqSgTW31Vg/4
	xDkl4Z8dwbaG9TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304933EA68;
	Mon, 23 Feb 2026 07:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4zMCXwFnGkrMgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 07:45:00 +0000
Message-ID: <8ac43648-6a65-47ff-b8e6-13513422bade@suse.de>
Date: Mon, 23 Feb 2026 08:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet: lift blocksize restriction to 64k
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Abdulla Nasirli <nasirabd@fit.cvut.cz>
References: <20260220151259.20372-1-hare@kernel.org>
 <20260220153237.GB14359@lst.de>
 <8d50557c-86a8-4364-b5e7-d40b36ad9f60@suse.de>
 <20260220164530.GB15907@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260220164530.GB15907@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 754BD3EB5C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234505_138610_2FA03CC6 
X-CRM114-Status: GOOD (  13.23  )
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

On 2/20/26 17:45, Christoph Hellwig wrote:
> On Fri, Feb 20, 2026 at 05:42:25PM +0100, Hannes Reinecke wrote:
>> On 2/20/26 16:32, Christoph Hellwig wrote:
>>> On Fri, Feb 20, 2026 at 04:12:59PM +0100, Hannes Reinecke wrote:
>>>> With commit 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
>>>> we can now support up to 64k block sizes, so lift the restriction on 4k for
>>>> file-backed namespaces.
>>>
>>> Still not sure this is a great idea by default.  Yes, modern Linux supports
>>> 64k sector sizes, but even then just for a few file systems.  And this
>>> changes existing setups, which will now break when upgrading the kernel.
>>>
>> How so? There cannot be any existing nvmet setup with an LBS backing
>> device, as the device will be rejected when trying to setup the target.
>> Which breakage do you see here?
> 
> There can be a setup with a large i_blkbits that we limit to 4k
> export LBA size right now, and with your patch it will be exposed
> as something larger.
> 
True.
Hmm. Okay, I'll work on something.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

