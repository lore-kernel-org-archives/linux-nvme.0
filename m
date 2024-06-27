Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B59C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ffory/gfMjXlxRtGW+BVCCMdLN4caOjXQznWCxJZ4h8=; b=n/Vwk4roVfDF3OHxj0zvKY98KG
	CmPEdF1OtlsB9xjdxVWGS6W0vznn78Rv9qSIEKf8Qfr2g/GEEgCjRbFq28pZjKKeKhYKFNdx9Lp5o
	Yws9jZdfMSY574kb4lw87SOcxtH1lTnoBlVcLg5n51kQoDSPZ4cZYmByzhRIlG6pKcbjqjCE+NAGJ
	a7vKs5GUBz9x0C7KO1AndvMkI6mACv8u90c9WMbWG6Sc31YRFOMZTxAkZ1QE+8NtrQZCWKEJSYhP+
	1AJtdpnvIT5riAUOIOMSQjyij3/zzZM1Kp1bxTB8St3hXzQlcSad1+m2M99rNJochvfyaK/AdJWr+
	wJq4KEIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmpY-0000000A3tw-2MEb;
	Thu, 27 Jun 2024 10:58:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMmpS-0000000A3sW-4999
	for linux-nvme@bombadil.infradead.org;
	Thu, 27 Jun 2024 10:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ffory/gfMjXlxRtGW+BVCCMdLN4caOjXQznWCxJZ4h8=; b=jVOaySX/RUEz2LWBBqIRC/mdmY
	FCfUG1fZ5x0Ur0d+BpY4rI04zUK9yCKlhTf+wpOCBnf/wQpYPTqTgHmnrm4jXocrrYRhvZbKNraGP
	3cHAyIP9UhXbdpnF+hpYDSJyr/4/lE2wFHkMuV/veOdSH+825ImsqOCrB963B1KWrN8MxKA6SJRLE
	AOV49hhaVMost0VpYJQ202E8gKg9GDlzrdKMuuDp+W9FFRo/VKC162BI07xMHPai2srgtMUXbusPP
	S6uwntA9BksTJfUDjnRE7gxhDVJpjEpkGEcZMZflzlSHNqM+SFg6cW8/FvmidCsXgvRTUKANjzpf2
	+GDX37xg==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMlQW-00000008nvP-3se1
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 09:28:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C070A1FBB1;
	Thu, 27 Jun 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE6C51384C;
	Thu, 27 Jun 2024 09:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oeKXKLYwfWanGwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Jun 2024 09:28:22 +0000
Message-ID: <2f1d6ff3-c087-4dce-8e91-41f097f38c6d@suse.de>
Date: Thu, 27 Jun 2024 11:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 0/3] Add support to run against real target
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627091016.12752-1-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: C070A1FBB1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_102826_754055_71A5D1C4 
X-CRM114-Status: GOOD (  11.65  )
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

On 6/27/24 11:10, Daniel Wagner wrote:
> I've added a new hook so that the default variables can be configured via the
> script. This simple overwrite of the defaults allows to use external configured
> setups (there is some trickery involved as it's not possible to do it only once
> due to include orders). The upside of this approach is that we don't have to add
> more environment variables.
> 
Round of applause ... Thanks for doing this!

> I've run blktests against a PowerStore. That worked fairly okay but there were
> some fallouts which is kind of expected at this stage:
> 
I guess we should blank out tests which don't make sense for a real target.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


