Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424D8C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmwZd7CrgkpLrSe+knYT1TrM1LoP5AXofSVFZUol46Y=; b=edZnffgrTRU27A8TiQ89Dme+Rk
	R8Ut8rswG8fALgvo7fbs3S9c67LPY/Onhk3NxkVfqd72ZvvoUIqv5Lv5bKhJYpogLxPX8kRJIb62s
	zuujFANMfP6z5RJljDwLQntj8vVIuOZSQ+brNx2O8qUvu0uTT83l8EsK2oZwx0QTfW0BujjrzdGaT
	RZYEwVmKG4LKNkBlqv0dUpNuv4pqmbM6KFbHBufpvHbO1i7+07MgWU9pgvNhJIpJbSXKUbL3uFSrq
	KDeRj8JqmTKqLBncmm6Garpp+fmu+xaCc+46mRRpraPDia6mK1QhhH/vib8pS9alvADl56GzCC5vK
	on+TyUxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQji-00Gs4d-1Q;
	Mon, 17 Apr 2023 15:25:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQjf-00Gs3K-2N
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:25:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D83BB219F7;
	Mon, 17 Apr 2023 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681745139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmwZd7CrgkpLrSe+knYT1TrM1LoP5AXofSVFZUol46Y=;
	b=h6rbssgmJmrDFsGPYoeH64areNwgUVSWRn0oKpa+2PFl6gswQAjiiEEZVnlsPSiubxFB4C
	oqOFLSAnElv5I7K8YfqAJfNQlQYlNnQJaNUup6U38hxIo+p0LpRub7PqFNctMuzb9dZZYd
	EEkne8T4dBPxWOdxIol8ivO/ReYhqlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681745139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmwZd7CrgkpLrSe+knYT1TrM1LoP5AXofSVFZUol46Y=;
	b=LLAOaCeLZmLCrMe9dB63IHW8zbqk4ljJLlIPN4NeDnRK0vHmBUP51SFj6hiL/Is3O85ipc
	c5DvFc6yJbhwojAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90C1D1390E;
	Mon, 17 Apr 2023 15:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ckUpIfNkPWQCNAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 17 Apr 2023 15:25:39 +0000
Message-ID: <654702da-246a-934c-14e4-7b179c46ed98@suse.de>
Date: Mon, 17 Apr 2023 17:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-9-hare@suse.de>
 <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_082543_926073_65D91C27 
X-CRM114-Status: GOOD (  14.84  )
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

On 4/17/23 17:10, Sagi Grimberg wrote:
> nak from me.
> 
>> MSG_SENDPAGE_NOTLAST was introduced with commit 35f9c09fe9c7
>> ("tcp: tcp_sendpages() should call tcp_push() once") to fix issues
>> with the ->sendfile() call, and the implication seems to be that
>> the flag should be strictly internal to sendfile.
> 
> no, the use case was to allow sendpage consumers to build larger
> tso packets for large payloads (splice being the primary one), nvme-tcp
> also benefits from it (as do others), just like sendfile.
> 
>> Hence we shouldn't be setting it on nvme-tcp, and anyway doing
>> so will cause TLS sending invalid data.
> 
> That is something else. I don't recall the full details on the
> discussion with Jakub, but it was not my intention to strike
> it altogether, just remove it if !sendpage_ok.
> 
But then we're running afoul with tls_sw_do_sendpage(), which uses 
MSG_SENDPAGE_NOTLAST as a record indicator. Forwarding 
MSG_SENDPAGE_NOTLAST to tls results in incorrect TLS records on the wire 
and a transmission stall.

Took me days to figure that out.

If you have a better idea, I'm all ears.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


