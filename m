Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EE2C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yhh3CCxOXfWI4Q/r+EUVNX5w0ScDQdxllv4Z8QyNJg4=; b=lOScBxhCpRq2eU5uvKM4hy3lqV
	rl0yGfOoWXAD1CcafAFVofA9EB0jVaOE642IZALHra5SjWF26qaIAuoItTyzzVrZk1KTYAN7ukILM
	2kbznAdA4gAP3ENueNFwglPb5OCg56kW++9A15LJ/QHxf54WEYiPIlviWvHGi29f8rahmhqGvb/QT
	UUY4yHAIfwsn9po0/Tsm4J5cCQbHht8bXSwT4PAqOeK3pQLr1gHGoPXqlHD+w6jzTZ5DDSP4bjmwz
	VjkNWAGv9NMkYI5fzLQlFAElEJ+xYdRBZcRecLUoWPg/Ec8eLiv6FTKg/nXGhLl4Y97e7wng+6XZD
	FJT4R6gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcpg-007umM-MS; Fri, 10 Jun 2022 11:29:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcpd-007ul7-Dq
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:29:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D927D1F948;
	Fri, 10 Jun 2022 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhh3CCxOXfWI4Q/r+EUVNX5w0ScDQdxllv4Z8QyNJg4=;
	b=vkRjyE0UVCmekn1HmCqzzcwQrPAsmM6ORZVifA5YGrkz49citS9bm5idzxRI4cfYgmfuVr
	EP9FN6uYWirMOmO4/U5fR5jU3QsbmmFh48XkzNSnAL510BimHw7Utgae8OlhXXfP7EhNTl
	1MSv8VlWHsevQxpXKNCrdVHqyRfOATE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhh3CCxOXfWI4Q/r+EUVNX5w0ScDQdxllv4Z8QyNJg4=;
	b=0w1ppp5kWBRMj83Kz8juyPbKzIX22V5ntZ95IhDlyyvDzP+9k8fXH1roF9zGtIEGDO6JyH
	fSxEnyEJpjoAvEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBDD5139ED;
	Fri, 10 Jun 2022 11:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id saFmMRwro2LOFgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 10 Jun 2022 11:29:32 +0000
Message-ID: <d1e30f4f-7c6c-4728-8d13-b23b3b7ae740@suse.de>
Date: Fri, 10 Jun 2022 13:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
 <af8d390c-abd7-d4da-6bd9-99354b2ab2c0@suse.de>
 <c0da59d2-52ab-e219-8610-5f253cde7076@nvidia.com>
 <623745a5-78cd-7280-97ca-f91c4f4b6720@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <623745a5-78cd-7280-97ca-f91c4f4b6720@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_042937_672049_4BFB9A5F 
X-CRM114-Status: GOOD (  11.57  )
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

On 6/10/22 11:35, Chaitanya Kulkarni wrote:
[ ..  ]
> 
> 
> Let me know if you need any more information, I'll also try and debug
> the problem tomorrow.
> 
I've now created a new pull request for blktests (#94), that one should 
be good for the recent changes to nvme-cli.

Can you test with that or do I need to send a patchset to the linux-nvme 
mailing list?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

