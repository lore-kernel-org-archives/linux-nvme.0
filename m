Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228D2C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDguVhHkxuNoWKGbgMlT7mCSq51xGz1K6L5DGlimFGY=; b=nCLPGLXb11iXLVmOU4L4uNoRf/
	KzDDuar6tqz23UYTOGHQ9uDrtRDSxjNfj4KxHkHPxTZGT5hV48KkeScIG6HOlV/vVqfhdCDoPUSeC
	sD62l2E0cM8K/3blhhelDeSmCRqOqX7LHkT0Sx2qXtil0X8+UuCjlmaUecE0PZfKkz50Y2MLz/oYf
	VZvfDC7+6UmWSysaVZFq84LN1KGvOkkJvvvTgiplzdKheNC0mYEPGpe2CYKa9fDQ28lykISAFF0mH
	xCE180QbZ1cSzKUoiDDN5/X1b6cvvVH0U208gMpHsO0oEKa5gV41mPuUoEvomb+UXOaxnWaolJY7E
	VDIXIYOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryV9m-0000000AMV5-49Nm;
	Sun, 21 Apr 2024 11:14:50 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryV9k-0000000AMUE-19T3
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 11:14:49 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-345606e8ac0so421910f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 04:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713698082; x=1714302882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDguVhHkxuNoWKGbgMlT7mCSq51xGz1K6L5DGlimFGY=;
        b=ehKZlsBXxIhnZS22+f342juAx615fCDXQkcPVx1z8bS5SRji8MHiiqYglOBkrfOU/c
         OzBuP72cHefyyyJtvo03ZDR6vFoa6eLVnrPzHD8Fu06qczr9RHJRf9jx+BVkRGMEOkwJ
         LPhfT5RUtqHa3y5pDMmyqtQmFS1WMo+yE/06MbnPYE/ezdUXYywq8L1ogm1+a2/MR367
         CW+WmCFMl9hlCbxXIjuRBhbN+L8U60cM2WiGudWDiYu6TY0oEu87whlMHi7iKnO/za/Y
         2eGah13PmWUdxrc+CwQhUBuQIT0ytMROUM9n8Avm6b2kz7jNAbn44awSsRnrMctxeRye
         w9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVEGMzYJ4ssIf+0WTMUSBKAq+FgV5EEyqGiaRbDO3ys/e5tg/uoRpNJ9w9nqsIRDcI+hFa/YTFEDrgj+IJpgJ8phcOiIObRtU9KFCOols4=
X-Gm-Message-State: AOJu0YwfAjQ2kk5z+N/aUxYWOPuxXCJscmSycFD2lfFOfNZpgDJAgrvI
	u8P0E4vkcr7U0ICMBxZc12SENLHj4eKo3jAmLWMWJKyWx3GxWCbi0ykPsQ==
X-Google-Smtp-Source: AGHT+IFvecQNw3vBjk7JGY2LrhBhxWWm77PqIhzy4pvg/ojficQj46hLUyIGzQx1VUChq8w7s6lo7Q==
X-Received: by 2002:a05:600c:a688:b0:419:f4d6:5044 with SMTP id ip8-20020a05600ca68800b00419f4d65044mr2491277wmb.2.1713698082362;
        Sun, 21 Apr 2024 04:14:42 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm16674387wmb.44.2024.04.21.04.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:14:42 -0700 (PDT)
Message-ID: <a9b6c7c3-69fb-4e3f-aaed-3d4b0b39cdb6@grimberg.me>
Date: Sun, 21 Apr 2024 14:14:40 +0300
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
 <4c599101-71af-46b0-bbc0-dcb868ed9f43@grimberg.me>
 <b628f390-a8c7-4145-ab9e-73022af4b951@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b628f390-a8c7-4145-ab9e-73022af4b951@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_041448_424292_5840DF7E 
X-CRM114-Status: GOOD (  34.58  )
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



