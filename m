Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBA4C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5IvKJJ2VdKgNwLXZPoLNp/zUa9uRqEl+rZ2ziAokkq0=; b=qki5PP1jQe9hYkozGBORe3M5Bf
	Za/IPsnudrchpmKrrIYFROEs6Ko+ZFCGdQeMuZ4Hcwn4j9NvsVUK0Kr660YIPJ1Gn8OqJu7+2ZNXC
	napJGWaQDqmE+izDFZFg8EIeRYz3q3CknY/8tnwm0nnf0R5u9ceRydmKBtB2Q5sEFeVeLAyNt9yuM
	oFn/VMqp4FecCNP9IR7GA8EQM2TKhvwnaowR3ao+pW5dl3wHWlaTocjSEalsdGVy6oBwQ/JIP/wwX
	d8AmTlLt7ofbMgfCwyqi1ZB1omh5xoUk/Kjc3vrkpp0YLC8dOm7lOZtmDEsbKyWh3lWeTA0RnPCbA
	gEdUk42A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM75W-007Y0a-2V;
	Wed, 19 Jul 2023 13:19:30 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM75U-007XyT-1C
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 13:19:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1835121A31;
	Wed, 19 Jul 2023 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689772764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IvKJJ2VdKgNwLXZPoLNp/zUa9uRqEl+rZ2ziAokkq0=;
	b=qwveKplDIKLcEmlaY4YAON3ALGv55CZsC7g0FTiMYikMalaZ3gQlXnCg2Pl4Oz7fr42Kp/
	lLCzhSjhhzhuEXIZy6CJToikKvan+fU92D5RPijrO1V0jeTRsv6+ZCwY23+SEWoGCgZsHb
	u8Yb99YfXvXdPjADhW/c7Bi/o1E0J6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689772764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IvKJJ2VdKgNwLXZPoLNp/zUa9uRqEl+rZ2ziAokkq0=;
	b=EiKZBjNEp8kLzRCS/z14aYMNieFJ85J3MxjJRN13vWl28Z3rgcaMUbcYX1DpzjkflQHBzD
	iapKOCk18xkj09Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DC051361C;
	Wed, 19 Jul 2023 13:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xtP/Atzit2TMIgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 13:19:24 +0000
Message-ID: <f2e6bdf2-d7fa-79a8-7bc0-87af0e1e4452@suse.de>
Date: Wed, 19 Jul 2023 15:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
 <ZLfLT5Oirckc+o7W@kbusch-mbp.dhcp.thefacebook.com>
 <fjx7ojmvl7campt6ccexvt7rhpfopw3spkopdfigmkjlkjinb3@vfj2gzjic55v>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <fjx7ojmvl7campt6ccexvt7rhpfopw3spkopdfigmkjlkjinb3@vfj2gzjic55v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_061928_569651_5E45E8EF 
X-CRM114-Status: GOOD (  19.09  )
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

On 7/19/23 14:12, Daniel Wagner wrote:
> On Wed, Jul 19, 2023 at 01:38:55PM +0200, Keith Busch wrote:
>> Yeah, dm-mpath is such a setup this was intended to prevent, as well as
>> out-of-tree alternatives. Not that I advocating one way or another at
>> this point; I'm just trying to set the context for why this message
>> exists for discussing your patchset.
> 
> Fair enough.
> 
>> I'm curious why a proprietary module is even used, though. Is the
>> driver's native handling doing something undesirable, or is this to
>> cater to some vendor specific behavior outside the spec? If the former,
>> I'd like to understand the problem and see if there's something we can
>> improve.
> 
> Unfortunatly, I don't have any insides into PowerPath, or what it tries to
> achieve. I suspect it's more vendor specific handling features. I'll ask if
> there is a feature gap we could address in upstream.
> 
 From my perspective there is no feature gap. With dm-multipath there 
used to be one, as powerpath would provide /dev/sd* devices, not the 
/dev/dm-* devices from dm-multipath.
Also powerpath was/is able to detect which array is being used, and
pull all sorts of information from it.
Not that we really need that, though.

Other than that the functionality is pretty much identical.

PowerPath is primarily there as Dell/EMC used to recommend using 
PowerPath, and customer are wont to do whatever the IHV tells them.

So really, the issue not about PowerPath.

The issue is about dm-multipath, which requires this option to work at 
all. And that is a really contentious issue which I will not engage upon.

Good luck.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


