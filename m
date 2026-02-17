Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4498E8385B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zptlUhDUhQ/ClynPqe9MRdFUVPTk77XaWJ7L6G/r//Q=; b=4/SRnerOaypqo6vfowiY6r4unq
	ibMohVq18MykVCYFk56DkldtXFyXNX9slwGACKBwJk7vthZA9D4yFm4NhXQnwa94cQbBQcy24E7af
	ZfgpU/+7jEzlrXKH7o0G6hQ5qSEQwI5GaHhlnsnUhQPxRL8MwgFg/41gTrj+kwpK9rjPim/10OYNs
	0URja+QT5F4ssyzed56pq6aFG98e6uwIRW7qWqGjl8A/P1OdGdJq5PiE9z9RAhoPrZGybZtb8hbQN
	nrMKO3arzt2feESfX1ZB81mt99JKNxQrYwcntPUeqP9v5TP1hyqVvKHimEHQ3WAGRx9qvSYC+QSrj
	0BOE64Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsFDM-00000007jyo-1Ugk;
	Tue, 17 Feb 2026 07:09:44 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsFDJ-00000007jyU-0AMy
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 07:09:42 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3897B5BCD9;
	Tue, 17 Feb 2026 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771312179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptlUhDUhQ/ClynPqe9MRdFUVPTk77XaWJ7L6G/r//Q=;
	b=qDwu5gOa35Tr9DoTpHppktq+Lq6y6Noqcc7zeJ8cr8fJw4+s/p0N71lFOHA85sTDq3cV6K
	DNafHZ7d3qZvAt6GblgG3aDPkuZjP7fPdfK3FmhW+9WTK9wcmxLQFVinpPESeJ8l2hi2B4
	mvJpD4MlSDu2C6tHkfx6coT0J11D6jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771312179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptlUhDUhQ/ClynPqe9MRdFUVPTk77XaWJ7L6G/r//Q=;
	b=Bs0XkhcqzTMKzLKtfS+W2tRlqjoeeoTr+0wiATm4XxisAFv7hHioOCTba0YA35q+S6Aj+3
	EZF6LJf/m6+57rCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771312179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptlUhDUhQ/ClynPqe9MRdFUVPTk77XaWJ7L6G/r//Q=;
	b=qDwu5gOa35Tr9DoTpHppktq+Lq6y6Noqcc7zeJ8cr8fJw4+s/p0N71lFOHA85sTDq3cV6K
	DNafHZ7d3qZvAt6GblgG3aDPkuZjP7fPdfK3FmhW+9WTK9wcmxLQFVinpPESeJ8l2hi2B4
	mvJpD4MlSDu2C6tHkfx6coT0J11D6jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771312179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zptlUhDUhQ/ClynPqe9MRdFUVPTk77XaWJ7L6G/r//Q=;
	b=Bs0XkhcqzTMKzLKtfS+W2tRlqjoeeoTr+0wiATm4XxisAFv7hHioOCTba0YA35q+S6Aj+3
	EZF6LJf/m6+57rCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3218E3EA65;
	Tue, 17 Feb 2026 07:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nQQ7CjAUlGnzCgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Feb 2026 07:09:36 +0000
Message-ID: <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
Date: Tue, 17 Feb 2026 08:09:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Aaron Dailey
 <adailey@purestorage.com>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260216184515.GH2392949-mkhalfella@purestorage.com>
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
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_230941_254155_008700FB 
X-CRM114-Status: GOOD (  18.25  )
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

On 2/16/26 19:45, Mohamed Khalfella wrote:
> On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
>> On 2/14/26 05:25, Mohamed Khalfella wrote:
>>> TP8028 Rapid Path Failure Recovery does not define how much time the
>>> host should wait for CCR operation to complete. It is reasonable to
>>> assume that CCR operation can take up to ctrl->cqt. Update wait time for
>>> CCR operation to be max(ctrl->cqt, ctrl->kato).
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/core.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 0680d05900c1..ff479c0263ab 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
>>>    	if (result & 0x01) /* Immediate Reset Successful */
>>>    		goto out;
>>>    
>>> -	tmo = secs_to_jiffies(ictrl->kato);
>>> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
>>>    	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
>>>    		ret = -ETIMEDOUT;
>>>    		goto out;
>>
>> That is not my understanding. I was under the impression that CQT is the
>> _additional_ time a controller requires to clear out outstanding
>> commands once it detected a loss of communication (ie _after_ KATO).
>> Which would mean we have to wait for up to
>> (ctrl->kato * 1000) + ctrl->cqt.
> 
> At this point the source controller knows about communication loss. We
> do not need kato wait. In theory we should just wait for CQT.
> max(cqt, kato) is a conservative guess I made.
> 
Not quite. The source controller (on the host!) knows about the
communication loss. But the target might not, as the keep-alive
command might have arrived at the target _just_ before KATO
triggered on the host. So the target is still good, and will
be waiting for _another_ KATO interval before declaring
a loss of communication.
And only then will the CQT period start at the target.

Randy, please correct me if I'm wrong ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

