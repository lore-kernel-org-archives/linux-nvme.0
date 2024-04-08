Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E90CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCcR1wfc4WKTu9YTYKU1T4KZlFpF0SfXB/VbUfY5k2U=; b=MwYo+1dImS3Vy9i7arUm2NYsvL
	d2w4DvBYqikGCjsh2fYOcDclSyRSLY5VvvLS0OekRBqpQnXCrKB9xiAErG6Zy8xgceMDrJKwTuJbv
	cmp/TbIsDCTeOEMnvkTxwWzUvu8kGGCQd20HlYjYKtiFbMkLy5VRTEOjicQR0XthKui/QIDAPFY6a
	4ESr9CJLa7qAJGs9dBvqSmkunl5lvAKlAVqgkvh/jWOrtXUlx552whbCAyObKJVZv0mG4k9sL5phP
	HqbP5w3zSvwddGNOQMK6dUvzZePSIIhfdKt0ag4g+rGBHRAcUWSXtiS1YjS0KbIkwJDYQL9+tzC6l
	HmFysyeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwqr-0000000GwJz-0Xc3;
	Mon, 08 Apr 2024 21:48:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwqk-0000000GwIM-0ReY
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:48:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A566022D57;
	Mon,  8 Apr 2024 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712612899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCcR1wfc4WKTu9YTYKU1T4KZlFpF0SfXB/VbUfY5k2U=;
	b=qqxzyjIE3Y+ROd/PFJUsI5dCIjcJvj2nMwgOL3anOdo/eya4Iewq2ldmvSbEnqT02GQ6eC
	PtrND3SvyFz2GeV7Utq6c3/9zI2zME7Je19xQTc04Ebzy5nzliBR1m/U81RE1YjZA4vAv7
	LSl6a0NFa1WQM4/mZXI4ouLbaEgxHSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712612899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCcR1wfc4WKTu9YTYKU1T4KZlFpF0SfXB/VbUfY5k2U=;
	b=s5MK48/tYYnS/+RAtRl5WVrtxKtPqS7yPh/4pqaJw2ogaGiTOGBlvzbsvQ2UOI/baEkqeh
	sZhiNkmTTxtmSkBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qqxzyjIE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="s5MK48/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712612899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCcR1wfc4WKTu9YTYKU1T4KZlFpF0SfXB/VbUfY5k2U=;
	b=qqxzyjIE3Y+ROd/PFJUsI5dCIjcJvj2nMwgOL3anOdo/eya4Iewq2ldmvSbEnqT02GQ6eC
	PtrND3SvyFz2GeV7Utq6c3/9zI2zME7Je19xQTc04Ebzy5nzliBR1m/U81RE1YjZA4vAv7
	LSl6a0NFa1WQM4/mZXI4ouLbaEgxHSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712612899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCcR1wfc4WKTu9YTYKU1T4KZlFpF0SfXB/VbUfY5k2U=;
	b=s5MK48/tYYnS/+RAtRl5WVrtxKtPqS7yPh/4pqaJw2ogaGiTOGBlvzbsvQ2UOI/baEkqeh
	sZhiNkmTTxtmSkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C6A013675;
	Mon,  8 Apr 2024 21:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xr6oGCNmFGZpOAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 21:48:19 +0000
Message-ID: <b628f390-a8c7-4145-ab9e-73022af4b951@suse.de>
Date: Mon, 8 Apr 2024 23:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] nvme-tcp: request secure channel concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-12-hare@kernel.org>
 <7102826f-b92c-4546-a351-159b8a7dd233@grimberg.me>
 <616d5ebc-0f75-4be9-beff-f8ee24fe71d3@suse.de>
 <4c599101-71af-46b0-bbc0-dcb868ed9f43@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4c599101-71af-46b0-bbc0-dcb868ed9f43@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A566022D57
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_144822_580188_E66E4ECF 
X-CRM114-Status: GOOD (  26.49  )
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

