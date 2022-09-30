Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B048C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 07:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLGRNBOhN7qPEZSAgQdORPpqx6ib0SBNqkz9JxIe1LE=; b=ibHNG93WLNjH+/dL7j6swr8Hgs
	oXbSZs4k+6YEp+l8OrYcuQnGp5gpfsRj3+x+s8ww2OX8t+i0rJD2Ta4VFQDJxWzKiv1Bg5VC+TfI9
	BL8hz74Vn8eJqODENfMZvAe7cXZ/Icj2dk9kY8rDpAP+4A6QSkv8MnEfawSYMYLa5vPFbkfZ0pSlB
	+1gHT5jG6Nmr4XZmQD3WR2WL9+oR5L2OEn+3pCZB1FCGHauddzSzCrk1Oj4Z/goWc8OgS9b1+bqFN
	66Dvbab3VzTD3szf8OEx9AKSlTVcjqZnVJXWn8HSS+MTdgTUumPPI/7g7JVqJLlpGnzCXBuuPkljY
	FCoiIntA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeA42-007hYU-Ag; Fri, 30 Sep 2022 07:04:02 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeA3y-007hWh-Ue
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 07:04:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA9C21F88E;
	Fri, 30 Sep 2022 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664521435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLGRNBOhN7qPEZSAgQdORPpqx6ib0SBNqkz9JxIe1LE=;
	b=q+Vy0egIgHSzHeevxGZc7+GWRBPDrzW283t8YnNzePPmYRFNuD4gAskWK7vg7tgkOu5K+u
	Kj5TS4SegBcE/drHpE4ffuv/MFNeKRn93u1O9fCV9lPrjlXMuPx58X5LvbT/EWYhqBZxWK
	2wPSdZ2LObbC9n972cVN1T24eJGhJ9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664521435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLGRNBOhN7qPEZSAgQdORPpqx6ib0SBNqkz9JxIe1LE=;
	b=Mn0KI2S4cKzgpAYwwa7GI6XizIYp19l6FB0kJ3Q6QA3Qd/NijS3PYztmxD3ACr6cvxYM87
	toNUot82+I09drCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74B9A13677;
	Fri, 30 Sep 2022 07:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UB9oGtuUNmPQHwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 30 Sep 2022 07:03:55 +0000
Message-ID: <36289eb9-2605-8461-a414-fea5e4ed1211@suse.de>
Date: Fri, 30 Sep 2022 09:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>,
 "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
 <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
 <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <410aeb5c-3045-59ac-3fc8-fe80a89b9119@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <410aeb5c-3045-59ac-3fc8-fe80a89b9119@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_000359_153148_B8FF31EF 
X-CRM114-Status: GOOD (  12.72  )
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

On 9/29/22 04:14, John Meneghini wrote:
> On 9/28/22 14:02, Knight, Frederick wrote:
>> Reset and Disconnect are different.
>>
>> Reset uses registers (and therefore Get Property and Set Property 
>> commands) over a valid connection.
>>
>> Disconnect causes a reset (you have to reconnect to the reset controller)
>> Reset does not cause an immediate disconnect.
> 
> OK, so you are saying that the rule "The controller shall not change the 
> value allocated between resets" in NVMe 5.27.1.5 doesn't apply to fabric 
> controllers?
> 
No; problem is that the linux usage of the word 'reset' really is a 
disconnect/reconnect (for which a queue change is allowed); we never to 
a NVMe reset via Get/Set Properties for fabrics.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


