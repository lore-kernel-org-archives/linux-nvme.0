Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C872C5320E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KjjB+VAIk/KxK+uZ2L1H3Z4ZHVqzmixrG2XwPlJUow=; b=20mbcNTBdAd5gKrMPCDofiGTgj
	4NJ/0+1/cvligfrNH4PPIhXPa+3+E9gg9EZL0pB0gJfrLX9mXgsuCi57/xN9ryN1hbMmpLiGTiDQ3
	ZAAb459mVoIjkTp1NyyWXKwQgpDUC/EimZh4DA7jU6Uwp8P5TbqWA1CVEQSgsCtblfjsQZwj4HJ2S
	l5OOxmLrAIfMhztTUC7zOxa01gNyJavBE6ZkRmPZxdxiBLvtkVvrFX/LepLFXbKuTjzLIJ8xqngPg
	OVOFEbG2obqXTSCly9IudQhtFDCaXlDfQiSy17Air2txCpElKdKOz8SMBRrmcaZeS4VKdO/yNKmvB
	kT77T5wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2m4-00000001fHh-1NHu;
	Mon, 19 Aug 2024 13:50:20 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2lz-00000001fFZ-0JEX
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 13:50:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC8E226EA;
	Mon, 19 Aug 2024 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724075413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KjjB+VAIk/KxK+uZ2L1H3Z4ZHVqzmixrG2XwPlJUow=;
	b=QhgnTdHV+mqpcbBo5vbKWJ55GC8iIqn7Ob9pWorQbnIamPVgcqz944NkNaZ4WeLj1W2f4/
	Zbh6MfZMVJ1ypYax3UNjSm9V2+qpumMdvtT8msrmutMseJEGpz9Lk8mbzb0nWOr+9/oqS1
	97rgTKlhqYE+6sVIOs3CGcZTt+2XQWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724075413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KjjB+VAIk/KxK+uZ2L1H3Z4ZHVqzmixrG2XwPlJUow=;
	b=3z5Eaxdmy91diPzXUVyOtIg0Q9RM6kwmhMlNQb6/oTQtT1qi8bUzUQllruuSke1rNHSEUW
	ePI6+HeJREh04UDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724075413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KjjB+VAIk/KxK+uZ2L1H3Z4ZHVqzmixrG2XwPlJUow=;
	b=QhgnTdHV+mqpcbBo5vbKWJ55GC8iIqn7Ob9pWorQbnIamPVgcqz944NkNaZ4WeLj1W2f4/
	Zbh6MfZMVJ1ypYax3UNjSm9V2+qpumMdvtT8msrmutMseJEGpz9Lk8mbzb0nWOr+9/oqS1
	97rgTKlhqYE+6sVIOs3CGcZTt+2XQWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724075413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KjjB+VAIk/KxK+uZ2L1H3Z4ZHVqzmixrG2XwPlJUow=;
	b=3z5Eaxdmy91diPzXUVyOtIg0Q9RM6kwmhMlNQb6/oTQtT1qi8bUzUQllruuSke1rNHSEUW
	ePI6+HeJREh04UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A48B137C3;
	Mon, 19 Aug 2024 13:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O6+xFJVNw2bBewAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 19 Aug 2024 13:50:13 +0000
Message-ID: <1502800d-f2f6-4c44-9d73-c026e3fdeeb5@suse.de>
Date: Mon, 19 Aug 2024 15:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix typo clearing NVME_NSHEAD_DISK_LIVE
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122736.57863-1-hare@kernel.org>
 <1512e3c7-ef59-4096-ae8d-0e158addda42@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1512e3c7-ef59-4096-ae8d-0e158addda42@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_065015_287469_6F69D8EB 
X-CRM114-Status: GOOD (  11.97  )
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

On 8/19/24 15:18, Sagi Grimberg wrote:
> 
> 
> 
> On 19/08/2024 15:27, Hannes Reinecke wrote:
>> NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_nshead', not
>> 'struct nvme_ns'.
> 
> Hannes, what is the phenomenon here? Is anything leaked or functionally
> broken?
> 
> The patch looks good, but please explain if this is caught from code 
> inspection
> or a real issue that surfaced.
> 
> For the patch itself,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

We've seen the issue popping up during repeated map/unmap operations
with reusing NSIDs; occasionally we would end up with stale multipath
namespaces and non-existing generic devices.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


