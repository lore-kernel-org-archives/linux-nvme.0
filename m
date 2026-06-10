Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F20CD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWlXqMNaTbPlacfk2adDm3ySIJoJTDnUX//bGkTagt0=; b=fBxjMBffakNJZ1ApIh5mIG5Ter
	NJDdCfhIxhVghsvKv9jpT0zPMkDSAXtyymCj7P8NQluxxxXWu+cJ9PrGkyPUhRM7QpbIcOTiM2Xq+
	kynCPCXTwaiqfV8qxL355pAAcnvLxotGpPNTmI/hzss3/heryHTVCZSlU9rL25ZyH07TN/NzSYE7Q
	Y4tLt8xLYXZ+lj2umbKiDDOHIEmGvZuynylfY1/BHilqKK0asQ4cxPYk70bnUfI714suFpuTX3VFT
	eiuMNuuLWnzBX6XY+cc3H7/Sx3V+an30Xn4zXM6aHdWdg5A2ER9zDo10UM0FeryIQcQ3YmjjTVSox
	94M1wJHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHBn-00000007Y2a-3jcz;
	Wed, 10 Jun 2026 11:33:43 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHBk-00000007Y21-43Hb
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:33:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2CD375950;
	Wed, 10 Jun 2026 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781091219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWlXqMNaTbPlacfk2adDm3ySIJoJTDnUX//bGkTagt0=;
	b=G0HMC9hKOrV0h5l09u9RuXQK+vouSO25xR766dzx2DXDlb/hvTXml3bJQgkCWQ0VBaAgfS
	PkchwWG4nk/BISOPwuH6jA/swgbRV88GmuaLeYf6CAkuULoY0Ub9iF4/coe9GAdDHLjTQj
	ILuebVEAowNoxWrBcEXjW7l9X7BoQys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781091219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWlXqMNaTbPlacfk2adDm3ySIJoJTDnUX//bGkTagt0=;
	b=958h9ToibTwc98APt6b55jAj1Hu3Rap+HmhOOZAjaL2phXylY1b+5VJZQJdjsLgEoLMBSZ
	yEtuaHEu7AqyDiBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781091218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWlXqMNaTbPlacfk2adDm3ySIJoJTDnUX//bGkTagt0=;
	b=ENb9j3iT2qdszAUsNInReK9xBtv6d1p71iht0mWYvCtcauu137dziZOTGKVOZEHIEd6rZd
	ndHrbr5HTWIweb1PfaYd63mlItcYGbNXBSQEOSZyIjtltgIqsbeEThNAIaVMJ8hjpLSi5S
	3gSgTaihei8ZfgS9lr86PAp53PFWul4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781091218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWlXqMNaTbPlacfk2adDm3ySIJoJTDnUX//bGkTagt0=;
	b=OwLj/Wqy/ecLg/AQDBslNCJpJB2Zddg8dv7c+AD0rhYz/N9zs3KrPu6/mF7TkAQ3R0bUuB
	PIzIXz21J6upBJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B928D779A7;
	Wed, 10 Jun 2026 11:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OY0LJJLKWqVNQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 11:33:38 +0000
Message-ID: <3207d702-f51d-4e20-bd2f-ea61d41e1c4b@suse.de>
Date: Wed, 10 Jun 2026 13:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make nvme_add_ns{_head}_cdev return void
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, mlombard@redhat.com
References: <20260610111608.3252988-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260610111608.3252988-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_043341_162158_E05458FB 
X-CRM114-Status: UNSURE (   7.03  )
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

On 6/10/26 13:16, John Garry wrote:
> The return code from nvme_add_ns_head_cdev() and nvme_add_ns_cdev() is
> never checked, so make those functions return void.
> 
> A cdev add failure is tolerated during initialization, and flags
> NVME_NS_CDEV_LIVE and NVME_NSHEAD_CDEV_LIVE are for determining whether
> a cdev needs to be deleted during un-initialization.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

