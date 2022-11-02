Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99DEC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14SXcubzPId8C4KpXvrlFcNilDP+3aKZEgYc6P0vMgY=; b=UoXqbLMEGgcaofJzEb4Ek8e0F0
	T9ApJalf8cQZVCXZZxeTHsXuUPIfu2iu27j4eAADNll4BZJ+ZAmBH5Eu7RqF86ceUpE2d8MxHIwSd
	DAlozQ79H7Hn6WbuMfZsPckwaR+WzLwUXrkJlKsYo9QuAWiR7qscBfmD8ipCm1DilfnSqqaIk0UwF
	z9PU614+m44gYusLhRjL3cV5nb82o2AL5zTsxNr9/84XYKPtR1A4C05WcMC414m39FukefRn3lhAC
	Vkfk4zsLyvHYFKKnvOuyyzwUAOgjRvquL+r6bL1zp5rwNuRt+2UYMKpXNsDZZsZXT647Ex7nKByhu
	k22l7AbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9IG-0094d0-D2; Wed, 02 Nov 2022 08:40:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq9ID-0094ag-DT
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 08:40:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC0DF1F898;
	Wed,  2 Nov 2022 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667378411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14SXcubzPId8C4KpXvrlFcNilDP+3aKZEgYc6P0vMgY=;
	b=y5umlmeYQnhqViallNrBgUAFnZvvJqeoOGoVlTf5TSSQCFIsI+LE4FcF2VyYr8jpb5lhx9
	Y+rQvGcIL44q0Tsh3A8pk8Xx0w6K5HRXY49/G3TfS97Ca8gAOdsO4pNjR3Ir2b+polBqLv
	Hdf9jXUj/Trj7soYOJ+1YvntSeB58VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667378411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14SXcubzPId8C4KpXvrlFcNilDP+3aKZEgYc6P0vMgY=;
	b=k1x6oSjUU90syrYmYMnSLo88R70uRHtu0svEJnV/lT6GGPeVXMKq5dRbxJIa+dVVU6DTOi
	1OiJOfNeeJB8sNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9F4E139D3;
	Wed,  2 Nov 2022 08:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MzKVMOssYmNbEQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 02 Nov 2022 08:40:11 +0000
Message-ID: <7e7610c0-b301-39ea-109d-707771a74d08@suse.de>
Date: Wed, 2 Nov 2022 09:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-6-hare@suse.de> <20221102080220.GA10816@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/6] nvme-auth: set DNR bit on non-retryable errors
In-Reply-To: <20221102080220.GA10816@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_014013_626428_01BDA2CC 
X-CRM114-Status: GOOD (  14.85  )
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

On 11/2/22 09:02, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 08:52:23AM +0100, Hannes Reinecke wrote:
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index b4af8661c988..6ca0c2bb06c0 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -151,7 +151,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
>>   
>>   	if (chap->buf_size < size) {
>>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>> -		return NVME_SC_INVALID_FIELD;
>> +		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
> 
> Any use of NVME_SC_ for error purely in host software are bogus.  This
> should be using Linux error codes.

I knew you would be saying that.
I was worrying about retryable and non-retryable errors, but seeing that 
all errors are currently treated as non-retryable I'll be changing it to 
return error codes.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer


