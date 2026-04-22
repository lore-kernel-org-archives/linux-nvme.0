Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45399F9B5E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVwuTOQV0mMeLAV+uTvZsvzCk2RqF8M1lQKE5VcgeBs=; b=ytQhcV9nTk5r8U1RMPR1BlUgeM
	SsiGmXFMMmd0NIp2yAH/foONYTO5G4yJLpCrt5CzEMMyW2Bsu5/OtA8gt0OAVps3zfYLDwpvQftzh
	3wPAUoYP1zkdXsFjD6BcgBLd7NNepMMQOrExj0+Poftj8PDFjklpiKAuYiaQoYJ44138US1EmnPYl
	Q0bu3DRDjJDDtYf6lgQlFMGHHHTIrBGKu5bezHt7AtSi3ve5cbmuJTQ68uxY359CGePsdECBWQRCF
	s/hK1KzVmQlirRQ36+VYpNsHeVG+zY+yvCu4o1sqrAk9pr91Lgg3SaPQpW+B6PJJqqs+m0BO+M0+l
	qPz/n4cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFTJZ-00000009ntv-1VWi;
	Wed, 22 Apr 2026 08:52:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFTJU-00000009ntM-2TOO
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 08:52:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A23C6A81D;
	Wed, 22 Apr 2026 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776847921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVwuTOQV0mMeLAV+uTvZsvzCk2RqF8M1lQKE5VcgeBs=;
	b=CO5TFzwVcDC87AEWy8cB9sh4/gsHB2h+c7Mtyjjkd6ERKThbKgm3+pV6HfuHSWpDOkdALM
	S9KLYLmkS5AQpGOEKjzCETQnNYiNDOIc+1wnuLxlamzCi++SMUZjt79gp2NkRuuoC9CifH
	1WaHXiMPelItAYms4NRSBVRBSwVRZLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776847921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVwuTOQV0mMeLAV+uTvZsvzCk2RqF8M1lQKE5VcgeBs=;
	b=TuTle3o/beUcrQYDl/fRZqhx0QAkYeNEj1rPlfzK24j9fuY5qYO1T/M2ctlL5toWS89UcD
	atpRm9GHVIDIiBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CO5TFzwV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="TuTle3o/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776847921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVwuTOQV0mMeLAV+uTvZsvzCk2RqF8M1lQKE5VcgeBs=;
	b=CO5TFzwVcDC87AEWy8cB9sh4/gsHB2h+c7Mtyjjkd6ERKThbKgm3+pV6HfuHSWpDOkdALM
	S9KLYLmkS5AQpGOEKjzCETQnNYiNDOIc+1wnuLxlamzCi++SMUZjt79gp2NkRuuoC9CifH
	1WaHXiMPelItAYms4NRSBVRBSwVRZLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776847921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVwuTOQV0mMeLAV+uTvZsvzCk2RqF8M1lQKE5VcgeBs=;
	b=TuTle3o/beUcrQYDl/fRZqhx0QAkYeNEj1rPlfzK24j9fuY5qYO1T/M2ctlL5toWS89UcD
	atpRm9GHVIDIiBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06515593B0;
	Wed, 22 Apr 2026 08:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DdxWADGM6GmnEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 22 Apr 2026 08:52:01 +0000
Date: Wed, 22 Apr 2026 10:51:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCHv3 0/9] libnvme: add support for retrieving additional
 NVMe stat
Message-ID: <1c081dc2-6b1e-45b4-ab3a-81decf431949@flourine.local>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A23C6A81D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_015204_780643_F88811E9 
X-CRM114-Status: GOOD (  16.37  )
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

On Tue, Apr 21, 2026 at 08:20:21PM +0530, Nilay Shroff wrote:
> Certain NVMe attributes and statistics can change dynamically at runtime.
> However, the current libnvme implementation caches attribute values while
> scanning and building the topology. Subsequent libnvme API calls return
> these cached values.
> 
> While this approach works well for one-shot nvme-cli commands, it is not
> suitable for use cases that require upto date information. In particular,
> real-time monitoring tools such as nvme-top require access to the latest
> (non-cached) values of such attributes.
> 
> To address this, this patchset introduces support for retrieving
> non-cached values for selected attributes whose values may change
> dynamically. The first three patches disable auto-generated accessors
> for ana_state, numa_nodes, and iopolicy using "!accessors:none", and
> provide custom implementations that always return the latest values.
> 
> In addition, libnvme lacks support for retrieving gendisk statistics, which
> provide useful insight into disk activity (e.g., number of I/Os processed,
> time spent servicing I/O, and in-flight I/O counts). This patchset adds
> support for retrieving gendisk I/O statistics for both per-path and namespace
> gendisks.
> 
> Finally, this series adds support for retrieving diagnostic counters at 
> different levels, including per-path, namespace, nshead, and controller.
> These counters should improve visibility into NVMe native multipath behavior.
> 
> All of the above statistics and counters can be leveraged by tools such as
> nvme-top to provide real-time monitoring and analysis.
> 
> As usual, feedback and suggestions are welcome!

I went ahead and applied them. I did some cosmetic formatting changes
for the accessors generator comment and added the manually written
getters to the python binding define table.

This should unblock your work on 'nvme monitor'

Thanks,
Daniel

