Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E839C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Q9q1k+QhC5g2t76lLIcYeKNmwYGWa4J5VpRWz8hx0c=; b=atLkM8HsUKEw5eJc6uc6Xk9JSG
	34ZUzphHOpj6Ayq+YgTLy7MEoAg34abbsqopGRmx4891gvnrbyaICkRStDhoQZ6uQAPuJhuO9MmON
	zyege7Mf8AOZpmtWdzF3ZytwuhIDqsSKrowFcQUgS/CpsdfeD1x7BCfE3ZURKU9JaSyaUAfsfYwWY
	hDRd+PwZq2mLIWOd93VKiYJRQLFmTSDgG5OcY9cFVV03qkgKRmyHaL4dObFjml6iRlMSLJjHGZGmO
	nVIN3z/7D4PM54wVvwkGau6tYMdqp1U0tERlhDWwJpRSVsIDfXbmsn9d7YgajfSpLWhip8iqkISfo
	orKLTi1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXMFK-00000004C1L-3Rcw;
	Fri, 26 Jul 2024 14:48:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXMFF-00000004C0Q-25KA
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 14:48:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9AF21B71;
	Fri, 26 Jul 2024 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722005310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q9q1k+QhC5g2t76lLIcYeKNmwYGWa4J5VpRWz8hx0c=;
	b=V1d6kyd57fvKNe12NHUZiVuIZrdO5uX0Z8feo2bp6cnnBIikjyRyvjgiz2GQpENE0oPopl
	fSgd0OlWXgPWdjAWzAAaH+oTJstTf2YciVVyU0rZ1ZK9/WPtnkvDl3HsjL+pO8GVnOcCjl
	xjKcRkTjEn39xfMKF8qlolROySgDGag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722005310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q9q1k+QhC5g2t76lLIcYeKNmwYGWa4J5VpRWz8hx0c=;
	b=dsrgCcOtGLmTFu6GgLkDjgqyee3zuv0mavrOpTih/OWQdd+gXdVjytIBZ2VxW/QkkgsZFk
	N9sIQClVxhnNsoCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V1d6kyd5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dsrgCcOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722005310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q9q1k+QhC5g2t76lLIcYeKNmwYGWa4J5VpRWz8hx0c=;
	b=V1d6kyd57fvKNe12NHUZiVuIZrdO5uX0Z8feo2bp6cnnBIikjyRyvjgiz2GQpENE0oPopl
	fSgd0OlWXgPWdjAWzAAaH+oTJstTf2YciVVyU0rZ1ZK9/WPtnkvDl3HsjL+pO8GVnOcCjl
	xjKcRkTjEn39xfMKF8qlolROySgDGag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722005310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q9q1k+QhC5g2t76lLIcYeKNmwYGWa4J5VpRWz8hx0c=;
	b=dsrgCcOtGLmTFu6GgLkDjgqyee3zuv0mavrOpTih/OWQdd+gXdVjytIBZ2VxW/QkkgsZFk
	N9sIQClVxhnNsoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35546138A7;
	Fri, 26 Jul 2024 14:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nfNRCz63o2aIJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jul 2024 14:48:30 +0000
Message-ID: <39b9e26e-e471-4e51-8ce7-7cb6149223db@suse.de>
Date: Fri, 26 Jul 2024 16:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with
 nvme_fc_create_association
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240611190647.11856-1-dwagner@suse.de>
 <20240611190647.11856-3-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240611190647.11856-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7E9AF21B71
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_074833_706292_5DEBA35D 
X-CRM114-Status: GOOD (  15.93  )
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

On 6/11/24 21:06, Daniel Wagner wrote:
> We are racing with nvme_fc_create_association here. We wouldn't have to
> do anything in nvme_fc_ctrl_connectivity_loss IF
> nvme_fc_create_association would reliable detect that the setup failed.
> In reality, nvme_fc_create_association is able to return success even
> though some of the operation fail during the setup (and this is even on
> purpose):
> 
>   nvme nvme10: NVME-FC{10}: create association : ...
>   nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
>   nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>   nvme nvme10: Could not set queue count (880)
>   nvme nvme10: Failed to configure AEN (cfg 900)
>   nvme nvme10: NVME-FC{10}: controller connect complete
> 
> Thus we transition to the CONNECTED state and don't start the reconnect
> loop. Thus we should unconditionally schedule a reset.
> 
> If a reset has already been schedule it's either a no-op or we observe
> back to back reset. But we can't really distinguish between host side
> double scheduled reset work or a connectivity loss event right after a
> reset. Thus we have to live with this corner case. The system will enter
> the correct state eventually.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
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


