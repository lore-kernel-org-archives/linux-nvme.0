Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9951C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jDzzRNs2Lthud5OsNHv605JlYFbym+kRZsMpXN5Py7E=; b=j1DJjVYmwk8pkNathmgBzuVbXX
	HvmFEZiFqVa1Ii9wYE8eCXPSbnqKW6q1xvU++zdc1m6LlmMB7mPq3qyCK8upI6o6wFQT11eWnvKfR
	lBVS6QnmwYMReCCPjlpLmYiqRN0MfZm4q70xGprvOQmuyo/Kydqk43F6awipVkFfsfpyHzORhRerO
	si9MZXprZ6xV8XoA7OnHDIZQecLRumkIGStqt9/s9tx/RJOonrjJYxk93mJRo05QwbJNla2oyCLk3
	itYuwBWUye58xuunQH4hv9dwQ5ECN9WNk97s9L5CBkEbnm1RkGtkgIIi2tPXlM/a0b3l0gfSGrCg7
	k3kyFk/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkgJ-0000000GSjg-41U9;
	Mon, 21 Jul 2025 07:11:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkgH-0000000GSj3-2EGL
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:11:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE3121ADC;
	Mon, 21 Jul 2025 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753081884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDzzRNs2Lthud5OsNHv605JlYFbym+kRZsMpXN5Py7E=;
	b=zOu+YmiX3I1qyB9xJFGRfTpn5CKefXA/6D0mlP+oM1uT7oyRflnWieMXV/Okbx0wF7Fdw/
	TTZqP0obIbOT9EU0Dbif/a4H4LX5kpYYoTUAEIMUBdLcqLQZ/Dmm/wZ6UKjS7EKO0AvnGV
	fZbybltP98h8iRLkwXcM+68weqM7wA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753081884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDzzRNs2Lthud5OsNHv605JlYFbym+kRZsMpXN5Py7E=;
	b=9xbX9u2lRqBkZW7G6MZznuIObVQJcIy75gUO9Z8G9bnxebyuZt9fVcz8LsuTsqVctgYVtr
	WBBREMsNj9YWdhCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DCiMleSD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vf6jTlU2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753081883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDzzRNs2Lthud5OsNHv605JlYFbym+kRZsMpXN5Py7E=;
	b=DCiMleSDnJT2ZxcHaZN2OdITte0bG8FcQTIblTHeV5uRHk8Ln66ShCl95Mns9LxSXFaIju
	clYNDIAOqC6qVMNuX1qXAb83iD9upXBCHzzLzFpbP6TAKLfFIVclsHmqlCfTvMg66Izo/o
	q4HK4WDKL9eLY0Y//4fGrvU0WOB97MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753081883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDzzRNs2Lthud5OsNHv605JlYFbym+kRZsMpXN5Py7E=;
	b=Vf6jTlU2ItuNIkvGCwMi/lV+D+hyx9XhlmFDukMOeD1IxcFkPsyLlgdK8UH0QPKin5XCm4
	fTLaq8baKRIOrtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488A1136A8;
	Mon, 21 Jul 2025 07:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uD4mEBvofWhMWQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 07:11:23 +0000
Message-ID: <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
Date: Mon, 21 Jul 2025 09:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250721021718.1159879-1-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7BE3121ADC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_001125_718456_74849C7F 
X-CRM114-Status: GOOD (  20.27  )
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

On 7/21/25 04:17, Chris Leech wrote:
> I was attempting to debug connecting the Linux driver / libnvme /
> ktls-utils host stack to the SPDK nvmf_tgt over TLS, and ran into some
> issues.
> 
> The TLS connection fails to complete a handshake because the TLS PSKs
> are different. The NVMe/TCP specified key derivation steps from the
> configured interchange format, to a retained PSK and finally the TLS
> PSK, is implemented incompatibly in libnvme and SPDK.  After some
> investigation, I believe the SPDK implementation to be correct and am
> providing a libnvme patch to match it. With libnvme modified, I see the
> TLS handshake complete in tlshd.
> 
> (Note that this was tested using the obsolete "version 0" PSK Identity
> and TLS PSK derivation from the TCP transport 1.0 specification, as SPDK
> has not been updated with the "version 1" changes)
> 
> The NVMe/TCP host driver then quickly fails when SPDK sends a TLS "New
> Session Ticket" message before ICResp.
> 
> While possibly pointless due to the transport specification prohibition
> on session resumption and 0-RTT data, I don't think this is necessarily
> wrong and the host driver should be able to safely ignore it and
> continue.
> 
Sigh. The neverending discussion.
Originally I didn't implement key update for NVMe as neither gnutls nor
the kernel supported it.
Turns out that key update was implemented last year for ktls, and gnutls
has support functions (gnutls_session_key_update()) for this, too.
So we _could_ start looking into it if nvme wouldn't be using the
->read_sock() interface.
This interface just works on skbs, and as such we can't easily get hold
on the TLS alert data required for figuring out if a New Session Ticket
message had been sent.

I do have a patchset for converting that into a recvmsg() based
implementation, but that got shelved as we didn't have an efficient
iterator for data hashing. With the crc32 update from Eric Biggers
we now should have an iterator for crc32 data hashing, so I
guess I could revisit that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

