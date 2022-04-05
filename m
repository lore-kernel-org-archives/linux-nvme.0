Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CBDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUXDQfVTwuUcJQDmth+U8UI+LElxkfTMraI33gXTH3o=; b=FVCdd9MfUd0maz5mAhA5cV8cw/
	Qp6pZk/TOs7RWkoSoB+2z8C98zDCZAgzCfC4QBpsSikcC9o/LS2XtsPzMA1TltP/KZA9Brfi7/2vX
	AC1hhUMv4QbHtWt8W6fLDyldzJEhC/W/esmnh1B6voyjOfgBh7F/w2irQ1UEy1YRuT4ZKWjZJxaHe
	IkgpD7gkgN54CkD8JWXRRW+F/caFiK0EqmLbJvDtFLDuNR/1t6Cl85e6MASmJJ+j+fIe7UXHvVPV+
	k9KM7TsVhfRO0+pnhzbkh5xK/L2jqp7JoDfZ2/2850+YkmPva+hBV4HGIbJPjPNioHPxZ4DZQckKu
	qzcg293Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbh7E-000l2v-DI; Tue, 05 Apr 2022 11:12:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbh7B-000l1f-DC
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 11:12:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F11D91F745;
 Tue,  5 Apr 2022 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649157167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUXDQfVTwuUcJQDmth+U8UI+LElxkfTMraI33gXTH3o=;
 b=IVBdlkfVLMm73udj4jeJHpby8hrIVL0dBwIjhBUhO5Dg5IYTck0TteHjp0BbuszcmceN5L
 aGyvUXIMtCkUfGmEyeZmvAKiyQI9Ef53uRstMeNkXweYcVXAQ/fVlmm2jQmih0foNLmHcT
 mAS5r/jT83Lfg7z6M9Xg1Clwt3RScyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649157167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUXDQfVTwuUcJQDmth+U8UI+LElxkfTMraI33gXTH3o=;
 b=mZyoa+bIVOM6GWcgZ9U5j+utYVOiNPVtQtui59jBF+3Kx0fWVw2ti1H8K8JyALz7B1Oeh1
 TZBkT8O4kxsCLrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BCF13522;
 Tue,  5 Apr 2022 11:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AIRXMy8kTGI1aQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 11:12:47 +0000
Message-ID: <13c13023-be65-2b54-cc6d-ff1161a28f54@suse.de>
Date: Tue, 5 Apr 2022 13:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
 <20220405060946.GB24073@lst.de>
 <66428672-250b-950e-ab7c-0a6ceb10c06e@suse.de>
 <1ff01a7a-2687-4a90-672a-e9218cc54331@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
In-Reply-To: <1ff01a7a-2687-4a90-672a-e9218cc54331@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_041249_629374_97D94CEA 
X-CRM114-Status: GOOD (  18.66  )
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

On 4/5/22 12:35, Sagi Grimberg wrote:
> 
>>>> I actually looked into that with my previous attempt, and really 
>>>> found no
>>>> good way of having an entry which is
>>>> a) pre-filled
>>>> and
>>>> b) removable by the admin later on.
>>>>  From what I've seen all pre-filled entries are static; I haven't 
>>>> found a
>>>> way to do pre-filled dynamic entries.
>>>
>>> I don't think we need to remove the well known discovery subsystem. But
>>> we can allow removing all entries from it and thus reporting an empty
>>> log.
>>
>> Hmm.
>> We still would need to pre-fill these entries when creating subsystems.
>> Bringing us back to square one, namely there is no way to create 
>> dynamic pre-filled entries.
> 
> Why do we need to remove it altogether? Why not just make these
> subsystems attach to port(s) like any other subsystem?

That's what I tried in my first attempt, which got rejected as it does 
break existing installations.
We could introduce a module option for this (and I think that's what I 
did in my first round).
And yes, ideally I would like to have the discovery subsystem as a 
'normal' subsystem just like the others; should be trivial to expose the 
current one in configfs.
But then changing the subsystem NQN becomes awkward:
- Either we create a new subsystem with the unique NQN, but then we have 
to change the type later on (as creation happens with a simple 'mkdir', 
and one cannot really pass arguments to that).
- Or we have a distinct discovery subsystem type (ie the idea Christoph 
mentioned), but then we have to cross-check the directory names against 
the existing one in the 'normal' subsystem directory.
And, of course, we still end up with a defunct discovery subsystem if we 
create a unique discovery subsystem.

Alternatively: if we're going to break existing configurations anyway 
(or, rather, have to modify nvmetcli to handle the new discovery 
mechanism), why do we need to start off with a default discovery subsystem?
Can't we require the user to create one?
We would be requiring a module option here, but that looks like the best 
approach here as we won't have to deal with stale subsystems ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

