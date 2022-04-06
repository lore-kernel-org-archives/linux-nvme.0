Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EA4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LFK5xKlvhzoQpK+dvSthj0wSmSJeuPNyKBnN6CjMU3I=; b=DFxAo/QReGJbEAfJzCGoKiftFH
	IyVGhYtsyW6AonWISiwLnlVa6R7nNhd+wRlbIFzfwksQ7Vh2B7DZnpteqQqJX0Z7uRbiAEyNxURHk
	acRs8nmGsN1r4ZaTXpRs9UNNhoq/emti/jPhKDZQL07yM/iW9P08iuIlZQVSBQxG3LLM90bnl4Ys1
	rIMWq53MCtmQuXgta/NGhjsRff8AwJdvwJtbRoQ/HUcG+yKMgP7ifS2pzirUZ/kL19y3Rz0OPj1VM
	4SYvKFVqXpwhJ0ADDkyxt+7CIBUPT6QFFevmQS+j6qB1Nag3Kdmj6rw96XAm7mu7sU9sWO6QeYXHW
	nTTydF8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc41B-005owV-Qr; Wed, 06 Apr 2022 11:40:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc418-005otD-SZ
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 11:40:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 296EA210F1;
 Wed,  6 Apr 2022 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649245200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFK5xKlvhzoQpK+dvSthj0wSmSJeuPNyKBnN6CjMU3I=;
 b=adyrjypRdBQuJCovljlWx1BUmmBkhi/4tBIAFiCKTNbLnHo9xo0F9DxW3zb19LoQVJyaeV
 vKwTC9uKBBd4sVe3umDpke6rxQPgpQtAV/dmrQUasbd0TrtfEPwPkmXd6Lj4UksEnQSflm
 vQdvP+Kn5cdALAGaxHlJ0pT17O5pqvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649245200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFK5xKlvhzoQpK+dvSthj0wSmSJeuPNyKBnN6CjMU3I=;
 b=IwbUWW9WM+TxHQ4tob0ikDqgpKaCQAmbIxIdrR4FemgcRHFdXbGnX1JYqsSn3PdrGqN3d4
 dbOImrpSMCboVlAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E759A139F5;
 Wed,  6 Apr 2022 11:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zvn7Mw98TWL2SQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 06 Apr 2022 11:39:59 +0000
Message-ID: <5680c407-4f3e-fa50-8c11-d7343afa87ce@suse.de>
Date: Wed, 6 Apr 2022 13:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
 <20220405073121.GA25524@lst.de>
 <ba2cce05-c7d5-b51a-a796-3223ef67aadc@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
In-Reply-To: <ba2cce05-c7d5-b51a-a796-3223ef67aadc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_044007_106791_A19E7CF1 
X-CRM114-Status: GOOD (  15.12  )
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

On 4/5/22 17:09, John Meneghini wrote:
> On 4/5/22 03:31, Christoph Hellwig wrote:
>> 2) (optionally) make the well known discovery controller go away
>>
>> Just renaming the subsystem will make the well known one go away,
>> but while that can be useful for some use cases, I think making it
>> always go away has the potential for breakage.  So maybe we need
>> to not rename but be able to create an alias and have a way to
>> disable the well known discovery controller if not used.
> 
> I agree. I think making the well known discovery controller "go away" 
> will have huge problems in a multi-vendor fabric. We really can't touch 
> the well known discovery controller because there are too many legacy 
> and non-TP-8010 compliant NVMe hosts on the fabric.
> 
> We have to assume that both new and old implementations will coexist. 
> And legacy hosts will NEVER look at the new, unique discovery NQN 
> because they won't even recognize the new NVME_NQN_CURR log page entries.
> 
It doesn't 'go away'.
The original, static, configfs entry will be unused, true.

But the unique discovery subsystem will _still_ react to the default 
discovery NQN, and any controller will continue to get information when 
using the default discovery NQN.

And even older implementations will continue to work _if_ they just skip 
unknown entries.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

