Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E2C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHGtN+NDT7qEVbB4Du1rBX4rQS0jrXiWfCvKAMIyooY=; b=LSgWt7GAxvnEoKpa5LApQ7c03N
	6Vca2KhfVxUon9EQi9np2oAVTcAl9njvrKLI9T0dBBHMKmnQJJJ/CcG/TQ1Ymiq42K7aNuTTERGLD
	KzstQ9dBfv8E/+MVTQ3xBRdhy2HstksW2fGDYhGWbwvfsT8iaViZ7HYL5xu+/Saf6y3DuqUxMpnjk
	5uz7T2WHnTtqX91pnF65AdM2ymrM3I2vWCUh6bqAp07bsR0zsrs28SNuPjEyBZswaNwkl0/cfc+vz
	JhSHyY1hR9DO7itp9PRRI53jl9+o1NGJa7FVi+6bsOPyVzsgoiMA896EnBpkiU0HzFvqGOEd4Dh6Y
	7GHvjcGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z7i-00000001JGH-3JWt;
	Mon, 21 Sep 2026 08:11:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z7h-00000001JFZ-0zJU
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:11:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27CE821B46;
	Mon, 21 Sep 2026 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHGtN+NDT7qEVbB4Du1rBX4rQS0jrXiWfCvKAMIyooY=;
	b=PkkUDnyPZHMdW/gRDQ7BBGLwikYey+dEyS6Lp7BRiPrx3Rp/Av+5lfPi/vCJo1n50JIZvN
	+0sARiaLjBJswTuldhXlppOtj6EK6AJMpXTh0VQIQydVMkiuwoujVl/lINfwh/FqmTbZQz
	VZx/jdhjCourjnjS0NkNrGsbQgU8PeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHGtN+NDT7qEVbB4Du1rBX4rQS0jrXiWfCvKAMIyooY=;
	b=PAEpvjOA4hw6qF9UdHbEsKHWBGarWChAPaKXqnsH2OuIs3Ih9G6Go3v794qgBhwngI4Twr
	XvH0Kw0r0L6+3oCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHGtN+NDT7qEVbB4Du1rBX4rQS0jrXiWfCvKAMIyooY=;
	b=uVqm58usbB7/B0oCgnhakdGnX17h4nB0NM583/70T2MnLaYpi/26fd1BfRD5B1Uq6aPXk2
	5IchZZBwBhFY6L26kwbtBiXd7gyOTeH/Ja53mopkahvwEMNXGXmteBDhTj/Ubv6incKSmv
	PqVkR4wT6jf0WZWGqbwYzTwuNuqa4cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHGtN+NDT7qEVbB4Du1rBX4rQS0jrXiWfCvKAMIyooY=;
	b=NuSGlHtsKgiBrXl/1ieV81WSUVdC/7RAWSVh7PEmako29hh5+6OMG1MGg7LvhyOTzzbYL3
	t5HYCpFhpO1hO9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8893B1368D;
	Mon, 21 Sep 2026 08:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FY4IGK7msGqKHwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 08:11:26 +0000
Message-ID: <f7854f34-70af-476c-affc-c7e36d1352a5@suse.de>
Date: Mon, 21 Sep 2026 10:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] nvme-fc: Use CCR to recover controller that hits an
 error
From: Hannes Reinecke <hare@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
 <20260918181614.3947933-15-mkhalfella@purestorage.com>
 <6a2fddc2-0a32-4dc2-9642-efebe6934633@suse.de>
Content-Language: en-US
In-Reply-To: <6a2fddc2-0a32-4dc2-9642-efebe6934633@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_011137_443100_36A3228D 
X-CRM114-Status: GOOD (  11.68  )
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

On 9/21/26 10:07 AM, Hannes Reinecke wrote:
> On 9/18/26 8:14 PM, Mohamed Khalfella wrote:
>> An alive nvme controller that hits an error now will move to FENCING
>> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
>> terminate inflight IOs. Regardless of the success or failure of CCR
>> operation the controller is transitioned to RESETTING state to continue
>> error recovery process.
>>
>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>> ---
>>   drivers/nvme/host/fc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
[ .. ]
> 
> I would merge it with the previous patch as both are required to get FC
> error handling working properly.

Oh, just checked the remaining patches.
It's indeed better to keep this patch separate.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

