Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649A5CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=; b=bGB8bBP2sWjeDZHM0Nfl/O82Uj
	fEUtn0X46yKj4iXUd3DIFhd1hziXjTpDxSfGQjzLcZMLmCIJKOur/ArZWdzk8oBV4lKJCZD7WerZ8
	7/IiUzK4Gg1qs//SxtoTUY2JOr42pVjQQUOIpUkFgTe2Gw/sGMRT0uv2INKEIXX014rtMRsxr22fK
	PPqWKBBB/gS3G2lqvCVYKWlpQ/D6PIa8MQS7m+LOiW0pXK0u2ELoOTyRPJnfVZ+yurvUN5LZ72C0q
	eSzMPqE6cIobTzfMfnQPNKuchHK71s17Zryb4ps8UFPWDJjdk/QKl2Swf6Uw4t7NbE0u4mq694cgQ
	WKAv9uDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utNH2-0000000GLqP-1jqf;
	Tue, 02 Sep 2025 09:25:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utMnj-0000000GChd-33bc
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 08:55:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 353E21F44E;
	Tue,  2 Sep 2025 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=DGlPwnXtH8mCUTXb6T5MHUKgfNtZnDvffrikG16pXSj5i2pDtRTrXteTU2slrFdhcdEfRS
	v6nnF7cIBtZXzD5HjTt5kICE1YtYrvt/+uds7jYxr8wLXa/XYNd1mubz+r6R8Sla3WJcax
	49Wk5ap6Xs/0djam1SDxGyTzTNYs1Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=HUof7w+AWtw38QdxpWcvbWJAMBz+atWfWTrucNjK+AwP4Rm+47rtOMEHuAer2aQZVKwtRA
	rULECNcAAHkTJJCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=DGlPwnXtH8mCUTXb6T5MHUKgfNtZnDvffrikG16pXSj5i2pDtRTrXteTU2slrFdhcdEfRS
	v6nnF7cIBtZXzD5HjTt5kICE1YtYrvt/+uds7jYxr8wLXa/XYNd1mubz+r6R8Sla3WJcax
	49Wk5ap6Xs/0djam1SDxGyTzTNYs1Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzEzSeG1OZAmNkAv8N7UBHLIFuPoLWkfKAmO5QPVi5M=;
	b=HUof7w+AWtw38QdxpWcvbWJAMBz+atWfWTrucNjK+AwP4Rm+47rtOMEHuAer2aQZVKwtRA
	rULECNcAAHkTJJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC4DB13888;
	Tue,  2 Sep 2025 08:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1T5ZOAmxtmhWAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:55:37 +0000
Message-ID: <24d92bef-6982-4cbc-91d1-49c21090860f@suse.de>
Date: Tue, 2 Sep 2025 10:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet-fc: avoid scheduling association deletion
 twice
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
 <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-fix-nvmet-fc-v2-2-26620e2742c7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_015539_929349_1D9CC12B 
X-CRM114-Status: GOOD (  18.29  )
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

On 8/29/25 17:43, Daniel Wagner wrote:
> When forcefully shutting down a port via the configfs interface,
> nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
> then nvmet_disable_port(). Both functions will eventually schedule all
> remaining associations for deletion.
> 
> The current implementation checks whether an association is about to be
> removed, but only after the work item has already been scheduled. As a
> result, it is possible for the first scheduled work item to free all
> resources, and then for the same work item to be scheduled again for
> deletion.
> 
> Because the association list is an RCU list, it is not possible to take
> a lock and remove the list entry directly, so it cannot be looked up
> again. Instead, a flag (terminating) must be used to determine whether
> the association is already in the process of being deleted.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

