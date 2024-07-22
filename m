Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A806EC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tevFfztA1vOmPaKOAEyIj0VDt2xNhRsgTuW3UnLWeQ8=; b=Dw3ZzRJibBnsVjSgh2uJi9Yvih
	TM/QQloXsrCiZlmyQ6vGl/WvAAu51ddMJ9BNxyR7qT7NTwE7hISiDTXa5bQSX+Lxc0X1etwLsgcDl
	t6LaKujm9/kEVHaq831VC2Sr2p2Ul8PM3NOzlLKIXWwIfucR1QI2mgYKP9TaYGKtFwDYYLkNUSuge
	ftbhzOp7vFdVGNPQ1+we5a1rFLckNIUowghEcbgpEINrTyIeGqEfgbdj+VUh0Os0KlOEupMaKlwF5
	RJVl3+fs0S3yDxYh9p4lT97rwJ7qOVIAdFOWkWYWTzqGG7BJpvgeOv5OR5kdfUrMwVDIAZdccsfKn
	aqXDc4UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmev-00000008XD8-4AP8;
	Mon, 22 Jul 2024 06:36:34 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVmeq-00000008XC7-3eVZ
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 06:36:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 448292199D;
	Mon, 22 Jul 2024 06:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721630186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tevFfztA1vOmPaKOAEyIj0VDt2xNhRsgTuW3UnLWeQ8=;
	b=ScIcYgxHp6g0vzUvOmzREpcsFmAxMTMiWQOfdWdMMw3+60NW9kDMeO4fnQ7usOuQCewkFr
	MVC+xSjr8xAGNzh5wsE1ul6Z1sbMOox9LnEbmlMnLTbQvcVwGP9zmw/eVh9IqlLGTOqWJp
	umeQElEV2pab8wowfUOMEQFpo7KukFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721630186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tevFfztA1vOmPaKOAEyIj0VDt2xNhRsgTuW3UnLWeQ8=;
	b=lX3IZyBdLpLN43YjAGIUucIpTWkTLMcDgjcPt/bs1twlDWg/ocsxfME0E9GcqtvnfXR4nB
	UersGQv8RdA5ymCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ScIcYgxH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lX3IZyBd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721630186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tevFfztA1vOmPaKOAEyIj0VDt2xNhRsgTuW3UnLWeQ8=;
	b=ScIcYgxHp6g0vzUvOmzREpcsFmAxMTMiWQOfdWdMMw3+60NW9kDMeO4fnQ7usOuQCewkFr
	MVC+xSjr8xAGNzh5wsE1ul6Z1sbMOox9LnEbmlMnLTbQvcVwGP9zmw/eVh9IqlLGTOqWJp
	umeQElEV2pab8wowfUOMEQFpo7KukFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721630186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tevFfztA1vOmPaKOAEyIj0VDt2xNhRsgTuW3UnLWeQ8=;
	b=lX3IZyBdLpLN43YjAGIUucIpTWkTLMcDgjcPt/bs1twlDWg/ocsxfME0E9GcqtvnfXR4nB
	UersGQv8RdA5ymCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB0D0136A9;
	Mon, 22 Jul 2024 06:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hKXJNun9nWblOQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Jul 2024 06:36:25 +0000
Message-ID: <d9a1f599-eea8-4069-8f95-3778280010e5@suse.de>
Date: Mon, 22 Jul 2024 08:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: request secure channel concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240718150658.99580-1-hare@kernel.org>
 <20240718150658.99580-7-hare@kernel.org>
 <271ab7cc-d766-4527-805f-a20107998beb@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <271ab7cc-d766-4527-805f-a20107998beb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 448292199D
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_233629_249316_A83BF0F5 
X-CRM114-Status: GOOD (  24.26  )
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

