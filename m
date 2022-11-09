Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97FEC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWs+Jsrss1XaffxxM9m6t13XXAZCZHXNJubmfdoP3gM=; b=PpXoXYdUl3cK3CmI/QR3jTC5KX
	j10H9KAaZAVUflgIFV8VYSNJucqD5M0bgzjuqvFmUHrZ5NC2P7HOKRI0Q2wklHFeH97BRrygUAzhI
	Ic+TPU15pXUa6Oh5ZOXro1M0KTavJ0fmK4kclRunDRdOGiUm4xQlPiK21k5g6Z0aAGM7A7imlL4ja
	qWUzi+EOAe1TrnZ6JkKQ1YvSUaScDwFabeJ6b7GSGNlZrqXs+pBYuFjmwPYOoHAoyPFz47Y3M4OHA
	GceD0tZCfU8piOl2A9a1r7H/CiiAtiGX7i7F+oLzglts+J4ovSoQp2PW453aZrwPrCkbvJlNfxAxx
	WDHuEH4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osozj-00FbtX-T3; Wed, 09 Nov 2022 17:36:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osozV-00FbjD-2R
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 17:35:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C95A1FD80;
	Wed,  9 Nov 2022 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668015351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWs+Jsrss1XaffxxM9m6t13XXAZCZHXNJubmfdoP3gM=;
	b=Jfhxc0MDkQwECu0Grud+7dpUejCY2SwLP/TL302yOd6m4jUassmhOq28/46xyQ/JMfNj/6
	x93xCFgDz7W5nhRy87287zwnklCc9L12fV115782vUrg17puVEd7q50ZKFd6ZIjxDa6riZ
	+tWw63bgYQaffR4G33ZydL+rju4krFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668015351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWs+Jsrss1XaffxxM9m6t13XXAZCZHXNJubmfdoP3gM=;
	b=luicP9T3uSlWX27Xk+Db77A/C+Whtv1z7lHoCWhNapG5/xMMUiw06dvZCSzEUuIT6YO8f+
	tnlE0+bUaHqQ7PAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30EFA139F1;
	Wed,  9 Nov 2022 17:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id t6SnCvfka2PzFgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 17:35:51 +0000
Message-ID: <b7657919-56fa-c599-818c-6c7b9b89ea33@suse.de>
Date: Wed, 9 Nov 2022 18:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/16] nvme-auth: rename __nvme_auth_[reset|free] to
 nvme_auth[reset|free]_dhchap
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-2-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_093557_322616_1E5E22EA 
X-CRM114-Status: GOOD (  12.57  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> nvme_auth_[reset|free] operate on the controller while
> __nvme_auth_[reset|free] operate on a chap struct (which maps to a queue
> context). Rename it for clarity.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


