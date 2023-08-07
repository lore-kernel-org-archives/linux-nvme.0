Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCBEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5bNiFKSI+NLCPSzlmcX1dWMO09vqsjtBdwUssAmxsyU=; b=UJLh9x1cqRPp2md4Ubpd7pps/4
	/7iy/SUjfEiagMyoDjrKctHRgFdbSU+BfXDPYVIfUI846SeFZaliEJj67+IzNkGcZ5LqJwjujP/ye
	IRjgsDXzAp7i1gJ3v6SuLkO+WMsbRplQYu+3xLu06kB7YG2ywWdsvF6K4za5pxWSMfzrRY6nvnQGp
	2WiSKHzuaiNm2FWuy6VlZkqOsULlECwTdY1SGqVV8QGL/D1Q8fYKp/zl7Tso3ilAUsAqa857mkkDD
	gZgJ26wSAZ6uMEAdndpZWnHidNQdfhdbd83Hz+WiLlIenHwNTDLCtDgKFuoE0AMzIVPTqFOLQezjx
	ZA8V9o1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSwMv-00GXwk-05;
	Mon, 07 Aug 2023 09:17:41 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSwMs-00GXw8-0z
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 09:17:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13A561F460;
	Mon,  7 Aug 2023 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691399857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bNiFKSI+NLCPSzlmcX1dWMO09vqsjtBdwUssAmxsyU=;
	b=Vg7WCpmbwqZQIN+h7PeZeva81FRqjLVBGdwEkCQRoLCASAXz6G/AQ0qAQBacIHrVHaVTpV
	i1iOc1UUsTHgY8cYXZXKHB+l92Aqf1Cl9DD5vCFDbIZXZ5sUymebzdSKu5L9eWn5KIZddg
	LY4mOySTN1dRhtLy/4+O/aBd0PkHZwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691399857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bNiFKSI+NLCPSzlmcX1dWMO09vqsjtBdwUssAmxsyU=;
	b=JjAIZmxml+/prFPeb14kfYc7ZWLX8qA06P7iNUJFzHVqaGhvsqralKwIHSALSKoH0wnQRK
	+vdCTQzV5YiwxmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1A7D13910;
	Mon,  7 Aug 2023 09:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lHTjLLC20GQ8HQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 07 Aug 2023 09:17:36 +0000
Message-ID: <4e14f8b3-27ac-4afa-91e9-8ccb41a8b89b@suse.de>
Date: Mon, 7 Aug 2023 11:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
 <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
 <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_021738_500968_D5AB74C4 
X-CRM114-Status: GOOD (  11.56  )
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

On 8/7/23 10:53, Sagi Grimberg wrote:
> 
>>>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>           struct socket *newsock)
>>>
>>> Why does the function change from retcode to void in this patch?
>>
>> Because the return code was never evaluated.
> 
> ??
> 
> I see it is evaluated.

Yes, but this patch moved the 'sock_release()' call into 
nvmet_tcp_alloc_queue(), making the return code obsolete.

But I can make it a separate patch if required.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


