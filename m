Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B7C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 08:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGEAN017bliOyl2SdA5tKF8ug9wKFUQ4OjKLerQ0lic=; b=yxD2vvwbgGhZYO3QNt0X95gr8G
	53GM1OYIea/dTUcHpLjvHDL0KoJUGeSV2cRJRILYrhjS5zyXeUHLC9Jx8ow3lR1xl+mJkPvFcQNzh
	BFKxvE9AbM9aTOW1brKPsIV9uLyLGUu/sD+QuFbROnYRy1qI5rAvIyAM1nlewCby0XEe/kYEIpc+l
	GfAUXywujJyGagUzuBFMcaCjQp+N8QUdvQbDotM8CmGWtjFBv/gixN1BkbxpKzp8/3/kgMJ0nc5lP
	g5YYbEil0itQkcuGFHoQzua91Oq8Xua1U4/zrZ5R/CPRH4zcXwkYrX28Uhl8DmcC9bniHmUTK/rj4
	MrGbFyoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujvvq-0000000HaRm-1hYc;
	Thu, 07 Aug 2025 08:25:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujvu3-0000000HaKF-2LNe
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 08:23:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B46EB1F7F4;
	Thu,  7 Aug 2025 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754554989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGEAN017bliOyl2SdA5tKF8ug9wKFUQ4OjKLerQ0lic=;
	b=SNy/cDepnjs8OmfRS4x9JUz+KxkAyY81771ANu+iQC/tK8fx/jaJkpneLBgUvqyxxyl/wL
	gWMlUGAqvYFv8RuyoUUFnpq3vZfA3BNTna8PZ0yXZjDf9UICBSLXWN859cKuvQilrlWsEW
	6dKaUe/LAKoJyui2+p544rqciT/WuHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754554989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGEAN017bliOyl2SdA5tKF8ug9wKFUQ4OjKLerQ0lic=;
	b=ChiITLvCoN9YdHUeqa6ZiodBVXelh6pGawj/WmENOPW4R/UMevizIcnwVLOx1QYy9p76uy
	PQf6d/fi/WeYjDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754554989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGEAN017bliOyl2SdA5tKF8ug9wKFUQ4OjKLerQ0lic=;
	b=SNy/cDepnjs8OmfRS4x9JUz+KxkAyY81771ANu+iQC/tK8fx/jaJkpneLBgUvqyxxyl/wL
	gWMlUGAqvYFv8RuyoUUFnpq3vZfA3BNTna8PZ0yXZjDf9UICBSLXWN859cKuvQilrlWsEW
	6dKaUe/LAKoJyui2+p544rqciT/WuHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754554989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGEAN017bliOyl2SdA5tKF8ug9wKFUQ4OjKLerQ0lic=;
	b=ChiITLvCoN9YdHUeqa6ZiodBVXelh6pGawj/WmENOPW4R/UMevizIcnwVLOx1QYy9p76uy
	PQf6d/fi/WeYjDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B586136DC;
	Thu,  7 Aug 2025 08:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXPBEG1ilGgBKAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Aug 2025 08:23:09 +0000
Message-ID: <3b2765ff-4a7d-4bf7-b390-b392b695c675@suse.de>
Date: Thu, 7 Aug 2025 10:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Maurizio Lombardi <mlombard@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_012311_745204_1E197CAB 
X-CRM114-Status: GOOD (  15.43  )
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

On 8/7/25 07:35, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
> Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 83f3d2f8ef2d0..0dd7bd99afa32 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1992,8 +1992,8 @@ static int __init nvmet_init(void)
>   static void __exit nvmet_exit(void)
>   {
>   	nvmet_exit_configfs();
> -	nvmet_exit_debugfs();
>   	nvmet_exit_discovery();
> +	nvmet_exit_debugfs();
>   	ida_destroy(&cntlid_ida);
>   	destroy_workqueue(nvmet_wq);
>   	destroy_workqueue(buffered_io_wq);

Hehe. I knew this would've been the case once I've seen the latest
blktest failure. Thanks for fixing it.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

