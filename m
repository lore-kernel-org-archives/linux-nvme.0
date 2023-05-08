Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3132C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  8 May 2023 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2OVX50VOAlktquuuhgxCzz1aCSMB8kp3XVT7pJlaOCo=; b=Bs8xD7AxZVL+iESgROFR73ZlmF
	ketCdDxydhGJRyilk9xGyzndZvMh4mg9T4Yvs7/s7raIo+kVXJQhtW6KFf5/wd4F1z//ZPkMYRyJk
	nJVMINbTnSnYNnild5L78XLG7IB+FdLsYJHxG2Kqkh2mczL2EShrSwIJB4u0X9l987T/NaeTRqmNB
	kQ6/Bc/shmN2F7gfzkVa+rEX4K6BVy4LhznRZHIHoU3nlI7Ycd4lvu4+QnGueoABp6MScaBjTuPGi
	pOEMD2Ay/d2PbOU9mnMsMxZ+pXxb/XjJ/cuwiKrWV8+O7i0lkWNDF2lZ8jaHp+V2RFxy7VIixxRzB
	rU+cY4Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pw1Lf-000gN1-1v;
	Mon, 08 May 2023 13:56:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pw1Lc-000gMA-0V
	for linux-nvme@lists.infradead.org;
	Mon, 08 May 2023 13:56:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F0931FF21;
	Mon,  8 May 2023 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683554170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OVX50VOAlktquuuhgxCzz1aCSMB8kp3XVT7pJlaOCo=;
	b=su8Bq8Pe96AyNCvqpxzg16TJup8u+JLPEy/BMXplWsQoj12fdXWIhDcG+XHm/YaiiPJ6fj
	2PIp4UVZyBT6WlLNlRnVVYM5JHhpUvftjECFQQQQfqt6MdZa8yGPQ6m+iYYsGSbJWH2gb5
	vuHkhIvogRsk2g52M1bdsg8QUK7XiNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683554170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OVX50VOAlktquuuhgxCzz1aCSMB8kp3XVT7pJlaOCo=;
	b=USD671Ba8byWKORoXbmYu1Ys9aN1vuFYL7PIVRdfGAFLO9MAtulL0Cjhzt7EDI5khSW0OK
	pv2dPE00R+f17cCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAEF01346B;
	Mon,  8 May 2023 13:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zlFPK3j/WGTkegAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 08 May 2023 13:56:08 +0000
Message-ID: <10668922-b09b-da68-2e34-75eb6dbe14c5@suse.de>
Date: Mon, 8 May 2023 15:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 02/17] nvme-keyring: define a 'psk' keytype
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-3-hare@suse.de>
 <91742b06-4138-82a8-050d-bd41cd2f8aa9@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <91742b06-4138-82a8-050d-bd41cd2f8aa9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_065616_363958_FA1FA2DB 
X-CRM114-Status: GOOD (  18.74  )
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

On 5/8/23 10:59, Max Gurtovoy wrote:
> Hi Hannes,
> 
> On 19/04/2023 9:56, Hannes Reinecke wrote:
>> Define a 'psk' keytype to hold the NVMe TLS PSKs.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/common/keyring.c | 94 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>
>> diff --git a/drivers/nvme/common/keyring.c 
>> b/drivers/nvme/common/keyring.c
>> index 5cf64b278119..494dd365052e 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/key-type.h>
>>   #include <keys/user-type.h>
>>   #include <linux/nvme.h>
>> +#include <linux/nvme-tcp.h>
>> +#include <linux/nvme-keyring.h>
>>   static struct key *nvme_keyring;
>> @@ -17,8 +19,94 @@ key_serial_t nvme_keyring_id(void)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_keyring_id);
>> +static void nvme_tls_psk_describe(const struct key *key, struct 
>> seq_file *m)
>> +{
>> +    seq_puts(m, key->description);
>> +    seq_printf(m, ": %u", key->datalen);
>> +}
>> +
>> +static bool nvme_tls_psk_match(const struct key *key,
>> +                   const struct key_match_data *match_data)
>> +{
>> +    const char *match_id;
>> +    size_t match_len;
>> +
>> +    if (!key->description) {
>> +        pr_debug("%s: no key description\n", __func__);
>> +        return false;
>> +    }
>> +    match_len = strlen(key->description);
>> +    pr_debug("%s: id %s len %zd\n", __func__, key->description, 
>> match_len);
>> +
>> +    if (!match_data->raw_data) {
>> +        pr_debug("%s: no match data\n", __func__);
>> +        return false;
>> +    }
>> +    match_id = match_data->raw_data;
>> +    pr_debug("%s: match '%s' '%s' len %zd\n",
>> +         __func__, match_id, key->description, match_len);
>> +    return !memcmp(key->description, match_id, match_len);
>> +}
>> +
>> +static int nvme_tls_psk_match_preparse(struct key_match_data 
>> *match_data)
>> +{
>> +    match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
>> +    match_data->cmp = nvme_tls_psk_match;
>> +    return 0;
>> +}
>> +
>> +static struct key_type nvme_tls_psk_key_type = {
>> +    .name           = "psk",
>> +    .flags          = KEY_TYPE_NET_DOMAIN,
>> +    .preparse       = user_preparse,
>> +    .free_preparse  = user_free_preparse,
>> +    .match_preparse = nvme_tls_psk_match_preparse,
>> +    .instantiate    = generic_key_instantiate,
>> +    .revoke         = user_revoke,
>> +    .destroy        = user_destroy,
>> +    .describe       = nvme_tls_psk_describe,
>> +    .read           = user_read,
>> +};
>> +
>> +static struct key *nvme_tls_psk_lookup(struct key *keyring,
>> +        const char *hostnqn, const char *subnqn,
>> +        int hmac, bool generated)
>> +{
>> +    char *identity;
>> +    size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
>> +    key_ref_t keyref;
>> +    key_serial_t keyring_id;
>> +
>> +    identity = kzalloc(identity_len, GFP_KERNEL);
>> +    if (!identity)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
>> +         generated ? 'G' : 'R', hmac, hostnqn, subnqn);
>> +
>> +    if (!keyring)
>> +        keyring = nvme_keyring;
>> +    keyring_id = key_serial(keyring);
>> +    pr_debug("keyring %x lookup tls psk '%s'\n",
>> +         keyring_id, identity);
>> +    keyref = keyring_search(make_key_ref(keyring, true),
>> +                &nvme_tls_psk_key_type,
>> +                identity, false);
>> +    if (IS_ERR(keyref)) {
>> +        pr_debug("lookup tls psk '%s' failed, error %ld\n",
>> +             identity, PTR_ERR(keyref));
>> +        kfree(identity);
>> +        return ERR_PTR(-ENOKEY);
>> +    }
>> +    kfree(identity);
>> +
>> +    return key_ref_to_ptr(keyref);
>> +}
>> +
>>   int nvme_keyring_init(void)
>>   {
>> +    int err;
>> +
>>       nvme_keyring = keyring_alloc(".nvme",
>>                        GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>>                        current_cred(),
>> @@ -28,12 +116,18 @@ int nvme_keyring_init(void)
>>       if (IS_ERR(nvme_keyring))
>>           return PTR_ERR(nvme_keyring);
>> +    err = register_key_type(&nvme_tls_psk_key_type);
>> +    if (err) {
>> +        key_put(nvme_keyring);
> 
> I see in the nvme_keyring_exit you call "key_revoke(nvme_keyring);"
> Should we call it here as well ?
> 
Mysteries of the keyring subsystem.
But yeah, I guess we should.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


