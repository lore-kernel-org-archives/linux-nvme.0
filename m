Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54036606A33A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jeubyCfS;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Vw9ueLFH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kOMiutDv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=27XGT/qQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kOMiutDv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=27XGT/qQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=; b=jeubyCfS22NEyS
	MmjGNRrrkQdBfeiaQk3iqqPRsjQI8zjXVvEkatDjIodseOkU/dklxuVc8eSoz2Bk7x1ptUW5ZfZcH
	Af5jimaUAeeyjqZfoN279AOwbX/ZADDRRt8NquDkjzNHg+53JSt9KOcGlrL84+mGNPTYOsgfAxSpL
	SEsnwTBsoiprXq54UIkkDmBTkeT1+EJPlcxa0FzffL8u2O2wTbKxt3BPXeuP8iZw4HC8b9E3L+YGn
	1k3+n8fiYaGunKcOq1YSZt1C7EBwEibYgdJ1UJ+6h8oOPdPiqNfrdkwmI43jvIOiJ81xP/hXeb+cL
	J57YVpLbADK/ZKgiJiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXXp-0000000Cwng-2dlb;
	Thu, 26 Nov 2026 11:21:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXWm-0000000CviW-3gcG
	for linux-nvme@bombadil.infradead.org;
	Thu, 26 Nov 2026 11:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=; b=Vw9ueLFHg9GTv+fJrdvusThHWn
	NTS52b5MlWL9YSPZtO35fmzb6KfmYKbyXzKdc5q2CQ6TjTvaIErKXvUgFUuK9y/qVOaCj1MEOtRWB
	9/EMENSut76KDPzznZ2X92pLhOE1wXzWHuBwP9wp1FM3L9aTdWNWsdlQuVjMwa5DrJL1TiIPgJAHm
	l1JUYDtTYSbpJfTQcBs1v1CPe/jS0f7taGfUwX2A1NOxzguXt5XPBc0ot6wApgnh3yTPN5Ue4DSuU
	Yhhk8ul6dCu7bhCl4ce+/VimmBqcKZdW7vqTw8DJiHFIcgiJO7TIpEragrXhAyaU8XC8UhAJc5bg8
	r3k/i3IQ==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXWk-00000006O3P-0Nkm
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 11:20:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50DE12271F;
	Thu, 26 Nov 2026 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795692031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=;
	b=kOMiutDv4x0ozX9GPyKtD9+2QcWiiPU+8PMikouC7la6Hx6W25RKek2mCNCHUIjF1X8nCi
	Yz+Y85dfkJW21Iup35AXgnDiMhoiETvkul7jdBsbrLvTAMRgONVyK6m+KFKrM+3IVh1/lu
	UjLOBftj+EykNopLyLbTgTNTX+nUtl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795692031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=;
	b=27XGT/qQp01LmOgD5RzvI9mQTCCWy1Rp36oAXxZUYs/AXKLvHlHfbkK8a1pJO/EP1eVU8o
	7ixL146gLRtqXZDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kOMiutDv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="27XGT/qQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795692031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=;
	b=kOMiutDv4x0ozX9GPyKtD9+2QcWiiPU+8PMikouC7la6Hx6W25RKek2mCNCHUIjF1X8nCi
	Yz+Y85dfkJW21Iup35AXgnDiMhoiETvkul7jdBsbrLvTAMRgONVyK6m+KFKrM+3IVh1/lu
	UjLOBftj+EykNopLyLbTgTNTX+nUtl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795692031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4z1yavWhrCP15OdenIXeqTRT32JkFP8J2SOWQU7YGJQ=;
	b=27XGT/qQp01LmOgD5RzvI9mQTCCWy1Rp36oAXxZUYs/AXKLvHlHfbkK8a1pJO/EP1eVU8o
	7ixL146gLRtqXZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F02D8134C3;
	Thu, 26 Nov 2026 11:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4tBLMf4VCGsPWwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Nov 2026 11:20:30 +0000
Message-ID: <f514b658-bdbd-4797-b2b1-a82fe6e8edc7@suse.de>
Date: Thu, 26 Nov 2026 12:20:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: document the per-subsystem iopolicy sysfs
 attributes
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116114208.2226472-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116114208.2226472-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50DE12271F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-14.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -14.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_112034_049738_0E967D08 
X-CRM114-Status: GOOD (  13.29  )
X-Spam-Score: -2.5 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:42 PM, Guixin Liu wrote:
> nvme-multipath.rst only mentions the global nvme_core.iopolicy module
> parameter. That value is only picked up when a subsystem is created;
> changing it does not affect subsystems that already exist. The runtime
> interface is the per-subsystem iopolicy attribute, which applies the
> new policy to a single subsystem immediately, plus the read-only
> iopolicies attribute listing the supported policies. Document both,
> and note that discovery subsystems report "none" and reject writes.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   Documentation/admin-guide/nvme-multipath.rst | 35 +++++++++++++++++---
>   1 file changed, 30 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

