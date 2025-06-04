Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6472BC5B549
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3m4NxdZPLHksCLv6fxYocYRRPSyfs/tkHuw2AZw7lRU=; b=b4ntmAsRNJJChBG3pCeqqbfzcf
	1NWKQ2SrlDwe9E7TXKrqREL8TGTOTem79DYTwEVxdpRFybLZ3gcWP1SXM0rhC39uGwYBD6+3q+jtz
	/Rd+pTwD4u5PLu3S+ygQOX09beulh/xoZpMZRmNYzs2ZBpqrLO27KOU3+j6XX6HSn1oDOXeRp9UtZ
	MVW4QCuUIs9lhknJ+BM9rI7/Y14lj/5+4RspEzg9mxUVcEvEPRMqCpQ+gxRzuG+pR/tHQcl2JMMN5
	g5eD/jP1zF8NTqIQxGpfe8lH6+deV7PnInDkeE2OzzRzgPhheM9sQ0+3p+khehsW9jyqTmvSner23
	yq0s+JxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMpOv-0000000DcSD-3fdq;
	Wed, 04 Jun 2025 14:47:33 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMpOt-0000000DcQq-0GQK
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 14:47:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C010022025;
	Wed,  4 Jun 2025 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749048447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m4NxdZPLHksCLv6fxYocYRRPSyfs/tkHuw2AZw7lRU=;
	b=Yg8kZ2UB7rDbqZ3RXDHx30VDr0kXEjyxuHjX1F4jURgMnM+OR8eU34FrgeLdnyhVqDBbaL
	SKQc3Gf3NOXutJTUS0ELqbf326+sQ3FixGAN6y1bQ+vtceLXVjX7nGZ77Yh/jFLDPkoahl
	TGP0YIoJ+g9ArusPEPTXkPqE7rNktZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749048447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m4NxdZPLHksCLv6fxYocYRRPSyfs/tkHuw2AZw7lRU=;
	b=kXZ1xwBVo1dmLVAQzuLlwlHhv8di42Qy7t7jDQaM7e0Eg/0tpvq4INaYSb0BkJSrxyhXWf
	l9YhGrIA6G2ZUVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749048447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m4NxdZPLHksCLv6fxYocYRRPSyfs/tkHuw2AZw7lRU=;
	b=Yg8kZ2UB7rDbqZ3RXDHx30VDr0kXEjyxuHjX1F4jURgMnM+OR8eU34FrgeLdnyhVqDBbaL
	SKQc3Gf3NOXutJTUS0ELqbf326+sQ3FixGAN6y1bQ+vtceLXVjX7nGZ77Yh/jFLDPkoahl
	TGP0YIoJ+g9ArusPEPTXkPqE7rNktZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749048447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m4NxdZPLHksCLv6fxYocYRRPSyfs/tkHuw2AZw7lRU=;
	b=kXZ1xwBVo1dmLVAQzuLlwlHhv8di42Qy7t7jDQaM7e0Eg/0tpvq4INaYSb0BkJSrxyhXWf
	l9YhGrIA6G2ZUVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2B9E1369A;
	Wed,  4 Jun 2025 14:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JCdfJX9cQGgrfwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Jun 2025 14:47:27 +0000
Date: Wed, 4 Jun 2025 16:47:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCHv3 0/4] libnvme: add support for discovering multipath of
 a shared ns
Message-ID: <fc6c4b79-980f-48e4-bb5c-f72322a30052@flourine.local>
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.06 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_SPAM_SHORT(0.04)[0.012];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_074731_262606_B1C84B60 
X-CRM114-Status: GOOD (  14.57  )
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

Hi Nilay

On Sat, Apr 26, 2025 at 12:26:05AM +0530, Nilay Shroff wrote:
> Hi,
> 
> Recently released Linux kernel v6.15-rc1 added support for easily discovering
> multiple paths to a shared NVMe namespace. This multipath information is
> exposed to userspace via a new sysfs group attribute named "multipath",
> located under /sys/block/<ns-blkdev>/. More details on this functionality
> can be found here [1].
> 
> This patch series leverages that new functionality to discover multiple paths
> to a shared namespace and exposes that information in libnvme so that it can
> later be used by nvme-cli.
> 
> There are four patches in this series:
> The first patch adds support for discovering NVMe paths using the sysfs
> "multipath" group attribute.
> The second patch adds a new "queue_depth" attribute under the NVMe path
> object.
> The third patch adds a new "numa_nodes" attribute under the NVMe path object.
> The fourth patch extends the sysfs tree dump test to validate multipath link
> support

LGTM. I've applied the series.

Thanks,
Daniel

