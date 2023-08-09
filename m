Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A7FEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XT5CimFCCI/bIeUWIZG1R15lSt4GXUAvOOCAkMlolmA=; b=qpnfCiRtIfpUUvY5is3NeJyE3f
	hU4Sm64wCIVtuENcfEuQa3NjWPhV5wM5j7pFrqCh0DhLRY1OVgpsMOKtacsheR+AzLRUnHYu7ouBd
	GBcjtkzmAijaBxt9/Ed3Gbx1bbcH2ZcV3ycC8wXchSrocZwohzs59xo0WoFr7t07DIo4EEGN/Xj9Z
	KDeeR7AK4MuirQqmvDyPdMQ9BoG6DnLopIQV6RrbXzMbSjbX+fR1GYmBbUYeigUoDrPGBmb8tg+FD
	szZd1T/OL6sZtM67AYKTJGxNvHnRPTSiQKFmuirkLshbmp4F21n/HPmwgP8SAoojx1vUjhPjvohqL
	a2aqBqIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTg1k-004UYr-07;
	Wed, 09 Aug 2023 10:02:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTg1g-004UYR-10
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:02:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAB9121862;
	Wed,  9 Aug 2023 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691575366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XT5CimFCCI/bIeUWIZG1R15lSt4GXUAvOOCAkMlolmA=;
	b=cFPwFtH3flO5BAlpuYwtn/XP5j0sn8Uof4Ap4nMD3gmhs91o8rm/YsMX1PS+gr9SXnb0+K
	oiALv65X635fwME++akWwVgROyv18tMsS046TX0HxLOA+NZIPMJEKnHZuDN/7weKBKne3d
	0/ci0kVkRt9uV3NsUvTMMy58OlOJKYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691575366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XT5CimFCCI/bIeUWIZG1R15lSt4GXUAvOOCAkMlolmA=;
	b=zPqYu2Hu084xGlmsyKw74iZzWBlDM438cv3dQnl5WKFv9I4QmsP0Pm3uYxXZ+zf2XY9kMD
	cmPjmLB+2r5YgZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E35F133B5;
	Wed,  9 Aug 2023 10:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Yrw1JkZk02RzIwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Aug 2023 10:02:46 +0000
Message-ID: <052019c8-00c8-a497-7cf9-437124ecd86a@suse.de>
Date: Wed, 9 Aug 2023 12:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-11-hare@suse.de>
 <658826df-9404-3245-6bbe-9862156c70da@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <658826df-9404-3245-6bbe-9862156c70da@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_030248_510782_A9337386 
X-CRM114-Status: GOOD (  20.48  )
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

On 8/9/23 11:56, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 19:53, Hannes Reinecke wrote:
>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>> referenced keys in the options structure.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fabrics.c | 71 ++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/fabrics.h |  6 ++++
>>   drivers/nvme/host/tcp.c     | 11 ++++--
>>   3 files changed, 84 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ddad482c3537..df986a7641a3 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -622,6 +622,41 @@ static struct nvmf_transport_ops 
>> *nvmf_lookup_transport(
>>       return NULL;
>>   }
>> +static int parse_key(struct nvmf_ctrl_options *opts, int key_id,
>> +             bool is_key)
>> +{
>> +    struct key *key = NULL;
>> +
>> +    if (key_id < 0) {
>> +        pr_err("Invalid %s id %d\n",
>> +               is_key ? "key" : "keyring", key_id);
>> +        return -EINVAL;
>> +    }
>> +    if (key_id) {
>> +        key = key_lookup(key_id);
>> +        if (!key) {
>> +            pr_err("%s id %08x not found\n",
>> +                   is_key ? "Key" : "Keyring", key_id);
>> +            return -ENOKEY;
>> +        }
>> +    } else {
>> +        if (is_key)
>> +            pr_debug("Using 'best' PSK\n");
>> +        else
>> +            pr_debug("Using default keyring\n");
>> +        key = NULL;
> 
> Not sure I understand the else case here.
> Why do we allow key_id = 0 if it does not represent
> a valid existing key_id?
> 
No, you are right. While there is a default keyring, there is no
point in allowing '0' as a value here; if the user wants to use
the default keyring he shoudn't have set the '--keyring' option.

>> +    }
>> +    if (is_key) {
>> +        key_put(opts->tls_key);
>> +        opts->tls_key = key;
>> +    } else {
>> +        key_put(opts->keyring);
>> +        opts->keyring = key;
>> +    }
>> +
> 
> Perhaps instead of is_key, just return the key and assign outside.

Could be. Lemme see.

Cheers,

Hannes


