Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67287CCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CoV6QlynsoaKz3pL03DfaQng9wukju4CUok/Xssn+v4=; b=k2VtAO04zU17YYcZKObuGjLajT
	SXUGE/b4sQPON7LQcZlbBqCxw0sGB1ZtQbVh/kid49Lfyu3meSNm8oknWwhTXkdsBsPqYPTJzil9L
	rrHW5vCKmhBBnwgmHq5fXeapQUWBWDRKeFchg2ThY52XF2hQ2BUOg3xBhnSxcKQq25u+mu8bZSAur
	/tj1ZWRYoA9o7Bm9CLdjrgpjNHg5aCDckAiFzm4wntiiCqxtre755ZAZdIwmGJQytBkzFbdD4BZcW
	kbXhH65nXlXzxyVdkXu8KGDOxGGPSO63yDbELgaS1g0Q9/tqKirWPqnFuvCTLIP91z57qCrxWXiA/
	IcGc3rqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3YxM-00000005BRk-2nac;
	Tue, 30 Sep 2025 11:55:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3YxK-00000005BRC-1lRK
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 11:55:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9071433694;
	Tue, 30 Sep 2025 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759233338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoV6QlynsoaKz3pL03DfaQng9wukju4CUok/Xssn+v4=;
	b=A+zoDee9Db34XsIVoVRJIR5etpbYUzkGApOvi03I7a8z5a+yVe5rejojcVzG2DxC7iALsV
	r3q93HLBHwSXTdanrcH+COotJV7wJfeUglXPL3XCPeJJu5qZMWol4gnmCof4U2BEZcw6FU
	rigNpG+EQvHpsJz27zTWfijO4pNZtOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759233338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoV6QlynsoaKz3pL03DfaQng9wukju4CUok/Xssn+v4=;
	b=39EQADBDAZYGozJENY4RyO7kFc4r5s1ugm7+mimw9LJicWjC+9PUlkLd/rYAMa1rTfZsms
	/fRDxk58UPkG40AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759233338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoV6QlynsoaKz3pL03DfaQng9wukju4CUok/Xssn+v4=;
	b=A+zoDee9Db34XsIVoVRJIR5etpbYUzkGApOvi03I7a8z5a+yVe5rejojcVzG2DxC7iALsV
	r3q93HLBHwSXTdanrcH+COotJV7wJfeUglXPL3XCPeJJu5qZMWol4gnmCof4U2BEZcw6FU
	rigNpG+EQvHpsJz27zTWfijO4pNZtOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759233338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoV6QlynsoaKz3pL03DfaQng9wukju4CUok/Xssn+v4=;
	b=39EQADBDAZYGozJENY4RyO7kFc4r5s1ugm7+mimw9LJicWjC+9PUlkLd/rYAMa1rTfZsms
	/fRDxk58UPkG40AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DAF91342D;
	Tue, 30 Sep 2025 11:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aRoFEDrF22i/JQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 30 Sep 2025 11:55:38 +0000
Message-ID: <c07e6d1b-3212-487b-b859-7a4d0837f98d@suse.de>
Date: Tue, 30 Sep 2025 13:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvmetcli] nvmet: store DHCHAP attributes
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250822115155.95097-1-hare@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250822115155.95097-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_045542_607098_3F769D06 
X-CRM114-Status: GOOD (  13.00  )
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

On 8/22/25 13:51, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> The DHCHAP authentication is stored under hosts/, and are starting
> with 'dhchap_'. So add a 'dhchap' attribute group for the host object
> to correctly save and restore DHCHAP values.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   nvmet/nvme.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5..679116e 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -892,6 +892,7 @@ class Host(CFSNode):
>           '''
>           super(Host, self).__init__()
>   
> +        self.attr_groups = ['dhchap']
>           self.nqn = nqn
>           self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
>           self._create_in_cfs(mode)

Christoph?
Ping?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

