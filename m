Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35812C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5R/w3GJ8ow9f56R0PNbT0ogP0sGCCDZ4PjKVCPswv8E=; b=cX1aFic3/as1jm2Euk4W52LjdH
	wUCuoezo+JtMirezz2XZThaVbVfjFQMwXPmcwkHt9gI5JoHJlSiycL15ey+Dcx8aAOfSZoCG8LbWE
	0G/X/fLwCMRRf4Os7WO5eiUzfNiJs3ggHovYvhWrvINTzmPWmB8scV+OacSCX+ZSaH8qbHH8ro2Fs
	YqqwEh734vPSy2CWqY/JlD+WaZGxu5DrBJxFI/OMzkT6fe1LEapmTOhvkRnZJq6hz+GR9NtmYrTjR
	pjjR58LhlcB65R8ywV5nacyEuYL3Naooh/thM5rL1giSyNYQD5lzAZoeJaowIypAylifqYq+odTzM
	2EoLlwKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BK1-00GXdu-LY; Mon, 20 Jun 2022 06:55:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BJy-00GXcL-Ic
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:55:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C40F21BE3;
	Mon, 20 Jun 2022 06:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655708137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R/w3GJ8ow9f56R0PNbT0ogP0sGCCDZ4PjKVCPswv8E=;
	b=o1HXtjSYs5sFnYFMOEbN2wTqth2Z+OAoPfoCqm9/xJzzNCBmoz7Yq0aMRUiUXaB812bG5Z
	ul0HHbZbAQ4anud+tIctpcMr3rYNJWMePuDPObWzuEsPW/9LAlSIH351hRFcD79TXZ9R3z
	fy8Rrkeor49OHXRH0Wk3z7PFtz6Kf/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655708137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R/w3GJ8ow9f56R0PNbT0ogP0sGCCDZ4PjKVCPswv8E=;
	b=pDrQq3nBfJ+q11Jc6vU+Dh0bhfGTw7R7VXVjs0SV4DAEAavZd0ZVFaytgwKyZzm8RzfJmD
	TMwYLstczT87OCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA654134CA;
	Mon, 20 Jun 2022 06:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZY/NN+gZsGJzdwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:55:36 +0000
Message-ID: <312649a9-3b5b-404c-c411-66df13efb92e@suse.de>
Date: Mon, 20 Jun 2022 08:55:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 05/10] nvme/rc: add more arguments to
 _nvme_connect_subsys()
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.com>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-6-hare@suse.de>
 <20220614042348.jb3i7wjmbbzdfmxn@shindev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220614042348.jb3i7wjmbbzdfmxn@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_235538_793713_8B727B63 
X-CRM114-Status: GOOD (  13.11  )
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

On 6/14/22 06:23, Shinichiro Kawasaki wrote:
> On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> Add optional arguments for setting 'hostnqn', 'hostid', 'hostkey',
>> and 'ctrlkey' to _nvme_connect_subsys() to make it usable for
>> testing nvme in-band authentication.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/rc | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 2873037..b7bb3cd 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -190,11 +190,27 @@ _nvme_connect_subsys() {
>>   	local subsysnqn="$2"
>>   	local traddr="${3:-$def_traddr}"
>>   	local trsvcid="${4:-$def_trsvcid}"
>> +	local hostnqn="${5:-$def_hostnqn}"
>> +	local hostid="${6:-$def_hostid}"
> 
> I can not find def_hostnqn and def_hostid defined. Did they slip out from this
> series?
> 
No, not really; these are optional args anyway.
But I probably should add code to read them in from /etc/nvme/

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