On 7/21/24 13:27, Sagi Grimberg wrote:
> 
> 
> 
> On 18/07/2024 18:06, Hannes Reinecke wrote:
>> Add a fabrics option 'concat' to request secure channel concatenation.
>> When secure channel concatenation is enabled a 'generated PSK' is 
>> inserted
>> into the keyring such that it's available after reset.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/auth.c    | 100 ++++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/fabrics.c |  34 ++++++++++--
>>   drivers/nvme/host/fabrics.h |   3 ++
>>   drivers/nvme/host/tcp.c     |  56 +++++++++++++++++---
>>   include/linux/nvme.h        |   7 +++
>>   5 files changed, 188 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 371e14f0a203..5f71aa7b5e27 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -12,6 +12,7 @@
>>   #include "nvme.h"
>>   #include "fabrics.h"
>>   #include <linux/nvme-auth.h>
>> +#include <linux/nvme-keyring.h>
>>   #define CHAP_BUF_SIZE 4096
>>   static struct kmem_cache *nvme_chap_buf_cache;
>> @@ -131,7 +132,12 @@ static int 
>> nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>>       data->auth_type = NVME_AUTH_COMMON_MESSAGES;
>>       data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>>       data->t_id = cpu_to_le16(chap->transaction);
>> -    data->sc_c = 0; /* No secure channel concatenation */
>> +    if (!ctrl->opts->concat || chap->qid != 0)
>> +        data->sc_c = NVME_AUTH_SECP_NOSC;
>> +    else if (ctrl->opts->tls_key)
>> +        data->sc_c = NVME_AUTH_SECP_REPLACETLSPSK;
>> +    else
>> +        data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
>>       data->napd = 1;
>>       data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
>>       data->auth_protocol[0].dhchap.halen = 3;
>> @@ -311,8 +317,9 @@ static int nvme_auth_set_dhchap_reply_data(struct 
>> nvme_ctrl *ctrl,
>>       data->hl = chap->hash_len;
>>       data->dhvlen = cpu_to_le16(chap->host_key_len);
>>       memcpy(data->rval, chap->response, chap->hash_len);
>> -    if (ctrl->ctrl_key) {
>> +    if (ctrl->ctrl_key)
>>           chap->bi_directional = true;
>> +    if (ctrl->ctrl_key || ctrl->opts->concat) {
>>           get_random_bytes(chap->c2, chap->hash_len);
>>           data->cvalid = 1;
>>           memcpy(data->rval + chap->hash_len, chap->c2,
>> @@ -322,7 +329,10 @@ static int nvme_auth_set_dhchap_reply_data(struct 
>> nvme_ctrl *ctrl,
>>       } else {
>>           memset(chap->c2, 0, chap->hash_len);
>>       }
>> -    chap->s2 = nvme_auth_get_seqnum();
>> +    if (ctrl->opts->concat)
>> +        chap->s2 = 0;
>> +    else
>> +        chap->s2 = nvme_auth_get_seqnum();
>>       data->seqnum = cpu_to_le32(chap->s2);
>>       if (chap->host_key_len) {
>>           dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
>> @@ -677,6 +687,76 @@ static void nvme_auth_free_dhchap(struct 
>> nvme_dhchap_queue_context *chap)
>>           crypto_free_kpp(chap->dh_tfm);
>>   }
>> +static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>> +                   struct nvme_dhchap_queue_context *chap)
>> +{
>> +    u8 *psk, *digest, *tls_psk;
>> +    struct key *tls_key;
>> +    size_t psk_len;
>> +    int ret = 0;
>> +
>> +    if (!chap->sess_key) {
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d no session key negotiated\n",
>> +             __func__, chap->qid);
>> +        return -ENOKEY;
>> +    }
>> +
>> +    ret = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
>> +                     chap->sess_key_len,
>> +                     chap->c1, chap->c2,
>> +                     chap->hash_len, &psk, &psk_len);
>> +    if (ret) {
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to generate PSK, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        return ret;
>> +    }
>> +    dev_dbg(ctrl->device,
>> +          "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
>> +
>> +    ret = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
>> +                    ctrl->opts->subsysnqn,
>> +                    ctrl->opts->host->nqn, &digest);
>> +    if (ret) {
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to generate digest, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        goto out_free_psk;
>> +    };
>> +    dev_dbg(ctrl->device, "%s: generated digest %s\n",
>> +         __func__, digest);
>> +    ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, 
>> digest, &tls_psk);
>> +    if (ret) {
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to derive TLS psk, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        goto out_free_digest;
>> +    };
>> +
>> +    tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring, 
>> ctrl->opts->host->nqn,
>> +                       ctrl->opts->subsysnqn, chap->hash_id,
>> +                       true, tls_psk, psk_len, digest);
>> +    if (IS_ERR(tls_key)) {
>> +        ret = PTR_ERR(tls_key);
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to insert generated key, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        tls_key = NULL;
>> +        kfree_sensitive(tls_psk);
>> +    }
>> +    if (ctrl->opts->tls_key) {
>> +        key_revoke(ctrl->opts->tls_key);
>> +        key_put(ctrl->opts->tls_key);
>> +    }
> 
> Any reason why error in nvme_tls_psk_refres() does not goto the normal 
> error handling? Is it acceptable to fail here? Maybe I'm missing 
> something...

