Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8DFC47DDB
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 12:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=; b=P3KLU2ol0p9i0Qhtl2k0KwweAJ
	dkq0lGMHeXpiQ12iGHalfuGKbSQqAgNkSisBQd/iNVVL1maLyOsw9eDdNv3OaWk70ZkFOYG/ZOMQz
	LtqWoaASSMnIRGAZodYGPmXnyKtpqjGC44e+xijfhm+BFwzLeLf7cDmviJy5S//oa6JzLRUpYf5qg
	vG84bKSLnyhA+G+g1De1ooT6aX/KTT0983NjrB9m0mkvHoYWgvnAqMMnfp2nj6dm9AthowYE86GkE
	IS3nzaHzpzvoLi/uuKdJnuay6amMsfo+QHlpJF85BRG6EvgeCtMGuQGIAe+VOYAQZoEcWubSl92gT
	vrslggfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWPx-00000007o5u-2rRW;
	Thu, 01 Feb 2024 12:43:45 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVWPt-00000007o4s-3hq2
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 12:43:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6953F21224;
	Thu,  1 Feb 2024 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=F4cLai+eLndNDqg8YFCVtTP1zL1i34bjMCADck/SiU4rXF8uzBriaHtDCUXi5Ms4z9zMXm
	bpfCAyNRcLwBRjNOWJgxyog+kkiIZZsyOKCw5Usu1daaQcvlQRjOLoQGMeMdhL5ki62mxv
	NgJnG+E7hss6hpY41S6PDpcroDC7XcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=SKyiwdm27mplhBRTaDbfoJA74KfKPUGFi80nqLEE2z8ZDJjqKVm2Y6jCB+VA9kbgG6RnjL
	SCDxqYI7cszPo5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=F4cLai+eLndNDqg8YFCVtTP1zL1i34bjMCADck/SiU4rXF8uzBriaHtDCUXi5Ms4z9zMXm
	bpfCAyNRcLwBRjNOWJgxyog+kkiIZZsyOKCw5Usu1daaQcvlQRjOLoQGMeMdhL5ki62mxv
	NgJnG+E7hss6hpY41S6PDpcroDC7XcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=SKyiwdm27mplhBRTaDbfoJA74KfKPUGFi80nqLEE2z8ZDJjqKVm2Y6jCB+VA9kbgG6RnjL
	SCDxqYI7cszPo5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7A60139B1;
	Thu,  1 Feb 2024 12:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kBbBJPqRu2XNOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 01 Feb 2024 12:43:38 +0000
Message-ID: <2abd09d9-eb35-413f-9447-5ecb6e9839ba@suse.de>
Date: Thu, 1 Feb 2024 13:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] nvmet-fc: defer cleanup using RCU properly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F4cLai+e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SKyiwdm2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 6953F21224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_044342_098680_1BE1CBAD 
X-CRM114-Status: GOOD (  18.04  )
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

On 1/31/24 09:51, Daniel Wagner wrote:
> When the target executes a disconnect and the host triggers a reconnect
> immediately, the reconnect command still finds an existing association.
> 
> The reconnect crashes later on because nvmet_fc_delete_target_assoc
> blindly removes resources while the reconnect code wants to use it.
> 
> To address this, nvmet_fc_find_target_assoc should not be able to
> lookup an association which is being removed. The association list
> is already under RCU lifetime management, so let's properly use it
> and remove the association from the list and wait for a grace period
> before cleaning up all. This means we also can drop the RCU management
> on the queues, because this is now handled via the association itself.
> 
> A second step split the execution context so that the initial disconnect
> command can complete without running the reconnect code in the same
> context. As usual, this is done by deferring the ->done to a workqueue.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 83 ++++++++++++++++++----------------------
>   1 file changed, 37 insertions(+), 46 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


