Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF55510775E6
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyNSpfJycQvmc9Dwcox0eBbj7nc/2eYewd/VeIr02Hk=; b=2SzdZbm1DXjH5vOI4G0PSkYfDW
	j4itdMG4O1gUXRwzl0bNNLpltI7aa8tr8copioKimeBfvOvD9PY4Yg1k0s1jRPTJvkc9m9Ufy0NgB
	FFx8hJ7M+plMtmRQOkpUm8nAWgm9marRXoI5sjliHi7MyvWYxnGXklTwuu3xWVDhBzicTAg0Jb600
	jQcLgfccPdLxa1bIjyWeH35oFk/902032ieC+lJvJa+QWTcRHxP4C77wquP/ioS/2o+tK0Bav3D+Q
	eDvfx++gLYBrsUPp95PfRqwDAAgQaeQb1AbzKtZWuDt8GJfTyQeFLVe439BypczLTDFRfEZDAYacs
	/ACo8vYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2u43-00000008zzo-3jAv;
	Wed, 18 Mar 2026 16:48:11 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2u40-00000008zys-3Isx
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 16:48:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C3975BECE;
	Wed, 18 Mar 2026 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyNSpfJycQvmc9Dwcox0eBbj7nc/2eYewd/VeIr02Hk=;
	b=EGElgVeo3SMJOArkPU9ljZoTP+jzK0+L6WLv7VcCHWi51Jc/XxDSpOfj2AhGpdPjwjOXG7
	u2edWMR0CqMeYQjip016q3ZJLq3cxo+0Wa6T8UYMgCOWeZe5HfaY1AN/DQAl7c0Ah2/din
	7us04mIqmZyqyCXRZVU2lpibVX7UHsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773852486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyNSpfJycQvmc9Dwcox0eBbj7nc/2eYewd/VeIr02Hk=;
	b=XIEoLe/ieasKOL9jBUt8Jj/u3Q/5O3wdpCTe/N4HoHEej/EfngSSw3Mnf3BFi/xV4W62WB
	gH6q2b24nHK5BHCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyNSpfJycQvmc9Dwcox0eBbj7nc/2eYewd/VeIr02Hk=;
	b=EGElgVeo3SMJOArkPU9ljZoTP+jzK0+L6WLv7VcCHWi51Jc/XxDSpOfj2AhGpdPjwjOXG7
	u2edWMR0CqMeYQjip016q3ZJLq3cxo+0Wa6T8UYMgCOWeZe5HfaY1AN/DQAl7c0Ah2/din
	7us04mIqmZyqyCXRZVU2lpibVX7UHsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773852486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyNSpfJycQvmc9Dwcox0eBbj7nc/2eYewd/VeIr02Hk=;
	b=XIEoLe/ieasKOL9jBUt8Jj/u3Q/5O3wdpCTe/N4HoHEej/EfngSSw3Mnf3BFi/xV4W62WB
	gH6q2b24nHK5BHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 179464273B;
	Wed, 18 Mar 2026 16:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RZYmBEbXummddgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Mar 2026 16:48:06 +0000
Message-ID: <45828832-b084-4e2d-bfb1-751c4d18321e@suse.de>
Date: Wed, 18 Mar 2026 17:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: Include SC_C in RVAL controller hash
To: Chris Leech <cleech@redhat.com>, alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20260317031330.2794078-1-alistair.francis@wdc.com>
 <20260318-straw-snazzy-a8976b9c9427@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260318-straw-snazzy-a8976b9c9427@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_094809_291952_EB09C524 
X-CRM114-Status: GOOD (  11.43  )
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

On 3/18/26 17:40, Chris Leech wrote:
> On Tue, Mar 17, 2026 at 01:13:30PM +1000, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
>> included in the Response Value (RVAL) hash and SC_C should be included.
>> Currently we are hardcoding 0 instead of using the correct SC_C value.
>>
>> Update the host and target code to use the SC_C when calculating the
>> RVAL instead of using 0.
> 
> Am I correct in reading this, the current kernel implementation is out
> of spec when doing secure channel concatenation (SC_C != 0) with
> bidirectional authentication (R1 takes SC_C into account, but not R2)?
> 
I certainly never tested secure concatenation with bi-directional 
authentication (seem to have fallen into the same trap as Martin
George). So the chance of regression is rather small.
When you fix it, pleas add a test-case for blktests, too, such
that we extend test coverage for this particular corner-case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