On 09/04/2024 0:48, Hannes Reinecke wrote:
> On 4/8/24 23:09, Sagi Grimberg wrote:
>>
>>
>> On 08/04/2024 8:32, Hannes Reinecke wrote:
>>> On 4/7/24 23:41, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> Add a fabrics option 'concat' to request secure channel 
>>>>> concatenation.
>>>>
>>>> maybe name it secconcat ? or secure_concat ?
>>>>
>>>>> When secure channel concatenation is enabled a 'generated PSK' is 
>>>>> inserted
>>>>> into the keyring such that it's available after reset.
>>>>
>>>> Umm, I'm not sure what this means? Is this the revoke action? what if
>>>> the user passes a keyring? I'm not entirely sure what is the 
>>>> interface semantics here.
>>>>
>>> No, this is not the 'revoke' action. This is the modification TP8018
>>> brought in. For secure concatenation the initial connection is done
>>> without encryption, DH-CHAP is run and generates the TLS PSK. Then
>>> the connection is reset, and the new connection starts TLS with the
>>> generated key.
>>
>> Yes, I misread "it's available" and "it's not available". Sorry.
>>
>>>
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/host/auth.c    | 108 
>>>>> ++++++++++++++++++++++++++++++++++--
>>>>>   drivers/nvme/host/fabrics.c |  25 ++++++++-
>>>>>   drivers/nvme/host/fabrics.h |   3 +
>>>>>   drivers/nvme/host/sysfs.c   |   2 +
>>>>>   drivers/nvme/host/tcp.c     |  53 ++++++++++++++++--
>>>>>   include/linux/nvme.h        |   7 +++
>>>>>   6 files changed, 186 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>>> index a264b3ae078b..a4033a8f9607 100644
>>>>> --- a/drivers/nvme/host/auth.c
>>>>> +++ b/drivers/nvme/host/auth.c
>>>>> @@ -12,6 +12,7 @@
>>>>>   #include "nvme.h"
>>>>>   #include "fabrics.h"
>>>>>   #include <linux/nvme-auth.h>
>>>>> +#include <linux/nvme-keyring.h>
>>>>>   #define CHAP_BUF_SIZE 4096
>>>>>   static struct kmem_cache *nvme_chap_buf_cache;
>>>>> @@ -131,7 +132,12 @@ static int 
>>>>> nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>>>>>       data->auth_type = NVME_AUTH_COMMON_MESSAGES;
>>>>>       data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>>>>>       data->t_id = cpu_to_le16(chap->transaction);
>>>>> -    data->sc_c = 0; /* No secure channel concatenation */
>>>>> +    if (!ctrl->opts->concat || chap->qid != 0)
>>>>> +        data->sc_c = NVME_AUTH_SECP_NOSC;
>>>>> +    else if (ctrl->opts->tls_key)
>>>>> +        data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
>>>>> +    else
>>>>> +        data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
>>>>>       data->napd = 1;
>>>>>       data->auth_protocol[0].dhchap.authid = 
>>>>> NVME_AUTH_DHCHAP_AUTH_ID;
>>>>>       data->auth_protocol[0].dhchap.halen = 3;
>>>>> @@ -311,8 +317,9 @@ static int 
>>>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>>>       data->hl = chap->hash_len;
>>>>>       data->dhvlen = cpu_to_le16(chap->host_key_len);
>>>>>       memcpy(data->rval, chap->response, chap->hash_len);
>>>>> -    if (ctrl->ctrl_key) {
>>>>> +    if (ctrl->ctrl_key)
>>>>>           chap->bi_directional = true;
>>>>> +    if (ctrl->ctrl_key || ctrl->opts->concat) {
>>>>>           get_random_bytes(chap->c2, chap->hash_len);
>>>>>           data->cvalid = 1;
>>>>>           memcpy(data->rval + chap->hash_len, chap->c2,
>>>>> @@ -322,7 +329,10 @@ static int 
>>>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>>>       } else {
>>>>>           memset(chap->c2, 0, chap->hash_len);
>>>>>       }
>>>>> -    chap->s2 = nvme_auth_get_seqnum();
>>>>> +    if (ctrl->opts->concat)
>>>>> +        chap->s2 = 0;
>>>>> +    else
>>>>> +        chap->s2 = nvme_auth_get_seqnum();
>>>>>       data->seqnum = cpu_to_le32(chap->s2);
>>>>>       if (chap->host_key_len) {
>>>>>           dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
>>>>> @@ -677,6 +687,79 @@ static void nvme_auth_free_dhchap(struct 
>>>>> nvme_dhchap_queue_context *chap)
>>>>>           crypto_free_kpp(chap->dh_tfm);
>>>>>   }
>>>>> +static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>>>>> +                   struct nvme_dhchap_queue_context *chap)
>>>>> +{
>>>>> +    u8 *psk, *digest, *tls_psk;
>>>>> +    struct key *tls_key;
>>>>> +    size_t psk_len;
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    if (!chap->sess_key) {
>>>>> +        dev_warn(ctrl->device,
>>>>> +             "%s: qid %d no session key negotiated\n",
>>>>> +             __func__, chap->qid);
>>>>> +        return -ENOKEY;
>>>>> +    }
>>>>> +
>>>>> +    psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
>>>>> +                     chap->sess_key_len,
>>>>> +                     chap->c1, chap->c2,
>>>>> +                     chap->hash_len, &psk_len);
>>>>> +    if (IS_ERR(psk)) {
>>>>> +        ret = PTR_ERR(psk);
>>>>> +        dev_warn(ctrl->device,
>>>>> +             "%s: qid %d failed to generate PSK, error %d\n",
>>>>> +             __func__, chap->qid, ret);
>>>>> +        return ret;
>>>>> +    }
>>>>> +    dev_dbg(ctrl->device,
>>>>> +          "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
>>>>> +
>>>>> +    digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
>>>>> +                       ctrl->opts->subsysnqn,
>>>>> +                       ctrl->opts->host->nqn);
>>>>> +    if (IS_ERR(digest)) {
>>>>> +        ret = PTR_ERR(digest);
>>>>> +        dev_warn(ctrl->device,
>>>>> +             "%s: qid %d failed to generate digest, error %d\n",
>>>>> +             __func__, chap->qid, ret);
>>>>> +        goto out_free_psk;
>>>>> +    };
>>>>> +    dev_dbg(ctrl->device, "%s: generated digest %s\n",
>>>>> +         __func__, digest);
>>>>> +    tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, 
>>>>> psk_len, digest);
>>>>> +    if (IS_ERR(tls_psk)) {
>>>>> +        ret = PTR_ERR(tls_psk);
>>>>> +        dev_warn(ctrl->device,
>>>>> +             "%s: qid %d failed to derive TLS psk, error %d\n",
>>>>> +             __func__, chap->qid, ret);
>>>>> +        goto out_free_digest;
>>>>> +    };
>>>>> +
>>>>> +    tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, 
>>>>> ctrl->opts->host->nqn,
>>>>> +                       ctrl->opts->subsysnqn, chap->hash_id,
>>>>> +                       true, tls_psk, psk_len, digest);
>>>>> +    if (IS_ERR(tls_key)) {
>>>>> +        ret = PTR_ERR(tls_key);
>>>>> +        dev_warn(ctrl->device,
>>>>> +             "%s: qid %d failed to insert generated key, error 
>>>>> %d\n",
>>>>> +             __func__, chap->qid, ret);
>>>>> +        tls_key = NULL;
>>>>> +        kfree_sensitive(tls_psk);
>>>>> +    }
>>>>> +    if (ctrl->opts->tls_key) {
>>>>> +        key_revoke(ctrl->opts->tls_key);
>>>>> +        key_put(ctrl->opts->tls_key);
>>>>> +    }
>>>>
>>>> Question, is this for the case where the user passes both tls_key and
>>>> concat? Is this something that we expect users to do? What is the
>>>> benefit?
>>
>> Answer?
>>
> Once DH-HMAC-CHAP is run a new key is generated, and that key should 
> be used for the subsequent TLS connection. So I need to find a 
> location where to store the key, _and_ be sure that the key reference 
> is kept intact during controller reset (which I need to do to 
> establish the TLS connection).
> So I store the generated key in 'opts->tls_key', as this structure is 
> kept around throughout the lifetime of a connection.

