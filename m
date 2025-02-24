Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3117DC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9uibzbREKuCgY/EfiKLuGOGXUkwVZhZTzEQKVvd7ao=; b=CAb81EB9s9yP+wHyJG8YgZG4dw
	vhz5MHOuxxJsqFBh2UJbR3cHX7Whi3B3QEsuScr7kdrDGTBYU5AcrcXPnr+GtHuy8vxK4VPsQDq18
	S9HCHl7BCeiOPPvj0oI04dClKcPoiJftea0cCh9fmcaueI/jHLsEWS1CYeFflKFm7S+QWagqrTURI
	zV1RCuHpkpgmuxH2wtObWYh2Chy97NMW5Dh+zRrnsKdsrvh7xtpXatP6EK/vDuScsUiyCcRR/uBMh
	dOUBvNiMHIfq9wCCfz829bqAyO+F7eASkWO5TH3/i//Yf3hDwdm3xbuVyMbqvVKWFxRoWDi30em60
	Si0CchHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmawW-0000000EOr7-2Q5W;
	Mon, 24 Feb 2025 16:04:28 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmawT-0000000EOpZ-3YU9
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 16:04:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13A4221189;
	Mon, 24 Feb 2025 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740413064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9uibzbREKuCgY/EfiKLuGOGXUkwVZhZTzEQKVvd7ao=;
	b=LqPfbODzWlBbTRs0v+tXNDrAZ+ujQDM8S2/akpJFDDAxAXFqJyegFF4BhyYWzJY3NmYBJQ
	crK0+bSwYo+A067F31gOY1ThN6nDx3ktEm1NBYe4KKPy4FBivzEIO65my/4M9qkmSn1GZd
	ZHIYZ0cXnw5AAkh3lOfsmthgFunW+Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740413064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9uibzbREKuCgY/EfiKLuGOGXUkwVZhZTzEQKVvd7ao=;
	b=rdMrCzNev9nnguCKrK9ayF6Cu+2Qa8IFwVB+nm4X9un0esE5SJ5K762yCYSCi6vyhAAZBg
	AoSS1kknsT5nZdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740413064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9uibzbREKuCgY/EfiKLuGOGXUkwVZhZTzEQKVvd7ao=;
	b=LqPfbODzWlBbTRs0v+tXNDrAZ+ujQDM8S2/akpJFDDAxAXFqJyegFF4BhyYWzJY3NmYBJQ
	crK0+bSwYo+A067F31gOY1ThN6nDx3ktEm1NBYe4KKPy4FBivzEIO65my/4M9qkmSn1GZd
	ZHIYZ0cXnw5AAkh3lOfsmthgFunW+Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740413064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9uibzbREKuCgY/EfiKLuGOGXUkwVZhZTzEQKVvd7ao=;
	b=rdMrCzNev9nnguCKrK9ayF6Cu+2Qa8IFwVB+nm4X9un0esE5SJ5K762yCYSCi6vyhAAZBg
	AoSS1kknsT5nZdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9D3013707;
	Mon, 24 Feb 2025 16:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CMHANIeYvGdoZwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Feb 2025 16:04:23 +0000
Message-ID: <0e3af565-f8e6-4647-89c3-6757f6bae3a6@suse.de>
Date: Mon, 24 Feb 2025 17:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hare@kernel.org
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
 <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_080426_042960_C8AEDB59 
X-CRM114-Status: GOOD (  12.23  )
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

On 2/24/25 15:38, Maurizio Lombardi wrote:
> On Mon Feb 17, 2025 at 11:56 AM CET, Hannes Reinecke wrote:
>> Can you add support for nvmet, too, such that we can test the patch?
>> (And maybe even a blktest script for it?)
> 
> Possible target-side implementation here.
> 
> Question is if it's acceptable to send the packet in
> blocking mode (MSG_DONTWAIT unset).
> 
I really wouldn't be doing that, as we need to terminate the queue upon
fatal error and don't really want to delay that (eg by waiting for the
transfer to finish) and

> Errors in nvmet_send_c2h_term() can be safely ignored because in any
> case we are going to perform a fatal error recovery immediately after.
> 
we don't really care about the error on sending anyway, so this is just
a 'best effort' thingie. If it works, fine, if not, fine too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

