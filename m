Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA56C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsfuTj1cBD+ak+eem621IiWn0xckexUJGyUbnt/ub/w=; b=uofzrdMaha4b2wbcknOr5xSc34
	wRoetGVtGflnuEamhLEAzEE8Y1x+m1BAS/LG93hM3ZG4wKdYTq32ob0J2jE7AwzEdhPoIK65iLsIY
	lmI2Nl575E+3AjyGYF7flUE2cMtkhAf4s4J70QXvc8wehrRB99iMRdtJmDaZsVDS+e8ZlRzoyYCDO
	ygTpBqHXI0TFZ5VcDHCqtd+lRJw9KAui+fAAlW+lJSIYY16alb0oOcurMK8PMsxsVJPairFO+tuho
	jpoo6SowON+hg1CUYG1xTSiKKuDlYmqbynhPSsFEhet7xYO7to+S4hHzTmhfaO/cMmACW9n0ZFzHy
	wY4LCixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2qR-00000001faR-2OJF;
	Mon, 19 Aug 2024 13:54:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2qN-00000001fZi-1viS
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 13:54:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E03422690;
	Mon, 19 Aug 2024 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724075685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsfuTj1cBD+ak+eem621IiWn0xckexUJGyUbnt/ub/w=;
	b=C5CnAv59Ebt53NO7o7otUriy4adm/PRqdQjc6V9DxjSV3bF6fK7VRPaZs3NodfK0sigKPk
	KiGBqlm9IDMINKDartwMR5CuyLqjfvW0bMX3KjtZKZ4nxPsUKLmlZuUiZs0e5mWDPKSUvn
	aBfyfmzx+V6Uh7cskrBy/M4JgmhIyqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724075685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsfuTj1cBD+ak+eem621IiWn0xckexUJGyUbnt/ub/w=;
	b=qAY5kMdzSqs0iub7Y2XqrMaCQC6gVvUKsWpxHCHBIpIHf4XON/JMiLLXKhoePnZwA1FY5g
	VRN422UfiYR+fvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bi9PDoSf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J0oMqm0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724075684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsfuTj1cBD+ak+eem621IiWn0xckexUJGyUbnt/ub/w=;
	b=Bi9PDoSfBcbw3rKAYP1Lt6vPezkyBjmk1wwY5e29h6xKicpCwPSBYgF64/8RR9ciKjDFpm
	IEhF1+V+RHY0OpXcxi30xEp8cfwWjM4BTEsbppZDi2P1NaqmGT1c07RkLQa4V13zeNolDA
	lMOEYZ/b9ItMulBlYfh+e5lnTWGSO6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724075684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsfuTj1cBD+ak+eem621IiWn0xckexUJGyUbnt/ub/w=;
	b=J0oMqm0/CFbjmwHxPiX2wZTX6+DmY1/hSers2H/Med9f4LqN8ntXehf9yvXdoeE8uEztpk
	jKGLEqrMC6n7dZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 493C1137C3;
	Mon, 19 Aug 2024 13:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IoxtEaROw2YnfQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 19 Aug 2024 13:54:44 +0000
Message-ID: <9e1839fc-5b8f-435f-abde-e8fb1bd9b60d@suse.de>
Date: Mon, 19 Aug 2024 15:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: return 'namespace not ready' for disabled
 namespaces
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122917.65313-1-hare@kernel.org>
 <dc3d279d-58a9-412b-9cb3-cc51297f65ba@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <dc3d279d-58a9-412b-9cb3-cc51297f65ba@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E03422690
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_065447_673533_E4FB183D 
X-CRM114-Status: GOOD (  12.23  )
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

On 8/19/24 15:17, Sagi Grimberg wrote:
> 
> 
> 
> On 19/08/2024 15:29, Hannes Reinecke wrote:
>> When a namespace is disabled from configfs returning 'path error'
>> is quite an odd choice; the actual description for that error is:
>> 'The command was not completed as a result of a controller internal
>> error that is specific to the controller processing the command.'
>> Which is not the case here; once disabled the namespace is disabled
>> for the entire subsystem, not just the controller.
>> So return 'namespace not ready' here to clarify the problem.
> 
> Hannes, can you explain what this patch is solving?
> 
> The reason why this error was selected is because this is a path
> error, which will trigger a host IO failover.

???

This is not a path error.

# echo 0 > 
/sys/kernel/config/nvmet/subsystems/<NQN>/namespaces/<NSID>/enable

will disable the namespace for all controllers. Not just the individual
path (as there is not individual path). Failover won't change anything.

Hence this change.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


