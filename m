Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF72D0C61F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQic03WAciGo48jyxgjtrEj23aLfVegD8khLSAAfjSM=; b=Z+aXEBiG/Xo2xKZ63QcvouZY8C
	hmVRvwoxk5Ok+m3e2opHH9S54CBF8d5o4/W2Sk0TOQfjW7XoaFN4d8uHjgNtOqb/QYH7TLQvu4MtQ
	WCKoazG4Z+JBTC1/uHEY3QyaSSroCNsuMrFkG+4TXMpZZPTc4U6VcgTpeGAdeBs4WMesKhFkIkx0o
	niNxp83qjPLcH7O17ZpTpGvVZzL9zPNAi8pApEnxFEktrajbpFWIn8QR+bvBH9tx6mSWXYdP0H3+a
	azkXEONqRYn/CRpEZiuUXNNR7/IAwDsyjg31p8nFWvNWZWYFvnMSueLQZPH8s9Rttbkrl5xInXuok
	PDOJoYag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lx6-00000004A3U-3Obr;
	Fri, 25 Oct 2024 15:10:12 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lbb-0000000451T-0JX9
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:48:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D6421F7F8;
	Fri, 25 Oct 2024 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQic03WAciGo48jyxgjtrEj23aLfVegD8khLSAAfjSM=;
	b=wDZF/gZ5/HPz73szN4mxj1FKzARvCjIGThvfXYkL5fAkTLetqEL6JHKA0fVAr81bcpMHIc
	VytvyPsWhWTiA8MTXJ8G0qtZyxjQ7Yn/9EwI0SPbFiWWrOyV84gHlLC1eLV5YAnZNu1+1D
	cyCgw5blC9d73RqrCGLPiQbJP4nEa68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQic03WAciGo48jyxgjtrEj23aLfVegD8khLSAAfjSM=;
	b=o4O8Ym7WRjgLsdkOCo25s7iFLyfA2zKka3aUk5XG923PsnEwsPtosBQwotCZUGAXUJtJNl
	h+VCrb/vFilhmjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQic03WAciGo48jyxgjtrEj23aLfVegD8khLSAAfjSM=;
	b=wDZF/gZ5/HPz73szN4mxj1FKzARvCjIGThvfXYkL5fAkTLetqEL6JHKA0fVAr81bcpMHIc
	VytvyPsWhWTiA8MTXJ8G0qtZyxjQ7Yn/9EwI0SPbFiWWrOyV84gHlLC1eLV5YAnZNu1+1D
	cyCgw5blC9d73RqrCGLPiQbJP4nEa68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQic03WAciGo48jyxgjtrEj23aLfVegD8khLSAAfjSM=;
	b=o4O8Ym7WRjgLsdkOCo25s7iFLyfA2zKka3aUk5XG923PsnEwsPtosBQwotCZUGAXUJtJNl
	h+VCrb/vFilhmjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8794136F5;
	Fri, 25 Oct 2024 14:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nFhfNpyvG2cyYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:47:56 +0000
Date: Fri, 25 Oct 2024 16:47:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 10/15] nvme: pass in port parameter to
 _nvme_connect_subsys()
Message-ID: <76a76173-b35d-4d04-9014-2a9f90a11bbc@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-11-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-11-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,wdc.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_074759_343895_F5D31C5F 
X-CRM114-Status: GOOD (  10.53  )
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

On Thu, Oct 24, 2024 at 10:00:20AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> A subsystem might have more than one port, and that port might be
> configured differently from the default settings. So rather than
> to rely on the default settings we should extract the parameters
> from the passed in ports on that subsystem and issue 'nvme connect'
> with the extracted parameters.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: fixed conflicts for fc transport]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

