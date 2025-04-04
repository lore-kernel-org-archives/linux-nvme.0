Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A0C36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOHWLTohOvEe3bGytvnpUq4sFBZwxOi5+xflW0Yu+jE=; b=zWzZDUPkMs3oQWyZDjZIvcVJzC
	nTlm64dlJJuDQxMgRhncnqp+WpjAhCjIdklTfTfkOL3GJtHITbpnvQ5VM03Lh108xUavfswPPbz26
	8l7I9wc1xta7d0ZZSwecR/9wrIhkejRSw4ZUBCPJdX/KrbsCObDXG6ZXk6vZsKQAUkctICTcBzylu
	Pj4G8tEfD5DeUodvB3v8aeHcNzNbBonRbs1iRoLuhQ/o6+RcS6lIx3psNlXlx73RTia3CxqSlDEnD
	Q/Xm+ucY9WXrDQyK1wsOQ9aoa1y+L6Z9f1VeIbQ0nMKN+nO+GmYP66fFshozPlY28nw9ftbtV03ep
	MhXZ0FMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0dTq-0000000BION-3hh0;
	Fri, 04 Apr 2025 09:36:54 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0dTo-0000000BINn-1r1F
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 09:36:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC3AB1F385;
	Fri,  4 Apr 2025 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743759410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOHWLTohOvEe3bGytvnpUq4sFBZwxOi5+xflW0Yu+jE=;
	b=h0KRpG6vTMVSY/qQKdkAsPPHl9+85OebMKJg7bE/n4SRTwliQ/bSvO1Da4fSke6OfJN0Fe
	AIXwLx4dVSlkjsMTQje/7h4ewOdMp8gQ8CUN0EHo8uWiQDi/8bDU1YPS2bpMYwr1Nob0T8
	GgNgnXLkpDBVApIsiJ9PmGb1UlznaHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743759410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOHWLTohOvEe3bGytvnpUq4sFBZwxOi5+xflW0Yu+jE=;
	b=dqk7u7wq/KcpKuostu5gBvUWFij84/zBhZUND+2eI+eW00PW0ruIxtE4MG/npfDuKXgMr0
	1mmTGsRxDk0JJ5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743759410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOHWLTohOvEe3bGytvnpUq4sFBZwxOi5+xflW0Yu+jE=;
	b=h0KRpG6vTMVSY/qQKdkAsPPHl9+85OebMKJg7bE/n4SRTwliQ/bSvO1Da4fSke6OfJN0Fe
	AIXwLx4dVSlkjsMTQje/7h4ewOdMp8gQ8CUN0EHo8uWiQDi/8bDU1YPS2bpMYwr1Nob0T8
	GgNgnXLkpDBVApIsiJ9PmGb1UlznaHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743759410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOHWLTohOvEe3bGytvnpUq4sFBZwxOi5+xflW0Yu+jE=;
	b=dqk7u7wq/KcpKuostu5gBvUWFij84/zBhZUND+2eI+eW00PW0ruIxtE4MG/npfDuKXgMr0
	1mmTGsRxDk0JJ5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA10F13691;
	Fri,  4 Apr 2025 09:36:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gyFTLDKo72cqEQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 04 Apr 2025 09:36:50 +0000
Message-ID: <c12cf84e-360b-4b8b-b830-f792ea5889a4@suse.de>
Date: Fri, 4 Apr 2025 11:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: implement persistent read-only namespace
 feature
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250403144747.43043-1-hare@kernel.org>
 <20250403144747.43043-3-hare@kernel.org> <20250404062617.GD31468@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250404062617.GD31468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_023652_634875_FAD93838 
X-CRM114-Status: GOOD (  12.10  )
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

On 4/4/25 08:26, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 04:47:47PM +0200, Hannes Reinecke wrote:
>> Per default we try to open the 'device_path' read-write, which might
>> fail if the device is read-only. So retry with opening read-only, and
>> implement a new 'persistent_ro' flag if we did so.
>> And map that flag onto the 'Permanently Write Protect' setting in the
>> write protection feature.
> 
> This sounds like a really horrible interface, but maybe there is logic
> for it so explain why we don't require the explicit read-only attribute
> to open read only.
> 
I do agree, interface needs to be reworked.
But while playing around I found that apparently 'filp_open()'
ignores the file mode; I can easily call 'filp_open()' with
O_RDWR on a file with mode 0444.
Expected?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

