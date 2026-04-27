Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECEAFF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enecEF/kxiIim2Tkby9fngRmnDMvi3KSBpX7DDuh9D0=; b=tAonjafXoIURRhLQgIiG8QZNx1
	vhpdbnQM/wW2t6qaZGDflv5Kc8bWozqM8k1A8v7O/b047N9SEjT6mSG909FXiMlwvnJ0jBKUG/vBc
	14yLAW9toSya0Vs7G3crCsAMmaJ8b/U41Wx00euSd2cqPTEjw4jte1A5QxKrxmy7y5tJxqw7zX7zI
	+XVVmnZWQWCfy/Bfe4T4/MtJmKNxwMHnrAQZ+LCNsBmmjcbBIRVSx5kYMMReCxwrSej67AeaaRg8C
	Q98B31HIdNl0LHgmPQb/mFjql2GAt5yHH+9K32BB0izKSZQSyfHaOR+xA/8fFvzhWwSiGM10HaYC/
	PAGg2bDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHK4O-0000000GnD5-3d0p;
	Mon, 27 Apr 2026 11:24:08 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHK4M-0000000GnCh-2xSX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 11:24:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24BB75BCC9;
	Mon, 27 Apr 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777289043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enecEF/kxiIim2Tkby9fngRmnDMvi3KSBpX7DDuh9D0=;
	b=jQ5sQo3RZ64sLKeSPbRdtJEvR66L+VnVOd0tpQghoqFpe1ldmx4GqHjKx1pUloNM0fE9Hs
	R6s8/gAwaMRATqbNxJ0E53qpVN89Ay+9C/8OCnNnmcLwHwOu6JtB5s+bFxqfR38kI7k2Ic
	lclYnf24ryIGD5ocENz4M8wlSWAowOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777289043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enecEF/kxiIim2Tkby9fngRmnDMvi3KSBpX7DDuh9D0=;
	b=NDyeSNljzsIM62HnpVoxbDlp0YBcrKK1WiDpFwZIkWoq7Qlyzr7flKBxTFA7gnoF1YAY/g
	yqsmmIGo9TshAbDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jQ5sQo3R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NDyeSNlj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777289043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enecEF/kxiIim2Tkby9fngRmnDMvi3KSBpX7DDuh9D0=;
	b=jQ5sQo3RZ64sLKeSPbRdtJEvR66L+VnVOd0tpQghoqFpe1ldmx4GqHjKx1pUloNM0fE9Hs
	R6s8/gAwaMRATqbNxJ0E53qpVN89Ay+9C/8OCnNnmcLwHwOu6JtB5s+bFxqfR38kI7k2Ic
	lclYnf24ryIGD5ocENz4M8wlSWAowOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777289043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enecEF/kxiIim2Tkby9fngRmnDMvi3KSBpX7DDuh9D0=;
	b=NDyeSNljzsIM62HnpVoxbDlp0YBcrKK1WiDpFwZIkWoq7Qlyzr7flKBxTFA7gnoF1YAY/g
	yqsmmIGo9TshAbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBB5D593B0;
	Mon, 27 Apr 2026 11:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHDyOFJH72lfVgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Apr 2026 11:24:02 +0000
Message-ID: <1bd69c23-cfe5-41e4-bdd7-768cf74d923f@suse.de>
Date: Mon, 27 Apr 2026 13:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
To: Alistair Francis <alistair23@gmail.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
 <20260416051627.GC14802@lst.de>
 <CAKmqyKON1MoOU-MQNK8EEVwVWmSJZ9OmxH2M_mmYTadmcbVyTw@mail.gmail.com>
 <9bb1d1bd-2acc-453d-970e-762e173d230f@grimberg.me>
 <CAKmqyKMk5CeXBDCfrXasZs4h9QcgBX9iTrJWXJOC5C5eFz6vBw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKMk5CeXBDCfrXasZs4h9QcgBX9iTrJWXJOC5C5eFz6vBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,grimberg.me];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 24BB75BCC9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_042406_890908_BB0F2786 
X-CRM114-Status: GOOD (  17.77  )
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

On 4/27/26 01:22, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 8:58 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>
>> On 16/04/2026 8:25, Alistair Francis wrote:
>>> On Thu, Apr 16, 2026 at 3:16 PM Christoph Hellwig <hch@lst.de> wrote:
>>>> On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
>>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>>
>>>>> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
>>>>> included in the Response Value (RVAL) hash and SC_C should be included.
>>>>> Currently we are hardcoding 0 instead of using the correct SC_C value.
>>>>>
>>>>> Update the host and target code to use the SC_C when calculating the
>>>>> RVAL instead of using 0.
>>>> This looks correct.  But I guess this breaks existing implementations
>>>> in the wild now?
>>> It would break an implementation that is using non zero sc_c and
>>> updates one of the Linux target or Linux host but not the other.
>>>
>>> Note that similar changes have been made recently to "HostHost" and
>>> didn't seem to break everything
>>>
>>> 7e091add9c43 nvme-auth: update sc_c in host response
>>> 159de7a825ae nvmet-auth: update sc_c in target host hash calculation
>>
>> Still doesn't mean that it does not break folks.
> 
> The current implementation breaks all cases of secure concat with a
> spec compliant implementation though, which does seem worse.
> 
>>
>> I don't see how we get around not breaking other than introducing some
>> compat mode under some sysctl (yukk).
> 
> Ewww...
> 
>>
>> Perhaps secure-concatenation is new enough that the breakage surface
>> is very small.
> 
> I suspect the user base right now is small to zero, especially
> considering that this won't work with any spec compliant
> implementation and no one else has noticed.
> 
Precisely. Secure concatenation is still pretty new, and there are
very few implementations out there.
So I'm fine with not having a 'compat' setting.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

