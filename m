Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4044EC76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1hAdGF97iIefDKJjwUntUBVqSwoqYbzmfxgyIOj18oM=; b=0uWY9tA0itps9kus+b/YJixrsJ
	wYWINiXerlgnI4J8XyZkLcab+O8BiaKNFJGrCUjybzD2n4r2LXxytWn1JvG54icm/nRR1nfR5B17A
	2AHCh082kWlZsxbfdoYLvwoQzeW6ZXAfq5fBKbzRHicBoOrMwJ5u4E/6rW/2Y8MSufmPEIECV7yA6
	c6+n8ZjKROTAtEdC1QjhTRvAj+JKCtmHugEUsP4fVsyT/Jp9M8hvKFH3c2hAyvMAIFKKxz0VvXwLS
	8n/deE5h1x86QLDO5DHcXEMTvBgrAel876f8oqJh+ASj5HRz18RdYx5rJI3jeIz2rryq7VGhZm+JA
	dDswUocQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph6Bo-00DpqL-20;
	Tue, 28 Mar 2023 10:04:28 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph6Bl-00Dppi-1O
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 10:04:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFF761F854;
	Tue, 28 Mar 2023 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679997860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hAdGF97iIefDKJjwUntUBVqSwoqYbzmfxgyIOj18oM=;
	b=ilnxHT8PXyQAJ0nvssV0vKuCk6TIlU2D9pVliufpVhK5md5mjc71eFd6kIQLZSO+aCrD2t
	Jy5cSXHFX9oKo5fdgqSY/H/2ItGHg/KdfYuGKp5t9OFoA2KkQr3wkTH821J7XiFHVQ7e0g
	tQtInsHdrowvMlXf0c0Jex9hWzro5Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679997860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hAdGF97iIefDKJjwUntUBVqSwoqYbzmfxgyIOj18oM=;
	b=4KntcIRn3TV30MKiTKOsZ2ii2LJpxPy3wkOptDf7o4JmC441UTmDvNaOWk3YnWWSsHJ+uE
	p73Yx/tejPZd+DBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BACD1390D;
	Tue, 28 Mar 2023 10:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CPawJaS7ImR8XQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 28 Mar 2023 10:04:20 +0000
Message-ID: <7ef60c30-d318-4656-3102-020560343ee9@suse.de>
Date: Tue, 28 Mar 2023 12:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chuck Lever <cel@kernel.org>,
 "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
 <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
 <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
 <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
 <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
 <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
 <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
 <8fa65f04-7e82-77a6-00de-f51d20138ece@suse.de>
 <3962f9d9-2ee0-2065-827f-ca0cda881271@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3962f9d9-2ee0-2065-827f-ca0cda881271@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_030425_614668_01B219E2 
X-CRM114-Status: GOOD (  19.07  )
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

On 3/28/23 11:43, Sagi Grimberg wrote:
> 
>>>> But there might be the odd case where the data_ready
>>>> callback is invoked after kTLS has been started but before
>>>> we're setting it to nvmet_tcp_data_ready().
>>>
>>> What does nvmet_tcp_data_ready has to do with it?
>>> You are changing nvmet_tcp_listen_data_ready.
>>>
>> This is not a 'race;
>>>> Then we cannot guarantee that sk_user_data really is set
>>>> to the 'queue' pointer, so we should skip the function.
>>>
>>> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
>>> is nvme_tcp_listen_data_ready. Are you referring to the case
>>> where the callback has changed before the read lock ?
>>>
>> No. The callback is changed when the userspace daemon starts ktls, as
>> that will set sk->sk_data_ready to tls_data_ready().
>>
>> So before the userspace upcall we have the chain:
>>
>> sk_data_ready -> nvmet_tcp_listen_data_ready()
>>
>> and after a (successful) upcall we have the chain
>>
>> sk_data_ready -> tls_data_ready
>>    -> nvmet_tcp_listen_data_ready()
>>
>> once we set our callback we have
>>
>> sk_data_ready -> nvmet_tcp_data_ready
>>    -> tls_data_ready
>>      -> nvmet_tcp_listen_data_ready
>>
>> Calling into nvmet_tcp_listen_data_ready() is pointless here,
>> but we cannot remove the callback either. So we should to deactivate
>> it to avoid any side effects.
> 
> Thanks for the explanation.
> 
> First, I would like to understand how is this different from
> svc.
> 
> Second, we don't want nvmet_tcp_listen_data_ready keep being
> called from the datapath, especially as it is taking a read
> lock, for absolutly no good reason.
> 
> Why don't we restore the original socket callback before
> we trigger the handshake? then we wait for the handshake
> to complete, and then store nvmet_tcp_data_ready once it
> is done?

Yep, that works.

Will be updating the patch.

Cheers,

Hannes


