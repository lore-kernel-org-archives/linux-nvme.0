Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C82D6B6A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/wHQvSNouR2vorTfNcSoCClzKmnf7AR6glWeBAzzBU=; b=DqGNBjg7NUDnGI7Cm25A1J491n
	sM63iOZgI0rWgh8PAOvU974sZTfsAt5kUD+FF5/Sy5Xwsyn23vwwlI1ABnlTPXrPMvTywxxyemOIT
	TjJpKJwPYHcMWPierCLLTzqbDO9sbnQ6W1EIytZWGty0w0wHAdrppSmdS9DhDfNGyljQSANFaMqC2
	z0U/iETIbWFX2eDe0m3HY/vdpSmfHLSe22s6giHNr1/i0FRIG0rmZLxpu15No2heeijvbJMPn4el/
	VlpsQF7NNhlwTr32OcTPwmwebNc6HWyaZ+u93if24fAlEaG2HlRnwl3Uzmci1yabIGWbWarLO3eYG
	XORBgxsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6BdE-000000015RC-18mX;
	Wed, 30 Oct 2024 16:33:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Bat-0000000154O-21MA
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 16:30:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B49A921F39;
	Wed, 30 Oct 2024 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730305848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/wHQvSNouR2vorTfNcSoCClzKmnf7AR6glWeBAzzBU=;
	b=0vZDq87ScSmj6wUkz2oX3msr3YlFcXd2tAMq/Fn23uIA9rtrYswQlOaE5dPtMj5EHEpoi5
	QofvaviDpH+j/u2Q8oTqoX7XOHMAsSFLUYN/KyTXe0zpkm7n15jSPcBV4OFGi51atm4LUw
	MItymdGfEydARw1einGGbUPquhcN70Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730305848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/wHQvSNouR2vorTfNcSoCClzKmnf7AR6glWeBAzzBU=;
	b=gy6loYrHjtcfJJMybDdcva8sSxHWLTyuMAa2TB95l9NDJeeAp4Wqa8qzYuocRicoVz9Dst
	JP7+Va1ruun/NMAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730305848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/wHQvSNouR2vorTfNcSoCClzKmnf7AR6glWeBAzzBU=;
	b=0vZDq87ScSmj6wUkz2oX3msr3YlFcXd2tAMq/Fn23uIA9rtrYswQlOaE5dPtMj5EHEpoi5
	QofvaviDpH+j/u2Q8oTqoX7XOHMAsSFLUYN/KyTXe0zpkm7n15jSPcBV4OFGi51atm4LUw
	MItymdGfEydARw1einGGbUPquhcN70Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730305848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/wHQvSNouR2vorTfNcSoCClzKmnf7AR6glWeBAzzBU=;
	b=gy6loYrHjtcfJJMybDdcva8sSxHWLTyuMAa2TB95l9NDJeeAp4Wqa8qzYuocRicoVz9Dst
	JP7+Va1ruun/NMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96477136A5;
	Wed, 30 Oct 2024 16:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3DoPIzhfImcDMQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Oct 2024 16:30:48 +0000
Message-ID: <eab93123-e7e1-411e-b513-4c351e006a57@suse.de>
Date: Wed, 30 Oct 2024 17:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 04/13] nvme: introduce wwnn/wwpn helper
 functions
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-5-shinichiro.kawasaki@wdc.com>
 <ae95fb38-8290-419f-aff8-b2964c9dc4f7@suse.de>
 <zndmkpl7qs53vyans4r552pwcumxhyhc4ualrodwnxh6y2azec@waicvtyoaccw>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <zndmkpl7qs53vyans4r552pwcumxhyhc4ualrodwnxh6y2azec@waicvtyoaccw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_093051_691709_18D12191 
X-CRM114-Status: GOOD (  19.22  )
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

On 10/30/24 13:20, Shinichiro Kawasaki wrote:
> On Oct 30, 2024 / 08:21, Hannes Reinecke wrote:
>> On 10/30/24 07:51, Shin'ichiro Kawasaki wrote:
>>> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
>>> modified the wwnn and wwpn names for fc transport to calculate from the
>>> port ID. It also moved the timing to set the global variable
>>> def_host_traddr based on the wwnn and wwpn from _setup_nvmet() to
>>> _create_nvmet_port(). This move made _nvme_connect_subsys() fail
>>> to refer to the def_host_traddr variable, and caused nvme/003 test case
>>> failure.
>>>
>>> To avoid the failure, do the wwnn and wwpn calculations both in
>>> _create_nvmet_port() and _nvme_connect_subsys(). Introduce helper
>>> functions to calculate wwnn and wwpn.
>>>
>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> ---
>>>    common/nvme | 63 +++++++++++++++++++++++++++++++++++++----------------
>>>    1 file changed, 44 insertions(+), 19 deletions(-)
>>>
>> Hmm. This was not what my patchset did.
>>
>> In my patchset I changed the 'logical' FC port setup in using _always_
>> the same local wwpn/wwnn, and only have the remote wwpn/wwnn modified with
>> the port id.
>> That way the host_traddr can be kept global throughout the code, and
>> we can calculate the remote wwpn/wwnn when creating the FC ports.
> 
> Hannes, I think you mean the patch titled "nvmet: rework fcloop" [1] in the
> comment above. The patch is not in this series. I once tried to include it in
> this series and moved its commit position, but it caused rather heavy conflicts.
> So I'm preparing to include the patch in one of the following series. I hope it
> is okay for you to apply this series as it is, and later on we revisit the
> patch "nvmet: rework fcloop" in the following series.
> 
> In the following series, conflicts of the patch are easier for me to resolve.
> The patch I modified looks like this [2]. Your original patch [1] gets
> remote_wwnn/wwpn for port removal from addr_traddr, but after my modification,
> it gets remote_wwnn/wwpn from the port itself, because I think its simpler.
> 
> [1] https://github.com/osandov/blktests/pull/146/commits/5545881f11769832100a517d29ff059435a1fbbf
> [2] https://github.com/kawasaki/blktests/commit/93227f4c41f52032da3de1be1c3b485e639d9663
> 
Ah, ok, that's fine then.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

