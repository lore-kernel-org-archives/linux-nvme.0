Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40142C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCc7c/ljwsGzkLdnCgYgoz9FhT85N0Q1geRQEXfp0Gk=; b=topBwyKY+b2ttPO/cWtFZckQIR
	c7OA+36A5+RR4XEoT4x2Jvsf/I9sNT9pCvOGtxgQzsZ7z1rVYF54ET+RSOEukqga0fo9epcCYDh83
	fMExEJv5uqrhTH1VOZEcE27BbXZs/0gkd55e5R3zvUuEj6nICS+jVrqWGQg8A/p3Cw9oBDzefWEPm
	g1nzqeLjPfjtTr4oT2K1gDwpcOkAEvMUeAeoJ6EToPpxT8sQmXXhp9ysOcWcOgsIxZLioxrPxnNY9
	3MUABkNp/Q8eF4LpFyZkjUog+e/7cqmLLXCLj7jfJ05mjEQbhEtYMW2uVyJw42wkZPD+uyU//ZJ3v
	QPQKpgVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqYh-002ebB-V0; Fri, 04 Nov 2022 06:52:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqWT-002diq-1b
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 06:49:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB57C2189B;
	Fri,  4 Nov 2022 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667544581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCc7c/ljwsGzkLdnCgYgoz9FhT85N0Q1geRQEXfp0Gk=;
	b=hMMAqHY9au0RUX8JDyM7zdlYd1BlYgv4oUeaHTsAG+CZpmym9+mrbipdu/eiXWcQUr2Tqv
	CCi1sXABealGaBRnm0qATakF6pyrwQvPUYGR0iTszkIIOFcE2pP2mK4OpvA0Ea86Y2H733
	FtvrBy8CTIdUXh5/FZxJhfU77TMxsQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667544581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCc7c/ljwsGzkLdnCgYgoz9FhT85N0Q1geRQEXfp0Gk=;
	b=p6x93OH5Y3WK/ZGF8L9b97on3WIGHbsfkms4QJI7PETOwtWFXgQHOBi+jphMiEfdIyziCX
	K7hPFnv6lKkZ+9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C02BC13216;
	Fri,  4 Nov 2022 06:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JU4bLgW2ZGO7MAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 04 Nov 2022 06:49:41 +0000
Message-ID: <a2f7ab14-4c1f-6f46-eed9-69345c42c61a@suse.de>
Date: Fri, 4 Nov 2022 07:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] nvme-auth: allocate authentication buffer only during
 transaction
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-2-hare@suse.de>
 <be22e517-50da-03a7-7504-1a592e04803c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <be22e517-50da-03a7-7504-1a592e04803c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_234949_382917_12725401 
X-CRM114-Status: GOOD (  15.67  )
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

On 11/3/22 21:01, Sagi Grimberg wrote:
> 
> 
> On 11/2/22 09:52, Hannes Reinecke wrote:
>> The authentication buffer is only used during the authentication
>> transaction, so no need to keep it around.
> 
> Patch is fine, but why do we need the chap context dynamically
> allocated? It is always the number of queues and never ever changes.
> 
I didn't want to clutter the main nvme structure with the chap stuff, so 
I kept it as a private definition in auth.c, and did a private allocation.

Also there is no 'queue' definition in the nvme structures; they live 
only within the transport definitions. The common nvme structures only 
know about controllers, and I don't have anything where I could hook the 
dhchap context into.

But the most crucial part here is that the number of queues are 
calculated after the initial 'connect' command (it's calculated during 
nvme_enable_ctrl()), so I would be prone to over-allocating the number 
of contexts.
If that's fine, though, I can easily simplify the code by allocating the 
dhchap contexts up front, and saving quite a bit of hassle with locking 
and stuff.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


