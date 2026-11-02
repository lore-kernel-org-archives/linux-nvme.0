Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE3606A324
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sSUR678M;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bDLGMxTX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5+yjXGQ/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J2WRIVGZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=moL6VIMi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gQWdQIzZ2bCKBTMUKnE0PqNOxQmw2Qi57vHX9Cn9mks=; b=sSUR678Mm7HDEi
	E6Ol4AHikRR/EPc3BVe1XaC0kX7k6u3mYDADBjaDfPQaNwI1CvxTWnPCT8oh/C+yTpbPMDIWiHJXF
	GVoEV5XsXf9aONZrA52VbZDOtZaS5nXFyhMY/wdeAtv1zowV2qC0rE3g+DBQbWlKDAuXKwl9Vjcts
	bTeLTK0zyKhNdxSUqd9T87iSpBHoNh1xtubbyYA5g5WBIhMQ+YyJVfc10yf98LCRP0yrUK257bJau
	ZKyB9HNEYCqsvPSziB5jBl8SoB6GGQ0+Bvh26JH8VEH3C5nff5yWBXqUZxSPG2F8oxeOxHGYGxl8l
	N5jlo1cIzCjZiHDn4ubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmSm-0000000FkI2-0zKM;
	Mon, 02 Nov 2026 07:28:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmSj-0000000FkGa-4123
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 07:28:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E804F1F788;
	Mon,  2 Nov 2026 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQWdQIzZ2bCKBTMUKnE0PqNOxQmw2Qi57vHX9Cn9mks=;
	b=bDLGMxTXyMIqxWdAXqwFLgIanu5AmjJ7CQrvSUXqvFpNJ8uY3Tr5+JVlPNVCmZxShL5dqV
	e/cHCRj8UHKtxUvXriwOwlQBuAfLMu4iBSpkIiYWYByXTBEvKpeIukAnyb8CwfrbN4kRFi
	86GkrUKw/BneevruEYElb2s1RxPmyAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQWdQIzZ2bCKBTMUKnE0PqNOxQmw2Qi57vHX9Cn9mks=;
	b=5+yjXGQ/wRGrXiQhR/lHqvquxETME3v7jrZpfxhRh35czuZxZBw9ex5yYMO34D3jmE7BlM
	GXYzYTAKttPdMcBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J2WRIVGZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=moL6VIMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793604490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQWdQIzZ2bCKBTMUKnE0PqNOxQmw2Qi57vHX9Cn9mks=;
	b=J2WRIVGZauSt4aMc2PNK+lUQMskNg2r9pTJbTzrm9DO7axAPQifFiGACtQZzAovGDkHQ67
	MLKRt/Xp7Wy6xRTURf0yQf8ptdPVVUfgqiuuL5GZTS3VKNqxuI8lRYsPqK41MSPfwzugWQ
	GZusGD/bsy9yaWYgMiwD5eFGkoEw3FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793604490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQWdQIzZ2bCKBTMUKnE0PqNOxQmw2Qi57vHX9Cn9mks=;
	b=moL6VIMiQpapkZ1Ep8uk3VUF1l7u36mhcG0BmDL+peFk8G9kocu2vbERKXRlqJKLNpkQ5e
	ZGRSXyk/GciLbTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A52134B3;
	Mon,  2 Nov 2026 07:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FwteG4o76Gq9bgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 07:28:10 +0000
Message-ID: <8635ef5c-278b-46d9-90e9-b048d45963a2@suse.de>
Date: Mon, 2 Nov 2026 08:28:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and
 queue info export
To: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
 <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
 <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
 <104ce7b7-dea4-4a08-912b-a8222ff73db7@linux.ibm.com>
 <2f852433-b799-47b7-bf08-0b11070e49f4@flourine.local>
 <cd9bf3cd-50be-4891-bfa7-50a021b57765@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <cd9bf3cd-50be-4891-bfa7-50a021b57765@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E804F1F788
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_232814_142398_CF20459C 
X-CRM114-Status: GOOD (  11.76  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 6:42 PM, Nilay Shroff wrote:
> On 10/30/26 9:58 PM, Daniel Wagner wrote:
>> On Fri, Oct 30, 2026 at 08:35:16PM +0530, Nilay Shroff wrote:
>>>> Alright, then I'll move this under sysfs and spin a new version.
>>
>> FWIW, I can imagine that it might be useful to add some support in
>> nvme-cli, so sysfs would be the choice for this.
> 
> Yes agreed!
> 
Yeah, that was my reasoning, too.
So we should store it in sysfs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

