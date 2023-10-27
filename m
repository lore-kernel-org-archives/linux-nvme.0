Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B9C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lc2dr6syY3dkplAgU0AZebIj/NLmsdY97GFqgD7N5C4=; b=f3HFyWs9Bur2pi26z8wnywjNVy
	YWpi/0wjvV+wOrrKrUb+9iz89bVBS0r7dyZfkDhjAL6z3txV9pv73Ud+REFeg8PyzE4nKpbtBVWMG
	mHLwsRVKueOhScHDMflSn/nqAAnjvkoxnYsSA0Q9ZWjmvOKZqIDuN9pj8/OkjoBKd6QRSarzf2YmT
	FhmNMmDBdh6PJN/hQ5Kr0gDjiR3BpzWUEblkfE8eGSU58Ot/23cUMa6GDVZdWefA4ngKWbfYjEASE
	ZmQ42L02gl8lyobexSAk/w3zRRggOKMjO5LfwbykNpEL7Q7IBGHNi0uzfrrj/g9miPQ88HmnOXg4p
	5AGjwBYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIcI-00FyPj-05;
	Fri, 27 Oct 2023 08:54:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIcD-00FyOt-21
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 08:54:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CFB521AD8;
	Fri, 27 Oct 2023 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698396883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc2dr6syY3dkplAgU0AZebIj/NLmsdY97GFqgD7N5C4=;
	b=xmhI/3GCPB/NQ2RELb7ESz52fXj9KxZl1fLFVIiJXeIb3Cr2C1ETG9mSFs16UXFZkwjdIL
	I1o0fE5Gnbm/LuSLMUl8YR0pPax/xLHCdg1AzL1vo5CYuxtRiBPvA0nGL/Tl7FVdU7mvGb
	zMJpKpiKovfC08ZLZiaCRSD5zTPqPvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698396883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc2dr6syY3dkplAgU0AZebIj/NLmsdY97GFqgD7N5C4=;
	b=d5ij1SD9+yL6bbaz/P+QrPOObtnBATDoHiHfq1RitzbN1n5f/BUKpOcMPJQmbEJJHOi+dg
	o/z0ufH1jMsMuxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03DB81358C;
	Fri, 27 Oct 2023 08:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LLKQANN6O2XvSAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 27 Oct 2023 08:54:43 +0000
Message-ID: <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
Date: Fri, 27 Oct 2023 10:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
 <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de>
 <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
 <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
 <20231027083003.GA17042@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027083003.GA17042@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.13%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_015449_811958_2CD2AA1D 
X-CRM114-Status: GOOD (  15.69  )
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

On 10/27/23 10:30, Christoph Hellwig wrote:
> On Fri, Oct 27, 2023 at 10:12:11AM +0200, Arnd Bergmann wrote:
>>> In principle. Unfortunately I have to initialize the keyring, and that
>>> can be done only once.
>>> I see if I can come up with a different solution.
>>
>> If the keyring has to be initialized first, I think the safest
>> way is to move it to a different initcall level, to avoid
>> relying on link order for the everything-built-in case.
> 
> I don't really mind the link order, for these cases I usually add a
> comment to the Makefile so that people don't accidentally change it.

Point is not that it has to be initialized first, point is it has to be 
initialized only _once_.
So when moving it into a separate module we cannot use the Makefile 
trick from Christoph, and when initialized it in nvme-core we have a
dependency on nvme-core from nvmet.
Which would be the easiest way (ie have nvmet dependent on nvme-core),
but no sure if that's the way we want to go.

Cheers,

Hannes


