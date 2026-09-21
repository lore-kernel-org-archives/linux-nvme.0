Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA773C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYtVNdTlEN0KkQ4HDZ6Q6o7+wc0T0a2l6jxfSkZvLds=; b=S3DmZ4z3iCRMmiourNTeMcIwuB
	I+BTgITfQhQ2yxQyaqnqIKZqOJOfCVhCv+/qVX/EsAgZlwWjz5/xXTFUHDBc6iuD6A9Qpfh0Qq/7m
	0O3/iIwxI3GkSZ8j5zXzn/7bIRUiWvnclZ4pkKU2usuEpv6UJhqmuFBRhn7XbTgotCpzF0EU30+nJ
	waA0egyx6A7X7EmfSEjK/htPValrtjPn0uloYCKnwvAuESJ63K7J+5Gkx7K0sQBgHwIwwhsDRjrzH
	Z6dzHh5Z3iQHfjjk3YIBzuFCfYO/rNyNzyvgj2ExpEMtCEtCY8R/K3G4a9oeYkH5+S66UqBDoSqEm
	7NUpMHIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zvy-00000001R81-1Xfs;
	Mon, 21 Sep 2026 09:03:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zvs-00000001R66-35n5
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 09:03:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C51111F747;
	Mon, 21 Sep 2026 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789981402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYtVNdTlEN0KkQ4HDZ6Q6o7+wc0T0a2l6jxfSkZvLds=;
	b=13GGOxK+GEjnNtjkNi9mlhOK0ecTptB3I0JNVZCgJ+CseOSP23HYJrvJmrAz+pEkQkPWPE
	9WwDiuayYKLDvqqv0P7JFaxIEsa8t3RsqlUayAUes09pvpGv77mC/xGBtLqDGhVXg4eQDL
	ALsDddCXTJrtYN7zmwylmNCyqaqn2xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789981402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYtVNdTlEN0KkQ4HDZ6Q6o7+wc0T0a2l6jxfSkZvLds=;
	b=rNYfvwI7Lv1bLyuMFVnwUG1ce30Vl3z7gsuKqo0z/23FH2zF6fsxE8TdV5MecihnUjMhcB
	siGmbFyl7MRoeiCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789981398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYtVNdTlEN0KkQ4HDZ6Q6o7+wc0T0a2l6jxfSkZvLds=;
	b=pwZvzqjbLZSkFeW62uxAFtu9G49EO+7Rkt8xVwikwKZOlvGC+HuycYDw539DcTH5wGhVSc
	0vTLs22ODzFxkTbqZmrSOBUhL4mkRRaH+FPWcLmJ9i+2tjFDaxauXeO5gcaNfWgpjeQkxd
	Pe7/ZGfTUMpyBobMqtm5pMt9LgOuh+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789981398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYtVNdTlEN0KkQ4HDZ6Q6o7+wc0T0a2l6jxfSkZvLds=;
	b=zBFqRS1qzZAgMDqQVxR9W1CVhe+MSIffUPZOl90aCTMEcrryFacUVpHWfgJwlbnWXnP1NL
	CuTlmwQR+v7S0fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 595D71368D;
	Mon, 21 Sep 2026 09:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tc9mB9bysGplXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 09:03:18 +0000
Message-ID: <65caa009-080d-47aa-a25b-632878a82160@suse.de>
Date: Mon, 21 Sep 2026 11:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
References: <20260920025214.3089533-1-kanie@linux.alibaba.com>
 <20260920025214.3089533-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260920025214.3089533-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020329_606721_B3C9CF38 
X-CRM114-Status: GOOD (  14.97  )
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

On 9/20/26 4:52 AM, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
> current path state, including whether the path is enabled or disabled
> with a specific reason.
> 
> Factor the path disable checks from nvme_path_is_disabled() into a new
> nvme_path_get_state() helper that returns an enum nvme_path_state. This
> keeps the path selection logic and sysfs reporting in sync, so any future
> updates to the path disable criteria are automatically reflected in the
> sysfs output.
> 
> Possible values:
>    - "enabled"      : path is usable for I/O
>    - "ctrl-down"    : controller is not live
>    - "ana-pending"  : ANA state change pending
>    - "ns-not-ready" : namespace is not ready
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   Documentation/ABI/stable/sysfs-nvme | 21 +++++++++++++
>   drivers/nvme/host/multipath.c       | 47 +++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h            |  1 +
>   drivers/nvme/host/sysfs.c           |  4 ++-
>   4 files changed, 66 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

