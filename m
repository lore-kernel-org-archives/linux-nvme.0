Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68AAC54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 07:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkgI9zLxDTYiw+H2ByyVZv+x5SXruoYgvbpLGEcCRzc=; b=UG3EjMF7wXGJc3XkiDxEbjDbiO
	U7HKMQOfH301Vvo3fE2zMqH1GIXiznyBazoZbl2c5SrZkCj2xZezt78FsDAT9EkFQjmFXvKTqHfF1
	nP1Ynhjo46Y6vvK3bwAj+MIyJycFY12G1wxHvGiiK0aJ/f7tJCGy79P7sp7glmlpxS0HGpZ8KM2I2
	qSVcTOtG9L8akozVBsHcLsCmz5ii8gdg6TE/VZzCZDi2HuVoYoLMW63O52BqKFwjAyk4hvvyusx46
	odUyb6xTyC/1cYq6SWGhLQJfAvoRNFIMOjBPZoBPh4At8nWNfmDxenpxehSu4rtnvLlqPk+Jv1hnz
	cMhEjXmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhlgX-0000000GhWX-1AEQ;
	Wed, 06 Mar 2024 07:27:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhlgQ-0000000GhUP-42c0
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 07:27:26 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9684670EF;
	Wed,  6 Mar 2024 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709710034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgI9zLxDTYiw+H2ByyVZv+x5SXruoYgvbpLGEcCRzc=;
	b=d3AAQT/irkmv5mAa00gGjM9yy2/NzMbX1eeJendC/LiShsiV6jvuLGHdDxmXuwlgB0Mys+
	LA1XYrvPmLt8Z5M6QFVKjg3vkZJgAF3KzSWlKS4tow/hdctsZodO95nZcXAh0/pj/L/rxS
	06c7Hydu41E9nn7wCUpMOvH80ZjgKcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709710034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgI9zLxDTYiw+H2ByyVZv+x5SXruoYgvbpLGEcCRzc=;
	b=mNuVdU7FyNfI5mc7D0DJMMlrdd4WMFPg4bha1c5MAOu60HgI3tfIRRXllVz0Ok6EQWh5XK
	hxkwDzouTgIO60Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709710033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgI9zLxDTYiw+H2ByyVZv+x5SXruoYgvbpLGEcCRzc=;
	b=JyUQoQn7vunQu5pLyBJ9UW1SR2DdM7JTrDS2W/xazTb1g/88lHv/X93J51qh95vAQIfHfM
	HBxGSWiqyE6+SPq7Yqr6gbH/wTKTsNBiSpPaJ5JfN+cmuVHBduaA9mxEcg105ogxaKyG4d
	XDqv906WMOMEBgX1S+aaMq9QoTamPrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709710033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkgI9zLxDTYiw+H2ByyVZv+x5SXruoYgvbpLGEcCRzc=;
	b=mYcUkboknclZ4VWWNIEHHyCSxJXS6D7iAJwT6hcVOicaJDA3MuG0RDUhW0DdW+ZJciBLcp
	gTsJfoGcUoR4RnDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 972C413A79;
	Wed,  6 Mar 2024 07:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aw9UI9Ea6GV/CwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Mar 2024 07:27:13 +0000
Date: Wed, 6 Mar 2024 08:27:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: host: fix double-free of struct nvme_id_ns in
 ns_update_nuse()
Message-ID: <flgjnpirzgy4srgtn6sjn6ncdilgum4b36nwljaunaeyluh26i@tfbfai2g2jeo>
References: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306060303.2615950-1-shinichiro.kawasaki@wdc.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JyUQoQn7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mYcUkbok
X-Spamd-Result: default: False [-4.62 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.81)[99.18%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9684670EF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_232723_251133_C5D03BD0 
X-CRM114-Status: GOOD (  11.53  )
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

On Wed, Mar 06, 2024 at 03:03:03PM +0900, Shin'ichiro Kawasaki wrote:
> When nvme_identify_ns() fails, it frees the pointer to the struct
> nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
> for the pointer even when nvme_identify_ns() fails. This results in
> KASAN double-free, which was observed with blktests nvme/045 with
> proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
> skipping kfree() when nvme_identify_ns() fails.
> 
> Link: https://lore.kernel.org/linux-block/20240304161303.19681-1-dwagner@suse.de/ [1]
> Fixes: a1a825ab6a60 ("nvme: add csi, ms and nuse to sysfs")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

