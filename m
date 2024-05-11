Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0E5C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fg/9NzJ9JZq7UAGY1dWL+Wpq5rYtsuJf+b8ABIg5lb8=; b=XloLM1rWkM5lYUa+jMdpVSdkfa
	MsdnhewZyEWFHVLW+AeO2M8e6KTeEqrNOYiJQ0GRdvPLiSLqpNOQQxe5SlAVndfPnydU90yvCjbfU
	pAC883TuBrol4gSa+csYLGDT16JR/kuGBmqd5ew6f+kmKv22hqrJp+/gcG7d+oXFfgtYHsu3xITRo
	ans8bF4LBPYFvE5AHx1IJk6hRyUmocJWYsF+nvWkvGrexf3mZjunuHJVtiqG1aDgZtpY/1UjcwSYu
	my4Zyg20g3JKipfnjHcPNt0jTPyAWXOSWI52rcvXpCKmbzR4L/wAzVf70hVyJrynXalaFLyoyr1ns
	ppVXdg6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5ipn-00000007be4-2aIn;
	Sat, 11 May 2024 09:16:03 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5ipi-00000007bch-3Auy
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 09:16:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90CF933F80;
	Sat, 11 May 2024 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg/9NzJ9JZq7UAGY1dWL+Wpq5rYtsuJf+b8ABIg5lb8=;
	b=qnFK2wtcUWXtlQERoCldRWOnpH38Un5cpx7L7tBDYGxH08RDOkdoJcAW5+89Bl0Zcca5Fu
	w26mRf/3aTbayG3SjUw/QJ7KjFKbsMZhndAeUx+SLY7wHhlRXTHc9MmBdaHReCOr6iTWh/
	/NUiXsj4z77WTE9R+gpEEkeWnFS76zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg/9NzJ9JZq7UAGY1dWL+Wpq5rYtsuJf+b8ABIg5lb8=;
	b=18iUeZQOVcnoDOir5v8H/thnXm9DtiP1Dg/QFNM5/4wEZefB7z4h1leig533lHgeMmgNuQ
	4TxTLJh9rSiEVaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715418955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg/9NzJ9JZq7UAGY1dWL+Wpq5rYtsuJf+b8ABIg5lb8=;
	b=qnFK2wtcUWXtlQERoCldRWOnpH38Un5cpx7L7tBDYGxH08RDOkdoJcAW5+89Bl0Zcca5Fu
	w26mRf/3aTbayG3SjUw/QJ7KjFKbsMZhndAeUx+SLY7wHhlRXTHc9MmBdaHReCOr6iTWh/
	/NUiXsj4z77WTE9R+gpEEkeWnFS76zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715418955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg/9NzJ9JZq7UAGY1dWL+Wpq5rYtsuJf+b8ABIg5lb8=;
	b=18iUeZQOVcnoDOir5v8H/thnXm9DtiP1Dg/QFNM5/4wEZefB7z4h1leig533lHgeMmgNuQ
	4TxTLJh9rSiEVaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3421F13A3E;
	Sat, 11 May 2024 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xzKOCUs3P2bVJwAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 11 May 2024 09:15:55 +0000
Message-ID: <985265c8-c8cb-40cb-bec3-8b808bdf4d3b@suse.de>
Date: Sat, 11 May 2024 11:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
 <Zj6e95dncIn-Zrlh@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zj6e95dncIn-Zrlh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_021558_984568_6370481D 
X-CRM114-Status: GOOD (  10.62  )
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

On 5/11/24 00:25, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:04PM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> We now can support blocksizes larger than PAGE_SIZE, so lift
>> the restriction.
> 
> Do we need to make this conditional on a CONFIG option?  Not all
> architectures support THP yet ... which means they don't support
> large folios.  We should fix that, but it is well below the cutoff line
> on my todo list.

Well. We will only ever trigger this if we _really_ encounter a block 
device with a block size larger than PAGE_SIZE.
If which there currently are none (note to self: check NFS).

And the overall idea is that the logical blocksize is mandatory, ie the 
device _cannot_ handle requests with shorter blocksizes.
We might be setting min_order == max_order, but again this can be 
discussed once we get min_order working :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


