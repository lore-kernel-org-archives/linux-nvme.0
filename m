Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D439AC54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11KkO03JX9NaxIyCFJ74bsWCPIp70G+48xbSO7NybfA=; b=Tv7NC57gqFsZiU25HI9X9hoKNl
	64B45ZUyMzlJGxpa5cTu1OGDq33N2QryPC1jLA50bn80A/pQewQ905AI1eGE9zJFK2oLugAhD0Q/v
	r6wffHBSdBoDLew/VV765vNAsAWgWP56/UvH5PT0xUu1FbPwp4w+u4CZl58CoJZvyUGc0q11KQ5NM
	6VDgiL4T4MlwfxI+DP72VT6mRS4WjRA0P7Yt2O87tcb9zm44iIV7HZZbf7RXU7lI/vhiT2vtnGM/J
	N0iPrsLLM8kKJO5pL28QdrT1GQmn3hACMnQ97Wn2vUey7ZlUT7okyqWaaHfm/AfQnu3cR6BLleL94
	UAa9i1dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCKh-000000025pU-1Em8;
	Thu, 21 Mar 2024 06:55:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnCKc-000000025nk-09zx
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 06:55:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2135C9DA;
	Thu, 21 Mar 2024 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711004113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11KkO03JX9NaxIyCFJ74bsWCPIp70G+48xbSO7NybfA=;
	b=kwQHTz/AMZPpVGcMYN3sEYwdNU+w3L7s+4dDOOjprIpqb4Kf/AI/vdx3rDUQiA89sReWZQ
	XP9YGZYeq45P+47PPD/U56XD2PlrMiGirJ38yYcfhrpg0b6g4qkbHZubEBXDbvzCRio0VB
	Dtdz8GdaGB1Vd/4BkwOPYY4P37hr0wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711004113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11KkO03JX9NaxIyCFJ74bsWCPIp70G+48xbSO7NybfA=;
	b=urt7RMJT+iECJqlTARGC1+Y1JAze/tlK0JGiJGHZlGDywMDngxFsfz9dv9p64zBZmLE5FU
	MJtX7cHmFRUVyIBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711004113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11KkO03JX9NaxIyCFJ74bsWCPIp70G+48xbSO7NybfA=;
	b=kwQHTz/AMZPpVGcMYN3sEYwdNU+w3L7s+4dDOOjprIpqb4Kf/AI/vdx3rDUQiA89sReWZQ
	XP9YGZYeq45P+47PPD/U56XD2PlrMiGirJ38yYcfhrpg0b6g4qkbHZubEBXDbvzCRio0VB
	Dtdz8GdaGB1Vd/4BkwOPYY4P37hr0wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711004113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11KkO03JX9NaxIyCFJ74bsWCPIp70G+48xbSO7NybfA=;
	b=urt7RMJT+iECJqlTARGC1+Y1JAze/tlK0JGiJGHZlGDywMDngxFsfz9dv9p64zBZmLE5FU
	MJtX7cHmFRUVyIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C5DE136AD;
	Thu, 21 Mar 2024 06:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KxvCENHZ+2VbVQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 21 Mar 2024 06:55:13 +0000
Message-ID: <a4ee4c4f-ac1e-4309-aacc-d25a14ad5091@suse.de>
Date: Thu, 21 Mar 2024 07:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/7] nvmet: debugfs support
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20240320144017.106283-1-hare@kernel.org>
 <eeba8428-e5d1-49ff-914c-cfdf7fd18750@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <eeba8428-e5d1-49ff-914c-cfdf7fd18750@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.99%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_235518_271272_26A22909 
X-CRM114-Status: UNSURE (   9.04  )
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

On 3/21/24 00:07, Sagi Grimberg wrote:
> 
> 
> On 20/03/2024 16:40, Hannes Reinecke wrote:
>> Hi all,
>>
>> taking up the original patchset for nvmet debugfs
>> I've improved upon that submission by modifying
>> the layout:
>>
>> /dev/kernel/debug/nvmet
>>    <subsysnqn>
>>      ctrl<cntlid>
>>        port
>>        state
>>        hostnqn
>>        kato
>>        queue<qnum>
>>          host_traddr
> 
> Why is host_traddr per queue?

Blame TCP. We're having one connection per queue, and as such the
peer address is a per-queue thingie.
And it really felt daft to look for queue 0 to get the peer address
of the controller.
Unless we declare TCP the odd man out, and store the peer address
per controller. Certainly would make sense for FC and loop.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


