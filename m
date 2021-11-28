Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CBC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBTCVMrz/MVP+EygJ7NpTbT87zyswfrEshSA9IFGGMo=; b=Q/sVEJN91hLP2IZosbV4d4Wev8
	fwbvz4k8dNHVL/Z1YIZBl6T44QNn/8EgYxemJaFCorx6dQe6UWjP1wG9TjcjKVz4sR00UuomO/K/R
	PVeexh60Z2ck4QOez02E+6LVWHk76r6EtB5pChW7Txp3LZht9ARbUxKMSHUmA5snLRWxlWdUX5tPm
	mcWzZ3H+S+dKBxBQwuJ+Q/rGOZGwRPZ0EX1tBB5edJBTkWpNEqN829Rpod/CUnIfU09l5uMain3jT
	mLzd6CpT2tLsxswt4hFl8wGBl4HDbYX4NcKYXJSb//ciY3bFz3QHMVoR9SzWaXSJjtaWk+OE1EGzc
	dGsdZEzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrJOS-00FfBq-I7; Sun, 28 Nov 2021 12:34:56 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrJOQ-00FfBI-9r
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 12:34:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DCB921709;
 Sun, 28 Nov 2021 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638102890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBTCVMrz/MVP+EygJ7NpTbT87zyswfrEshSA9IFGGMo=;
 b=dhulpvpCCBGIDfHvvrFrtgp31NSWkx8EXGsUvrKo6b3BrHJ5JtTfHCSdO4ZPWGmZyiODP+
 mVN5BIl2s7ZExfEeUMaUSDIpCA5+8B2JQPnU1EH9jckTl/3PH1s/fnONx1fAQ6UC1U0C4l
 pr9rasDOhZmUhQfRUi7mtwonG+f+/ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638102890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBTCVMrz/MVP+EygJ7NpTbT87zyswfrEshSA9IFGGMo=;
 b=2K4wDn/2sY/bGwW+SOkIEV95B+9vU7/ZGZFzqHFLB1SdEnuV7aJmQlw5YOwzAxb8tWR/gv
 sBvd5eL1eSZTFKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24D17133D1;
 Sun, 28 Nov 2021 12:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Of3dBmp3o2H3ZwAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 12:34:50 +0000
Subject: Re: nvme connect-all endless loop?
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <81576b69-07c0-a8ff-f818-6e8d2fbe691c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2db5f96c-f4b1-0586-a183-bef07972a69a@suse.de>
Date: Sun, 28 Nov 2021 13:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <81576b69-07c0-a8ff-f818-6e8d2fbe691c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_043454_530177_203EC9BE 
X-CRM114-Status: UNSURE (   9.35  )
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

On 11/28/21 1:02 PM, Sagi Grimberg wrote:
> Hannes,
> 
> Seems that now that nvmet discovery service returns itself nvme
> connect-all loops forever?
> 
> This was fixed before, and must have been broken with the
> switch to libnvme...
Hmm. Haven't seen that.

Will be checking (on Monday, mind :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

