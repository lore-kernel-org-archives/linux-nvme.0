Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ED1C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pd/zoKIPVhqGALsb31F68cBqemSalKhzNTSQBWPlkNs=; b=A9ebsaD6VY3REoBJgxp4vZNDsf
	CMzrXFTADof+3o3Nz/nJCpUBCHIroc74nlbFDS1G6inaJzdEuKtqbhh2bGsMoj/MMeE4ikSUyzBWz
	IyC0CZEo0f28fsA4fxjN1RM5qOKug6IV6M6nq29k9uD2xrnPHKkm456StHeGiBWFZfzhSA1xLZTrm
	1ZVOnG/72wFv76OPe92H8jBEuDnEsdVCSXpx9B0r+aPslNaQwac/zv6HGAycNjg+IBsKXZi7i3ue0
	zHTzdRqpOMT67Kap7isdWShlHDFVdsjR/kYZHjdJULldalXSKXvnVRpDrTILiZX8t+Y4lzqYOZFm9
	jkxVEy7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKsk-0000000G1Hz-41o1;
	Thu, 18 Jul 2024 06:44:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUKsg-0000000G1Fd-3nCa
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 06:44:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49FF521BDB;
	Thu, 18 Jul 2024 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721285085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd/zoKIPVhqGALsb31F68cBqemSalKhzNTSQBWPlkNs=;
	b=cLkJH8sE/jS+YN3hotx57bnq6BEMAAlec+/d+MUQczPSGN0iU6NMFzLu1BW5lsc2l1vKlH
	PCRjH5u/vtRaoL6Zm1urhE7Bgst+6qHR/O5LA1gCLFsV7Z7006gsJ7RIJHMaPjHfgYIOW1
	kWNLAAZZb44g8TmVYFtVDRH2/LMYT8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721285085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd/zoKIPVhqGALsb31F68cBqemSalKhzNTSQBWPlkNs=;
	b=/g1ygKrjiXpDcWQxlQaZm6HLgGFT0EXJjXbwQ/4kvTKwyBwNkdVNgp/doZBtHhsL/KDM8q
	C/+33vrsntfGi/Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cLkJH8sE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/g1ygKrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721285085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd/zoKIPVhqGALsb31F68cBqemSalKhzNTSQBWPlkNs=;
	b=cLkJH8sE/jS+YN3hotx57bnq6BEMAAlec+/d+MUQczPSGN0iU6NMFzLu1BW5lsc2l1vKlH
	PCRjH5u/vtRaoL6Zm1urhE7Bgst+6qHR/O5LA1gCLFsV7Z7006gsJ7RIJHMaPjHfgYIOW1
	kWNLAAZZb44g8TmVYFtVDRH2/LMYT8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721285085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd/zoKIPVhqGALsb31F68cBqemSalKhzNTSQBWPlkNs=;
	b=/g1ygKrjiXpDcWQxlQaZm6HLgGFT0EXJjXbwQ/4kvTKwyBwNkdVNgp/doZBtHhsL/KDM8q
	C/+33vrsntfGi/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1D5136F7;
	Thu, 18 Jul 2024 06:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Cy+BN25mGbzAwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 06:44:45 +0000
Message-ID: <59cad15b-1088-412e-8f61-6a5d87f81ccd@suse.de>
Date: Thu, 18 Jul 2024 08:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 00/16] nvme: implement secure concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <58cea755-d1c1-483d-b6b8-008d22daba7f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <58cea755-d1c1-483d-b6b8-008d22daba7f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49FF521BDB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_234447_306421_07B8E538 
X-CRM114-Status: GOOD (  18.39  )
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

On 7/17/24 23:38, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 12:10, Hannes Reinecke wrote:
>> Hi all,
>>
>> here's my attempt to implement secure concatenation for NVMe-of TCP
>> as outlined in TP8018.
>> Secure concatenation means that a TLS PSK is generated from the key
>> material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
>> is then used for a subsequent TLS connection.
>> The difference between the original definition of secure concatenation
>> and the method outlined in TP8018 is that with TP8018 the connection
>> is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
>> with the generated TLS PSK.
>>
>> To implement that Sagi came up with the idea to directly reset the
>> admin queue once the DH-CHAP negotiation has completed; that way
>> it will be transparent to the upper layers and we don't have to
>> worry about exposing queues which should not be used.
> 
> I'm glad it worked out. Happy to see that this set is getting in shape!
> 
>>
>> As usual, comments and reviews are welcome.
>>
>> Patchset can be found at
>> git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
>> branch secure-concat.v5
>>
>> Changes to v4:
>> - Rework reset admin queue functionality based on an idea
>>    from Sagi (thanks!)
>> - kbuild robot fixes
>> - Fixup dhchap negotiation with non-empty C2 value
> 
> Can we split fixes from this patch set? (unless they are only
> relevant only to the code introduced here).

Yes, thought about it myself already.
Will be doing that for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