Hmm? But we do; we are setting 'ret' to a non-zero value, and then
trigger the normal error handling ...
Or did you mean something else?

>> +    ctrl->opts->tls_key = tls_key;
>> +out_free_digest:
>> +    kfree_sensitive(digest);
>> +out_free_psk:
>> +    kfree_sensitive(psk);
>> +    return ret;
>> +}
>> +
>>   static void nvme_queue_auth_work(struct work_struct *work)
>>   {
>>       struct nvme_dhchap_queue_context *chap =
>> @@ -833,6 +913,14 @@ static void nvme_queue_auth_work(struct 
>> work_struct *work)
>>       }
>>       if (!ret) {
>>           chap->error = 0;
>> +        /* Secure concatenation can only be enabled on the admin 
>> queue */
>> +        if (!chap->qid && ctrl->opts->concat &&
>> +            (ret = nvme_auth_secure_concat(ctrl, chap))) {
>> +            dev_warn(ctrl->device,
>> +                 "%s: qid %d failed to enable secure concatenation\n",
>> +                 __func__, chap->qid);
>> +            chap->error = ret;
>> +        }
>>           return;
>>       }
>> @@ -912,6 +1000,12 @@ static void nvme_ctrl_auth_work(struct 
>> work_struct *work)
>>                "qid 0: authentication failed\n");
>>           return;
>>       }
>> +    /*
>> +     * Only run authentication on the admin queue for
>> +     * secure concatenation
>> +     */
>> +    if (ctrl->opts->concat)
>> +        return;
>>       for (q = 1; q < ctrl->queue_count; q++) {
>>           ret = nvme_auth_negotiate(ctrl, q);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 432efcbf9e2f..93e9041b9657 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -472,8 +472,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>       result = le32_to_cpu(res.u32);
>>       ctrl->cntlid = result & 0xFFFF;
>>       if (result & (NVME_CONNECT_AUTHREQ_ATR | 
>> NVME_CONNECT_AUTHREQ_ASCR)) {
>> -        /* Secure concatenation is not implemented */
>> -        if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>> +        /* Check for secure concatenation */
>> +        if ((result & NVME_CONNECT_AUTHREQ_ASCR) &&
>> +            !ctrl->opts->concat) {
>>               dev_warn(ctrl->device,
>>                    "qid 0: secure concatenation is not supported\n");
>>               ret = -EOPNOTSUPP;
>> @@ -550,7 +551,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>>           /* Secure concatenation is not implemented */
>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>               dev_warn(ctrl->device,
>> -                 "qid 0: secure concatenation is not supported\n");
>> +                 "qid %d: secure concatenation is not supported\n", 
>> qid);
>>               ret = -EOPNOTSUPP;
>>               goto out_free_data;
>>           }
>> @@ -706,6 +707,7 @@ static const match_table_t opt_tokens = {
>>   #endif
>>   #ifdef CONFIG_NVME_TCP_TLS
>>       { NVMF_OPT_TLS,            "tls"            },
>> +    { NVMF_OPT_CONCAT,        "concat"        },
>>   #endif
>>       { NVMF_OPT_ERR,            NULL            }
>>   };
>> @@ -735,6 +737,7 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       opts->tls = false;
>>       opts->tls_key = NULL;
>>       opts->keyring = NULL;
>> +    opts->concat = false;
>>       options = o = kstrdup(buf, GFP_KERNEL);
>>       if (!options)
>> @@ -1053,6 +1056,14 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               }
>>               opts->tls = true;
>>               break;
>> +        case NVMF_OPT_CONCAT:
>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> +                pr_err("TLS is not supported\n");
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            opts->concat = true;
>> +            break;
>>           default:
>>               pr_warn("unknown parameter or missing value '%s' in ctrl 
>> creation request\n",
>>                   p);
>> @@ -1079,6 +1090,23 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               pr_warn("failfast tmo (%d) larger than controller loss 
>> tmo (%d)\n",
>>                   opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>       }
>> +    if (opts->concat) {
>> +        if (opts->tls) {
>> +            pr_err("Secure concatenation over TLS is not supported\n");
>> +            ret = -EINVAL;
>> +            goto out;
>> +        }
>> +        if (opts->tls_key) {
>> +            pr_err("Cannot specify a TLS key for secure 
>> concatenation\n");
>> +            ret = -EINVAL;
>> +            goto out;
>> +        }
> 
> I think you mean it is unsupported?
> 
Of course.

>> +        if (!opts->dhchap_secret) {
>> +            pr_err("Need to enable DH-CHAP for secure concatenation\n");
>> +            ret = -EINVAL;
>> +            goto out;
>> +        }
>> +    }
>>       opts->host = nvmf_host_add(hostnqn, &hostid);
>>       if (IS_ERR(opts->host)) {
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 21d75dc4a3a0..9cf5b020adba 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -66,6 +66,7 @@ enum {
>>       NVMF_OPT_TLS        = 1 << 25,
>>       NVMF_OPT_KEYRING    = 1 << 26,
>>       NVMF_OPT_TLS_KEY    = 1 << 27,
>> +    NVMF_OPT_CONCAT        = 1 << 28,
>>   };
>>   /**
>> @@ -101,6 +102,7 @@ enum {
>>    * @keyring:    Keyring to use for key lookups
>>    * @tls_key:    TLS key for encrypted connections (TCP)
>>    * @tls:        Start TLS encrypted connections (TCP)
>> + * @concat:     Enabled Secure channel concatenation (TCP)
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>>    * @data_digest: generate/verify data digest (TCP)
>> @@ -130,6 +132,7 @@ struct nvmf_ctrl_options {
>>       struct key        *keyring;
>>       struct key        *tls_key;
>>       bool            tls;
>> +    bool            concat;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>>       bool            data_digest;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 5885aa452aa1..b748e4033df2 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -227,7 +227,7 @@ static inline bool nvme_tcp_tls_configured(struct 
>> nvme_ctrl *ctrl)
>>       if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>>           return 0;
>> -    return ctrl->opts->tls;
>> +    return ctrl->opts->tls || ctrl->opts->concat;
>>   }
>>   static inline struct blk_mq_tags *nvme_tcp_tagset(struct 
>> nvme_tcp_queue *queue)
>> @@ -1942,7 +1942,7 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>       if (nvme_tcp_tls_configured(ctrl)) {
>>           if (ctrl->opts->tls_key)
>>               pskid = key_serial(ctrl->opts->tls_key);
>> -        else {
>> +        else if (ctrl->opts->tls) {
>>               pskid = nvme_tls_psk_default(ctrl->opts->keyring,
>>                                 ctrl->opts->host->nqn,
>>                                 ctrl->opts->subsysnqn);
>> @@ -1972,9 +1972,25 @@ static int __nvme_tcp_alloc_io_queues(struct 
>> nvme_ctrl *ctrl)
>>   {
>>       int i, ret;
>> -    if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
>> -        dev_err(ctrl->device, "no PSK negotiated\n");
>> -        return -ENOKEY;
>> +    if (nvme_tcp_tls_configured(ctrl)) {
>> +        if (ctrl->opts->concat) {
>> +            /*
>> +             * The generated PSK is stored in the
>> +             * fabric options
>> +             */
>> +            if (!ctrl->opts->tls_key) {
>> +                dev_err(ctrl->device, "no PSK generated\n");
>> +                return -ENOKEY;
>> +            }
>> +            if (ctrl->tls_pskid &&
>> +                ctrl->tls_pskid != key_serial(ctrl->opts->tls_key)) {
>> +                dev_err(ctrl->device, "Stale PSK id %08x\n", 
>> ctrl->tls_pskid);
>> +                ctrl->tls_pskid = 0;
>> +            }
> 
> What is the user supposed to do with a stale psk? meaning why print an 
> error and continue as usual?
> 
Technically TLS handshake is independent from secure concatenation.
While we do generate a new TLS PSK from secure concatenation, there is
no guarantee that this TLS PSK is then selected from the TLS handshake.
So theoretically it's possible that the TLS handshake arrives at a 
different TLS PSK than the generated one.
But that is not actually an error, as both steps (authentication and
TLS handshake) have been successful. However, it's definitely an odd
situation, and we should tell the user about it.

>> +        } else if (!ctrl->tls_pskid) {
>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>> +            return -ENOKEY;
>> +        }
>>       }
>>       for (i = 1; i < ctrl->queue_count; i++) {
>> @@ -2205,6 +2221,30 @@ static void nvme_tcp_reconnect_or_remove(struct 
>> nvme_ctrl *ctrl,
>>       }
>>   }
>> +/*
>> + * The TLS key needs to be revoked when:
>> + * - concatenation is enabled and
>> + *   -> This is a generated key and only valid for this session
>> + * - the generated key is present in ctrl->tls_key and
>> + *   -> authentication has completed and the key has been generated
>> + * - tls has been enabled
>> + *   -> otherwise we are about to reset the admin queue after 
>> authentication
>> + *      to enable TLS with the generated key
>> + */
>> +static bool nvme_tcp_key_revoke_needed(struct nvme_ctrl *ctrl)
>> +{
>> +    return ctrl->opts->concat && ctrl->opts->tls_key && ctrl->tls_pskid;
>> +}
>> +
>> +static void nvme_tcp_revoke_tls_key(struct nvme_ctrl *ctrl)
>> +{
>> +    dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
>> +        key_serial(ctrl->opts->tls_key));
>> +    key_revoke(ctrl->opts->tls_key);
>> +    key_put(ctrl->opts->tls_key);
>> +    ctrl->opts->tls_key = NULL;
>> +}
> 
> I think this belongs in a common place no?
> 
?
Where?
'ctrl-opts' is pretty much initiator specific, so I am not sure where
it should go ...

>> +
>>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>>   {
>>       struct nvmf_ctrl_options *opts = ctrl->opts;
>> @@ -2308,6 +2348,8 @@ static void nvme_tcp_error_recovery_work(struct 
>> work_struct *work)
>>                   struct nvme_tcp_ctrl, err_work);
>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>> +    if (nvme_tcp_key_revoke_needed(ctrl))
>> +        nvme_tcp_revoke_tls_key(ctrl);
> 
> Should this maybe move to nvme_tcp_teardown_admin_qeueue ?
> 

Good point, will do.

>>       nvme_stop_keep_alive(ctrl);
>>       flush_work(&ctrl->async_event_work);
>>       nvme_tcp_teardown_io_queues(ctrl, false);
>> @@ -2348,6 +2390,8 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, reset_work);
>>       int ret;
>> +    if (nvme_tcp_key_revoke_needed(ctrl))
>> +        nvme_tcp_revoke_tls_key(ctrl);
> 
> Would eliminate this call...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


