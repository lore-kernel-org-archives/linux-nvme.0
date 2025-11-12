Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF146CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PMXZ7if8Xu++WQXwdY351iV2/4IOGjIAUfslX54zK8=; b=BFO8ninEPtvlm2+SE00wDQlgCh
	Czhhun1zX52ZeDEvQE2kOcdZhYZrotFCZNHDXrM+sACTwUFWbMLeO7QI1p3JUjIdHhbrbfb4lUuqg
	nJ7BJilI4nfGS9eNz/ltofS0LccNNaFI29ktd42PuPtEnR9OUTIrXusMDeMiTOSezBkF9/ta7miLz
	59bnQK3Ws4t+z/P6RyXuzjK9MWA/ApVPwb+nv+fHrRQByatUXh2zS1msNOZKbynJ4kh12QMD5XNf2
	krkjA5oyaky4q85eX4kAydrf+Z0i8Hp43wDCoH4pep/1Y+rNBwCKG9NlLwSd4OhWd4nx4JjhhhoNF
	F/0T03YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ5Ap-00000008Gh7-2S87;
	Wed, 12 Nov 2025 07:21:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ5An-00000008Ggc-1T8V
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 07:21:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66B281F388;
	Wed, 12 Nov 2025 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762932103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PMXZ7if8Xu++WQXwdY351iV2/4IOGjIAUfslX54zK8=;
	b=UH08PUS0jXkumjZ16rx1cG/h85bT0jke62DdVyxobuQwqALf+OPbdT1kjD2csc19UT8jC+
	dQKbWQbWhQs2MPbt6cGtdITuPIyZ+z+ii36w0VyDmTjBQtx4CNeUlFMDnnp1rITzhrZH7N
	oJfzsc2hw0zCJgRop7aUOw5uBSc0UX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762932103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PMXZ7if8Xu++WQXwdY351iV2/4IOGjIAUfslX54zK8=;
	b=jPlQ+q9taDOOHJvqfNn5c/VRb+mFUZWziulUpmuicBVmpWdw+lF+ddwTP6A3cJUVBP+/30
	zhkhRS3pqng58mCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RdAhi6/S";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3dHZD8+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762932102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PMXZ7if8Xu++WQXwdY351iV2/4IOGjIAUfslX54zK8=;
	b=RdAhi6/SKgycoIdTxDw7HU3ndJjwv8fwtXqbCrWOXG5tfHg/BbvdFvw1B+ZKFe5gNLYnsH
	FgkHFRyfBE+6e4TkAnp+/UgY9MP/vrDTunSEAlA24Uq3G7Ngw4X1sdU7awFHys/6WaPLhA
	A2nOLQFku2NgA4NvNndErm8VdXokS9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762932102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PMXZ7if8Xu++WQXwdY351iV2/4IOGjIAUfslX54zK8=;
	b=3dHZD8+/GOuMUiDkB1kWwrZh4I1vhIdvfIVXSd4lQRhoJxlpy/mof0x3i/c/Q61fKMTimh
	WM0LF4oSnKtmzJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F0FA14DD1;
	Wed, 12 Nov 2025 07:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e7ALAoY1FGmDAwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:21:42 +0000
Message-ID: <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
Date: Wed, 12 Nov 2025 08:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Christoph Hellwig <hch@lst.de>, Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com>
 <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
 <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
 <20251112070256.GA5276@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251112070256.GA5276@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66B281F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[lst.de,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_232145_535458_D5E8702D 
X-CRM114-Status: GOOD (  13.93  )
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

On 11/12/25 08:02, Christoph Hellwig wrote:
> On Wed, Nov 12, 2025 at 09:32:00AM +1000, Alistair Francis wrote:
>>> I would suggest just allow writes to the 'tls_key' attribute; any
>>> writes to that would trigger a replacepsk operation.
>>
>> I think the `tls_configured_key` is actually the better attribute to
>> write to as that is the one that updates after a REPLACETLSPSK
>> operation, see v2 patches which I'm sending now.
> 
> Just saw Hannes reply here and saw why you did the current version
> the way I did.  Hannes, please don't recommend weird ABIs that
> make error checking and future extensibility impossible.
> 
Hmm.

'tls_configured_key' prints out the value of
ctrl->opts->tls_key, ie the key passed in from the 'connect'
string. Normally this value will be empty,
as the 'connect' command will pick up the TLS key from
the keyring automatically.

'tls_key' prints out the value of
ctrl->tls_pskid, ie the value of the _negotiated_ key.

So why is 'tls_configured_key' key the better option?
Personally I think that 'tls_key' is more 'natural',
as we want to replace the negotiated key, not the
configured key ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