Why do you store a generated key in opts? That is supposed to hold what 
the user passed.

> I am aware that the controller structure has a 'tls_key' entry, too, but
> this holds the key being negotiated from the TLS handshake, so we cannot
> store it there.

I suggest to introduce a new tls_generated_key ctrl member. Lets not 
overload
opts->tls_key which is designed to hold the a user driven tls_key 
(unless I'm misunderstanding
what you are saying?).


> For reference, the schedule is:
> ctrl->opts->tls_key: key to be used for the TLS handshake, overriding
>  the default selection scheme

This is what the user passes in?

> ctrl->tls_key: negotiated key from TLS handshake on the admin channel.
>  Defines the key to be used for the I/O channels; I/O channels do
>  _not_ use the default selection scheme
> queue->tls_pskid: serial number of the negotiated keys from the TLS
>  handshake.

what do you mean by "negotiated keys"? plural?

> I do agree that we could use a flag instead of the per-queue tls pskid,
> but then we'll lose the information _which_ key had been used for
> the TLS handshake.

Isn't it stored in the ctrl?

> Keys will be regenerated after each DH-CHAP
> negotiation, and the spec allows for running DH-CHAP negotiation
> on the encrypted connection.
> (Not that it's currently implemented, but we might want to eventually).
> In that cases we would need to know which key is currently active
> on the TLS connection. That information is pretty much opaque as
> the in-kernel crypto is using derived key information, and we cannot
> get the original key information via any other means.
> So I'd rather keep it.

Can you give a concrete example of what info you are missing?
I'm not following...

