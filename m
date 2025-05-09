Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB82CC3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 06:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqJtJlMtTXMK5LUASMHdc+Re7ZoiZCJ6S4p38bW8Q+4=; b=eaZWOQjLjZ7+A5evA9oWLUQWpz
	PNT2S+/tjG19gP5Jbcwqf6Kt7vZEABpSCeWFcRQYbiWnZTIGoKRYQW0ppdxoRE39GBPwq5j1pV0HQ
	Bsp1SOyt3URrFQLKw7JcquVbaFEF3uL6IS865ias0hzDdWckrYbwHbsU+kI52qHqdGWpENtiMTGkq
	/VdgFQ9/HGb9h1Q/UqTYy+CO69tyaUl43yUGmKZozoasnwyW+b3IiL7u0pXDppxSA+IkeWklueQ6/
	bX1lQbqz0zka6sLKMG1OZ/ZyG6X8IfidpjRkMAlt3i3XbtoN9SQsz2V0zKI5St4zjFaRjUzH3uetQ
	5kCaZ00g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDHbg-00000002fTy-11cm;
	Fri, 09 May 2025 06:53:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDHau-00000002fOd-3frC
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 06:52:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C3C61F38A;
	Fri,  9 May 2025 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746773545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqJtJlMtTXMK5LUASMHdc+Re7ZoiZCJ6S4p38bW8Q+4=;
	b=y4e4wcoadAdmkgv64hwwDOVN0ZU4Zl4LJnkyOwCfyX1whNfHmreHgncPKUtWmE9/MSoxE+
	Verq5tcjU8cER8gGheNbJMlfdAIMWZOaCoLb6HCTD0ZbWOL27U0ChtGYp0nhcGbfyoSR9o
	Ie5E9yXsLwclugBfcmTvF/aey7QHzLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746773545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqJtJlMtTXMK5LUASMHdc+Re7ZoiZCJ6S4p38bW8Q+4=;
	b=WRXkIWdrYtAVfsv/CHzC9DVvjgnxAyhJY2ngM+N4dByYcgGAHJmaD00W4a19wxs3g+7K3i
	9QpO/0mp/p4LM+Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BExbk+UG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cUDV8h0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746773544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqJtJlMtTXMK5LUASMHdc+Re7ZoiZCJ6S4p38bW8Q+4=;
	b=BExbk+UGxp9Oi9ozf8k0saY60ZkAx1H4n0Uz0FfehckZzgrCjFENUVbcu0JoNU7kQNDyRF
	U5uv3cpj+m3dXz4Do/1fLIJ84qhrokcSxcHBkeYRie4zU85dmp2Bm/OX0rmJLN3l4GIm/2
	Rb6+4powIWWzRtzBJEMZzosq4NXYlu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746773544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqJtJlMtTXMK5LUASMHdc+Re7ZoiZCJ6S4p38bW8Q+4=;
	b=cUDV8h0LkCa8jlVY8SiXwQRFpzyW80m8XEblaHzEUqMYFJZWVeWy+MMET2dEvz7KXUmfSq
	N+oCAtgwEq2KEQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C84213931;
	Fri,  9 May 2025 06:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2E7DSimHWh0PAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 09 May 2025 06:52:24 +0000
Message-ID: <698775ee-3502-4f45-98bb-81ca495226ec@suse.de>
Date: Fri, 9 May 2025 08:52:23 +0200
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C3C61F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_235229_063928_479B9CA5 
X-CRM114-Status: GOOD (  19.99  )
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

On 5/8/25 23:23, Kamaljit Singh wrote:
> Hi Hannes, Sagi,
> 
> On 5/7/25 15:26, Kamaljit Singh wrote:
>>> Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup
>>> I/O stall on congested sockets' _only_ ?
>>> (on top of nvme-6.16 latest, of course).
>>> I think I _should_ have included all the suggestions floating here,
>>> but we need to have confirmation.
>>
>> I've built the kernel against the latest of nvme-6.16 branch along with
>> these patches. Its with test now. Will let you know when we get some
>> results back.
>>
>> 0. [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets - Apr 29, 01:18
>>      Hannes Reinecke (2):
>>        nvme-tcp: sanitize request list handling
>>        nvme-tcp: fix I/O stalls on congested sockets
>>
>> 1. [PATCH 1/2] nvme-tcp: sanitize request list handling - Apr 29, 02:31
>> 2. [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets - Apr 29, 01:18
> IO timeouts are still occurring with Writes. The only Read that timed
> out was most likely due to the path error. It takes ~4.5 hours to fail.
> 
> However, this test does not fail if either ECN is off or if digests
> are not enabled. These passing combinations were run for 16+ hours
> without any issues. Both ECN and Header+Data Digests need to be turned
> on for it to fail.
> 
> Do you have a failing test as well? If so, is it quicker to cause the
> failure? Would you mind sharing any details?
> 
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n3: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 opcode 0x2 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 opcode 0x1 (I/O Cmd) QID 4 timeout
>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O
>    [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 seconds...
> 
> In the current build I had these patches on top of the "nvme-6.16" branch:
>    41b2c90a51bd nvme-tcp: sanitize request list handling
>    9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets
> 
Extremely wild guess: Can you try with this patch on top?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0e178115dc04..cdb8ea4eb467 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1277,10 +1277,7 @@ static int nvme_tcp_try_send_ddgst(struct 
nvme_tcp_request *req)
                 .iov_len = NVME_TCP_DIGEST_LENGTH - req->offset
         };

-       if (nvme_tcp_queue_more(queue))
-               msg.msg_flags |= MSG_MORE;
-       else
-               msg.msg_flags |= MSG_EOR;
+       msg.msg_flags |= MSG_EOR;

         ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
         if (unlikely(ret <= 0))

It _could_ be that we're waiting in sendmsg() due to MSG_MORE, causing
these I/O timeouts as processing doesn't continue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

