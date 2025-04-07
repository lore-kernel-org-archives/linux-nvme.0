Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591DC3601A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GnGMy4Zhmiskekm4Ot8J6YmoxJmuI+shOKHlmNQVu2E=; b=1cTFELazLc7cy+3N04ePmTUjz6
	4KwJJUCdNBPlXolVuqeX6iGfZyk2BunddRGwMYTEt1n9rUvuxOk//PQf0VjV4GzzNHNBri+6KQ1Se
	hJlIWpmeavFj3Gs6rUicIEGfKyUbzzzEtsHTcKfH1S2FwR7bqLbQW05wmXUf6HQiJpFiM41MX+3/C
	tYHCvZH3w55yUhgbqvdcYFNI1leidSNAbNX74NtpEsTa06tYWFsCNKqwLyICQBVcW621zaiUD6LcV
	xPc8HjJwJEwqd6ptT3NEKPyENAyzXftyyRr6JyzbGR9RDwK1bmdHsnbddJ465Gmra4DAXI4fHzb0i
	ChQtXVoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1hAm-0000000GpoN-0ssd;
	Mon, 07 Apr 2025 07:45:36 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1glS-0000000GinF-3Hmp
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 07:19:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01BB8211C4;
	Mon,  7 Apr 2025 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744010364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnGMy4Zhmiskekm4Ot8J6YmoxJmuI+shOKHlmNQVu2E=;
	b=eTiW91dJidwBp/D6ipIrDm6LkZZHQBouTEPyj0dRMsSPIofGCplT09GDbCviLu5fcA5O2t
	DEWuUhwn/FR0WX74Unm8St8OICX9RQ+d2ZJTZJNzz8ATSJ906R9U9z+5Lx6DsjPMmKCPdg
	GYy+7pLWpxQtvkJsCyWIrgZRyGaDU00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744010364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnGMy4Zhmiskekm4Ot8J6YmoxJmuI+shOKHlmNQVu2E=;
	b=sW6C7zvAPK7gIvG/APyrSgrK5Yr89qiTqqpMZdXRufwB0d8NlSAjIK8wUISnpeNQLACUc/
	PzQLH1/Qg/vGbGAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744010364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnGMy4Zhmiskekm4Ot8J6YmoxJmuI+shOKHlmNQVu2E=;
	b=eTiW91dJidwBp/D6ipIrDm6LkZZHQBouTEPyj0dRMsSPIofGCplT09GDbCviLu5fcA5O2t
	DEWuUhwn/FR0WX74Unm8St8OICX9RQ+d2ZJTZJNzz8ATSJ906R9U9z+5Lx6DsjPMmKCPdg
	GYy+7pLWpxQtvkJsCyWIrgZRyGaDU00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744010364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnGMy4Zhmiskekm4Ot8J6YmoxJmuI+shOKHlmNQVu2E=;
	b=sW6C7zvAPK7gIvG/APyrSgrK5Yr89qiTqqpMZdXRufwB0d8NlSAjIK8wUISnpeNQLACUc/
	PzQLH1/Qg/vGbGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D946813A4B;
	Mon,  7 Apr 2025 07:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5+ewMnt882d4FQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 07:19:23 +0000
Date: Mon, 7 Apr 2025 09:19:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 1/3] tree: add support for discovering nvme paths using
 sysfs multipath link
Message-ID: <6a1f8acc-acf6-4a72-abdd-84aa81623ec7@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405130255.448345-2-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_001926_968498_E30659CC 
X-CRM114-Status: GOOD (  12.87  )
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

Hi Nilay,

On Sat, Apr 05, 2025 at 06:32:47PM +0530, Nilay Shroff wrote:
> With kernel v6.14, when NVMe native multipath is enabled, it is possible
> to discover all paths to a shared namespace using the sysfs multipath link.
> Leverage this functionality to update the path links for each shared NVMe
> namespace, simplifying path discovery and management.

Since this is not a trivial change, could you extend this section a bit
how it works? I understand from reading the patch, a new head namespace
object is introduced which links to the different paths. 

> Please note that
> this change is fully backward compatible.

Could you elaborate what that means? libnvme should still work on older
kernels.

Also could you add a tests for this? The is already a test for the
current sysfs tree parser, see test/sysfs.

Thanks,
Daniel

