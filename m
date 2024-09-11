Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23EBEE020C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8Wg9VR1U8tQjhPJsM43Mn7ldfMECMrKn9cM04Ldj90=; b=pD+h/uz5ed6UEL1gnxvYeoaKM0
	K3H28e/o6w5M5BZ2+J24aYh843Lof1JLztEIodIf7QdYppHyovMhrK900rkNVYPl9cpKIlKnI3Ybx
	S+KTR9oVuJKBEGiPEwc6zSu84ujgrIhVq5IGX1Bs0yukBmozkPh888j6Fvcu5uPnTNDh/JOIKK/MP
	NthhusdAn+7gnilR3BpSw8HJXmm8L+oHRRY/39PO5+5pTOgFn/2MQtbcIoanBQI8sNamrSy/j51OD
	SSnEBHVdQCD8VU6KDmeCDae2d84orZkraSrMUGQlpYRJ5/8UufWJ6njjl0zfZus5+Cl7yfV59DlU6
	u0u6kkdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soM6K-00000009P5i-1u2d;
	Wed, 11 Sep 2024 12:05:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soM50-00000009Oni-2En6
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 12:04:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CCF01F8AA;
	Wed, 11 Sep 2024 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726056251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Wg9VR1U8tQjhPJsM43Mn7ldfMECMrKn9cM04Ldj90=;
	b=ibxybv5Cu0vfA1jxvFuEVjN4QPi38FIN93TyqZQnyZr08M/vT6Q9kCAmym2Emgv9wE+XZB
	AIUa0vfqinU3M1i33llBhSg6Wv+svkxoGWdsdzG+F04Q+a4XT3MjVb2ghRRIH2mKHEXeiG
	O8pCzN0HDh+ukkSrQ42BhhzAol/ZYf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726056251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Wg9VR1U8tQjhPJsM43Mn7ldfMECMrKn9cM04Ldj90=;
	b=JS3bFN3XIMNNIafhIZQkM9jDaO/n5+l8dQRQuumbF/Uib3CRbI7nljBDOvp4HZcS+aj70s
	ak7MrWSYyyZyIwAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ibxybv5C;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JS3bFN3X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726056251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Wg9VR1U8tQjhPJsM43Mn7ldfMECMrKn9cM04Ldj90=;
	b=ibxybv5Cu0vfA1jxvFuEVjN4QPi38FIN93TyqZQnyZr08M/vT6Q9kCAmym2Emgv9wE+XZB
	AIUa0vfqinU3M1i33llBhSg6Wv+svkxoGWdsdzG+F04Q+a4XT3MjVb2ghRRIH2mKHEXeiG
	O8pCzN0HDh+ukkSrQ42BhhzAol/ZYf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726056251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Wg9VR1U8tQjhPJsM43Mn7ldfMECMrKn9cM04Ldj90=;
	b=JS3bFN3XIMNNIafhIZQkM9jDaO/n5+l8dQRQuumbF/Uib3CRbI7nljBDOvp4HZcS+aj70s
	ak7MrWSYyyZyIwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1B713A7C;
	Wed, 11 Sep 2024 12:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3a3ETuH4WZpJgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 11 Sep 2024 12:04:11 +0000
Message-ID: <519c188c-0701-4a82-859c-16cfd56ab359@suse.de>
Date: Wed, 11 Sep 2024 14:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: skip inaccessible paths during
 partition scan
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240911095107.121688-1-hare@kernel.org>
 <20240911095107.121688-4-hare@kernel.org>
 <9b8b7d54-8716-4449-8497-149dcc62ae77@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9b8b7d54-8716-4449-8497-149dcc62ae77@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CCF01F8AA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_050414_744325_E1273447 
X-CRM114-Status: GOOD (  24.88  )
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

On 9/11/24 13:24, Sagi Grimberg wrote:
> Hannes, if this patch fixes a bug, please phrase the title to reflect that.
> 
> 
> On 11/09/2024 12:51, Hannes Reinecke wrote:
>> When a path is switched to 'inaccessible' during partition scan
>> triggered via device_add_disk() and we only have one path the
>> system will be stuck as nvme_available_path() will always return
>> 'true'. So I/O will never be completed and the system is stuck
>> in device_add_disk().
>> This patch introduces a flag NVME_NSHEAD_DISABLE_QUEUEING to
>> cause nvme_available_path() to always return NULL, and with
>> that I/O to be failed if all paths are unavailable.
> 
> So what will happen if a new device comes along, and the first
> path it connects to is 'inaccessible'? What will scan partitions?
> 
No, it won't. But it won't do that today, neither, as we never call
nvme_mpath_set_disk_live():
nvme_mpath_add_disk()
-> nvme_update_ns_ana_state():
         if (nvme_state_is_live(ns->ana_state) &&
             nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
                 nvme_mpath_set_live(ns);

> I don't think that this approach is the right one.
> Effectively, there is a semantic decision here, is 'inaccessible' a
> temporary state or not, if it is we should queue IO knowing that
> it may change in the future, and if not, we should fail it.
> 
Yes.

I would argue that we should never requeue I/O if it's triggered
from partition scan, ie from within device_add_disk().
Reasoning is as follows:

We never call nvme_mpath_set_live() during initial scan if all paths are 
inaccessible.
So when a path is 'optimized' / 'non-optimized' and the path state 
changes to 'inaccessible' while device_add_disk() is running, we are
perfectly fine to disable the device (and kill all I/O), as this is
what would have happened if the path had been inaccessible originally.

> ANA inaccessible is semantically temporary. Its just that your test
> treats it as permanent. For this case you have fast_io_fail_tmo, which is
> designed to give up also in cases where there is hope that any path will
> become online in the future.
> 
It's not just ANA inaccessible. We're facing a similar problem if the
target returns PATH_ERROR during scanning; then we're constantly failing
over I/O to the next path, returning PATH_ERROR, failing over to the 
next path, ...

> I do agree that if the user disconnects the last path, should it be 
> inaccessible
> or not, it should succeed, and cause the queued IO to fail immediately.

I'll check if that would work for my testcases.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


