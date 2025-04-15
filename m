Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E85C369B9
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=; b=VPQb0fg8YEph3OA/qzeiJJFxz+
	wJiIzZBuHVu419spaLGHxdSSQqFCtBnkIA9cUPJXGnk13SRF3WoaEnf6GHdllCUrodxwrnZIW8Bv4
	dEgtR1wiNoRFzd4f6a3RaTZ8subwmk6SoDAdZeBYAhP07J49AKwmjm4kpKGmaRTE3DryliHyDkWdA
	LpP5s15lAeiIA7C+uYEPYyB8cXP1pV395/olunwpHOmPh5k1dgrUnKBZ3Ee3pFs8vP9/M/zMvuv51
	ykvygL4cmIPSrP4bpptl2B8TuFZlvtUECg+IfFWHz3R7rGCwWfkNN1L4LNrmFlpsBMEctgMpQdgvo
	/V5AAZdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4bHx-00000004vRC-2TZq;
	Tue, 15 Apr 2025 08:05:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4b3m-00000004s4o-2QuR
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 07:50:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5C631F38A;
	Tue, 15 Apr 2025 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=nvgumNWdlS9bpY0i7qwTNS4qOVAyRbx6q57FYS3t7wFKyWfaaLYXM6NVU9PvJEfZjgC1vc
	uRH/PTz5VyVn2Q0Ad9jjq/vHfBDTwo9bHQbuH/T4G46VoHaANjkrgJuT3oJ6gXTAHe0sX+
	kipdWfGdwWUlI47/bDnC36tuyzV7xJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=E3NFk2Oa5xaLL3TaGoiz99ibS3ZyZB2M8MGV75Q/4PuLHhV79ptI1KBmdHvk5FMl7QvJ5Q
	M2hrFeVf+jsPoMCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nvgumNWd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E3NFk2Oa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744703420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=nvgumNWdlS9bpY0i7qwTNS4qOVAyRbx6q57FYS3t7wFKyWfaaLYXM6NVU9PvJEfZjgC1vc
	uRH/PTz5VyVn2Q0Ad9jjq/vHfBDTwo9bHQbuH/T4G46VoHaANjkrgJuT3oJ6gXTAHe0sX+
	kipdWfGdwWUlI47/bDnC36tuyzV7xJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744703420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmxMsPsqrYg46jgsjRvFPzkSOIC3pJcRxDo9AxRp+8=;
	b=E3NFk2Oa5xaLL3TaGoiz99ibS3ZyZB2M8MGV75Q/4PuLHhV79ptI1KBmdHvk5FMl7QvJ5Q
	M2hrFeVf+jsPoMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AC0A139A1;
	Tue, 15 Apr 2025 07:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yufdH7wP/mcUNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 15 Apr 2025 07:50:20 +0000
Message-ID: <4c3eb3f4-6e19-401b-a110-cae405512ed4@suse.de>
Date: Tue, 15 Apr 2025 09:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 00/10] nvme: test cases for TLS support
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
 <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <nab6xnd63ose5yqawp5q3nwrgcfi654zveat6iiccci75ob67r@mkfarprb4aeg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5C631F38A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_005022_800139_9E3C1047 
X-CRM114-Status: GOOD (  17.64  )
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

On 4/15/25 09:47, Shinichiro Kawasaki wrote:
> On Apr 02, 2025 / 16:08, Shin'ichiro Kawasaki wrote:
>> Hannes created two testcases and shared them as the GitHub PR 158 [1]. Quote:
>>
>>   "This pull request adds two new testcases for nvme TLS support, one for 'plain'
>>    TLS with TLS PSKs, and the other one for testing 'secure concatenation' where
>>    TLS is started after DH-HMAC-CHAP authentication."
>>
>> The testcases were missing a few requirement checks. They also modified
>> systemctl service status after test case runs. To address these problems, I took
>> the liberty to add some more patches and modified the testcases. Here I post the
>> modified patch series for wider review.
>>
>> The first five patches are preparation patches to add several helper functions
>> for requirement checks and systemctl support. The last five patches are
>> originally created by Hannes to add the new testcases nvme/060 and nvme/061.
>>
>> I ran the two test cases using the kernel v6.14 with the patch series titled
>> "[PATCHv15 00/10] nvme: implement secure concatenation" [2]. I observed nvme/060
>> passed, but nvme/061 failed. FYI, I share the failure logs [3]. Actions to fix
>> the failure will be appreciated.
> 
> FYI, I applied this series. Of note is that the two new test cases were
> renumbered from nvme/060 & 061 to nvme/062 & 063 to avoid the number conflict.
> 
>> P.S. Hannes, please check the Copyright year of the second test case nvme/061.
>>       It is 2022, but I guess you meant 2024 or 2025.
> 
> I still suspect that Hannes intended the copyright year 2024 or 2025, but keep
> it 2022 unless Hannes requests change for it.

Weelll ... 2022 is actually correct, for that's when I wrote the
original test for TLS. It really took its time getting upstream ...

Thanks for doing this! Much appreciated!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

