Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED283C04A6A
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bs8GFqJdLR6YpYEb/PQpUFtoXE+F2xMFCO/25AMcKi4=; b=GNKAci2SEV5PkK1HEomlR2GjJu
	PVDaaW/az+Mp9oHYnrAqHxIqSkrB75Rs7l0hd+yW5n1zbPfK87I5CbW1Tl/7CpIQDYMYPY7TXye/L
	RW7uvDwKUwLDVQX5Fe67EluypTki8XiKBWT170zVDzCVAkqmkEDcOpJK/suiwzWYZtLcTYkfRFvYt
	b62DJAUOXiMJdecWqOPNOGCOTm8q5yt43z4hh2V1EFrEVgDxfBR9WjNjT0dKhQB/lImUKagakUtd7
	n6/d8ghGQ0ivGvfVDXg9+Ca9+kY5JKjPb2r/sr7Hsb18lu5MAuB6HoUewYg1rP1n85egsF4DQhJ/v
	AHmP47Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNpiU-00346Q-2I;
	Mon, 24 Jul 2023 07:10:50 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNpiR-00344E-2c
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 07:10:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9AD20534;
	Mon, 24 Jul 2023 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690182643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bs8GFqJdLR6YpYEb/PQpUFtoXE+F2xMFCO/25AMcKi4=;
	b=fBa9aV8+gRtjHML/OsSesIUP51mYQFhkYM/7fgqPo5h43uo7T5Akhavq8I0fiBZSrIDmHU
	x2L/4XxXEVCYQl6+x0lqRABaixaogDDqdgl2UNSGsyvx9hQuDydXAC/18jBj8KwsBIFKJs
	o+DVXYOrCVlwHbTEx/JPbw0uxVq62KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690182643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bs8GFqJdLR6YpYEb/PQpUFtoXE+F2xMFCO/25AMcKi4=;
	b=oWujHEFreCiu7vRYWv50U9iY0dW6CLto56R8LC7N39+g4VB41cwOT+oD0Lu9NaCZzKVPuf
	X//7dRdS+blS44AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1065413476;
	Mon, 24 Jul 2023 07:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id R36cAvMjvmQMWQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 24 Jul 2023 07:10:43 +0000
Message-ID: <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
Date: Mon, 24 Jul 2023 09:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230721190026.25d2f0a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_001048_019570_A2BBDE65 
X-CRM114-Status: GOOD (  13.43  )
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

On 7/22/23 04:00, Jakub Kicinski wrote:
> On Fri, 21 Jul 2023 16:35:17 +0200 Hannes Reinecke wrote:
>> here are some small fixes to get NVMe-over-TLS up and running.
>> The first set are just minor modifications to have MSG_EOR handled
>> for TLS, but the second set implements the ->read_sock() callback for tls_sw
>> which I guess could do with some reviews.
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> Sagi, I _think_ a stable branch with this should be doable,
> would you like one, or no rush?

I guess a stable branch would not be too bad; I've got another
set of patches for the NVMe side, too.
Sagi?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


