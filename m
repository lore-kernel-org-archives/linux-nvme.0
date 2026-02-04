Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07791E8B386
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BN+nd2sukPj4ejAn84TBHhk2uc/tPxCtdCFrVp1KgMQ=; b=IrjNXbrMOQYtDpbFFXSv24vS6Q
	2sTtgGJ/RvYajn8lsu/0KrTvasK1PvwGgAh50O4DITU4PISI25+N61Knfb3OmtRF1hEmFN/IRi1w2
	nbJmcKn/ncXKhQH6Ymi4y5h7ZmCAQls+eED+pBwq6jtHYf9kCsi4SQ9Km0Jcqz6YckB71vhb7dOVL
	Mbv4uHajppgFvwBJPkithvjJh4M+e7ZvMq0FfTln59CnTZr6BU8FCrPG7sG3dLuCltBYhk+Gii3rc
	hpA0bZmorYKtlpE5lu/U6fufaarPwdT26cmCqvSV9wtN6A6Q5r5Uw+v3NEI5uHzoGIa/RivA3mgsh
	jneyryAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRQE-00000007fZZ-3NSX;
	Wed, 04 Feb 2026 01:11:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRQ7-00000007fYZ-16H2
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 01:11:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25A9C5BCC6;
	Wed,  4 Feb 2026 01:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770167461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN+nd2sukPj4ejAn84TBHhk2uc/tPxCtdCFrVp1KgMQ=;
	b=SZOdm9yPQ3LA4Cl5n0XN+Zmqhi0piGegfzQZJ4v8h9Th0r2EN3tkIFn4csv0tiRvOddgG/
	e0oCgZAQYJMgFysy3OwgC15Iq2slmD8sKcuFDDBFYff61t8CbUk91zS2hnA1X6C5g2W2bY
	4QTe8J6OyNtOqGPTDXSPwVsuwd+hIHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770167461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN+nd2sukPj4ejAn84TBHhk2uc/tPxCtdCFrVp1KgMQ=;
	b=4CrIHP5X/SKpMFjXMFb2zgZXE5cjCoNM50Eo+lrgLlibZwBl2+nCK0RCSxadXkcFj4uOxI
	PZyqTR3smQ9kDNCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770167460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN+nd2sukPj4ejAn84TBHhk2uc/tPxCtdCFrVp1KgMQ=;
	b=KmlWaGj5oozLR0S/LmT/4qTqici50iduPDGx5lhgnzKiT7IDogjccAjQfH3kajlvy8Ua8l
	dC9p+yuCudhYqalvlMNXNStIenOIpYakgddfGiIjwmH9iqYDWdZxwiW765gl9/Pbr5E2pq
	Igd+oknrpXo1kw0k8u65r+olyg282Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770167460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN+nd2sukPj4ejAn84TBHhk2uc/tPxCtdCFrVp1KgMQ=;
	b=Nxy78gIfiUgP6rsk5HY2Rr6o04mGIPb7s6dqU5dqUcHs8nfU8kkxpJXsnsmmtxK8IdyvR6
	StE/jI0msNiDCsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CF153EA63;
	Wed,  4 Feb 2026 01:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GQTmD5+cgmn3bQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:10:55 +0000
Message-ID: <481562cd-0444-49db-8755-29436bec02de@suse.de>
Date: Wed, 4 Feb 2026 02:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
 <20260203200048.GE3729-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260203200048.GE3729-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_171103_457390_3E7E06DF 
X-CRM114-Status: GOOD (  21.66  )
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

On 2/3/26 21:00, Mohamed Khalfella wrote:
> On Tue 2026-02-03 06:19:51 +0100, Hannes Reinecke wrote:
>> On 1/30/26 23:34, Mohamed Khalfella wrote:
[ .. ]
>>> +	timeout = nvme_fence_timeout_ms(ictrl);
>>> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
>>> +
>>> +	now = jiffies;
>>> +	deadline = now + msecs_to_jiffies(timeout);
>>> +	while (time_before(now, deadline)) {
>>> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
>>> +		if (!sctrl) {
>>> +			/* CCR failed, switch to time-based recovery */
>>> +			return deadline - now;
>>> +		}
>>> +
>>> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
>>> +		if (!ret) {
>>> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
>>> +				 dev_name(sctrl->device));
>>> +			nvme_put_ctrl_ccr(sctrl);
>>> +			return 0;
>>> +		}
>>> +
>>> +		/* CCR failed, try another path */
>>> +		min_cntlid = sctrl->cntlid + 1;
>>> +		nvme_put_ctrl_ccr(sctrl);
>>> +		now = jiffies;
>>> +	}
>>
>> That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()'
>> returns an error. _And_ if the CCR itself runs into a timeout we would
>> never have tried another path (which could have succeeded).
> 
> True. We can do one thing at a time in CCR time budget. Either wait for
> CCR to succeed or give up early and try another path. It is a trade off.
> 
Yes. But I guess my point here is that we should differentiate between
'CCR failed to be sent' and 'CCR completed with error'.
The logic above treats both the same.

>>
>> I'd rather rework this loop to open-code 'issue_and_wait()' in the loop,
>> and only switch to the next controller if the submission of CCR failed.
>> Once that is done we can 'just' wait for completion, as a failure there
>> will be after KATO timeout anyway and any subsequent CCR would be pointless.
> 
> If I understood this correctly then we will stick with the first sctrl
> that accepts the CCR command. We wait for CCR to complete and give up on
> fencing ictrl if CCR operation fails or times out. Did I get this correctly?
> 
Yes.
If a CCR could be send but the controller failed to process it something
very odd is ongoing, and it's extremely questionable whether a CCR to
another controller would be succeeding. That's why I would switch to the
next available controller if we could not _send_ the CCR, but would
rather wait for KATO if CCR processing returned an error.

But the main point is that CCR is a way to _shorten_ the interval
(until KATO timeout) until we can start retrying commands.
If the controller ran into an error during CCR processing chances
are that quite some time has elapsed already, and we might as well
wait for KATO instead of retrying with yet another CCR.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

