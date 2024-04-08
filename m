Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DADCD1297
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uobAt6ESRQ26llwsoCu3jfdzRBd7gfzq9Ykmkgmitrg=; b=dKteByJyXOAB/DtBdqyF3SKDjV
	zGlsYjjAvVqN71k4WhpGbyL/SEWv96PCkd34wMfW2w5z4BH3qoiwqlYBAxoO9bDUkj56E5AcJ59iG
	eSPOPIydydB9SV4e1sB0jYEd5Ishuz6E3WOWHR+knQciEqBW/WoNBS0o3lxeCbLuJfA83d6QdDSdC
	K83LHR2wYNtX1gvJlhfI1WcTey3kM+z+7GjCc317Um/7mNdluQS6Ym2MLf3xD276uhMDumaoFztNz
	MOD0wc+myWJfN8/wycaYoLkSSR+f1R0hDuc4XBl/lnsA3trQLcRNiI99bCBZlXi8/8tCKcSDi2Cjj
	X64I6bwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwFR-0000000Gqvl-0Lkx;
	Mon, 08 Apr 2024 21:09:49 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwFO-0000000Gqv0-1eio
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:09:47 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4166344b68dso1358995e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 14:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610584; x=1713215384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uobAt6ESRQ26llwsoCu3jfdzRBd7gfzq9Ykmkgmitrg=;
        b=gXxj2aTt1FWGwbcrvr35g/uGBh8ECvy7geYRG9d8n0l+QtmWX2vU5R54zjVeVKvxL2
         Wfx3j8e2F9OC8QdIVdwRmq0WqzigG4QmkBvxQlTHhTKziQ3zkEdwIKrSbbtJ93ZO2nGC
         WnK1x3dA+C0X9VxBm3QZvz3J/q7+ZZNMffIMnG5L7iEIKrVehTknqyntRs8d91RQvTIn
         cjW8tjokCg9pNwD8CRffqV6iPjKDXri+WgAYfGNRHOdlI9cre1szX2xs3Rs0HK8kFc5j
         faHnCZKPoPI+8RWr5YP4FUbPMwLIUIAYkKlxB4SiLhbgbEMNJz4JAXjuFKT+gZNarHij
         9Vww==
X-Forwarded-Encrypted: i=1; AJvYcCV+cCl2OHKY4gspVgU92P9PhdgNAkq8mAb+iwb2UZKGIq4H7YkhWfE+hYpgcKH3zVbLUKsyeiy6nv7mlDSo1LN9HRdSaBKOOsFVr0/nGd4=
X-Gm-Message-State: AOJu0YwZrFIakYmDotP490AIoYX8XABuU8tqdf8uDjy8oXn0rSybBaEY
	qeYHXM5HRPRjUawVcTnalKKgwDI8QxQC55glS5uuc5Lm4fARfbM0
X-Google-Smtp-Source: AGHT+IHC0qengjpR0C24HVSttkvdJerDg45jyOyhCXKkb1mTbez81xy3GdBJ78UCdqNd/GSPvikTAA==
X-Received: by 2002:a05:6000:144f:b0:343:f2e0:449c with SMTP id v15-20020a056000144f00b00343f2e0449cmr7318008wrx.0.1712610583451;
        Mon, 08 Apr 2024 14:09:43 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00343d6c7240fsm9796470wrp.35.2024.04.08.14.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:09:43 -0700 (PDT)
Message-ID: <4c599101-71af-46b0-bbc0-dcb868ed9f43@grimberg.me>
Date: Tue, 9 Apr 2024 00:09:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] nvme-tcp: request secure channel concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-12-hare@kernel.org>
 <7102826f-b92c-4546-a351-159b8a7dd233@grimberg.me>
 <616d5ebc-0f75-4be9-beff-f8ee24fe71d3@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <616d5ebc-0f75-4be9-beff-f8ee24fe71d3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_140946_463202_D0990B3C 
X-CRM114-Status: GOOD (  21.48  )
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



On 08/04/2024 8:32, Hannes Reinecke wrote:
> On 4/7/24 23:41, Sagi Grimberg wrote:
>>
>>
>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Add a fabrics option 'concat' to request secure channel concatenation.
>>
>> maybe name it secconcat ? or secure_concat ?
>>
>>> When secure channel concatenation is enabled a 'generated PSK' is 
>>> inserted
>>> into the keyring such that it's available after reset.
>>
>> Umm, I'm not sure what this means? Is this the revoke action? what if
>> the user passes a keyring? I'm not entirely sure what is the 
>> interface semantics here.
>>
> No, this is not the 'revoke' action. This is the modification TP8018
> brought in. For secure concatenation the initial connection is done
> without encryption, DH-CHAP is run and generates the TLS PSK. Then
> the connection is reset, and the new connection starts TLS with the
> generated key.

Yes, I misread "it's available" and "it's not available". Sorry.

