Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09A8CCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=; b=gfTttgCwjbV740HP1taCI15B23
	eeXUnoSkBL4yaIWe4/Ak1MDBIZHYHbc5fiOZra3iw0YzAo/cVytYB99y6Eqj+ZQhnoqlKaeHUu+uf
	M7TlkhXjyXa5wdomxgK/l+IHx/wk8CJEKZyV/5ZhILAjx+7GFDfCJVNA7wbl0PTxewOqN+Jl1/qaV
	1odGYVOLVbZ83jXuPBmVCf6CmrSmUiBe0VghbAyeE+87bceJHUNe0UDXXBd3m64EE5pjesRjKBd2S
	56Vh0XLkxe/5W6RxcPP5CZT8RSfA/7BJtt885Vmxt+PlutZ/VHRQd1oP01W7Rur9ef5rBaAU8pZ6f
	ztrjiOwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4R1-000000010ZZ-3FXc;
	Wed, 29 Oct 2025 11:33:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4Qy-000000010Ya-463F
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 11:33:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9123E2081B;
	Wed, 29 Oct 2025 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761737622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=KG9EwIAuvPWxMLGAo5VGomGqoD9HEqR8wOypFpMFvqCRZxKjdpvUHIjL0kkf0EoHJ3kjpw
	FvA6WvCbXafeew2DkFVF93kNna+r6/JuEdcTmQpZquvfIMzgMuQy04UkAFRGBJAU4CUJv9
	nfjTToW3mtNHKwb6HVDtuouR357TYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761737622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=3Ci7Qz2IDhksHG9hIMAmu+b/iKiu9J60wBgeA+wdmy1PWmWBuo/TzOXslmLyOIII4wJ0p9
	djPo36V8xfpKPcCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761737622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=KG9EwIAuvPWxMLGAo5VGomGqoD9HEqR8wOypFpMFvqCRZxKjdpvUHIjL0kkf0EoHJ3kjpw
	FvA6WvCbXafeew2DkFVF93kNna+r6/JuEdcTmQpZquvfIMzgMuQy04UkAFRGBJAU4CUJv9
	nfjTToW3mtNHKwb6HVDtuouR357TYko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761737622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQYL23754EV/nvlI2xYg3V2OO8lUab0H+SIPolSVX/I=;
	b=3Ci7Qz2IDhksHG9hIMAmu+b/iKiu9J60wBgeA+wdmy1PWmWBuo/TzOXslmLyOIII4wJ0p9
	djPo36V8xfpKPcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 287F21396A;
	Wed, 29 Oct 2025 11:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkK/Bpb7AWmQBAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 29 Oct 2025 11:33:42 +0000
Message-ID: <72c291ff-8295-4bef-b368-68c24aa983ec@suse.de>
Date: Wed, 29 Oct 2025 12:33:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Alistair Francis <alistair23@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251029045327.2035337-1-alistair.francis@wdc.com>
 <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
 <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,wdc.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_043345_161779_11204810 
X-CRM114-Status: GOOD (  15.16  )
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

On 10/29/25 12:20, Alistair Francis wrote:
> On Wed, Oct 29, 2025 at 6:10 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 10/29/25 05:53, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
>>> the sc_c variable to the dhchap queue context structure which is
>>> appropriately set during negotiate and then used in the host response.
>>>
>>> This breaks secure concat connections with a Linux target as the target
>>> code wasn't updated at the same time. This patch fixes this by adding a
>>> new sc_c variable to the host hash calculations.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>    drivers/nvme/host/auth.c               | 1 +
>>>    drivers/nvme/target/auth.c             | 3 ++-
>>>    drivers/nvme/target/fabrics-cmd-auth.c | 1 +
>>>    drivers/nvme/target/nvmet.h            | 1 +
>>>    4 files changed, 5 insertions(+), 1 deletion(-)
>>>
>> I've already send a similar patch for this, which actually should
>> already have been merged.
>> Can you check if that works for you?
> 
> I checked master when I sent this and there was nothing applied. Is it
> in a different tree?
> 

https://lore.kernel.org/linux-nvme/aPl4-6WQ940kUso7@kbusch-mbp/T/#t

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

