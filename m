Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B68C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYQyY0HcoOFUfKuQ1Im2WAulWLdgLYPXxpHIKmoKi8A=; b=2Bb1daw8+HxpuBZPD/GIvtAblX
	KGnTUcrrVbq7Or0DHcbwObYpAWsH2dvVF3Uyz3kqGtKA8Cbr6yEcMfB7UM+BWA+OhYyYcPPKQi3pP
	dvA2mvC1D2IFEIVYlhRDxK23THp7VIHcqRH6XLVureqqD6jZFo1hfLtTVLAcHrH7Z0oFvZbTBK2tq
	l+G6cSFMe1M4gkPKKJ5PsEpd0dZ3kdANvdIQops9gNBj5FMgjTJ4aYWtZg8+WvEa3qg9BVMLI8Kby
	C8JJuezhDbGHujzH1/ylBvjosDo0i2uciPl/8caQC0dvGKp46mxdTNfWdlmoa8OjAvJ4W2Usl0v5t
	VaGVQh1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFrD7-00GSkW-23;
	Wed, 20 Dec 2023 07:41:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFrD4-00GSho-0i
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 07:41:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9024F1F81A;
	Wed, 20 Dec 2023 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703058093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYQyY0HcoOFUfKuQ1Im2WAulWLdgLYPXxpHIKmoKi8A=;
	b=Yzwu3gQ1wd6jxVJMenzpz/0dNqLR8p/8YyaNHjms2nIUZfFGm5brFR05VrwTr5BfIWik05
	jCRGvJVzViDLFq5aLQxTfxCn0wbmM3IGrC91VK+O9NNW3g9ZBwy7SJDjtiSGYF+WxpEn/5
	r1+a9f6PcmoZaqeeRGeqRqcNERtuMjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703058093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYQyY0HcoOFUfKuQ1Im2WAulWLdgLYPXxpHIKmoKi8A=;
	b=XhB79M/FC/4IaSmCYFzHVulxawuVPl/fAFZkQGEQ4SkexIx+OxRIjrSwDAIhi0lANx51w1
	q/9Ql/B+7dSOCeDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703058093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYQyY0HcoOFUfKuQ1Im2WAulWLdgLYPXxpHIKmoKi8A=;
	b=Yzwu3gQ1wd6jxVJMenzpz/0dNqLR8p/8YyaNHjms2nIUZfFGm5brFR05VrwTr5BfIWik05
	jCRGvJVzViDLFq5aLQxTfxCn0wbmM3IGrC91VK+O9NNW3g9ZBwy7SJDjtiSGYF+WxpEn/5
	r1+a9f6PcmoZaqeeRGeqRqcNERtuMjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703058093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYQyY0HcoOFUfKuQ1Im2WAulWLdgLYPXxpHIKmoKi8A=;
	b=XhB79M/FC/4IaSmCYFzHVulxawuVPl/fAFZkQGEQ4SkexIx+OxRIjrSwDAIhi0lANx51w1
	q/9Ql/B+7dSOCeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46EBF136A5;
	Wed, 20 Dec 2023 07:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MzRYD62agmUiQQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 20 Dec 2023 07:41:33 +0000
Message-ID: <513af2e4-77ed-4182-8ffa-af6b0291384c@suse.de>
Date: Wed, 20 Dec 2023 08:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvmet: implement unique discovery NQN
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 hare@kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231215123929.172940-1-hare@kernel.org>
 <20231215165920.GA3642@lst.de>
 <c59b84bd-db93-4190-8940-b5491c8ca1fe@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c59b84bd-db93-4190-8940-b5491c8ca1fe@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_234142_427125_DBB020AD 
X-CRM114-Status: GOOD (  12.81  )
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

On 12/19/23 15:17, Sagi Grimberg wrote:
> 
>>> Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
>>> directory to specify the unique discovery NQN.
>>
>> That's a bit of a sparse commit log.  What do  unique discovery NQN do?
>> Please include a reference and a bit of an explnation.  And tell us
>> why this feature is useful for Linux to have.
> 
> I think that a unique NQN is better to authenticate against. That would
> be the motivation in my mind here.

Correct; unique NQN is actually a requirement for authentication.
I guess there is even a TPAR out there to make it so.

But my main driver here is to test persistent discovery controllers
as this impacts far more than 'just' the nvme subsystem. Most notably
it requires enablement from the OS side, and possibly modifications
in various areas (udev, systemd, dracut, etc).
All of which need to be tested.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


