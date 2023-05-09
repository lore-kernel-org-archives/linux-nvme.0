Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD8FC7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+GTEFJL52uI7uazFDrE31LpvKl2DXOQO6QtEYwOv38=; b=OarnZsUFAxJE6q17UKreArHkLv
	w6CwdtL0YxPV5iMzsQPVzx6jmBCaW0x/4vj5tJUoo3TAOp1bXALFoiLZblQD6XMrOshSAS4Rgf34d
	6DDBNbLb/2b14qw8NH5Ihwt3oWwrbfTQCqyQUHP3c+n0Sv1P3kuOINSU+RLTBBRvEHhQg7XwideW1
	Ehzz8ub+d4HLIJID2Sw3sMjyQkCksWCAX1lo+3GvDjA5snig3DJSigjrHxtQbE7oScQtiaek+pFkh
	0b2c2VU0RBcybuDtov8NSXuN9UW9EDkIxpEl+pS+e2jvXeukBcySHla2mgsM/EnavI8HR12gCzCp/
	9AupT+BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwOH2-003XvC-1Y;
	Tue, 09 May 2023 14:25:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwOGy-003Xsp-1p
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 14:25:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FD1B21C7B;
	Tue,  9 May 2023 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683642299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GTEFJL52uI7uazFDrE31LpvKl2DXOQO6QtEYwOv38=;
	b=RDBiZS+ppWfHuTO6RwP11KVOL2c9ilmV98PuUxueamXv4wDhhizWAkBgHzfWWV3fStcqtJ
	eqbiQo6gasFkDR2e0WGJrOerH4T1c/DvNsRuOHZ4XvZP0EzdfuJl0OQ3xZW4S8PqNBPszm
	GwTmHaWdqAYqYoe4JHr2BEUvGKiHOz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683642299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GTEFJL52uI7uazFDrE31LpvKl2DXOQO6QtEYwOv38=;
	b=wX7hvdiW1QraAQJJfm6VWjKVtW1Mj+NNXDyrrEoGiKiyhdQWC9+U7JcbGxtHj9nZX9N4P1
	trF/oYdsyKb/GXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A46EB139B3;
	Tue,  9 May 2023 14:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ejTJHrlXWmR5CQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 09 May 2023 14:24:57 +0000
Message-ID: <aa843227-2430-e5f2-a292-3ed504338db7@suse.de>
Date: Tue, 9 May 2023 16:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 13/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-14-hare@suse.de>
 <3acac781-58d2-e0de-6072-b6b9d67550a0@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3acac781-58d2-e0de-6072-b6b9d67550a0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_072500_750533_210523FE 
X-CRM114-Status: GOOD (  30.47  )
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

On 5/9/23 12:00, Max Gurtovoy wrote:
> 
> 
> On 19/04/2023 9:57, Hannes Reinecke wrote:
>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>> referenced keys in the options structure.
> 
> Please add an example of how the nvme-cli will issue a connect command 
> with these new args.
> 
Okay.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/fabrics.h |  6 ++++
>>   drivers/nvme/host/tcp.c     | 11 ++++--
>>   3 files changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 2aa8fb991455..8fb80ccc38e1 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -605,6 +605,10 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_NR_WRITE_QUEUES,    "nr_write_queues=%d"    },
>>       { NVMF_OPT_NR_POLL_QUEUES,    "nr_poll_queues=%d"    },
>>       { NVMF_OPT_TOS,            "tos=%d"        },
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    { NVMF_OPT_KEYRING,        "keyring=%d"        },
>> +    { NVMF_OPT_TLS_KEY,        "tls_key=%d"        },
>> +#endif
> 
> redundant ifdef here.
> 
See explanation to the other patch. This ifdef is required to allow
nvme-cli to check for support of these option.

