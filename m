Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07ECC3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGKTMYX0WCA5O0UunEAA3SAeVU2LGdg2jLpkGQiEF7M=; b=gZI1wminzQkveesksJcgYLOfSR
	J+WQCobtmHxusetOGBzRRgp1t4+hzgj9BeS7wMVaLHNumLXMpcXx9LEs+HB8tfboVX3uvDr3C2aOa
	gORyiCc4fpnaTgJh91jA/c1vWU+rzGg9Pa8iyPhpNxPbplLDeNm7fPLndZR+hq+fvXfb2VvjaLx19
	VffcydB4AFjBoza2Skx9uubVh5opvVOInlEEYzANXE92GF/UgvgYF2V5XhNsmbtZNHqYiQEioBuzG
	sGdnqG/T1Qz6lnweaviEViOZ9Bc+gLAHbwf0ohy9awDMDNbHpEX9ZgsMM+U1AyMp0y1s5brlyyu26
	y4yKV+dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULip-0000000GEtn-2AJL;
	Thu, 18 Jul 2024 07:38:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULij-0000000GErI-49EE
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 07:38:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 555F221C39;
	Thu, 18 Jul 2024 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721288312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGKTMYX0WCA5O0UunEAA3SAeVU2LGdg2jLpkGQiEF7M=;
	b=HjdDwUTytoLNdaXkJ1R2aIwnpgROWuAB8OlKhixTC7dwNK3PkQzH7f1PbPJByPROKgAiVE
	9tUxEwl3M/pEft9rJvOm0vtex8wzIbnH/QS0lIIfyvjxpd4YCtC5s1sQn/wLgRmsCmyuC5
	0kkICf2Dg207TUzhr9Ec1xDb9GRhNtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721288312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGKTMYX0WCA5O0UunEAA3SAeVU2LGdg2jLpkGQiEF7M=;
	b=orbYYpur+shmdh+qatorpNEQHJJB4ShGGNBhFPuO81NtpYjz278g+/FRG5sd0qB1Lvnl2D
	VNuCj6LsHgctF/AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HjdDwUTy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=orbYYpur
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721288312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGKTMYX0WCA5O0UunEAA3SAeVU2LGdg2jLpkGQiEF7M=;
	b=HjdDwUTytoLNdaXkJ1R2aIwnpgROWuAB8OlKhixTC7dwNK3PkQzH7f1PbPJByPROKgAiVE
	9tUxEwl3M/pEft9rJvOm0vtex8wzIbnH/QS0lIIfyvjxpd4YCtC5s1sQn/wLgRmsCmyuC5
	0kkICf2Dg207TUzhr9Ec1xDb9GRhNtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721288312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGKTMYX0WCA5O0UunEAA3SAeVU2LGdg2jLpkGQiEF7M=;
	b=orbYYpur+shmdh+qatorpNEQHJJB4ShGGNBhFPuO81NtpYjz278g+/FRG5sd0qB1Lvnl2D
	VNuCj6LsHgctF/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123041379D;
	Thu, 18 Jul 2024 07:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GFQA3jGmGZUFAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 07:38:32 +0000
Message-ID: <ee49dc85-d2de-4f28-a022-6afbfabfc458@suse.de>
Date: Thu, 18 Jul 2024 09:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: Implement 'admin_only' authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240717110338.27332-1-hare@kernel.org>
 <20240717110338.27332-3-hare@kernel.org>
 <1b59c7c9-5d20-4d96-b844-88014cdaa14e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1b59c7c9-5d20-4d96-b844-88014cdaa14e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 555F221C39
X-Spamd-Result: default: False [-1.50 / 50.00];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_003834_200108_6EA94713 
X-CRM114-Status: GOOD (  10.00  )
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

On 7/18/24 00:40, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 14:03, Hannes Reinecke wrote:
>> It might be sufficient to run authentication on the admin queue only,
>> as this speeds up reconnection quite significantly.
> 
> By how much?
> 
Haven't really measured; the prime motivation for this patch was to
have a testbed for the patch to the initiator.
But I should be able to get some numbers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


