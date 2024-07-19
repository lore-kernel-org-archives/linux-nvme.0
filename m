Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BA3C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 06:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/tErD7yMbU2FNugZEFqGM6UTE4E0loywnrZGJKpTPDg=; b=dK1DT5fnfnM0EDfqh1z1AFCNgb
	pjMi3yw/xRnGVh9GMo8SLXfcQjKyRB/84b5dzEvhG11Oed7jw+DNUkKu4xLRogY7nyf8zkUtunnU5
	e3D7lGq6zw4/2tDIUKAFucVeuSh9fr7iHOfqWEeUv5TEXqB1OuCqTiJxybrpWOMj1CQ3OCp+Wfuow
	Dg5nQodDBGednZME5+uRu0+544fw/YwJt8WSyhQ/xO3+vZvGHUcT+qwtO9AYOcCGKpg52BOgZl2z3
	h7go+ej28XBOasK3P7H8jHO7BbrycS+a8MjVgA8SfnjlDofJgyrCva5UXEtQOOA/eLj7678Q2HE8o
	y6tP4OmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgri-00000001mTd-1mYW;
	Fri, 19 Jul 2024 06:13:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgrd-00000001mSK-1dc7
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 06:13:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19B5D1F393;
	Fri, 19 Jul 2024 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721369586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tErD7yMbU2FNugZEFqGM6UTE4E0loywnrZGJKpTPDg=;
	b=hOzYxoQSVyD6dsSF3uEdj6+yqaPWNZtky8MN6gC2BJr0jcyfNq+D072cvLPMR6jvITXLco
	Y/dQXt7VQopXcIYqfB5/NAINjm/uOizNUQvyNJu8QJkAaoVFMvhRz9WYxuBhLgRMj6PQRD
	YQKIMFZmgv8uJPT2vJbXDblVHVq1wdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721369586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tErD7yMbU2FNugZEFqGM6UTE4E0loywnrZGJKpTPDg=;
	b=CLTbJXp9vemS+UJJJXlx23D3QPZdzSwPqlpZjiM7CIL+lxFvt0gmDJc0ffSmR6D7GoXepM
	DUnGV3PkGVj7FGAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721369585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tErD7yMbU2FNugZEFqGM6UTE4E0loywnrZGJKpTPDg=;
	b=FXGhCmzDxyWlbAH1VwqaVV5noYA4yUImgQB1mxHJQaGLssOzwFEkwNIPTAPajSkdijNo9B
	7gJH5jzN9PoROfXAFNkyZ8N8OiFSN9txncRU201XeMxbEk2yIwy6/kJKfTZqyI0CFlnK0+
	EQyVqZXEXmQAh9bB+tD02FXnP+Ks/xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721369585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tErD7yMbU2FNugZEFqGM6UTE4E0loywnrZGJKpTPDg=;
	b=89sXlmEg6bjLH/++B9RfI9B/JZaIKu0pV01VxFhifSJcpXPt29xt/oNs5Rwz966F/+NrhG
	JcZJAFIKcUE6F4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1F48132CB;
	Fri, 19 Jul 2024 06:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vqg1LfADmmZYDwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 06:13:04 +0000
Message-ID: <d18616af-a32e-4867-9741-2007a3d149a0@suse.de>
Date: Fri, 19 Jul 2024 08:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20240718150658.99580-1-hare@kernel.org>
 <20240718150658.99580-2-hare@kernel.org>
 <20240718231424.GA2582818@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240718231424.GA2582818@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_231309_603730_6FB7F1B4 
X-CRM114-Status: GOOD (  14.09  )
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

On 7/19/24 01:14, Eric Biggers wrote:
> On Thu, Jul 18, 2024 at 05:06:51PM +0200, Hannes Reinecke wrote:
>> Separate out the HKDF functions into a separate file to make them
>> available to other callers.
>>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: linux-crypto@vger.kernel.org
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   crypto/Makefile       |   1 +
>>   crypto/hkdf.c         | 112 ++++++++++++++++++++++++++++++++++++++++++
>>   fs/crypto/hkdf.c      |  68 ++++---------------------
>>   include/crypto/hkdf.h |  18 +++++++
>>   4 files changed, 140 insertions(+), 59 deletions(-)
>>   create mode 100644 crypto/hkdf.c
>>   create mode 100644 include/crypto/hkdf.h
> 
> I was only sent patch 1, so this is unreviewable as there is no context.
> 
Sorry. Will include you with the full patchset for the next round.
The remainder of the patch series is just calling into the just exported
functions to derive TLS PSK keys, wasn't sure if you'd be interested in
that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


