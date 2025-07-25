Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CC7C83F26
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aXdnvb+5b4agasLxtjn/Yxjvx8W5ZLZ0f0C4G28seg=; b=atmupMziUqEb9sXDW4JhZYOZZh
	jiGL5QJ/blgmtJret35/NYTHE9/xBEEULowtZ6zx4UStJ/nsndJa1Lt6Mt+lHlnapjPrDGsQ0Rcp2
	Pop2Lfvmapc8e56Fitq8WSWWxTIgA9OlHOHAmCDfbSL8sJSb3SDfdQUfY+2vxnTH5ObLw66MmJH6S
	ift3Fk94Mx2r92BEiUUsicjgP4TBInjCSwZipdJvZogsK51YDR0YU3ElR9dofYG1aefFQaTk/v2oA
	tjwE4+mYcQXFPenlOWFXPNc4b6I5V+hcgCOubMxF9a63jWQIr9VjToGrenHVlwhDQKRbHwmzGWRxM
	YSHwiZ3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufEsR-00000009SzH-41UB;
	Fri, 25 Jul 2025 09:38:07 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufEqk-00000009Str-3HN7
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 09:36:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2FE42191C;
	Fri, 25 Jul 2025 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753436181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aXdnvb+5b4agasLxtjn/Yxjvx8W5ZLZ0f0C4G28seg=;
	b=WxZYFpuAMURpSh5VzIHPSEHovvaWDaYO6xBTSUd5w9Mts1y3SmMI1U0tM4XSpNi8qyc38W
	bXPNYG+uTU3QRM/bfSOFetCjAVx98bdQtJwrjoe4DMmClMMczxL+7dYKTSQpQp/+eQuy8q
	Dimse4Kan+j9TZDtc9kWHenQ/0wVZXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753436181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aXdnvb+5b4agasLxtjn/Yxjvx8W5ZLZ0f0C4G28seg=;
	b=oYBmVO8BrKveM6hYGULeGETggvF2OFy8oR8UwaQuGUAxWRgPoNoMpL12CZWDEK8C6k3Zlw
	EF9je6W9mL1HAhDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WQcjzJrI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JaZVYhFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753436180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aXdnvb+5b4agasLxtjn/Yxjvx8W5ZLZ0f0C4G28seg=;
	b=WQcjzJrITz831YfLJZ5Bqkuf67kpzXoAVFPPpxUb8YDcsvWKn8CW29HYIfrSOg0XEJEIp7
	EpJLTYd2OII8hJWvUG0bcvUQ+9g0/0gNGv6JRz9bhz2MSwvh2I6jtccdr1EgIE2KyHHh6O
	Q9wPC2WzwOAJ+sWOTMH2nqS0W1IM/E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753436180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aXdnvb+5b4agasLxtjn/Yxjvx8W5ZLZ0f0C4G28seg=;
	b=JaZVYhFaxZDwGhh65Qt4To46c/qYa60mxkJV0y+ob2V1NqRvin2HKxocBFqld0OAWaqF5z
	jL1Npa0iZzjGULCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA361373A;
	Fri, 25 Jul 2025 09:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HHGKBRQg2gEdAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Jul 2025 09:36:20 +0000
Message-ID: <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
Date: Fri, 25 Jul 2025 11:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C2FE42191C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_023622_965773_4665E257 
X-CRM114-Status: GOOD (  14.33  )
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

On 7/21/25 17:31, Chris Leech wrote:
> On Mon, Jul 21, 2025 at 08:36:01AM +0200, Hannes Reinecke wrote:
>> On 7/21/25 04:17, Chris Leech wrote:
>>> There are issues with the Retained and TLS PSK derivations due to the
>>> implementation not adhering to the RFC 8446 definition of the
>>> HKDF-Expand-Label function.
>>> ...
>> Hmm. I _thought_ we had it all fixed...
> 
> I went into this expecting/hoping to find the problem on the spdk side,
> and I'd be happy to wrong here (especially if backed up by another
> interoperable implementor).
> 
> The lack of a full example in the nvme/tcp transport spec to verify
> implemenatations against is kind of a bummer.
> 
Okay, seems that you have been right after all.
I've re-read RFC 8466 and indeed you seem to be right about
the encoding of variable length vectors (cf RFC 8446 section 3.4).

So I guess we need to take this patch after all.

_However_: PSKs generated with after applying this patch will be
different than those prior to this patch.
Consequently there will be interop issues with existing implementations
(which will use the original encoding).

I guess we would need to wait for the target implementations to be fixed
or introduce a flag switching to the old / compat implementation to 
avoid interop issues.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

