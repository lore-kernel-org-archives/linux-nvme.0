Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB08C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 06:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWtLl8i1rbPf13JE/6xoTLnWOhWNofxKSknjHfrEgxU=; b=UC0cI3sSlAI4W5eiUybbgFfCah
	BYmDVb7LQel43dhvUMi11dJu1Zu+SJDzIjr018dufbtpLXCBcM41a5FAJwOz6YQokyoQOsLoH9W7k
	4LNz3PngGAS//LmIkwO1aDOeirZ7iD2yBPCapErKWW0tv0z0ZQ7acSTZSa83pkkW1Xh9a3nLLzML1
	E/JOJeq36Q9yHiKBJ5DhLVQtf42ei52BHlqkIsqpGEfy+tHKkgG0DAkxdv0BSbST1+BUnVJrEePo+
	Cy31XC6C9Slmprh88VQ67uwEZpmvrWml4f7H+8I90rC4PIHwy//w7UJyo515c070FAMd5IsRt5ck0
	kMPKbwJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOBxU-006UWo-0k;
	Tue, 25 Jul 2023 06:55:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOBxO-006UVk-2t
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 06:55:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA2081F460;
	Tue, 25 Jul 2023 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690268141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWtLl8i1rbPf13JE/6xoTLnWOhWNofxKSknjHfrEgxU=;
	b=dO1SE3NEW+VJOAq8B7jbiygDGXXIU2Zlj3Ms5JSH0XPYcuTNyyYizuKKlqL1/cvM1KCKYl
	nFsUCylvx9XkAHJSLR9Y19xGEwy+Jy7aisva0f3Mqbf+3VxOr4ihIik38F2Jd4p2WCV2SD
	Eli4l8i0WlASYF0nXm1htpeN8Sk6M+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690268141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWtLl8i1rbPf13JE/6xoTLnWOhWNofxKSknjHfrEgxU=;
	b=elF174kLgi2YA1GJy699NE14euMwD1+jnbw6IYPpvh8IJoE8Yxi+PE3jUhjeIdfmtXMn+o
	Hn81AKb5UDMhXOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CC7913487;
	Tue, 25 Jul 2023 06:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id J4Z4He1xv2SRBQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Jul 2023 06:55:41 +0000
Message-ID: <6411e1e7-19a4-0cf4-8593-54b41c2adcbf@suse.de>
Date: Tue, 25 Jul 2023 08:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
 <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
 <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
 <20230724123546.70775e77@kernel.org>
 <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_235543_080468_84E821BE 
X-CRM114-Status: GOOD (  19.11  )
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

On 7/24/23 21:44, Sagi Grimberg wrote:
> 
>>>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>>>>
>>>>> Sagi, I _think_ a stable branch with this should be doable,
>>>>> would you like one, or no rush?
>>>>
>>>> I guess a stable branch would not be too bad; I've got another
>>>> set of patches for the NVMe side, too.
>>>> Sagi?
>>>
>>> I don't think there is a real need for this to go to stable, nothing
>>> is using it. Perhaps the MSG_EOR patches can go to stable in case
>>> there is some userspace code that wants to rely on it.
>>
>> I'm probably using the wrong word. I mean a branch based on -rc3 that's
>> not going to get rebased so the commits IDs match and we can both pull
>> it in. Not stable as in Greg KH.
> 
> Are you aiming this for 6.5 ? We are unlikely to get the nvme bits in
> this round. I also don't think there is a conflict so the nvme bits
> can go in for 6.6 and later the nvme tree will pull the tls updates.

I really would love to get this into 6.5, as then we can do a clean 
rebase of the NVMe development tree off 6.5, knowing that we won't have 
to touch the networking. Otherwise you have to be sure to fork the 6.6 
development branch off the right point.

But then I'm not doing the forking, so really all I care is that the 
networking bits are present in the 6.6 NVMe development branch ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


