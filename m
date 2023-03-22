Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CFC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyzJCjEb3uLVZsp7cxfG/DqIFon8OUNxLH/9tEstvh8=; b=yhGqtdXCcRF1bQY8O7TToHBFOn
	ygwMBUlQYsdyASF/90aIiUDhuU6qRQe2Ee40fC968aYgWqPmXFoQnJuFKIhlSDWOT5btwePFoYjMz
	oKSy+nVNjjI8AkSpwk1waDl5f5rJd99mKeRap2tt07GXjHcLOnR/syf+9XUpX5toASqwz94zBi5+4
	E6KjBH/RLeeTznFhb6GnvudGnwY42Y6c5TyDoUiBx8YK7Fns7p+GsANWrHhbin3QRY7mLyPJPeSVk
	4Gw/STEsbzVCGk56vop+0QYrVo+R45vxIJSDBZE/ymWkTmy9exlZJNZggstdNWzSSyd4uQ8617pEs
	zrwY0tKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peu9b-00FFHx-2N;
	Wed, 22 Mar 2023 08:49:07 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peu9Z-00FFH5-0O
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:49:06 +0000
Received: by mail-wr1-f44.google.com with SMTP id v25so12684527wra.12
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyzJCjEb3uLVZsp7cxfG/DqIFon8OUNxLH/9tEstvh8=;
        b=6lKyPXSeafNStL+lQZlpv4AiqWO3Gc90+F4FKQHpQuQRppCON7S6tu2KMvVvT6uqpa
         UJgL6+fVRSL75tqGEkYtG1tpi5JNqEKxfuKu4WcMlO6XiqGZlpyjQ4G/mgmD2oElUfp8
         G5uPbV4gr8wJaMH2DQmsZFqcNQDYkFODuXkMVc5Ec2By+bGOWK3e5Qzu2sza+Q3AjSMY
         bcBL+LhDIbIGQfaKzhkqa3mDKeXwoHz+PJ9JvTTZ3yVAI9dTXd7qWit/Ewwh37IYa8bp
         NEB1k2ncLz/FJrkfW+EfE1zUojpd7LepjdGw+a9ZDeW833um0Tlbb8hAC//wdwWCncXj
         C+pg==
X-Gm-Message-State: AO0yUKUL5gYihO86RtJUcMZVbXqyunlXy06oeQ4jF3eb9FWj7lENYcOj
	iDr1/aeWSJwOu5SzPhQ7sps=
X-Google-Smtp-Source: AK7set9W7ZqKSwztAWJSyPyxEf8ZvRdhlJzLFh1FsEOSXyYcenAg3oOct09itrpgkHMrNArwOmtRSQ==
X-Received: by 2002:a5d:6e54:0:b0:2d2:9c19:f75 with SMTP id j20-20020a5d6e54000000b002d29c190f75mr3719388wrz.1.1679474943263;
        Wed, 22 Mar 2023 01:49:03 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b002c54e26bca5sm13357345wrs.49.2023.03.22.01.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:49:03 -0700 (PDT)
Message-ID: <7480845a-1a95-2801-a929-b6b3dc0ad88d@grimberg.me>
Date: Wed, 22 Mar 2023 10:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/18] nvme-keyring: define a 'psk' keytype
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-3-hare@suse.de>
 <d5ca39af-ff50-db27-ab1b-a8c57d2152b9@grimberg.me>
 <fa1f8cd0-4bb7-c3cc-f4ca-64e2f877b528@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fa1f8cd0-4bb7-c3cc-f4ca-64e2f877b528@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_014905_157299_83F7EEE5 
X-CRM114-Status: GOOD (  23.77  )
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


>> On 3/21/23 14:43, Hannes Reinecke wrote:
>>> Define a 'psk' keytype to hold the NVMe TLS PSKs.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/common/keyring.c | 96 +++++++++++++++++++++++++++++++++++
>>>   include/linux/nvme-keyring.h  |  8 +++
>>>   2 files changed, 104 insertions(+)
>>>
>>> diff --git a/drivers/nvme/common/keyring.c 
>>> b/drivers/nvme/common/keyring.c
>>> index 3a6e8a0b38e2..6cbb9d66e0f6 100644
>>> --- a/drivers/nvme/common/keyring.c
>>> +++ b/drivers/nvme/common/keyring.c
>>> @@ -11,6 +11,96 @@
>>>   static struct key *nvme_keyring;
>>> +key_serial_t nvme_keyring_id(void)
>>> +{
>>> +    return nvme_keyring->serial;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_keyring_id);
>>> +
>>> +static void nvme_tls_psk_describe(const struct key *key, struct 
>>> seq_file *m)
>>> +{
>>> +    seq_puts(m, key->description);
>>> +    seq_printf(m, ": %u", key->datalen);
>>> +}
>>> +
>>> +static bool nvme_tls_psk_match(const struct key *key,
>>> +                   const struct key_match_data *match_data)
>>> +{
>>> +    const char *match_id;
>>> +    size_t match_len;
>>> +
>>> +    if (!key->description) {
>>> +        pr_debug("%s: no key description\n", __func__);
>>> +        return false;
>>> +    }
>>> +    match_len = strlen(key->description);
>>> +    pr_debug("%s: id %s len %zd\n", __func__, key->description, 
>>> match_len);
>>> +
>>> +    if (!match_data->raw_data) {
>>> +        pr_debug("%s: no match data\n", __func__);
>>> +        return false;
>>> +    }
>>> +    match_id = match_data->raw_data;
>>> +    pr_debug("%s: match '%s' '%s' len %lu\n",
>>> +         __func__, match_id, key->description, match_len);
>>> +    return !memcmp(key->description, match_id, match_len);
>>> +}
>>> +
>>> +static int nvme_tls_psk_match_preparse(struct key_match_data 
>>> *match_data)
>>> +{
>>> +    match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
>>> +    match_data->cmp = nvme_tls_psk_match;
>>> +    return 0;
>>> +}
>>> +
>>> +static struct key_type nvme_tls_psk_key_type = {
>>> +    .name           = "psk",
>>> +    .flags          = KEY_TYPE_NET_DOMAIN,
>>> +    .preparse       = user_preparse,
>>> +    .free_preparse  = user_free_preparse,
>>> +    .match_preparse = nvme_tls_psk_match_preparse,
>>> +    .instantiate    = generic_key_instantiate,
>>> +    .revoke         = user_revoke,
>>> +    .destroy        = user_destroy,
>>> +    .describe       = nvme_tls_psk_describe,
>>> +    .read           = user_read,
>>> +};
>>> +
>>
>> Hannes, can you please provide a documentation section
>> to this function? most importantly 'generated' argument.
>>
> Sure. There are two types of PSK types specified in the NVMe TCP spec;
> a 'retained' one which has to be provided by the admin, and a 
> 'generated' one which is derived from the shared key material from 
> DH-HMAC-CHAP when doing a secure channel concatenation.
> And each type has two possible hash algorithms (SHA-256 and SHA-384),
> resulting in 4 possible PSKs.
> 
> And indeed, the secure channel concatenation bits are missing as we're 
> still hashing out details at the fmds group.
> I do have a patchset for that, though, but decided not to include it in 
> this submission as it'll increase the patchset even more.
> Can do if you like ...

I'd prefer to split the secure channel concatenation out of this.
But it would be good to give some context in the code.

Also the bool is confusing, can you make this an enumeration that
translates to 'G' or 'R' and pass that in?

> 
> But will be updating the documentation.
> 
>>> +struct key *nvme_tls_psk_lookup(key_ref_t keyring,
>>> +        const char *hostnqn, const char *subnqn,
>>> +        int hmac, bool generated)
>>> +{
>>> +    char *identity;
>>> +    size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
>>> +    key_ref_t keyref;
>>> +    key_serial_t keyring_id;
>>> +
>>> +    identity = kzalloc(identity_len, GFP_KERNEL);
>>> +    if (!identity)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
>>> +         generated ? 'G' : 'R', hmac, hostnqn, subnqn);
>>
>> Is that a format that is expected from userspace to produce?
>>
> Yes. See
> NVMe-TCP 1.0a section 3.6.1.3 "TLS PSK and PSK Identity Derivation"
> for details.
> 

Yes, I see it now. Thanks.