>
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/auth.c    | 108 
>>> ++++++++++++++++++++++++++++++++++--
>>>   drivers/nvme/host/fabrics.c |  25 ++++++++-
>>>   drivers/nvme/host/fabrics.h |   3 +
>>>   drivers/nvme/host/sysfs.c   |   2 +
>>>   drivers/nvme/host/tcp.c     |  53 ++++++++++++++++--
>>>   include/linux/nvme.h        |   7 +++
>>>   6 files changed, 186 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>> index a264b3ae078b..a4033a8f9607 100644
>>> --- a/drivers/nvme/host/auth.c
>>> +++ b/drivers/nvme/host/auth.c
>>> @@ -12,6 +12,7 @@
>>>   #include "nvme.h"
>>>   #include "fabrics.h"
>>>   #include <linux/nvme-auth.h>
>>> +#include <linux/nvme-keyring.h>
>>>   #define CHAP_BUF_SIZE 4096
>>>   static struct kmem_cache *nvme_chap_buf_cache;
>>> @@ -131,7 +132,12 @@ static int 
>>> nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>>>       data->auth_type = NVME_AUTH_COMMON_MESSAGES;
>>>       data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>>>       data->t_id = cpu_to_le16(chap->transaction);
>>> -    data->sc_c = 0; /* No secure channel concatenation */
>>> +    if (!ctrl->opts->concat || chap->qid != 0)
>>> +        data->sc_c = NVME_AUTH_SECP_NOSC;
>>> +    else if (ctrl->opts->tls_key)
>>> +        data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
>>> +    else
>>> +        data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
>>>       data->napd = 1;
>>>       data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
>>>       data->auth_protocol[0].dhchap.halen = 3;
>>> @@ -311,8 +317,9 @@ static int 
>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>       data->hl = chap->hash_len;
>>>       data->dhvlen = cpu_to_le16(chap->host_key_len);
>>>       memcpy(data->rval, chap->response, chap->hash_len);
>>> -    if (ctrl->ctrl_key) {
>>> +    if (ctrl->ctrl_key)
>>>           chap->bi_directional = true;
>>> +    if (ctrl->ctrl_key || ctrl->opts->concat) {
>>>           get_random_bytes(chap->c2, chap->hash_len);
>>>           data->cvalid = 1;
>>>           memcpy(data->rval + chap->hash_len, chap->c2,
>>> @@ -322,7 +329,10 @@ static int 
>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>       } else {
>>>           memset(chap->c2, 0, chap->hash_len);
>>>       }
>>> -    chap->s2 = nvme_auth_get_seqnum();
>>> +    if (ctrl->opts->concat)
>>> +        chap->s2 = 0;
>>> +    else
>>> +        chap->s2 = nvme_auth_get_seqnum();
>>>       data->seqnum = cpu_to_le32(chap->s2);
>>>       if (chap->host_key_len) {
>>>           dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
>>> @@ -677,6 +687,79 @@ static void nvme_auth_free_dhchap(struct 
>>> nvme_dhchap_queue_context *chap)
>>>           crypto_free_kpp(chap->dh_tfm);
>>>   }
>>> +static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>>> +                   struct nvme_dhchap_queue_context *chap)
>>> +{
>>> +    u8 *psk, *digest, *tls_psk;
>>> +    struct key *tls_key;
>>> +    size_t psk_len;
>>> +    int ret = 0;
>>> +
>>> +    if (!chap->sess_key) {
>>> +        dev_warn(ctrl->device,
>>> +             "%s: qid %d no session key negotiated\n",
>>> +             __func__, chap->qid);
>>> +        return -ENOKEY;
>>> +    }
>>> +
>>> +    psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
>>> +                     chap->sess_key_len,
>>> +                     chap->c1, chap->c2,
>>> +                     chap->hash_len, &psk_len);
>>> +    if (IS_ERR(psk)) {
>>> +        ret = PTR_ERR(psk);
>>> +        dev_warn(ctrl->device,
>>> +             "%s: qid %d failed to generate PSK, error %d\n",
>>> +             __func__, chap->qid, ret);
>>> +        return ret;
>>> +    }
>>> +    dev_dbg(ctrl->device,
>>> +          "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
>>> +
>>> +    digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
>>> +                       ctrl->opts->subsysnqn,
>>> +                       ctrl->opts->host->nqn);
>>> +    if (IS_ERR(digest)) {
>>> +        ret = PTR_ERR(digest);
>>> +        dev_warn(ctrl->device,
>>> +             "%s: qid %d failed to generate digest, error %d\n",
>>> +             __func__, chap->qid, ret);
>>> +        goto out_free_psk;
>>> +    };
>>> +    dev_dbg(ctrl->device, "%s: generated digest %s\n",
>>> +         __func__, digest);
>>> +    tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, 
>>> digest);
>>> +    if (IS_ERR(tls_psk)) {
>>> +        ret = PTR_ERR(tls_psk);
>>> +        dev_warn(ctrl->device,
>>> +             "%s: qid %d failed to derive TLS psk, error %d\n",
>>> +             __func__, chap->qid, ret);
>>> +        goto out_free_digest;
>>> +    };
>>> +
>>> +    tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, 
>>> ctrl->opts->host->nqn,
>>> +                       ctrl->opts->subsysnqn, chap->hash_id,
>>> +                       true, tls_psk, psk_len, digest);
>>> +    if (IS_ERR(tls_key)) {
>>> +        ret = PTR_ERR(tls_key);
>>> +        dev_warn(ctrl->device,
>>> +             "%s: qid %d failed to insert generated key, error %d\n",
>>> +             __func__, chap->qid, ret);
>>> +        tls_key = NULL;
>>> +        kfree_sensitive(tls_psk);
>>> +    }
>>> +    if (ctrl->opts->tls_key) {
>>> +        key_revoke(ctrl->opts->tls_key);
>>> +        key_put(ctrl->opts->tls_key);
>>> +    }
>>
>> Question, is this for the case where the user passes both tls_key and
>> concat? Is this something that we expect users to do? What is the
>> benefit?

Answer?


