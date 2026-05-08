Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2733CCD37AD
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYrKGpCFalowHZMjuQkGoLBNTozxdvsusfQIlwXYRPs=; b=hrECPF/yB0FOi78Z/mn+QbuNC+
	WWgmXUkrG26cY9zPHMuUlIcMDYrRsmHVFCcmSLH7uq2w7e6E6i9JLYYY4WXHBrlRwcz/10ivE1sPO
	hv/kv/+fVvUJCf2Eb8tSMSDRxJYUpjNQR+N6DVSr1nv7uZPfTtZdSfbf51bqrfGPriMYhDxx3VLpO
	4hxt70qyCcHIVlC7z99cggeh+Y4dwMP64dqySHbv8mR+zHaWVm8DrBgHKUl9Cpqj0TEW3sqSju0+l
	8kByY7GepNTT31JLvtKiD09LobSyVaGQJP9fOp9cUCwj23KzqvfnMH7EQPJ8McUeavCybXX22WyS+
	RmIVkctg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOWG-000000073Ik-2C0u;
	Fri, 08 May 2026 16:57:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOWE-000000073Ha-3a63
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 16:57:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09E2F6A9CE;
	Fri,  8 May 2026 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778259461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYrKGpCFalowHZMjuQkGoLBNTozxdvsusfQIlwXYRPs=;
	b=ahS5qdMd9fGLnSiZYRDLlRXEJbDEsUzHc8kAW1Tw0tZgpcW31OXAWKoJncTCa5WW/C8S00
	9Z3PtpAmzUd1O9m7IhabseL+obQA1VQQN+p6WFSsPHTcU1bMtJQUveFmI+CnswbjuZAffJ
	hpJICue8aJRn+hC5fD8uS+pt62UJ8b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778259461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYrKGpCFalowHZMjuQkGoLBNTozxdvsusfQIlwXYRPs=;
	b=1GhmFrH2TBRxgQ7r09kwVTcTR/yF58PsRxHAtn+r9yd0I2T/M5KK7ZEuWonqF7L8ZTiDZY
	JpDCh1vN6XZegTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778259461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYrKGpCFalowHZMjuQkGoLBNTozxdvsusfQIlwXYRPs=;
	b=ahS5qdMd9fGLnSiZYRDLlRXEJbDEsUzHc8kAW1Tw0tZgpcW31OXAWKoJncTCa5WW/C8S00
	9Z3PtpAmzUd1O9m7IhabseL+obQA1VQQN+p6WFSsPHTcU1bMtJQUveFmI+CnswbjuZAffJ
	hpJICue8aJRn+hC5fD8uS+pt62UJ8b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778259461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYrKGpCFalowHZMjuQkGoLBNTozxdvsusfQIlwXYRPs=;
	b=1GhmFrH2TBRxgQ7r09kwVTcTR/yF58PsRxHAtn+r9yd0I2T/M5KK7ZEuWonqF7L8ZTiDZY
	JpDCh1vN6XZegTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAD45593A7;
	Fri,  8 May 2026 16:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3a5cNwQW/mn1XgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 08 May 2026 16:57:40 +0000
Date: Fri, 8 May 2026 18:57:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected uevent
 and STARTED_ONCE flag
Message-ID: <07e32fb5-04bd-4c12-aafb-2b1c746f870d@flourine.local>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-4-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[flourine.local:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_095743_048706_7974D860 
X-CRM114-Status: GOOD (  11.75  )
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

On Fri, May 08, 2026 at 03:33:29PM +0200, Maurizio Lombardi wrote:
> When a controller connects, nvme_start_ctrl() emits the
> "NVME_EVENT=connected" uevent and sets the NVME_CTRL_STARTED_ONCE flag.
> Currently, the uevent is emitted before the flag is set.
> 
> This creates a race condition for userspace tools (like udev rules)
> that might rely on the "connected" event to configure sysfs attributes.
> Specifically, if a udev rule attempts to set the newly introduced
> `admin_timeout` attribute immediately after receiving the uevent,
> the sysfs store function might evaluate the NVME_CTRL_STARTED_ONCE
> bit before it is actually set, resulting in spurious -EBUSY error.
> 
> Swap the order of operations in nvme_start_ctrl() so that the
> NVME_CTRL_STARTED_ONCE flag is set before the uevent is sent.
> This guarantees that the admin_timeout can already be changed
> when userspace is notified.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

