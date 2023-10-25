Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B4C25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xs0D9IRkGtYqBM2vSmOb0zkxIa8R2X+c6xyv22p3ibA=; b=lenWlstr8iet44K1o5w80XnpZe
	lwyiOLXwB44PD950rHedbchNcnsjkQy1V4luFYITyH4jx00Aj/7s5LWgtgeubGZHJUhyMTLOMz6lV
	+lITG/IeoeWxsIJLHpO+0miBP1r47zM7OaEroBMM8O3FLhnUNoBcG6URvySh0dJ4ECq/Frz/8rpfV
	ZjJ747aO3Z8xyc8zIPLvYJhufV7/JPPaUR2jo6RmjMKKjjdg0b7W2XCgs2+ungDKZvuv/TnysTS55
	hNNRqR3PJ55aPyc1HwTZhhaU3KokW8f8tmTCYfVNKlzZDdSUwHdWTTKeRs9Gn+GGbSjMdw6ode3bN
	Py3GEgEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXNK-00BU7j-1o;
	Wed, 25 Oct 2023 06:28:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvXNH-00BU4X-14
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 06:28:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12BBD21D49
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698215267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs0D9IRkGtYqBM2vSmOb0zkxIa8R2X+c6xyv22p3ibA=;
	b=wsYrDWthNREojCLkM+BFYoglJwI5AbVEPMaFg7NEwj1sx7uSj9pOfe2ye+CyHuBQ361GCl
	EB/AMBP/qKj8Mtwbh61qYYIJj0rS5vlP0fSWazcDXzdIST8fUJZkAN70iWwmj2ZYO8O401
	H4wwCfsx+LxbHJU6GQP1MXsb/CbD5ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698215267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs0D9IRkGtYqBM2vSmOb0zkxIa8R2X+c6xyv22p3ibA=;
	b=x7mSshfUibixfrvExJzUsODYiPRIPefXEyBTCOFgw2+6bHun2N6XC9tc13wGPBGTp3Z5Hd
	Wmyb7AWp+cR8ZRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 001E413524
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 06:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id m/bjOGK1OGXBQwAAMHmgww
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 06:27:46 +0000
Message-ID: <c71e8138-4374-4cda-9eac-6bde8fc271a0@suse.de>
Date: Wed, 25 Oct 2023 08:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme-auth: add flag for bi-directional auth
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20231023140003.58019-1-shiftee@posteo.net>
 <20231023140003.58019-3-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231023140003.58019-3-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.05 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.96)[99.81%];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_232815_539075_49822A43 
X-CRM114-Status: GOOD (  11.21  )
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

On 10/23/23 16:00, Mark O'Donovan wrote:
> Introduces an explicit variable for bi-directional auth.
> The currently used variable chap->s2 is incorrectly zeroed for
> uni-directional auth. That will be fixed in the next patch so this
> needs to change to avoid sending unexpected success2 messages
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/host/auth.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
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


