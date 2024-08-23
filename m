Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15BC52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=; b=RT0D5kCvOuFoIigwVv6evsl0OW
	Bh9suMqpxj1U5vICG2AjCndHbn7T+HGrBBoqUMMXy83WkUoHm9vE00Qk3h8O65WDw1hFPm9liuVdX
	WyemwzbjVK+VfldYBRjBI4f6EhnQag8qvJsB5DrigOc6nqHDzCK2fPiUP/1KfF/m0HSbdr2nglqyL
	oqfB7Z07LDcZVtlw3CBlfBigkcDaaGXjwcG44GiZGfWf9abD8t8krhiKRUPtcl4JHVIQuqi2jv3CF
	049aZBSjehLkFtBaaBpFBKy0Kgd6pu1MmMsnJYQvHcEzlX1FLq8VuvchNQPR/HWgMzDC9pYaDmglc
	A/uzcAjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNtR-0000000FTbU-3Aih;
	Fri, 23 Aug 2024 06:35:29 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNtM-0000000FTZS-1xBW
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:35:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4385722542;
	Fri, 23 Aug 2024 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724394922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=abCQLT79xELVRR16inkZwX8welhqvEj+BmaFbYs6KLSTQhK7SjAj5VDSVaax6xSRmwu1nZ
	gsTbipucZ1dfsPjv+3voUFr7W577qt8Tim2Br3+UrQ6zxIkO4ymlX07sUgjoMhXbUXbyaW
	vT+de0xlowOR7div09LtyNTqPC4Qekg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724394922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=1MBJiYtE5v5WJBnLCpuqTY78QPJmPLiwttA/9faY9tDJoJjxsZXRLLV/8xBTSuAS1CfErn
	vmo5i4rvL/UrYoCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724394922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=abCQLT79xELVRR16inkZwX8welhqvEj+BmaFbYs6KLSTQhK7SjAj5VDSVaax6xSRmwu1nZ
	gsTbipucZ1dfsPjv+3voUFr7W577qt8Tim2Br3+UrQ6zxIkO4ymlX07sUgjoMhXbUXbyaW
	vT+de0xlowOR7div09LtyNTqPC4Qekg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724394922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeYjev9hMpdxn5fEg5S0q3B3WfHja+KFH3a3ybILEQY=;
	b=1MBJiYtE5v5WJBnLCpuqTY78QPJmPLiwttA/9faY9tDJoJjxsZXRLLV/8xBTSuAS1CfErn
	vmo5i4rvL/UrYoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26C091333E;
	Fri, 23 Aug 2024 06:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JQwLB6otyGaqaAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 06:35:22 +0000
Date: Fri, 23 Aug 2024 08:35:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Message-ID: <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
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
X-CRM114-CacheID: sfid-20240822_233524_681008_977119BB 
X-CRM114-Status: UNSURE (   8.41  )
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

On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> +_require_test_dev_is_nvme_no_mpath() {
> +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
> +		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
> +		return 1
> +	fi
> +	return 0
> +}

Just a nit: what about _require_test_dev_is_native_multipath?

