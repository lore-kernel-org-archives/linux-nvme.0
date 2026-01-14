Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94016D31A3A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=; b=AoujId8ZLrdyXPzFHCWRyKT3Qj
	+5+31RTkniZquNZQNXVn/mpn0F4/IRQ5AGnIaRmt8vNXeEkwJaTUlsJBVQyhFuL0LB3m08DPXhhIP
	1aijRSz4VUy22+Bvx9huS7Se2wDqhOLo3PkDwfC9gw74FdNe2wgyxmLgd83eTlY24W1NYZ142dl0W
	EwDO1GxTThKqraLNeMNlpswxdD1pn7QpoVwErVkalM4xwofz7PPD4ZTarbPHDW0MmJ7UJAknQ1fDZ
	0VuaBvpJiGYjJc7vtk7fDJMqxxVaz7YZ+HHJClydcRlCByv8Zv+Hr7uKoNxyhrKwFEI9JBnZW2s3l
	quHOxVAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfxbV-00000008dyT-40Qc;
	Wed, 14 Jan 2026 09:55:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfxbP-00000008dxG-3HUc
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 09:55:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F41545C0F7;
	Wed, 14 Jan 2026 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768384545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=Hd4lnGQ3SYgdaCllYs/l7WBgqef4eoUcuS728s0lwrWpQDKIdBOEbCeB+MNs6BXx/xE+d7
	1HWEDY468V9NkdNSerkR/90o9U+6IbRoL+kiGxuj4Aet1PH1LPo5OPEHrxdhVFmkZrmdCz
	WZQRllusxepr5z1jGrIyWfa8yz7xfz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768384545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=BJ0FIoZH++RncmU8rfpt41vegt8jXn+4Qg/8FFNR6S6aA/vzeeU4g+40oJrBY9lL0WOS2M
	WlqWPEnUyEIgVAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768384545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=Hd4lnGQ3SYgdaCllYs/l7WBgqef4eoUcuS728s0lwrWpQDKIdBOEbCeB+MNs6BXx/xE+d7
	1HWEDY468V9NkdNSerkR/90o9U+6IbRoL+kiGxuj4Aet1PH1LPo5OPEHrxdhVFmkZrmdCz
	WZQRllusxepr5z1jGrIyWfa8yz7xfz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768384545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh4J+J139MUsgqQlbXT143sgh2AWLg/dO1Y2C1HEwLY=;
	b=BJ0FIoZH++RncmU8rfpt41vegt8jXn+4Qg/8FFNR6S6aA/vzeeU4g+40oJrBY9lL0WOS2M
	WlqWPEnUyEIgVAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12743EA63;
	Wed, 14 Jan 2026 09:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dnQJNiBoZ2l+KQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Jan 2026 09:55:44 +0000
Date: Wed, 14 Jan 2026 10:55:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, jmeneghi@redhat.com, wagi@kernel.org, 
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	james.smart@broadcom.com, hare@suse.de, shinichiro.kawasaki@wdc.com, 
	wenxiong@linux.ibm.com, nnmlinux@linux.ibm.com, emilne@redhat.com, mlombard@redhat.com, 
	gjoyce@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix PCIe subsystem reset controller state
 transition
Message-ID: <f0a74e06-9e96-4149-a8e5-16f09e15346b@flourine.local>
References: <20260114072416.1901394-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114072416.1901394-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_015547_971876_42ED0298 
X-CRM114-Status: GOOD (  12.53  )
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

On Wed, Jan 14, 2026 at 12:54:13PM +0530, Nilay Shroff wrote:
> The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
> state”) disallows controller state transitions directly from RESETTING
> to LIVE. However, the NVMe PCIe subsystem reset path relies on this
> transition to recover the controller on PowerPC (PPC) systems.
> 
> On PPC systems, issuing a subsystem reset causes a temporary loss of
> communication with the NVMe adapter. A subsequent PCIe MMIO read then
> triggers EEH recovery, which restores the PCIe link and brings the
> controller back online. For EEH recovery to proceed correctly, the
> controller must transition back to the LIVE state.
> 
> Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
> entering LIVE from CONNECTING state”), the controller can no longer
> transition directly from RESETTING to LIVE. As a result, EEH recovery
> exits prematurely, leaving the controller stuck in the RESETTING state.
> 
> Fix this by explicitly transitioning the controller state from RESETTING
> to CONNECTING and then to LIVE. This satisfies the updated state
> transition rules and allows the controller to be successfully recovered
> on PPC systems following a PCIe subsystem reset.
> 
> Cc: stable@vger.kernel.org
> Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks for fixing this.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

