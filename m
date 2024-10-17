Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7168D374B0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pltyOAUQckAhIe8nUsZ6Th3HCcyxy09hxK4sWcbQUTw=; b=IHjwDEzBzjxhWPNcjtXvsFSmEq
	wt3i2EMnzVdhvj3c9iTEp40wSK9Vfd+umT/48VnJuuPywlnECKpohnLpSc4HAFH5trGdGl9cWsWSP
	9bvtAc6YrbsRZgSRu9Y0Aj3sD42sw/xOI9htDeZvA3mPqoKOJA3PQvE4gLPXPn5O68DRtTtN2Z4q8
	cTS+xHMLOyAC9WvvdfT7vp44RQA+PtGmm3nL23CXqZsAbBpMEAJncDWkp3qzSv+e4u+wis2fsaqGg
	y5EyWt7RtMxv9E74uOlMzL3mCHKOpiyGEaUA0XMxAJpp38/bcE8SavSpeKQaA/EICYJME4s6EwR+m
	iVHZnCVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SoD-0000000FMo7-1Dc8;
	Thu, 17 Oct 2024 15:53:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SYr-0000000FJHL-0cW4
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 15:37:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 756BB1FD37;
	Thu, 17 Oct 2024 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729179431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pltyOAUQckAhIe8nUsZ6Th3HCcyxy09hxK4sWcbQUTw=;
	b=RK/+0iaA49C82UK7YQBzjXZD2X9UXKQbb81EYS2aIfRubCBTOTwwBWz07dF2fvQ9SSAVyW
	R5BFntVDcEiy0YaO71an5X1PpLCxzamSGCo4p6Qir4ocdV3b9npxw8hazbzmvJxfPZ3Quk
	tTToXnL9BQUo5i09BbuP1I8+SR9/yck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729179431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pltyOAUQckAhIe8nUsZ6Th3HCcyxy09hxK4sWcbQUTw=;
	b=a8vSupnGf/W4GuM72SkVN2YIibEKFFW76rvtYkr2FnG6vCLjwKn2SfBQqKxNWghhvs0cGJ
	5jehVZIlgE0JBIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729179431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pltyOAUQckAhIe8nUsZ6Th3HCcyxy09hxK4sWcbQUTw=;
	b=RK/+0iaA49C82UK7YQBzjXZD2X9UXKQbb81EYS2aIfRubCBTOTwwBWz07dF2fvQ9SSAVyW
	R5BFntVDcEiy0YaO71an5X1PpLCxzamSGCo4p6Qir4ocdV3b9npxw8hazbzmvJxfPZ3Quk
	tTToXnL9BQUo5i09BbuP1I8+SR9/yck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729179431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pltyOAUQckAhIe8nUsZ6Th3HCcyxy09hxK4sWcbQUTw=;
	b=a8vSupnGf/W4GuM72SkVN2YIibEKFFW76rvtYkr2FnG6vCLjwKn2SfBQqKxNWghhvs0cGJ
	5jehVZIlgE0JBIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E2D013A53;
	Thu, 17 Oct 2024 15:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /L1kFScvEWc1PAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 17 Oct 2024 15:37:11 +0000
Message-ID: <76be15f2-d537-4337-bba9-d4c55fc1bcc4@suse.de>
Date: Thu, 17 Oct 2024 17:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] nvme-tcp: request secure channel concatenation
To: Mark O'Donovan <shiftee@posteo.net>, linux-nvme@lists.infradead.org
References: <59e426f4069a3326353a22193be3740e041c4303.camel@posteo.net>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <59e426f4069a3326353a22193be3740e041c4303.camel@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_083713_482488_562651E7 
X-CRM114-Status: UNSURE (   7.34  )
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

On 10/16/24 00:30, Mark O'Donovan wrote:
>> +	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, ctrl-
>>> opts->host->nqn,
>> +				       ctrl->opts->subsysnqn, chap-
>>> hash_id,
>> +				       tls_psk, psk_len, digest);
>> +	if (IS_ERR(tls_key)) {
>> +		ret = PTR_ERR(tls_key);
>> +		dev_warn(ctrl->device,
>> +			 "%s: qid %d failed to insert generated key,
>> error %d\n",
>> +			 __func__, chap->qid, ret);
>> +		tls_key = NULL;
>> +		kfree_sensitive(tls_psk);
>> +	}
> 
> Should tls_psk be freed in the successful case also?
> 
> That is what happens in a similar situation in integrity_load_x509()

You are correct; tls_psk needs to be freed in all cases.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

