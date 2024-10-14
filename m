Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CF5CFC504
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=; b=jWn+EvtpPBREL7y3IZBi0wwHJB
	fg+kIMrPKchDxQXYudNBt1W/hV6PC0IdXn6DNxkX0SjM+gDXp89i5k4FRuRk4aUjiny5cieI163SA
	PEyYUhSLC+WM5F97YFyy0dOdMNydxGD3dwS5uh6LJC1Q2GMmYZRe2SoXyrveGyos6gheYGQpKbhvS
	7TWX0yJCYhfGUZmfQnLXC1a8yFhqwOxocGFicMQXJBK8Fj1249/nd9yhtXHAXTeRB/c3rgRiYLAaU
	venAoKJAZ/Y/HamL+OmuU+3W7Q+FVgxpBr0XIzHKVTUn3MV+fwmGRkfvMLuBEGXF/0nI6tZ0gsibw
	WT7HrtBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FL5-000000041fR-029b;
	Mon, 14 Oct 2024 07:17:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FKR-000000041Sk-0tSv
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 07:17:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A95961FE70;
	Mon, 14 Oct 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=wjgH7MnVvT67UWcN/GtBg43sRN1yCkbEKnqA7xCFTvrV3kWGNcCBSoNdqV5+3QaZ6kA9rw
	vhcqrQu95YPXyGyB1Y0dkFs2ezISkItZW0dTD2kvSu0QPbFJt/YcVHhnAmeiB89p7MnQ5f
	VwAxckHWyOSr1FKUNVcyzKkNgyDTKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=lS5c24f3EFA1nSLdg/EDEn9SNBdM8c1Gr+Azm4zFN0FEw0ASAPFA28/Tuw/pOSQ+bPygcY
	54e41h96UQ5prxDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=wjgH7MnVvT67UWcN/GtBg43sRN1yCkbEKnqA7xCFTvrV3kWGNcCBSoNdqV5+3QaZ6kA9rw
	vhcqrQu95YPXyGyB1Y0dkFs2ezISkItZW0dTD2kvSu0QPbFJt/YcVHhnAmeiB89p7MnQ5f
	VwAxckHWyOSr1FKUNVcyzKkNgyDTKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+E2RVLbJyII14eUTvlx/TQP9GCrs4WW55jghEq18SDI=;
	b=lS5c24f3EFA1nSLdg/EDEn9SNBdM8c1Gr+Azm4zFN0FEw0ASAPFA28/Tuw/pOSQ+bPygcY
	54e41h96UQ5prxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BDD213A42;
	Mon, 14 Oct 2024 07:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VbPLH3vFDGd6WgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 07:17:15 +0000
Date: Mon, 14 Oct 2024 09:17:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 1/2] nvme/{md/001,rc,002,016,017,030,052}:
 introduce --resv_enable argument
Message-ID: <2c78529c-2893-4891-9768-715e316caddc@flourine.local>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012111157.44368-2-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.97%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_001719_420061_73106419 
X-CRM114-Status: UNSURE (   8.88  )
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

On Sat, Oct 12, 2024 at 07:11:56PM GMT, Guixin Liu wrote:
> Add an optional argument --resv_enable to _nvmet_target_setup() and
> propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().
> 
> One can call functions with --resv_enable to enable reservation
> feature on a specific namespace.
> 
> And also make _create_nvmet_ns and _create_nvmet_subsystem to parse
> for arguments, this makes these functions more flexible to use.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

