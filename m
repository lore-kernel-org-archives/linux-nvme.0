Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13FD10F6FBF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gO8fisAVZANo8uE9YSPPGP8hAvcm3tlB9RsLpwaI80c=; b=CYFFEiKOF1+/CeBxtyJXRYrGiX
	SF/dqlebYSxzl04GV0yPlYKEghOl56Yewi52wk3g8TM4Lx3/Mk/SL/+DhrmWzGuHRty0Iqx4+EHNl
	6vHWcKnrBC3BSEMKUj44B1NLyPLzbCvT8RyiM49l0of+E7Z8ltA8sZj6Wr8S1e/luMybTi27ICWem
	g687CvjPDuCrna563AiYLCDl/jAyLNsvYSQPyNwSRw6Rq/d7LxSN0wzSYoh2X9BYuyhfFi6lRx/VX
	2NSHyu9Mr+nBd8mdn/zQDLVtEqZPFuAc/QfeUz/7G74pnNIyvaTo1O6jPdrz7zqTTYBoJieIKa/X2
	GzGPgqGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xuK-0000000Ffpm-0Iz8;
	Wed, 01 Apr 2026 15:55:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7xuI-0000000Ffov-005L
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 15:55:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53CD74D2EE;
	Wed,  1 Apr 2026 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775058900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8fisAVZANo8uE9YSPPGP8hAvcm3tlB9RsLpwaI80c=;
	b=KxKJdSJzMBB5KGBVpdjE2dZ13KK6gfJ53giMBggUKFNzmI/dfTBQtszMJ4Y30Am5iv3u/R
	MNVaSnZq+8oaP4iKT01s9/HQ3lHj6uBNbvYeG3Dqh6VnNm4omXX01HCLl01vAQON3V5RAY
	nE3qvz9bP53wSiag8AyuLZrNeIybKQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775058900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8fisAVZANo8uE9YSPPGP8hAvcm3tlB9RsLpwaI80c=;
	b=odYUPWdnx6IPKTNAFR5zk6Ev7rIWFM8rXa0fXjRoMo4XpZqnVIzVuP+LvCpH09v132HIoa
	Iyye2Zdc9nxZ/lBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775058900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8fisAVZANo8uE9YSPPGP8hAvcm3tlB9RsLpwaI80c=;
	b=KxKJdSJzMBB5KGBVpdjE2dZ13KK6gfJ53giMBggUKFNzmI/dfTBQtszMJ4Y30Am5iv3u/R
	MNVaSnZq+8oaP4iKT01s9/HQ3lHj6uBNbvYeG3Dqh6VnNm4omXX01HCLl01vAQON3V5RAY
	nE3qvz9bP53wSiag8AyuLZrNeIybKQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775058900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO8fisAVZANo8uE9YSPPGP8hAvcm3tlB9RsLpwaI80c=;
	b=odYUPWdnx6IPKTNAFR5zk6Ev7rIWFM8rXa0fXjRoMo4XpZqnVIzVuP+LvCpH09v132HIoa
	Iyye2Zdc9nxZ/lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C2B4A0B0;
	Wed,  1 Apr 2026 15:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4d2UD9Q/zWkDXQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 01 Apr 2026 15:55:00 +0000
Date: Wed, 1 Apr 2026 17:54:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 6/9] libnvme: add support for per-path diagnostic counters
Message-ID: <22c01a60-f9c1-41ff-8f74-b48dc330e867@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-7-nilay@linux.ibm.com>
 <8b123263-297b-43bb-b9ea-272a9dd419c5@flourine.local>
 <afc7e386-e474-4ba4-8e3f-b710eee781f2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afc7e386-e474-4ba4-8e3f-b710eee781f2@linux.ibm.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_085502_188279_0DDD7BD1 
X-CRM114-Status: GOOD (  16.18  )
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

On Tue, Mar 24, 2026 at 07:24:11PM +0530, Nilay Shroff wrote:
> There are essentially two options,
> 
> 1. Include the diagnostic counter patches now:
>    In this case, nvme-cli/nvme-top can start using the libnvme APIs immediately.
>    If the kernel does not yet expose these attributes, the counters will appear
>    as zero in the dashboard. Once the kernel support lands, the correct values
>    will automatically be reflected without requiring further changes to libnvme
>    or nvme-cli (unless the sysfs layout changes).
> 
> 2. Defer the diagnostic counter patches:
>    In this case, the counters would be omitted from the nvme-top dashboard for now.
>    Once kernel support is available, we would need to update nvme-top (and libnvme)
>    to add them.
> 
> Given these options, I would lean towards option (1), but I’m happy to go with
> your preference.

I’m not sure if I read the room right, but I sensed the patches might be
blocked by the libmultipath project. If they’re just delayed for the
usual reasons, I’m fine with option (1).

FWIW, the 3.0 release is still months away, so there’s no hurry. I still
have a few TODO items and want to wait for feedback from LSFMM. I’ll
likely start the -rc cycle after that. Realistically, 3.0 won't land
until August.

