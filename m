Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E397C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 05:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJiJPd8WFdOFWS8kfd4kOetdxP1gj0QBEqJ5LiIMKUk=; b=OA9vTW0GWZDyIHdUrlqAauKDrO
	u6j0hYTPMMVrNfhx3ynR8a8n/z7nWJzo3nOhI2bAMHtrmZI5YtJUjsPnX8ac2IxaIA6Bol4/gDjZF
	FVQedDrgMOI1ug7IZWZPQNrkSV+JW50J4YifXqSCcbhm58Oem1bT8OctFj6iecFS0qaSePO50jtZj
	pKj1a0i/KcocalaSHCErBVYwYvekvXbqyTrT1XM6qNfMtyILAaTe/6QgDJEJZRfHJiA1854ETr6Ek
	IgJED4bdkAmVkHgK7NY9dkvxuwGucsY9olPL+qk+7t5d8qwL8rQTLknMqYcF9igD9Awmlbx/2n0En
	A5wzsOFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthcl-0000000EP7d-2yFG;
	Mon, 08 Apr 2024 05:32:55 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthca-0000000EP6V-30PT
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 05:32:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFBAD20164;
	Mon,  8 Apr 2024 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712554362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJiJPd8WFdOFWS8kfd4kOetdxP1gj0QBEqJ5LiIMKUk=;
	b=BftUz3O2K334UAl+8Pfm9RQUyBLTmq5JOzAWapV+5PneWMNOEzS4ihScQkdGjTziJfIyA9
	x4OWxsbrGrHfB933ACpJQPXnPHm5YURAifr0WpJgXLQb515M5SfPy2BKUYPoSriq19030K
	JdeNzFMb/Z+aR8wpMjZKGC1OnAf9v1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712554362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJiJPd8WFdOFWS8kfd4kOetdxP1gj0QBEqJ5LiIMKUk=;
	b=x684dART7oQV2S+f7sm5/HmFi9J9XE+RmJoFAMlydLMq4ugLP+p6fAg0cveeGGHV4Xhsz3
	J1yLma34OrjGU5Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SiRBGZzh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O31sEjEL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712554361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJiJPd8WFdOFWS8kfd4kOetdxP1gj0QBEqJ5LiIMKUk=;
	b=SiRBGZzhj8/Wr1qE0J4/4FDDy5AL31dHxCIUhTz7Cp3Js85sbGw8751dGXD+4oo7bCAnPy
	FIDLUnACTQbszy5Qt4JEa7Wfx/wX3drcEmK0qI9Ak3xRc0ML7mrPCTpP9HLg06mZhTI5Ey
	cN6YK8nWTIEMZN5Io1dzimrk8i0k2EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712554361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJiJPd8WFdOFWS8kfd4kOetdxP1gj0QBEqJ5LiIMKUk=;
	b=O31sEjELF65wSuDyqCHxQDRpkBB/Z03EJyCpjouP/lvxI4YKxU6N365gvnAI5aScxqHce5
	G1JHqq2f+D3fDKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 883FC13675;
	Mon,  8 Apr 2024 05:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGSJHnmBE2ZeOwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 05:32:41 +0000
Message-ID: <616d5ebc-0f75-4be9-beff-f8ee24fe71d3@suse.de>
Date: Mon, 8 Apr 2024 07:32:40 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7102826f-b92c-4546-a351-159b8a7dd233@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DFBAD20164
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_223245_124926_3CE77198 
X-CRM114-Status: GOOD (  29.54  )
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

