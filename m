Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D470CC46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oZ3r6A05JfS/WWL0ax7LcwQtf1Dc7z0Xn007zoYGlc=; b=h05hnnV38Z+f0wi/kjjXr+b7kn
	QCGUqhxfJD2GlSvMsVn58NIyPFVh+tXGV5NQp6tSWV/sSF6ZqPatlVX/bLr23SsNEu6lgYbXbw1Ou
	qLrk/wWABjkFfJuJpQrNDc+r5HE4LQMo4K+tElOOyMGgBx0PXg8d7DxIMxz/VYR0THir45FPqmfkN
	14ILoCJlm7x+z7E4+UbQawpwB2xWDZeXAqR2x2MDgA19E49CtSbBZinHrKmWbkX/HxvHWBNVRDsrl
	F4R6pG3P3URkDv3yHK28tNuFG+9oNorUxVTbhajUhy8PTSmxzRaqTDLdyORFbrBDPfVBi8H0fpCKR
	d+9N/yIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYPR-00DpDO-16;
	Tue, 19 Dec 2023 11:37:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYPP-00Dp6z-0B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:37:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0595A1FD54;
	Tue, 19 Dec 2023 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oZ3r6A05JfS/WWL0ax7LcwQtf1Dc7z0Xn007zoYGlc=;
	b=b0LQ0y+Hw3+2Yc+SYifGeLRbKsi1eH1n14Cm6BGqD0NzWd8Ynr8uY4qVEJOSTebd2bok3w
	P+JI7ah37TJO1x4nbd+huYn6F2YWE8MdfLnRdBhIQv01lVHxtTwMopBqYAzwvfwsGy7aXp
	2ndmb9LkWyL6JzMj/14e+y5RvS6rIyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oZ3r6A05JfS/WWL0ax7LcwQtf1Dc7z0Xn007zoYGlc=;
	b=j4m8eY/aPtyYvX0kNcn+baczXDPlS7pZV3ct2yvMTYZCXwHJQTcYLjwDXDukFocH02tazR
	n27J9yQ3t4iZ7QCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702985822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oZ3r6A05JfS/WWL0ax7LcwQtf1Dc7z0Xn007zoYGlc=;
	b=b0LQ0y+Hw3+2Yc+SYifGeLRbKsi1eH1n14Cm6BGqD0NzWd8Ynr8uY4qVEJOSTebd2bok3w
	P+JI7ah37TJO1x4nbd+huYn6F2YWE8MdfLnRdBhIQv01lVHxtTwMopBqYAzwvfwsGy7aXp
	2ndmb9LkWyL6JzMj/14e+y5RvS6rIyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702985822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9oZ3r6A05JfS/WWL0ax7LcwQtf1Dc7z0Xn007zoYGlc=;
	b=j4m8eY/aPtyYvX0kNcn+baczXDPlS7pZV3ct2yvMTYZCXwHJQTcYLjwDXDukFocH02tazR
	n27J9yQ3t4iZ7QCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95E641375D;
	Tue, 19 Dec 2023 11:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5YXcIV2AgWVENQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:37:01 +0000
Message-ID: <40a449b9-f5b0-4fda-ae60-49f6010541fe@suse.de>
Date: Tue, 19 Dec 2023 12:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/16] nvmet-fc: remove null hostport pointer check
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-12-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-12-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.69)[98.62%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b0LQ0y+H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="j4m8eY/a"
X-Rspamd-Queue-Id: 0595A1FD54
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_033711_250565_C8D4CF79 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
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

On 12/18/23 16:30, Daniel Wagner wrote:
> An association has always a valid hostport pointer. Remove useless
> null pointer check.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
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


