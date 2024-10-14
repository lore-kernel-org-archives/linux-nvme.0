Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D20D16268
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Z44hsG0Xj/Sw9eVHXYKqhxFTCGG9B1HptzHkVirK2w=; b=pIgviMWZXEjjtbyXpNwvQkLmVI
	B8oxtKfQSEC4GOX6GUf3coQBpzv/S0PRsW7c8vRN/22yK704Fo3wIR3oXMvXRivTUP+bY+uctGFob
	lUan/54h7xNTOV3/UDb8+f8qYG8aLimE5jPRM+oPxODr1WL50WDN6i96ujtw7KpKRMEsSfzox6LdA
	wwk9L3edyiIKvp/Qy0KrM5FjlxC+D1duXSvFf6bH2f2xUrx6lbMgF/Z7s8flRZIwxjElaxZmqZzcE
	8A63IK/mrxxbQy1lLupxSshTzUK6LEWhvkzfx2q1Png3X2eG8Pcp3JggwyoshVEuXjfxFmMC1zBiE
	Yx9E3+mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0M00-00000005SUv-06VK;
	Mon, 14 Oct 2024 14:24:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0LY7-00000005NIe-27iR
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 13:55:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C28F21CA9;
	Mon, 14 Oct 2024 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728914149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z44hsG0Xj/Sw9eVHXYKqhxFTCGG9B1HptzHkVirK2w=;
	b=GEO3SYXDGo06Bf/VBFTLQ4cx3Cxwx9AITTmvlbCXgtE7sD7hzGv2gty4YDe1qGB89zuyWF
	YwnD3jgDTsVLGNW88G1RI3sG9dAy6L/rKJ6gEtk0m5LRZzR4ytcMfglRWSIjBFS3hsQQyE
	iMcN7mtKKw/DF4IwhJcMRHnQPQJUk1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728914149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z44hsG0Xj/Sw9eVHXYKqhxFTCGG9B1HptzHkVirK2w=;
	b=QP8sVXpwwmLJDpbJbH6FMD+D0JpwPn1hpeRA1xUhiSOJ+wOBgHz+FKq1oUZkmKjVWZfL8y
	fkm5Yts3BalFZICQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728914148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z44hsG0Xj/Sw9eVHXYKqhxFTCGG9B1HptzHkVirK2w=;
	b=f4uRPA0wVU547rAYHqX2N5CpABBqCFII4NV7WcQqgHVlmSMYq9G3FfiMhg52G9BhWG+UIN
	1AFQ81bGcVCuq8zzCIWAzcR4apjSCIuVpPSY+VoDoOevtuYXR7KbDroy6Zbs5aEEojZyV8
	1lEweTz/tDOSWn+NDU7EK2sJ/yr/Nek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728914148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z44hsG0Xj/Sw9eVHXYKqhxFTCGG9B1HptzHkVirK2w=;
	b=sW5FgnA6cbp+ttu6gwTW7hjy/gIeI5HNMRs6+Ey/zsLI3KGOH5PRc1Qb/wm7I2zPqGfQqj
	ZD/WemtQfKgBzbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42B5B13A51;
	Mon, 14 Oct 2024 13:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bIf3DeQiDWdJXgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 13:55:48 +0000
Date: Mon, 14 Oct 2024 15:55:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp uaf when tls setup fails
Message-ID: <a5ec9717-ebb0-4cdf-aaad-17f8a247a2c3@flourine.local>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
 <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
 <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
 <eb2298da-1d64-4424-a462-9056f722b5d7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2298da-1d64-4424-a462-9056f722b5d7@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_065552_080892_5D9FC7B7 
X-CRM114-Status: GOOD (  17.46  )
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

On Mon, Oct 14, 2024 at 03:18:27PM GMT, Hannes Reinecke wrote:
> On 10/14/24 15:14, Daniel Wagner wrote:
> > > The logs say that the connect to queue 3 fails, but it seems this
> > > command never got send out (ftrace):
> > > 
> > >      kworker/4:0H-759     [004] .....  8771.165686: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=1, sqsize=127, cattr=0, kato=0)
> > >            <idle>-0       [004] ..s1.  8771.172062: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
> > >      kworker/5:0H-796     [005] .....  8771.172422: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=2, sqsize=127, cattr=0, kato=0)
> > >            <idle>-0       [005] ..s1.  8771.178292: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
> > > 
> > > And it is very reliable to reproduce it.
> > 
> > It is also reproducible without TLS.
> 
> Does this help?
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 04f0ac57855e..12f8a97150af 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2163,8 +2163,8 @@ static int nvme_tcp_configure_admin_queue(struct
> nvme_ctrl *ctrl, bool new)
>         blk_sync_queue(ctrl->admin_q);
>  out_stop_queue:
>         nvme_tcp_stop_queue(ctrl, 0);
> -       nvme_cancel_admin_tagset(ctrl);
>  out_cleanup_tagset:
> +       nvme_cancel_admin_tagset(ctrl);
>         if (new)
>                 nvme_remove_admin_tag_set(ctrl);
>  out_free_queue:

No, nvme_tcp_configure_io_queue fails and not
nvme_tcp_configure_admin_queue. I wonder if the queue flag
NVME_TCP_Q_ALLOCATED is preventing a proper cleanup. The flag will set
only if the complete allocation went thru.