>>       { NVMF_OPT_FAIL_FAST_TMO,    "fast_io_fail_tmo=%d"    },
>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>> @@ -622,8 +626,9 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       char *options, *o, *p;
>>       int token, ret = 0;
>>       size_t nqnlen  = 0;
>> -    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>> +    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>>       uuid_t hostid;
>> +    struct key *key = NULL;
>>       /* Set defaults */
>>       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>> @@ -891,6 +896,66 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               }
>>               opts->tos = token;
>>               break;
>> +        case NVMF_OPT_KEYRING:
>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> +                pr_err("TLS is not supported\n");
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (match_int(args, &key_id)) {
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (key_id < 0) {
>> +                pr_err("Invalid keyring id %d\n", key_id);
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (!key_id) {
>> +                pr_debug("Using default keyring\n");
>> +                key_put(opts->keyring);
>> +                opts->keyring = NULL;
>> +                break;
>> +            }
>> +            key = key_lookup(key_id);
>> +            if (!key) {
>> +                pr_err("Keyring id %08x not found\n", key_id);
>> +                ret = -ENOKEY;
>> +                goto out;
>> +            }
>> +            key_put(opts->keyring);
>> +            opts->keyring = key;
>> +            break;
>> +        case NVMF_OPT_TLS_KEY:
>> +            if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> +                pr_err("TLS is not supported\n");
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (match_int(args, &key_id)) {
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (key_id < 0) {
>> +                pr_err("Invalid key id %d\n", key_id);
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            if (!key_id) {
>> +                pr_debug("Using 'best' PSK\n");
>> +                key_put(opts->tls_key);
>> +                opts->tls_key = NULL;
>> +                break;
>> +            }
>> +            key = key_lookup(key_id);
>> +            if (!key) {
>> +                pr_err("Key id %08x not found\n", key_id);
>> +                ret = -ENOKEY;
>> +                goto out;
>> +            }
>> +            key_put(opts->tls_key);
>> +            opts->tls_key = key;
>> +            break;
>>           case NVMF_OPT_DISCOVERY:
>>               opts->discovery_nqn = true;
>>               break;
>> @@ -1055,6 +1120,8 @@ static int nvmf_check_allowed_opts(struct 
>> nvmf_ctrl_options *opts,
>>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>   {
>>       nvmf_host_put(opts->host);
>> +    key_put(opts->keyring);
>> +    key_put(opts->tls_key);
>>       kfree(opts->transport);
>>       kfree(opts->traddr);
>>       kfree(opts->trsvcid);
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index 5db36e250e7a..2ff7b7168a40 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -71,6 +71,8 @@ enum {
>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>       NVMF_OPT_TLS        = 1 << 25,
>> +    NVMF_OPT_KEYRING    = 1 << 26,
>> +    NVMF_OPT_TLS_KEY    = 1 << 27,
>>   };
>>   /**
>> @@ -103,6 +105,8 @@ enum {
>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>> bi-directional
>>    *              authentication
>> + * @keyring:    Keyring to use for key lookups
> 
> is it only for TLS ? if it does please reflect in the comment and in the 
> name of the member.
> 
Yes and no. Currently it's just for TLS, but I've got patches to convert 
DH-HMAC-CHAP over to use this keyring, too.

>> + * @tls_key:    TLS key for encrypted connections (TCP)
>>    * @tls:        Start TLS encrypted connections (TCP)
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>>       int            max_reconnects;
>>       char            *dhchap_secret;
>>       char            *dhchap_ctrl_secret;
>> +    struct key        *keyring;
>> +    struct key        *tls_key;
>>       bool            tls;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index a3ac512fd1cc..84bf6c80cc7c 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1582,6 +1582,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl 
>> *nctrl,
>>       dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>           qid, pskid);
>> +    if (nctrl->opts->keyring)
>> +        keyring = key_serial(nctrl->opts->keyring);
>>       args.ta_sock = queue->sock;
>>       args.ta_done = nvme_tcp_tls_done;
>>       args.ta_data = queue;
>> @@ -1890,9 +1892,12 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>       key_serial_t psk_id = 0;
>>       if (ctrl->opts->tls) {
>> -        psk_id = nvme_tls_psk_default(NULL,
>> -                          ctrl->opts->host->nqn,
>> -                          ctrl->opts->subsysnqn);
>> +        if (ctrl->opts->tls_key)
>> +            psk_id = key_serial(ctrl->opts->tls_key);
>> +        else
>> +            psk_id = nvme_tls_psk_default(ctrl->opts->keyring,
>> +                              ctrl->opts->host->nqn,
>> +                              ctrl->opts->subsysnqn);
> 
> I don't understand why this patch can't be squashed to patch 11/17 ?
> If possible please do before next version submission.
> 
Oh, sure, it can.
Will do with the next round.

>>           if (!psk_id) {
>>               dev_err(ctrl->device, "no valid PSK found\n");
>>               ret = -ENOKEY;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


