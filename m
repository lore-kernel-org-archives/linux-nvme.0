Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869C8C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Nov 2022 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FD7txudoz12QtRVx1Hli1LxKdkbbIlwENYKuu0vrgk=; b=vQaqqafjhSMbAG14AEaH/WDMjw
	7rTnwClWb6VxX3PHtM8rK5JxvppWHWJTCOTiU00q6MZ7wSGeykX9iIcPAS2PoyBimeGgA1QkiRxVb
	V1plNFq+UGU4lDou//HeTwkoDetvSP0+hlLZMjmJHdYfUbqKG+MHx+hZTQ1WdYIB9+tXVe/3Rlig7
	S7Q2KHvb3T2lmefpm8dSO0FagmlZIwBzNC3VzsuPGNAEaqjZzFx+3b9iIOP7+flqBEWuTcCD7osJY
	VPDdpQv8nl7zh8xUuGgqRSghp8pXhow3PR575pK7bH3qwTWOK+CWBmxZjnfpShL8DizJlCMWmpBTm
	m0PLA1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqe1-002g25-4s; Fri, 04 Nov 2022 06:57:37 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqqdw-002g04-Pw
	for linux-nvme@lists.infradead.org; Fri, 04 Nov 2022 06:57:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5574B1F45F;
	Fri,  4 Nov 2022 06:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667545050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FD7txudoz12QtRVx1Hli1LxKdkbbIlwENYKuu0vrgk=;
	b=iNgYKZNsL/VFSSiYDdMuAiEy4Ob80AeRBJYkKnpHW+lMsYsQ7K1ciExOHW3usR7hczLEBL
	MZ69jXrETGo2M8nHW+6sSo7q0hnWc5IBbxl9A8BYkwgJO1xAA+0FIpnS0CYHo+OhrnvwMJ
	7ZMow08VRsjNRQKLLdBTTxK9mTzN3D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667545050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FD7txudoz12QtRVx1Hli1LxKdkbbIlwENYKuu0vrgk=;
	b=RN2yP+Q8gYMubP+u3Vxs22mRJ/8gqc7/bDGAb4UDjBVfe9+HaCjg/HJC7YexDJQjqh2w7D
	VcRvzOAvRJuSSOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CD101346F;
	Fri,  4 Nov 2022 06:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fMH5BNq3ZGMPNAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 04 Nov 2022 06:57:30 +0000
Message-ID: <0356b235-da07-9274-170a-3a934c9b7eaa@suse.de>
Date: Fri, 4 Nov 2022 07:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/6] nvme-auth: use xarray instead of linked list
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-4-hare@suse.de>
 <c87192c9-24b6-e6fa-8912-46c812a14d47@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c87192c9-24b6-e6fa-8912-46c812a14d47@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_235733_030971_E738A907 
X-CRM114-Status: GOOD (  13.94  )
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

On 11/3/22 22:20, Sagi Grimberg wrote:
> 
>> The current design of holding the chap context is slightly awkward,
>> as the context is allocated on demand, and we have to lock the list
>> when looking up contexts as we wouldn't know if the context is
>> allocated.
>>
>> This patch moves the allocation out of the chap context before starting
>> authentication and stores it into an xarray. With that we can do
>> away with the list traversal and access the context directly
>> via the queue number.
> 
> Why not just allocate the chap contexts in auth_init() ??
> its always the number of queues and is mapped 1x1. It IS
> an array effectively.

As the dhchap structure is rather large I was worried about pointless 
memory allocations; quite some nvme-of arrays expose only a small number 
of queues (say: 8), causing the number of queues to be decreased after 
the initial connect call.
But if you're fine with it I can easily move it into auth_init(); that 
certainly will make the implementation simpler.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


