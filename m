Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C077ACDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 06:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PHVftjgUsbSoduhlYKO3xpylXbMeB/YigrfNtTGt5qg=; b=l4MYCrL97Pwit1uaZ5VgnxutHd
	NZcuwer0ZVvBLrvPt9A40TxDZymwz/94EkIO0vhGTdFG7QY0jkEfbOEWvbXIv9qQj0NWGkUCSMqYM
	jtHBSgJUBTsWP72fkwWm20e1+OxJyN6tgGIa4d4fwNlCobEmZzf+Ty+iFUWj33ux4dLJcVYXgTFuF
	HsGVC9aWcsjFplnySiT9SkU6sn+Le1kDKySSSzhEAf5T0ayqj1EMkEDOJngUP82BsfHzsCh+rwSAA
	VRCznoQ/VbVgi9NOAr6gG6y1V3tEzfpvQA/4cEIMQ0rmCX5JLMa6csJA0IZg23XeFH6QvP4MTBAfw
	XlMwsyvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdDk-00BLva-2V;
	Tue, 17 Oct 2023 06:06:24 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsdDh-00BLsT-2V
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 06:06:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4443B1FEFC;
	Tue, 17 Oct 2023 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697522768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHVftjgUsbSoduhlYKO3xpylXbMeB/YigrfNtTGt5qg=;
	b=AyCWdeJCTiQBNMSg+ffSDEipfK5nXBeJc01Z6pl7PTS4Jw23isCj3DqdcO1v4CTsyTN8c0
	w6k39xAltnM22NsziHoOZoLFb7gpNy1E9uaWPVNhibkjXvRbRK+71i0Y+O1yra+P70RYmn
	90J1aBP1ZEdY7hy4RloMV5262uYZrKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697522768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHVftjgUsbSoduhlYKO3xpylXbMeB/YigrfNtTGt5qg=;
	b=5PuC+BLsjSmWB2I7L/lbYvGZo91nwBqtkqwWnn09vXclS9AZWJ67SU8ZvrzqkOwYVfOQ9i
	IdXKVZTnAA3tUcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E341E13597;
	Tue, 17 Oct 2023 06:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2MwLNk8kLmWIAQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 17 Oct 2023 06:06:07 +0000
Message-ID: <41582b35-07a0-40ef-8b52-6148b6cf015b@suse.de>
Date: Tue, 17 Oct 2023 08:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme-auth: use transformed key size to create resp
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org, Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231016225857.3085234-1-shiftee@posteo.net>
 <20231016225857.3085234-3-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231016225857.3085234-3-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-9.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.22)[89.32%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_230621_967634_0B3EB692 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

On 10/17/23 00:58, Mark O'Donovan wrote:
> This does not change current behaviour as the driver currently
> verifies that the secret size is the same size as the length of
> the transformation hash.
> 
> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
> V1 -> V2: support target implementation and controller secrets also
> V2 -> V3: return key from nvme_auth_transform_key
> 
Exactly what I had in mind. Thanks for doing this.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


