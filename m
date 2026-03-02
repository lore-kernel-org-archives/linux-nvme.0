Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70792D58E78
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/crSZTAVBg/arRIbdVQG6JKM/WErK2SFKRsM4zSBTzw=; b=RCq2SmmW0gRsQxdUh9FNJyDrC+
	GSCELlqQnkZKRRZXcURpHF5lwKLOSRaBRJgRTd47n1uoC85AEhQYb4r51Vu5a/nXA1v9Ky9WGtzWh
	LsOtTK9REydBkzCgeCG8DFK8qS8gSb7mU49w6qN4AkNR2CDzqX2bJi81fVQpALodABak7Fw21UpP6
	MWiCB4oOz2mJTPc94YO2hHHIr8eys7IIz8CvPV1Zz7WYjRZXTTu4goHhrrHmJaJJ0iObE/4P7Xa2F
	01KRy3GjZLd/HeymiIshi5gd40K+AtGSzQgq6JuOHROg3TMEG/BjnYuXXwLvobG3qF6oZn013oxzh
	hVmMPd6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxm3-0000000CQ8o-0ZD0;
	Mon, 02 Mar 2026 07:33:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwxm0-0000000CQ84-22Ln
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 07:33:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4ACB63FA8D;
	Mon,  2 Mar 2026 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/crSZTAVBg/arRIbdVQG6JKM/WErK2SFKRsM4zSBTzw=;
	b=Bo/tKAY6kL5tHbabFnnVeW2AUu0nkX13woA22g7qMH2McrVZxHhI5iACqH2H15MnOf78Oq
	H/C5S5diPwfpJ2Hz/8f4vc0KJ3A+sf8S1O3mfZsysq9aLc+rzK3uqNygztA5tAvKL9EUjX
	QfpJJS6+WZgJF/UJ9cGIcTLVjF74cjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/crSZTAVBg/arRIbdVQG6JKM/WErK2SFKRsM4zSBTzw=;
	b=lI8nDd6ShX20TAXokx3vqCXOYVBASjsYKyUIrFT/E4tQ/N4HRA4zc6xUn/mbA2yqkuOeAe
	DdKFbER+6Nwq3ABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/crSZTAVBg/arRIbdVQG6JKM/WErK2SFKRsM4zSBTzw=;
	b=Bo/tKAY6kL5tHbabFnnVeW2AUu0nkX13woA22g7qMH2McrVZxHhI5iACqH2H15MnOf78Oq
	H/C5S5diPwfpJ2Hz/8f4vc0KJ3A+sf8S1O3mfZsysq9aLc+rzK3uqNygztA5tAvKL9EUjX
	QfpJJS6+WZgJF/UJ9cGIcTLVjF74cjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/crSZTAVBg/arRIbdVQG6JKM/WErK2SFKRsM4zSBTzw=;
	b=lI8nDd6ShX20TAXokx3vqCXOYVBASjsYKyUIrFT/E4tQ/N4HRA4zc6xUn/mbA2yqkuOeAe
	DdKFbER+6Nwq3ABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1B893EA69;
	Mon,  2 Mar 2026 07:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ennWNSk9pWk4eAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:32:57 +0000
Message-ID: <1e3ba326-11fc-4b40-a7fc-f69c7025c920@suse.de>
Date: Mon, 2 Mar 2026 08:32:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Randy Jennings <randyj@purestorage.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Aaron Dailey
 <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
 <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com>
 <CAPpK+O35BBLnQOuPg37v772g7LtOpo6onxENRObUi7C_xLCoPQ@mail.gmail.com>
 <5dd3f2a9-5b8c-4604-a84d-46532b1802fc@suse.de>
 <CAPpK+O1u2JBpiee+Be3ROT4uSPKuXbJKHrZxBmP2c8xrDWmJdA@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAPpK+O1u2JBpiee+Be3ROT4uSPKuXbJKHrZxBmP2c8xrDWmJdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_233300_675021_9169AC1C 
X-CRM114-Status: GOOD (  15.92  )
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

On 2/27/26 04:05, Randy Jennings wrote:
> On Thu, Feb 19, 2026 at 11:25 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> On 2/20/26 03:01, Randy Jennings wrote:
>>> Hannes,
>>>
>>>> (ctrl->kato * 1000) + ctrl->cqt
>>> As Mohamed pointed out, we have already received a response from a CCR
>>> command.  The CCR, once accepted, communicates the death of the
>>> connection to the impacted controller and starts the cleanup tracked
>>> by CQT.  So, no need to wait for the impacted controller to figure out
>>> the connection is down.
>>>
>>> The max(cqt, kato) was just to give some wait time that should allow
>>> issuing a CCR again from a different controller (in case of losing
>>> communication with this one).  It certainly does not need to be longer
>>> than cqt (and it should be no longer than the remaining duration of
>>> time-based retry; that should get addressed at some point).  I cannot
>>> remember why kato (if larger; I expect it would be smaller) made sense
>>> at the time.
>>>
>> Because we have to wait for the AEN, at which point KATO comes into
>> play yet again.
>> So max(CQT, KATO) is the appropriate waiting time for that.
> I see your point.  It could take ~KATO time for the AEN to show up after
> the CCR operation finishes.  Technically true.  However, if responses
> are taking KATO time to get back to the host, I think would rather retry
> on a more healthy link.
> 
Sure. But currently we don't have a policy for this; for us the
AEN is just a normal completion, for which we have to wait until
the KATO interval is exhausted.

We really should have a session or BOF about CCR handling at LSF.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

