Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D51DEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0BK8fznQDkN/Yw+OZOhfYrDBBNJry58KTjlioF58Eo=; b=gP8/HwY39TUGmCqRH1xm7bDyBd
	DTrA/z9MRaVuoQ8sjz+UYn6C3iSVboD+8WbeFEHgmyaFs/vcMBaBrKoHRKdhEMirMZPWTqGAKdB5R
	CLn6QM79QmadlZuYxfm7jnPFEvaWYoDAoZpuUF8JnNrc1rCHXR0yFj+N/CMxpyCuH39UdjoiWMId3
	l4mTnVCpoWdqNqJXjmZEERlb5C5LPuiRWXAZOYQU04DrwO2w3DtYr8ZkaT9iselaR1L5VuIehLI65
	2OiTiLQ+DmvZTnHjqSezZzSc9c2EXWkZS4aGyALc5wV76SiCSxinxYZre80gW3+zQGDax3H3zagx7
	N9OX/pIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qThD1-004knL-1f;
	Wed, 09 Aug 2023 11:18:35 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qThCy-004kmG-0v
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 11:18:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F0B61F38C;
	Wed,  9 Aug 2023 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691579907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0BK8fznQDkN/Yw+OZOhfYrDBBNJry58KTjlioF58Eo=;
	b=dEdmDi2pwd+ym6+L/oQzH5n4VjyxPW9vB1nas554ivL0FLw/3mbeFEDmzFDQFEf7YLvn33
	X9XkEMW47sicnEAQiSf2aj8Em9x7cxZBzhCO9GAPZl2Na4BSfLCor+/i34SoEst0thA7Ga
	rbajEQO075YW9gzDoZc5Qfjb6VIDhBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691579907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0BK8fznQDkN/Yw+OZOhfYrDBBNJry58KTjlioF58Eo=;
	b=GZp1AreogUhHYmC9KlAi6A7FAKhBq0mpmv7vGRoieE2dF43x8s5B54zAliTdR9gMHauGVA
	IpCiex4VsRkJv3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85BBA13251;
	Wed,  9 Aug 2023 11:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1urxHwN202RfSgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 11:18:27 +0000
Message-ID: <d99912c7-13ba-b0df-c571-5a1cf0861d12@suse.de>
Date: Wed, 9 Aug 2023 13:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] nvmet: Allow to change 'TSAS' and 'TREQ'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-15-hare@suse.de>
 <28b7fa83-291f-00bc-913d-8a6a7688557a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <28b7fa83-291f-00bc-913d-8a6a7688557a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_041832_471603_B50F6CCD 
X-CRM114-Status: GOOD (  27.09  )
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

On 8/9/23 12:44, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 19:53, Hannes Reinecke wrote:
>> Allow to change 'TSAS' and 'TREQ' to values specified in the spec.
> 
> I think a little more description is needed here. About the
> rules of how the two interact.
> 
Ok.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 7f826ac8b75c..3c2aeb763e22 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -159,10 +159,15 @@ static const struct nvmet_type_name_map 
>> nvmet_addr_treq[] = {
>>       { NVMF_TREQ_NOT_REQUIRED,    "not required" },
>>   };
>> +static inline u8 nvmet_port_treq(struct nvmet_port *port)
>> +{
>> +    return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
>> +}
> 
> The function name does not match what it does.
> 
nvmet_port_addr_treq() ?

>> +
>>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char 
>> *page)
>>   {
>> -    u8 treq = to_nvmet_port(item)->disc_addr.treq &
>> -        NVME_TREQ_SECURE_CHANNEL_MASK;
>> +    struct nvmet_port *port = to_nvmet_port(item);
>> +    u8 treq = nvmet_port_treq(port);
>>       int i;
>>       for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
>> @@ -174,11 +179,16 @@ static ssize_t nvmet_addr_treq_show(struct 
>> config_item *item, char *page)
>>       return snprintf(page, PAGE_SIZE, "\n");
>>   }
>> +static inline u8 nvmet_port_treq_mask(struct nvmet_port *port)
>> +{
>> +    return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
>> +}
> 
> Same here, function name and what it returns seem diverged from each
> other.
> 
nvmet_port_addr_treq_mask() ?

>> +
>>   static ssize_t nvmet_addr_treq_store(struct config_item *item,
>>           const char *page, size_t count)
>>   {
>>       struct nvmet_port *port = to_nvmet_port(item);
>> -    u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
>> +    u8 treq = nvmet_port_treq_mask(port);
>>       int i;
>>       if (nvmet_is_port_enabled(port, __func__))
>> @@ -193,6 +203,15 @@ static ssize_t nvmet_addr_treq_store(struct 
>> config_item *item,
>>       return -EINVAL;
>>   found:
>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
>> +        if (port->disc_addr.tsas.tcp.sectype != 
>> NVMF_TCP_SECTYPE_TLS13) {
>> +            pr_warn("cannot change TREQ when TLS is not enabled\n");
>> +            return -EINVAL;
> 
> So what are you supposed to set in treq without tls?
> 
'not specified' is the only valid choice currrently.

>> +        } else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
>> +            pr_warn("cannot set TREQ to 'not specified' when TLS is 
>> enabled\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>>       treq |= nvmet_addr_treq[i].type;
>>       port->disc_addr.treq = treq;
>>       return count;
>> @@ -371,6 +390,7 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>           const char *page, size_t count)
>>   {
>>       struct nvmet_port *port = to_nvmet_port(item);
>> +    u8 treq = nvmet_port_treq_mask(port);
>>       int i;
>>       if (nvmet_is_port_enabled(port, __func__))
>> @@ -389,6 +409,16 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>   found:
>>       nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
>> +    if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
>> +        if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
>> +            treq |= NVMF_TREQ_REQUIRED;
>> +        else
>> +            treq |= nvmet_port_treq(port);
>> +    } else {
>> +        /* Set to 'not specified' if TLS is not enabled */
>> +        treq |= NVMF_TREQ_NOT_SPECIFIED;
>> +    }
>> +    port->disc_addr.treq = treq;
> 
> Hmm, so setting tsas modifies treq under the hood.
> Surprising...
> 
> It is not clear to me what is the user supposed to set in configfs.
> Just set tsas to tls1.3 and that's it? any treq setting will not be
> allowed after it? Its a bit confusing.

Yeah, it is. I guess we should disallow setting of the 'treq' bit from
the user, as it's pretty much defined by the TSAS value.

Will be modifying it.

Cheers,

Hannes