On 4/8/24 23:09, Sagi Grimberg wrote:
> 
> 
> On 08/04/2024 8:32, Hannes Reinecke wrote:
>> On 4/7/24 23:41, Sagi Grimberg wrote:
>>>
>>>
>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> Add a fabrics option 'concat' to request secure channel concatenation.
>>>
>>> maybe name it secconcat ? or secure_concat ?
>>>
>>>> When secure channel concatenation is enabled a 'generated PSK' is 
>>>> inserted
>>>> into the keyring such that it's available after reset.
>>>
>>> Umm, I'm not sure what this means? Is this the revoke action? what if
>>> the user passes a keyring? I'm not entirely sure what is the 
>>> interface semantics here.
>>>
>> No, this is not the 'revoke' action. This is the modification TP8018
>> brought in. For secure concatenation the initial connection is done
>> without encryption, DH-CHAP is run and generates the TLS PSK. Then
>> the connection is reset, and the new connection starts TLS with the
>> generated key.
> 
> Yes, I misread "it's available" and "it's not available". Sorry.
> 
>>
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/host/auth.c    | 108 
>>>> ++++++++++++++++++++++++++++++++++--
>>>>   drivers/nvme/host/fabrics.c |  25 ++++++++-
>>>>   drivers/nvme/host/fabrics.h |   3 +
>>>>   drivers/nvme/host/sysfs.c   |   2 +
>>>>   drivers/nvme/host/tcp.c     |  53 ++++++++++++++++--
>>>>   include/linux/nvme.h        |   7 +++
>>>>   6 files changed, 186 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>> index a264b3ae078b..a4033a8f9607 100644
>>>> --- a/drivers/nvme/host/auth.c
>>>> +++ b/drivers/nvme/host/auth.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include "nvme.h"
>>>>   #include "fabrics.h"
>>>>   #include <linux/nvme-auth.h>
>>>> +#include <linux/nvme-keyring.h>
>>>>   #define CHAP_BUF_SIZE 4096
>>>>   static struct kmem_cache *nvme_chap_buf_cache;
>>>> @@ -131,7 +132,12 @@ static int 
>>>> nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>>>>       data->auth_type = NVME_AUTH_COMMON_MESSAGES;
>>>>       data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>>>>       data->t_id = cpu_to_le16(chap->transaction);
>>>> -    data->sc_c = 0; /* No secure channel concatenation */
>>>> +    if (!ctrl->opts->concat || chap->qid != 0)
>>>> +        data->sc_c = NVME_AUTH_SECP_NOSC;
>>>> +    else if (ctrl->opts->tls_key)
>>>> +        data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
>>>> +    else
>>>> +        data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
>>>>       data->napd = 1;
>>>>       data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
>>>>       data->auth_protocol[0].dhchap.halen = 3;
>>>> @@ -311,8 +317,9 @@ static int 
>>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>>       data->hl = chap->hash_len;
>>>>       data->dhvlen = cpu_to_le16(chap->host_key_len);
>>>>       memcpy(data->rval, chap->response, chap->hash_len);
>>>> -    if (ctrl->ctrl_key) {
>>>> +    if (ctrl->ctrl_key)
>>>>           chap->bi_directional = true;
>>>> +    if (ctrl->ctrl_key || ctrl->opts->concat) {
>>>>           get_random_bytes(chap->c2, chap->hash_len);
>>>>           data->cvalid = 1;
>>>>           memcpy(data->rval + chap->hash_len, chap->c2,
>>>> @@ -322,7 +329,10 @@ static int 
>>>> nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>>>>       } else {
>>>>           memset(chap->c2, 0, chap->hash_len);
>>>>       }
>>>> -    chap->s2 = nvme_auth_get_seqnum();
>>>> +    if (ctrl->opts->concat)
>>>> +        chap->s2 = 0;
>>>> +    else
>>>> +        chap->s2 = nvme_auth_get_seqnum();
>>>>       data->seqnum = cpu_to_le32(chap->s2);
>>>>       if (chap->host_key_len) {
>>>>           dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
>>>> @@ -677,6 +687,79 @@ static void nvme_auth_free_dhchap(struct 
>>>> nvme_dhchap_queue_context *chap)
>>>>           crypto_free_kpp(chap->dh_tfm);
>>>>   }
>>>> +static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>>>> +                   struct nvme_dhchap_queue_context *chap)
>>>> +{
>>>> +    u8 *psk, *digest, *tls_psk;
>>>> +    struct key *tls_key;
>>>> +    size_t psk_len;
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!chap->sess_key) {
>>>> +        dev_warn(ctrl->device,
>>>> +             "%s: qid %d no session key negotiated\n",
>>>> +             __func__, chap->qid);
>>>> +        return -ENOKEY;
>>>> +    }
>>>> +
>>>> +    psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
>>>> +                     chap->sess_key_len,
>>>> +                     chap->c1, chap->c2,
>>>> +                     chap->hash_len, &psk_len);
>>>> +    if (IS_ERR(psk)) {
>>>> +        ret = PTR_ERR(psk);
>>>> +        dev_warn(ctrl->device,
>>>> +             "%s: qid %d failed to generate PSK, error %d\n",
>>>> +             __func__, chap->qid, ret);
>>>> +        return ret;
>>>> +    }
>>>> +    dev_dbg(ctrl->device,
>>>> +          "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
>>>> +
>>>> +    digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
>>>> +                       ctrl->opts->subsysnqn,
>>>> +                       ctrl->opts->host->nqn);
>>>> +    if (IS_ERR(digest)) {
>>>> +        ret = PTR_ERR(digest);
>>>> +        dev_warn(ctrl->device,
>>>> +             "%s: qid %d failed to generate digest, error %d\n",
>>>> +             __func__, chap->qid, ret);
>>>> +        goto out_free_psk;
>>>> +    };
>>>> +    dev_dbg(ctrl->device, "%s: generated digest %s\n",
>>>> +         __func__, digest);
>>>> +    tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, 
>>>> digest);
>>>> +    if (IS_ERR(tls_psk)) {
>>>> +        ret = PTR_ERR(tls_psk);
>>>> +        dev_warn(ctrl->device,
>>>> +             "%s: qid %d failed to derive TLS psk, error %d\n",
>>>> +             __func__, chap->qid, ret);
>>>> +        goto out_free_digest;
>>>> +    };
>>>> +
>>>> +    tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, 
>>>> ctrl->opts->host->nqn,
>>>> +                       ctrl->opts->subsysnqn, chap->hash_id,
>>>> +                       true, tls_psk, psk_len, digest);
>>>> +    if (IS_ERR(tls_key)) {
>>>> +        ret = PTR_ERR(tls_key);
>>>> +        dev_warn(ctrl->device,
>>>> +             "%s: qid %d failed to insert generated key, error %d\n",
>>>> +             __func__, chap->qid, ret);
>>>> +        tls_key = NULL;
>>>> +        kfree_sensitive(tls_psk);
>>>> +    }
>>>> +    if (ctrl->opts->tls_key) {
>>>> +        key_revoke(ctrl->opts->tls_key);
>>>> +        key_put(ctrl->opts->tls_key);
>>>> +    }
>>>
>>> Question, is this for the case where the user passes both tls_key and
>>> concat? Is this something that we expect users to do? What is the
>>> benefit?
> 
> Answer?
> 
Once DH-HMAC-CHAP is run a new key is generated, and that key should be 
used for the subsequent TLS connection. So I need to find a location 
where to store the key, _and_ be sure that the key reference is kept 
intact during controller reset (which I need to do to establish the TLS 
connection).
So I store the generated key in 'opts->tls_key', as this structure is 
kept around throughout the lifetime of a connection.
I am aware that the controller structure has a 'tls_key' entry, too, but
this holds the key being negotiated from the TLS handshake, so we cannot
store it there.
For reference, the schedule is:
ctrl->opts->tls_key: key to be used for the TLS handshake, overriding
  the default selection scheme
ctrl->tls_key: negotiated key from TLS handshake on the admin channel.
  Defines the key to be used for the I/O channels; I/O channels do
  _not_ use the default selection scheme
queue->tls_pskid: serial number of the negotiated keys from the TLS
  handshake.

I do agree that we could use a flag instead of the per-queue tls pskid,
but then we'll lose the information _which_ key had been used for
the TLS handshake. Keys will be regenerated after each DH-CHAP
negotiation, and the spec allows for running DH-CHAP negotiation
on the encrypted connection.
(Not that it's currently implemented, but we might want to eventually).
In that cases we would need to know which key is currently active
on the TLS connection. That information is pretty much opaque as
the in-kernel crypto is using derived key information, and we cannot
get the original key information via any other means.
So I'd rather keep it.

Cheers,

Hannes