On 4/7/24 23:41, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Add a fabrics option 'concat' to request secure channel concatenation.
> 
> maybe name it secconcat ? or secure_concat ?
> 
>> When secure channel concatenation is enabled a 'generated PSK' is 
>> inserted
>> into the keyring such that it's available after reset.
> 
> Umm, I'm not sure what this means? Is this the revoke action? what if
> the user passes a keyring? I'm not entirely sure what is the interface 
> semantics here.
> 
No, this is not the 'revoke' action. This is the modification TP8018
brought in. For secure concatenation the initial connection is done
without encryption, DH-CHAP is run and generates the TLS PSK. Then
the connection is reset, and the new connection starts TLS with the
generated key.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/auth.c    | 108 ++++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/fabrics.c |  25 ++++++++-
>>   drivers/nvme/host/fabrics.h |   3 +
>>   drivers/nvme/host/sysfs.c   |   2 +
>>   drivers/nvme/host/tcp.c     |  53 ++++++++++++++++--
>>   include/linux/nvme.h        |   7 +++
>>   6 files changed, 186 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index a264b3ae078b..a4033a8f9607 100644
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
>> @@ -677,6 +687,79 @@ static void nvme_auth_free_dhchap(struct 
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
>> +    psk = nvme_auth_generate_psk(chap->hash_id, chap->sess_key,
>> +                     chap->sess_key_len,
>> +                     chap->c1, chap->c2,
>> +                     chap->hash_len, &psk_len);
>> +    if (IS_ERR(psk)) {
>> +        ret = PTR_ERR(psk);
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to generate PSK, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        return ret;
>> +    }
>> +    dev_dbg(ctrl->device,
>> +          "%s: generated psk %*ph\n", __func__, (int)psk_len, psk);
>> +
>> +    digest = nvme_auth_generate_digest(chap->hash_id, psk, psk_len,
>> +                       ctrl->opts->subsysnqn,
>> +                       ctrl->opts->host->nqn);
>> +    if (IS_ERR(digest)) {
>> +        ret = PTR_ERR(digest);
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to generate digest, error %d\n",
>> +             __func__, chap->qid, ret);
>> +        goto out_free_psk;
>> +    };
>> +    dev_dbg(ctrl->device, "%s: generated digest %s\n",
>> +         __func__, digest);
>> +    tls_psk = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len, 
>> digest);
>> +    if (IS_ERR(tls_psk)) {
>> +        ret = PTR_ERR(tls_psk);
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
> Question, is this for the case where the user passes both tls_key and
> concat? Is this something that we expect users to do? What is the
> benefit?
> 
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
>> @@ -831,10 +914,21 @@ static void nvme_queue_auth_work(struct 
>> work_struct *work)
>>           if (ret)
>>               chap->error = ret;
>>       }
>> -    if (!ret) {
>> +    if (ret)
>> +        goto fail2;
>> +    if (chap->qid || !ctrl->opts->concat) {
>>           chap->error = 0;
>>           return;
>>       }
>> +    ret = nvme_auth_secure_concat(ctrl, chap);
>> +    if (ret) {
>> +        dev_warn(ctrl->device,
>> +             "%s: qid %d failed to enable secure concatenation\n",
>> +             __func__, chap->qid);
>> +        chap->error = ret;
>> +    } else
>> +        chap->error = 0;
>> +    return;
>>   fail2:
>>       if (chap->status == 0)
>> @@ -912,6 +1006,12 @@ static void nvme_ctrl_auth_work(struct 
>> work_struct *work)
>>                "qid 0: authentication failed\n");
>>           return;
>>       }
>> +    /*
>> +    * Only run authentication on the admin queue for
>> +    * secure concatenation
>> +     */
>> +    if (ctrl->opts->concat)
>> +        return;
>>       for (q = 1; q < ctrl->queue_count; q++) {
>>           ret = nvme_auth_negotiate(ctrl, q);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 75aa69457353..ae091e0e4ecf 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -463,8 +463,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
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
> 
> Perhaps the log msg should be adjusted as well.
> 
>>               ret = NVME_SC_AUTH_REQUIRED;
>> @@ -682,6 +683,7 @@ static const match_table_t opt_tokens = {
>>   #endif
>>   #ifdef CONFIG_NVME_TCP_TLS
>>       { NVMF_OPT_TLS,            "tls"            },
>> +    { NVMF_OPT_CONCAT,        "concat"        },
>>   #endif
>>       { NVMF_OPT_ERR,            NULL            }
>>   };
>> @@ -711,6 +713,7 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       opts->tls = false;
>>       opts->tls_key = NULL;
>>       opts->keyring = NULL;
>> +    opts->concat = false;
>>       options = o = kstrdup(buf, GFP_KERNEL);
>>       if (!options)
>> @@ -1029,6 +1032,14 @@ static int nvmf_parse_options(struct 
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
> 
> Isn't there a dependency with a dhchap auth rquested? meaning what 
> happens if the user
> did not pass a dhchap_secret?
> 
Ah, yes, indeed. Need to check for that.

>>           default:
>>               pr_warn("unknown parameter or missing value '%s' in ctrl 
>> creation request\n",
>>                   p);
>> @@ -1055,6 +1066,16 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               pr_warn("failfast tmo (%d) larger than controller loss 
>> tmo (%d)\n",
>>                   opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>       }
>> +    if (opts->concat && opts->tls) {
>> +        pr_err("Secure concatenation over TLS is not supported\n");
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +    if (opts->concat && opts->tls_key) {
>> +        pr_err("Cannot specify a TLS key for secure concatenation\n");
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>>       opts->host = nvmf_host_add(hostnqn, &hostid);
>>       if (IS_ERR(opts->host)) {
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 06cc54851b1b..accfc7228366 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -73,6 +73,7 @@ enum {
>>       NVMF_OPT_TLS        = 1 << 25,
>>       NVMF_OPT_KEYRING    = 1 << 26,
>>       NVMF_OPT_TLS_KEY    = 1 << 27,
>> +    NVMF_OPT_CONCAT        = 1 << 28,
>>   };
>>   /**
>> @@ -108,6 +109,7 @@ enum {
>>    * @keyring:    Keyring to use for key lookups
>>    * @tls_key:    TLS key for encrypted connections (TCP)
>>    * @tls:        Start TLS encrypted connections (TCP)
>> + * @concat:     Enabled Secure channel concatenation (TCP)
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>>    * @data_digest: generate/verify data digest (TCP)
>> @@ -137,6 +139,7 @@ struct nvmf_ctrl_options {
>>       struct key        *keyring;
>>       struct key        *tls_key;
>>       bool            tls;
>> +    bool            concat;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>>       bool            data_digest;
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 07ec26de2d91..edd96f501d8a 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -675,6 +675,8 @@ static ssize_t tls_key_show(struct device *dev,
>>       if (!key)
>>           return 0;
>> +    if (ctrl->opts->concat)
>> +        return 0;
>>       if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
>>           test_bit(KEY_FLAG_INVALIDATED, &key->flags))
>>           return -EKEYREVOKED;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 66675b2dc197..94152ded123a 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -219,7 +219,7 @@ static inline bool nvme_tcp_tls_configured(struct 
>> nvme_ctrl *ctrl)
>>       if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>>           return 0;
>> -    return ctrl->opts->tls;
>> +    return ctrl->opts->tls || ctrl->opts->concat;
>>   }
>>   static inline struct blk_mq_tags *nvme_tcp_tagset(struct 
>> nvme_tcp_queue *queue)
>> @@ -1941,7 +1941,7 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>       if (nvme_tcp_tls_configured(ctrl)) {
>>           if (ctrl->opts->tls_key)
>>               pskid = key_serial(ctrl->opts->tls_key);
>> -        else {
>> +        else if (ctrl->opts->tls) {
>>               pskid = nvme_tls_psk_default(ctrl->opts->keyring,
>>                                 ctrl->opts->host->nqn,
>>                                 ctrl->opts->subsysnqn);
>> @@ -1973,12 +1973,28 @@ static int __nvme_tcp_alloc_io_queues(struct 
>> nvme_ctrl *ctrl)
>>       key_serial_t pskid = ctrl->tls_key ? key_serial(ctrl->tls_key) : 0;
>>       int i, ret;
>> -    if (nvme_tcp_tls_configured(ctrl) && !pskid) {
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
>> +            if (pskid && pskid != key_serial(ctrl->opts->tls_key)) {
>> +                dev_err(ctrl->device, "Stale PSK id %08x\n", pskid);
>> +                pskid = 0;
>> +            }
>> +        } else if (!pskid) {
>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>> +            return -ENOKEY;
>> +        }
>>       }
>>       for (i = 1; i < ctrl->queue_count; i++) {
>> +        WARN_ON(nvme_tcp_tls_enabled(&tcp_ctrl->queues[i]));
>>           ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
>>           if (ret)
>>               goto out_free_queues;
>> @@ -2203,6 +2219,26 @@ static void nvme_tcp_reconnect_or_remove(struct 
>> nvme_ctrl *ctrl)
>>       }
>>   }
>> +static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>> +{
>> +    if (!ctrl->opts->concat)
>> +        return;
>> +    /* No key generated, nothing to do */
>> +    if (!ctrl->opts->tls_key)
>> +        return;
>> +    /*
>> +     * Key generated, and TLS enabled:
>> +     * Revoke the generated key.
>> +     */
>> +    if (ctrl->tls_key) {
>> +        dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
>> +            key_serial(ctrl->opts->tls_key));
>> +        key_revoke(ctrl->opts->tls_key);
>> +        key_put(ctrl->opts->tls_key);
>> +        ctrl->opts->tls_key = NULL;
>> +    }
>> +}
>> +
>>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>>   {
>>       struct nvmf_ctrl_options *opts = ctrl->opts;
>> @@ -2304,6 +2340,7 @@ static void nvme_tcp_error_recovery_work(struct 
>> work_struct *work)
>>                   struct nvme_tcp_ctrl, err_work);
>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>> +    nvme_tcp_revoke_generated_tls_key(ctrl);
>>       nvme_stop_keep_alive(ctrl);
>>       flush_work(&ctrl->async_event_work);
>>       nvme_tcp_teardown_io_queues(ctrl, false);
>> @@ -2343,6 +2380,7 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>       struct nvme_ctrl *ctrl =
>>           container_of(work, struct nvme_ctrl, reset_work);
>> +    nvme_tcp_revoke_generated_tls_key(ctrl);
>>       nvme_stop_ctrl(ctrl);
>>       nvme_tcp_teardown_ctrl(ctrl, false);
>> @@ -2632,6 +2670,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl 
>> *ctrl, char *buf, int size)
>>       len = nvmf_get_address(ctrl, buf, size);
>> +    if (ctrl->state != NVME_CTRL_LIVE)
>> +        return len;
>> +
>>       mutex_lock(&queue->queue_lock);
>>       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>> @@ -2817,7 +2858,7 @@ static struct nvmf_transport_ops 
>> nvme_tcp_transport = {
>>                 NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>>                 NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>>                 NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
>> -              NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
>> +              NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
>>       .create_ctrl    = nvme_tcp_create_ctrl,
>>   };
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index ce0c1143c7e4..b29310424ee1 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -1663,6 +1663,13 @@ enum {
>>       NVME_AUTH_DHGROUP_INVALID    = 0xff,
>>   };
>> +enum {
>> +    NVME_AUTH_SECP_NOSC        = 0x00,
>> +    NVME_AUTH_SECP_SC        = 0x01,
>> +    NVME_AUTH_SECP_NEWTLSPSK    = 0x02,
>> +    NVME_AUTH_SECP_REPLACETLSPSK    = 0x03,
>> +};
>> +
>>   union nvmf_auth_protocol {
>>       struct nvmf_auth_dhchap_protocol_descriptor dhchap;
>>   };
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


