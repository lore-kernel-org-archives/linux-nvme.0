Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF261606A33A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yuxZUrNj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cPUAdIEI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MeRVOgbM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cPUAdIEI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MeRVOgbM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8+/2WoxFdpcQdUsqbaVip+amN1KRS8T5dllu47RLv5o=; b=yuxZUrNjYcWi3s
	BTtoej4vCVC0j9BZAdjP3j+96WQmvf0xfYv6GDHj/NejsCp8xVNuOFSk25DvMTzDQ1W4PQty9F4BD
	411nLecC2bp8f22PojMyIaHGdX5oDGeIY5MjLX5dOhN0M1Le9HIZoBMHnlNjCVtB0ZumTPr1rnR4N
	SJvZRNPF02XiuzuukSc8yudUKz7ijAVZe17aUIxe4V/rYlWOJY1JQUVVwHQjiZCQCoBiA5dL2E+FR
	1e2Yhb0OLzs6rL3Q9pbm2gN5jFBivfbKUQR8QqezIuJd5IezYbOLVfCu8onx/tFtO7ARyi3BtpEtn
	k43Uu8gPGEzRKwNmzU9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVWAd-000000043Cx-2a6H;
	Mon, 23 Nov 2026 15:41:31 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVWAZ-000000043Bp-26SG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:41:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92E8E1F390;
	Mon, 23 Nov 2026 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/2WoxFdpcQdUsqbaVip+amN1KRS8T5dllu47RLv5o=;
	b=cPUAdIEIrqM1kE3D/wgLateAtVuXGul9Gi1xOsSPgQ1JLo4wgf89AjtTF1M47E0lBDUy85
	JC3FpvCNHTPtevWbQ5xcW+etHvlEstYZSTrs1nu89l25yTNCm0bgUiF+bp6shIbSGz1G22
	NVNsxAwD7u6hUIYS2ZZgN0arqYyuvfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/2WoxFdpcQdUsqbaVip+amN1KRS8T5dllu47RLv5o=;
	b=MeRVOgbMJEh/BOCD0ScBfVEUF9K5YqAqkyMRX/w/HHmCOcaa7rywBY9XW5vMRwS3JaHH+l
	0oQL5eePSq3xnLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cPUAdIEI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MeRVOgbM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/2WoxFdpcQdUsqbaVip+amN1KRS8T5dllu47RLv5o=;
	b=cPUAdIEIrqM1kE3D/wgLateAtVuXGul9Gi1xOsSPgQ1JLo4wgf89AjtTF1M47E0lBDUy85
	JC3FpvCNHTPtevWbQ5xcW+etHvlEstYZSTrs1nu89l25yTNCm0bgUiF+bp6shIbSGz1G22
	NVNsxAwD7u6hUIYS2ZZgN0arqYyuvfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+/2WoxFdpcQdUsqbaVip+amN1KRS8T5dllu47RLv5o=;
	b=MeRVOgbMJEh/BOCD0ScBfVEUF9K5YqAqkyMRX/w/HHmCOcaa7rywBY9XW5vMRwS3JaHH+l
	0oQL5eePSq3xnLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487CC1352B;
	Mon, 23 Nov 2026 15:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sULWCKVeBGvHJgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 15:41:25 +0000
Message-ID: <f9d90595-d2cc-4c24-99eb-9e924969aa1d@suse.de>
Date: Mon, 23 Nov 2026 16:41:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] nvme-auth: switch to use the kernel keyring
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <5aa50b65-c502-4b87-8f09-23a456e2ca6a@gmail.com>
 <463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92E8E1F390
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_074127_689216_1CCE14AE 
X-CRM114-Status: GOOD (  19.55  )
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

On 11/23/26 4:32 PM, Martin Belanger wrote:
> 
> 
> On 11/23/26 07:59, Martin Belanger wrote:
>> How should nvme-cli determine whether the kernel accepts a key
>> description for DH-HMAC-CHAP?
> [...]
>> 2. Use a separate option for the key description, for example
>>     dhchap_key=%s and dhchap_ctrl_key=%s. nvme-cli would then detect
>>     support through /dev/nvme-fabrics, as it does for the other
>>     options. It also avoids having one string that can mean either a
>>     description or key data.
> 
> Hi Hannes,
> 
> A follow-up with test results. I added DH-HMAC-CHAP support to
> nvme-keysd and tested it with v5 in a VM, with nvmet over TCP and keys
> in both directions. Import, connect by key description, a wrong key,
> and a key replacement all work.
> 
Cool.

> For detection, nvme-keysd now uses add_key(): it fails with ENODEV
> when the 'dhchap' key type does not exist. On an older kernel, the
> connect fails with "Invalid DH-CHAP secret <name>", which is clear
> enough. So nvme-cli does not need a new option for this. A separate
> option would still avoid the ambiguity between a description and key
> data, but that is your decision.
> 
> One finding: add_key() with the exact secret length, without a
> trailing NUL, fails at random with EPERM. nvme_dhchap_psk_preparse()
> treats the payload as a C string and reads past it (the bug Sashiko
> reported), and base64_decode() returns -1. User space passes the
> length without a NUL, keyctl(1) too. Could v6 parse exactly
> prep->datalen bytes? For now nvme-keysd passes the NUL.
> 
Yeah, that should be addressed with v6.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

