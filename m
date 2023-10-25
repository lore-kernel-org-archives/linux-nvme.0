Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6AFC25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeDWim+JScQgSjn6RlSH0KxhQY+Tl4p6+kd8bxOPMlY=; b=NuYpVYqdjfG1SkUl9MWbyBjHYG
	cgcfNH1bMY4sKKUvMcLgNKKdBDwsSmLxUXzHlMb/ERw83PQISrtAwAR2LKBEiswOTjqhb6ERp0SgN
	EgWA4K7LSahcttEncFbjW8lx+/uJoGoSkVRs0Evf4e2fS8ZjqcOUO2MOcffDKPza3vbkWGhddP/sw
	bR4PeMvRrU//SmmiTtecCyLGDwLc6rDJF2sSZ41aMovfZX82e5+ZXLfSmG4U/d0f/dXOPY8OSp+oI
	ooO1VtYb91tj4GtBtQhlrhzWRs2yOq28J9jMhR2tDAZNMPQButZEsatdTAQRHtVbOH7VHgLSFpmHd
	RnO9Awyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbZ9-00C87B-1k;
	Wed, 25 Oct 2023 10:56:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbZ6-00C86g-1s
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:56:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B4FF21DA9;
	Wed, 25 Oct 2023 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698231402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeDWim+JScQgSjn6RlSH0KxhQY+Tl4p6+kd8bxOPMlY=;
	b=NXnheQZXRctRq2m3ZlyuWmkmoLDpA+qf06DJJuynTTtgtq+EDmb1eph14FuwoRMIhoqcfF
	a7MLqTF3hRYZqtSjhtLegBBFCN3B2KrP4HA4dP1HkMrrO29pQW2LmGlJZmVMUlxcNaUpLe
	0eYMBpZCGQf6mAOtl1hA/2yeG9xi82M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698231402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeDWim+JScQgSjn6RlSH0KxhQY+Tl4p6+kd8bxOPMlY=;
	b=BAukHQ5a4vx/UD9JbN9yEXKEZACAjqqhFIAKD0uHEtu8bKWjkF4jkDLUCemLRHWKuuLPyf
	ZE4pzjFKIS9dfIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC40C13524;
	Wed, 25 Oct 2023 10:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SAINNWn0OGVfSgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 25 Oct 2023 10:56:41 +0000
Message-ID: <70ec751d-8aba-42b4-861c-e7e17c4a7476@suse.de>
Date: Wed, 25 Oct 2023 12:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme-auth: always set valid seq_num in dhchap
 reply
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org
References: <20231025105125.134443-1-shiftee@posteo.net>
 <20231025105125.134443-4-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231025105125.134443-4-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-11.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.80%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035644_808989_507A967E 
X-CRM114-Status: GOOD (  11.72  )
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

On 10/25/23 12:51, Mark O'Donovan wrote:
> Currently a seqnum of zero is sent during uni-directional
> authentication. The zero value is reserved for the secure channel
> feature which is not yet implemented.
> 
> Relevant extract from the spec:
> The value 0h is used to indicate that bidirectional authentication
> is not performed, but a challenge value C2 is carried in order to
> generate a pre-shared key (PSK) for subsequent establishment of a
> secure channel
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> ---
> v1: used incorrect prefix nvme-tcp
> v2: added spec extract to commit message
> v3: read the seq-num in nvme-target code
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



