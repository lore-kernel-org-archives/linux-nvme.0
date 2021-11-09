Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C05B61184
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 15:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C05B61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fr24ghdlwEpZ82n6LkCEJ0aL6GBcbiWiegw0cT/TQ8w=; b=3zFq/ZW5HlwxgD4Og6fyj6zURI
	P+NGuzafwmycVjAxSHo7XxepfSyTjTcnQirZzLe+C/EmS8XrOOCzh9hwgomwdC9djWKbIiOWX+nTY
	8d29X5bwt1ofrYsu+I59FngytjzdXutQ2fFlbMbWePjEo2RgBopgOqGgcyMaCM7KCPrvbVF3LJTRC
	y9LIbcVq3mf9TLqc0/Gad5jf74/AbJhdMXVuMo2GqaUrlz1jnDQZi3+GnR9Qxg6Bqs5ZifnKI4vV0
	qkhKgY/MOTORre23TYfBe7b/axqU3CQHH3pIrB91xQ0//cXkBCt7zLwf83+IGMsJnkwsz242g8kAV
	1KrPpW4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkSfZ-002W6E-AD; Tue, 09 Nov 2021 15:04:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkSfW-002W4w-J1
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 15:04:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA363218EF;
 Tue,  9 Nov 2021 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636470247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fr24ghdlwEpZ82n6LkCEJ0aL6GBcbiWiegw0cT/TQ8w=;
 b=dFHQdlVpdL893Exnno5b9YW5K/jx3oo8yOxTiI4GwuXKT3fxQ2lc1QLxmtdv0YUrgImQsp
 C/F4ddtqWqIBfGO5oCQHwnpmk5dJ1zL7ltUG3o+Pf3D038vEMLww7PLaAuey2xYcuY851Z
 xBzbLChvr4IhbVTpn8183nA0zFpkEfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636470247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fr24ghdlwEpZ82n6LkCEJ0aL6GBcbiWiegw0cT/TQ8w=;
 b=8p89m5xOX6cWcHJuBwThTBEo6EVtzsJVW8eMqhXYhcG7vfsxCSzbGgLCA8za75eJzGsJmY
 m8WYl8IRPozLGiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AC8513A6A;
 Tue,  9 Nov 2021 15:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VeiZDOeNimH7CQAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Tue, 09 Nov 2021 15:04:07 +0000
Date: Tue, 9 Nov 2021 12:04:05 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211109150405.uv2he4quk4dlud6p@cyberdelia>
References: <20211106020858.18625-1-ematsumiya@suse.de>
 <20211109080634.GA28581@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211109080634.GA28581@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_070414_818741_459C4E34 
X-CRM114-Status: GOOD (  13.07  )
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

On 11/09, Christoph Hellwig wrote:
>On Fri, Nov 05, 2021 at 11:08:57PM -0300, Enzo Matsumiya wrote:
>> +	},
>> +	{
>> +		/*
>> +		 * This Kioxia device times out and aborts I/O during any load,
>> +		 * but more easily reproducible with discards (fstrim).
>> +		 *
>> +		 * Device is left in a state that is also not possible to use "nvme set-feature"
>> +		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
>> +		 */
>
>Overly long lines here, but I can fix that up.

Missed that, sorry. Thanks.

>  Do you have a product
>name for this device or is just a nameless OEM controller?

I didn't, had to google. I see it listed on Kioxia's website as
CD6-V Series (6.4T model), but since customer was running on an
DL380 Gen10, I suspect it could also be HPE PE8030 (PN P19837-B21).


Cheers,

Enzo

