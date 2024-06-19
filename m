Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7D8C2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=; b=IUP2xnpNrP+5OV6Yx+EGVx5FLC
	8T9gIddjIm3UT1YupKuAA448tAtEhmDvNouKWITgE7UWa3kIAOrXC3Ua89Qvg4UDSV2XuBWaRYyQi
	MqvK0pK6+SpSN3JpRqUN1F3D29ts71/2Q9az6TiiHcS+a4d8esUI/7inQ4+mLkoCo79a5QtmRgFzJ
	zZmrvImhdT7uhvSkolqGAIzTf4M0SvSf4P+3bCmlak1+PNl7fdfMSWFPibvA5X90IT3Nru9ovur5G
	L4AchCSlLI2Lb70xumd5+fRTYF+B9fshlBu2F0DrZO5yaySLyEiLkVtELLc5R3ZagSDY4FaMsYxXa
	rTCIMHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJt2U-00000000tEB-1sIR;
	Wed, 19 Jun 2024 10:59:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJt2J-00000000tC1-21t9
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:59:40 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFC041F828;
	Wed, 19 Jun 2024 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718794770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=oE4FWtH4xAmH6XnQAzUwvTBR3kAMIcxHgAUefmKqwFpbJVc+xwlekRUuW8fGsUIr5mVOaS
	BmpH448EbUEkwRSjk+z7/MAXe4LHe1JQPHGvQ2Dy3bQE/6bLpQ0tydnOIL+bHjQIW8N4eG
	n4v/7uOF7+EhpqDHYKXlnLxzavzzCp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718794770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=TYxVnxaLlgSI/Jifyg+5ESD4z2OBnJv/ep15o3+adqhoWBPYTAEYWoveyZXcH0A7QSLuzU
	LeFEC6S0BlC8CFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718794769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=fqP3iTAoxO9hvXrjQZI0m9+ptbb/DdZDQluBeaoRNsdomJUb4VdqsK8m1zLpqlRDiLZVei
	eVzyhZ9BUHzVeSAG8tzI7CXjkGRg2GyuXPodwEnWnelFuyKQfyZsGE38Fr34lxjt3A+Kfu
	rDHQMFn8207wR7j4PplqNeZGbkmVjHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718794769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTtv0vza0aDFsFuSpkSP+ImyKshtUGpIrtIBRjMwDSo=;
	b=t0G4PNR6dEudrzk+TKp8qk9Cq7rnuGgWHtc5g6yYAdnVNJY0YhdMu06kZI3OqZuXNb8wb3
	imRgrlgZQn+XNDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE59D13AAA;
	Wed, 19 Jun 2024 10:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/0CNhG6cmYtSwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 19 Jun 2024 10:59:29 +0000
Date: Wed, 19 Jun 2024 12:59:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org, 
	sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, 
	venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, linux-block@vger.kernel.org, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
Message-ID: <b4itgwyvsk6xhlgccleshe2v5dmyqwh2tkualueotqdz3ljxef@lfrrwqcofuuf>
References: <20240619104705.2921801-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619104705.2921801-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_035931_696474_59B5D2F1 
X-CRM114-Status: UNSURE (   9.01  )
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

On Wed, Jun 19, 2024 at 04:16:40PM GMT, Nilay Shroff wrote:
> +	# start iteration from ns-id 2 because ns-id 1 is created
> +	# by default when nvme target is setup. Also ns-id 1 is
> +	# deleted when nvme target is cleaned up.
> +	for ((i = 2; i <= iterations; i++)); do {
> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> +		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i"
> +
> +		# allow async request to be processed
> +		sleep 1

This looks a bit fragile to ensure all request have been processed. Would
it possible to wait on a state?  E.g. something like

  nvmf_wait_for_state()

?

> +
> +		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
> +		rm "$(_nvme_def_file_path).$i"
> +	}

