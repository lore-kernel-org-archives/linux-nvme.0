Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DABFC36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bid8DTx6k9acJ92L41rKXVdYqSxzF6CRFLkkrnnNGOI=; b=NDOLZJG/2z7R4l/tQymiMDvg/B
	Dn3yD1gorA6V5GY/O/TvhMUKBCLUEq2nKOimBsR+U4M/r/C44Z5D2Y4YL8j0iDGapdoxdyCGTbiuh
	m/gnpIrrpEs15OuSQVCD8icvqDWRJngDoTduWSvPfsPj61pAjwuj7l86wWlP8NBIghmOwwo7WVBkr
	Sp+kZla3U1N+wuRg36Mf6X+lbURj33omh4PrhHqlKY8Mv5UFSGhU/zvVLU0lcnFBIeflFtL4uoyR4
	MuIpv/zEipzxfl3RCM3hB5PUJFjrfM2ypWp0234HmOYvc84A56FpYZMcWCA4vZdmJ1wEHW4/W996i
	+jBEWV1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1fjh-0000000GXXC-0BFw;
	Mon, 07 Apr 2025 06:13:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1fje-0000000GXWQ-1YNf
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 06:13:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E2362118D;
	Mon,  7 Apr 2025 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744006408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bid8DTx6k9acJ92L41rKXVdYqSxzF6CRFLkkrnnNGOI=;
	b=ou2pNDSoAhARHMIGp8hj7JbMF+McKJACcTlLNauRGmxH1czRezQPaALhg/vlQlk7diS7ar
	H5KdWzqNymV27QhDagTwWNa+T33zg3NF+H/10hPS2lZlvZwG6TV7xpS/1VwdgCHxeOHgm6
	HOjR+itmQMGK+xMoBfhgkXJNxU7/q5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744006408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bid8DTx6k9acJ92L41rKXVdYqSxzF6CRFLkkrnnNGOI=;
	b=xMBmbjI0tZ+1e1D87TfEYzIpS4kAzH4eRfPZShg1B9zWr78D2Zrljh9q/Hook1ivDaCzqe
	65xWbtVBA68G+BDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ou2pNDSo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xMBmbjI0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744006408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bid8DTx6k9acJ92L41rKXVdYqSxzF6CRFLkkrnnNGOI=;
	b=ou2pNDSoAhARHMIGp8hj7JbMF+McKJACcTlLNauRGmxH1czRezQPaALhg/vlQlk7diS7ar
	H5KdWzqNymV27QhDagTwWNa+T33zg3NF+H/10hPS2lZlvZwG6TV7xpS/1VwdgCHxeOHgm6
	HOjR+itmQMGK+xMoBfhgkXJNxU7/q5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744006408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bid8DTx6k9acJ92L41rKXVdYqSxzF6CRFLkkrnnNGOI=;
	b=xMBmbjI0tZ+1e1D87TfEYzIpS4kAzH4eRfPZShg1B9zWr78D2Zrljh9q/Hook1ivDaCzqe
	65xWbtVBA68G+BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 340B813691;
	Mon,  7 Apr 2025 06:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vk/WCght82f5AQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Apr 2025 06:13:28 +0000
Message-ID: <1bc57ed5-d1da-4340-a97d-8bc90a076562@suse.de>
Date: Mon, 7 Apr 2025 08:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] nvme-tcp: do not complete the request if send
 operation fails
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 mlombard@bsdbackstore.eu, zhang.guanghui@cestc.cn, loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-3-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250404082801.1614252-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E2362118D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250406_231330_553059_E031B497 
X-CRM114-Status: GOOD (  10.87  )
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

On 4/4/25 10:28, Maurizio Lombardi wrote:
> In some cases, the send operation may fail even though
> the command is successfully received by the target.
> The target then sends a command completion capsule back to the host,
> leading to double completion and a kernel panic.
> 
> To prevent this, do not fail the request; instead, let the
> error recovery mechanism clean everything up.
> 
> Tested-by: Zhang Guanghui <zhang.guanghui@cestc.cn>
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
You could have merged it with the previous patch, but that's more or
less cosmetical.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

