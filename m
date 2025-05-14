Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED3C3ABCB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 06:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YgIHSVCve782Kh2APOaAY5EGQKbI+6Zs7QVRLG/E4CE=; b=wZshW0hVaRAt81KfqF+CL9yJIA
	HPaVoF26sBKvhy606ko9eCY4CR5hBryvCCfkmFsaQQZMzthOQJGchpPCrHFoyx0y33od+stovH8/o
	X+WpLbpL/P71+nTbny+7xzCyzeCoG4rOP+Pqd0Pec+KNCVbkXmv/2DPiXZxNDBD7lCpcI/CWejey/
	idK0rOYm0SRjieVI4tyovoDNnJPzL2oJKeufsQUbuQXeuGhqLkxQrY3G9cF27vxAxCkoPJfIqbInx
	c+KZx6dgZIvOa0TkafxHnBEz8OpHu7IbbWMyCdGRFJVp55K0/qkQuUg1k+Unrhdc/6Wn+OLyILvPX
	UVPGdPPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF5kV-0000000EBjU-2QsW;
	Wed, 14 May 2025 06:37:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF5iN-0000000EBQ2-0olc
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 06:35:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F67721234;
	Wed, 14 May 2025 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747204535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgIHSVCve782Kh2APOaAY5EGQKbI+6Zs7QVRLG/E4CE=;
	b=RIME9X7Id/k4kW/x4eLK/T9T6Ym04j9jSxszLz2GUpNOHz9Hh1JJDcBiPdCvmttaNP4SZQ
	fEP4AdUZm33E6qDYv1T4V2tKCXQ6BY7xyQHUpc8girRxlw/WRIsGb1xAAywrEtKsQB8Sno
	6edgD9P3UPP1B2pg60l/Oz7W6MmlhBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747204535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgIHSVCve782Kh2APOaAY5EGQKbI+6Zs7QVRLG/E4CE=;
	b=BgspE0ruVdIg1HXIhJ+B3d4W+PKrOUMuqw9n/f0csI3D7XfINyx7sVdKGV4vMpIy8Kx/zT
	BnM4PHIo5xsWWZDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747204535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgIHSVCve782Kh2APOaAY5EGQKbI+6Zs7QVRLG/E4CE=;
	b=RIME9X7Id/k4kW/x4eLK/T9T6Ym04j9jSxszLz2GUpNOHz9Hh1JJDcBiPdCvmttaNP4SZQ
	fEP4AdUZm33E6qDYv1T4V2tKCXQ6BY7xyQHUpc8girRxlw/WRIsGb1xAAywrEtKsQB8Sno
	6edgD9P3UPP1B2pg60l/Oz7W6MmlhBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747204535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgIHSVCve782Kh2APOaAY5EGQKbI+6Zs7QVRLG/E4CE=;
	b=BgspE0ruVdIg1HXIhJ+B3d4W+PKrOUMuqw9n/f0csI3D7XfINyx7sVdKGV4vMpIy8Kx/zT
	BnM4PHIo5xsWWZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4DB1137E8;
	Wed, 14 May 2025 06:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eItrMrY5JGjccAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 14 May 2025 06:35:34 +0000
Message-ID: <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
Date: Wed, 14 May 2025 08:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Sagi Grimberg
 <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_233539_528870_CC706A2C 
X-CRM114-Status: GOOD (  18.76  )
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

On 5/13/25 21:24, Kamaljit Singh wrote:
> Hi Sagi, Hannes,
> 
> On 09/11/2025 02:11, Sagi Grimberg wrote:
>>> IO timeouts are still occurring with Writes. The only Read that timed
>>> out was most likely due to the path error. It takes ~4.5 hours to fail.
>>>
>>> However, this test does not fail if either ECN is off or if digests
>>> are not enabled. These passing combinations were run for 16+ hours
>>> without any issues. Both ECN and Header+Data Digests need to be turned
>>> on for it to fail.
>>>
>>> Do you have a failing test as well? If so, is it quicker to cause the
>>> failure? Would you mind sharing any details?
>>>
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] block nvme1n3: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 opcode 0x2 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>>>      [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 seconds...
>>>
>>> In the current build I had these patches on top of the "nvme-6.16" branch:
>>>      41b2c90a51bd nvme-tcp: sanitize request list handling
>>>      9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets
>>
>> Kamaljit, with the prior version of the patchset (the proposal with the
>> wake_sender flag) did this not reproduce regardless of ECN?
>   
> With the last patchset, when ECN=off, we did not see any IO timeouts
> even with a weekend long test. This was true for both cases, i.e. with
> Inband Auth and with SecureConcat.
> 
> With ECN=on & HD+DD=on IO timeout still persists for both Inband Auth &
> SC. I’m currently debugging a possible target side issue with ECN. I’ll
> let you know once I have some resolution.
> 
> I don't have any clear indications of the original kernel issue to be able to
> differentiate against the current target-side issue. So, if you want to go
> ahead and merge those two patchsets that may be fine for now.
> 
Thanks a lot for your confirmation.
We continue to have issues with high load or oversubscribed fabrics.
But this patchset is addressing the problem of I/O timeouts during
_connect_, which I would argue is a different story.


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

