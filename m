Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C89CE63F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0OmiP93TfgVIe/TNXJ0aBY8NrnPYQkGRPtu1BM8h1s=; b=ZGodMk0pTcIwsv2Cdy5wWoXsvK
	awHUmXMpWsFI+gSoYEtgOM+bFWLvGc3tkzJSTdDqeG6PSuz4L3Yap1PvbxTjvFx0M8dzrGPCoWZm6
	gZeoXZNh2/D2Xib+oX7fAmNL1pTAsMgc43sPPU1ZTAZ41xRgiM3NJxIXrCOcBJF0o6nw0yeDYwEXO
	7tfrnrc8mh+Up1jaFgGxdof5GLpU6FVqsrWm+YC/R3tsnbZFpwdtyRtaSkxffKE18zxYoOqNT+plV
	oq8D24RuVhhgYSNDB8DaTkgYzMuA/6FzCLRi1n45Dmw6EMqftjFGuzkAAYH4vyD+HwXHdKPd2CrEX
	WwIYCzag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsF9r-00000007ji6-2Zdu;
	Tue, 17 Feb 2026 07:06:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsF9p-00000007jhl-0rzM
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 07:06:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4366A5BCD9;
	Tue, 17 Feb 2026 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771311963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0OmiP93TfgVIe/TNXJ0aBY8NrnPYQkGRPtu1BM8h1s=;
	b=1V7GS3jX1+tAIZH7f1irMqHd7SdPygdJLncJL7Gttb5oQw/ZGyEE7JsONLKWB0CjKenrmm
	WGc+/x5F5uhSJ2qtZ+Q3gmzNje/eGNiogM0RmkzrV57Z22hTt1x4sjg/p1mrN8HnvTpHDL
	JPWS86T6OBVPhxajNEi0z79+XsmibnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771311963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0OmiP93TfgVIe/TNXJ0aBY8NrnPYQkGRPtu1BM8h1s=;
	b=5R7ttY1ml3NZVrHQZRNq9M9U95QiTXquKu7UhsdfbZBU+otbeaCTQ+meYYG1OOZmpgSEsh
	GcePSsaw058owlCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771311963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0OmiP93TfgVIe/TNXJ0aBY8NrnPYQkGRPtu1BM8h1s=;
	b=1V7GS3jX1+tAIZH7f1irMqHd7SdPygdJLncJL7Gttb5oQw/ZGyEE7JsONLKWB0CjKenrmm
	WGc+/x5F5uhSJ2qtZ+Q3gmzNje/eGNiogM0RmkzrV57Z22hTt1x4sjg/p1mrN8HnvTpHDL
	JPWS86T6OBVPhxajNEi0z79+XsmibnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771311963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0OmiP93TfgVIe/TNXJ0aBY8NrnPYQkGRPtu1BM8h1s=;
	b=5R7ttY1ml3NZVrHQZRNq9M9U95QiTXquKu7UhsdfbZBU+otbeaCTQ+meYYG1OOZmpgSEsh
	GcePSsaw058owlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 891973EA65;
	Tue, 17 Feb 2026 07:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIzYOlgTlGnaBwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Feb 2026 07:06:00 +0000
Message-ID: <f682b34e-aa40-4e0f-b89d-6a56452a66c3@suse.de>
Date: Tue, 17 Feb 2026 08:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <b598c5c9-6732-4661-85b2-7ab10a0830d4@suse.de>
 <dbf5fbdd-8894-40b7-b574-0c6385995ec2@oracle.com>
 <a5a0aa42-33e4-401f-ad94-8104cff9368c@suse.de>
 <28ab3aa2-7654-4b4b-94be-bd691c1903dd@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <28ab3aa2-7654-4b4b-94be-bd691c1903dd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_230605_417299_11543924 
X-CRM114-Status: GOOD (  16.14  )
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

On 2/16/26 17:55, John Garry wrote:
> On 16/02/2026 16:32, Hannes Reinecke wrote:
>>> cheers, in the meantime, I have some comments:
>>>
[ .. ]>>> - I am still not sure on whether we require a multipath 
version of
>>> sg. We can still have per-path sg. NVMe does have a multipath nvme- 
>>> generic dev, but that just handles IOCTLs/uring cmd, and nothing like 
>>> sg read/ write fops
>>>
>> 'sg' is primarily for testing 'raw' SCSI commands. (And dastardly 
>> complex to boot). I really would keep it in it's current form, and not
>> try to mimick something with SCSI multipathing.
> 
> I can get to scsi_ioctl() from the multipath sd device ioctl - 
> sd_ioctl() - maybe that is enough.
> 
Yeah, it should. In the end, the read/write path is less interesting
for 'raw' SCSI commands; I would think sg is more interesting for the
more obscure commands. And most of these would be path-specific anyway.

>>
>>> - I have not tried to detangle ALUA support from SCSI DH, so no ALUA 
>>> support yet
>>>
>> Ouch. But that is the key point of the implementation; ALUA provides
>> _all_ the information required for multipathing, so how can you _not_
>> have support for it?
> 
> So far every path is just "optimised" and scsi_vpd_lun_id() is used to 
> match scsi_devices ... ALUA support will be added, but if I were to do 
> it now, it would just delay posting anything even further...

Fair enough. Eagerly awaiting the patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

