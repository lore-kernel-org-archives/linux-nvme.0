Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACBCC3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYxHHJbJOCovnfXkJvcV4bgK4G3RHnj4HMSCKCCBvq8=; b=LDcF68iu0DAK2945jj2/4DYxA4
	RDJx4g3AqFizqY2WSBUzJBFRm/jXt5f9nDgsH9ptV/5EmPdJ2SWAwhwqpikF6Clj+fRUupZjCYTjX
	oglvfuACEcLnLPwS5peUTTRkY5XK0hHr/EFtPTPuDe6D43K5aBbQwaXFdf3x2080tBBLj0EyEGK7y
	+zeVbmjkwQWTKxC4ecITqlW47YGzl7r2RwTIA8PXY2Lv3FnQoAa/kTGFqyqfSs0VlcGCbOVHO6qmM
	ZK7WbJg8UBlDDBdwWkLNJS5HDfyeMebF0EjMaXN+r7hVcPjqm9p/LQeKlFLGyeY2RtngQjieV0Ndy
	JxF6WK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULag-0000000GC27-1N0x;
	Thu, 18 Jul 2024 07:30:14 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sULac-0000000GC0z-1UMh
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 07:30:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B66891F8B0;
	Thu, 18 Jul 2024 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721287808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxHHJbJOCovnfXkJvcV4bgK4G3RHnj4HMSCKCCBvq8=;
	b=V3L3qnlF3Y/0QZtaNlj4j9/wI8hrdt/jy0R5zsExEolIqAwzpdQkvzzMQYHQhW181HGvlG
	apFKvBiGkXIBzaDRen+muVa+AW99HvP2U5CF+HZv9e7Y5XZo4JB+W6dd2kADMwhfIZjJZY
	zIB6Tn7pFdw3ctD0BaH8jX77Crnrh1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721287808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxHHJbJOCovnfXkJvcV4bgK4G3RHnj4HMSCKCCBvq8=;
	b=fH9igixYL8vRjIobN3+n2GiyUm/oHvFsGu+dxpM8N/e0vCWlHlZ5H/BIfVUyvh4kUsoSng
	+Q0VxoB+pG3X1lDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721287808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxHHJbJOCovnfXkJvcV4bgK4G3RHnj4HMSCKCCBvq8=;
	b=V3L3qnlF3Y/0QZtaNlj4j9/wI8hrdt/jy0R5zsExEolIqAwzpdQkvzzMQYHQhW181HGvlG
	apFKvBiGkXIBzaDRen+muVa+AW99HvP2U5CF+HZv9e7Y5XZo4JB+W6dd2kADMwhfIZjJZY
	zIB6Tn7pFdw3ctD0BaH8jX77Crnrh1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721287808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYxHHJbJOCovnfXkJvcV4bgK4G3RHnj4HMSCKCCBvq8=;
	b=fH9igixYL8vRjIobN3+n2GiyUm/oHvFsGu+dxpM8N/e0vCWlHlZ5H/BIfVUyvh4kUsoSng
	+Q0VxoB+pG3X1lDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4EC1379D;
	Thu, 18 Jul 2024 07:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cCC9G4DEmGbWEQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Jul 2024 07:30:08 +0000
Message-ID: <1ba47252-faaa-4e5c-85b3-ac41c47d0a52@suse.de>
Date: Thu, 18 Jul 2024 09:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] nvme-tcp: request secure channel concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-13-hare@kernel.org>
 <8335d9f5-7195-43c0-bae1-b06fdf2fc75f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8335d9f5-7195-43c0-bae1-b06fdf2fc75f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_003010_732868_E44FD3B2 
X-CRM114-Status: GOOD (  32.82  )
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

On 7/18/24 00:31, Sagi Grimberg wrote:
> 
> 
> On 17/07/2024 12:10, Hannes Reinecke wrote:
>> Add a fabrics option 'concat' to request secure channel concatenation.
>> When secure channel concatenation is enabled a 'generated PSK' is 
>> inserted
>> into the keyring such that it's available after reset.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/auth.c    | 105 ++++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/fabrics.c |  34 ++++++++++--
>>   drivers/nvme/host/fabrics.h |   3 ++
>>   drivers/nvme/host/sysfs.c   |   2 +-
>>   drivers/nvme/host/tcp.c     |  54 ++++++++++++++++---
>>   include/linux/nvme.h        |   7 +++
>>   6 files changed, 191 insertions(+), 14 deletions(-)
>>
[ .. ]
>> @@ -831,10 +911,21 @@ static void nvme_queue_auth_work(struct 
>> work_struct *work)
>>           if (ret)
>>               chap->error = ret;
>>       }
>> -    if (!ret) {
>> +    if (ret)
>> +        goto fail2;
>> +    if (chap->qid || !ctrl->opts->concat) {
> 
> Please add a comment here on why you are doing this.
> 
Okay.

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
>> @@ -912,6 +1003,12 @@ static void nvme_ctrl_auth_work(struct 
>> work_struct *work)
>>                "qid 0: authentication failed\n");
>>           return;
>>       }
>> +    /*
>> +    * Only run authentication on the admin queue for
>> +    * secure concatenation
>> +     */
> 
> Seems like you got some whitespaces misalignment, I'd pass the patchset
> through checkpatch.pl
> 
Ok.

>> +    if (ctrl->opts->concat)
>> +        return;
>>       for (q = 1; q < ctrl->queue_count; q++) {
>>           ret = nvme_auth_negotiate(ctrl, q);
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index c62d8890f3a8..f83ac1292a3b 100644
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
> 
> Shouldn't you check for the dhchap_secret here instead of concat?
> 
I _thought_ I had checked for valid option combinations during options
parsing, ie at this position we already know that we have a valid option
combination, and the dhchap_secret will always be set when 'concat is 
enabled.

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
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 462d71e2fbf8..5350eb87ec52 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -683,7 +683,7 @@ static ssize_t tls_configured_key_show(struct 
>> device *dev,
>>       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>       struct key *key = ctrl->opts->tls_key;
>> -    if (!key)
>> +    if (!key || ctrl->opts->concat)
>>           return 0;
> 
> Same comment - move to visible check.
> 
Yeah, okay.

>>       return sysfs_emit(buf, "%08x\n", key_serial(key));
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 5885aa452aa1..d6c085ba0114 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -227,7 +227,7 @@ static inline bool nvme_tcp_tls_configured(struct 
>> nvme_ctrl *ctrl)
>>       if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
>>           return 0;
>> -    return ctrl->opts->tls;
>> +    return ctrl->opts->tls || ctrl->opts->concat;
> 
> I'm wandering if configured/enabled is the best naming...
> Maybe move it to a different check helper nvme_tcp_tls_concatenated() ?
> 
nvme_tcp_tls_configured() is a check to figure out whether TLS handshake 
should be attempted. So adding the check for secure concatenation here
seemed logical, and reduced code churn.

> btw, shouldn't tls + concat always be passed together? It is getting 
> confusing...
> 
--tls enables TLS _before_ the connect command is sent, --concat
enables TLS _after_ the connect command is sent.
The combination of '--tls' and '--concat' would set up a TLS connection,
and then run secure concatenation over TLS.
The spec does allow for that, but I haven't implemented it.

But that's not to say it will never be implemented, so I left this
option open for later and did keep both options separate.

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
>> +        } else if (!ctrl->tls_pskid) {
>> +            dev_err(ctrl->device, "no PSK negotiated\n");
>> +            return -ENOKEY;
>> +        }
>>       }
>>       for (i = 1; i < ctrl->queue_count; i++) {
>> @@ -2205,6 +2221,27 @@ static void nvme_tcp_reconnect_or_remove(struct 
>> nvme_ctrl *ctrl,
>>       }
>>   }
>> +static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>> +{
>> +    if (!ctrl->opts->concat)
>> +        return;
>> +    /* No key generated, nothing to do */
>> +    if (!ctrl->opts->tls_key)
>> +        return;
>> +    /* TLS is not enabled, do not wipe the key */
>> +    if (!ctrl->tls_pskid)
>> +        return;
> 
> Gotta say I usually dislike functions that are called and either do
> or don't do stuff based on internals.
> 
> But if you must, please add _if_needed suffix to this function.
> 
I thought a helper would be good here, but I can easily split off
the checks into a different function (nvme_tcp_key_revoke_needed?).

>> +    /*
>> +     * Key generated, and TLS enabled:
>> +     * Revoke the generated key.
>> +     */
>> +    dev_dbg(ctrl->device, "Wipe generated TLS PSK %08x\n",
>> +        key_serial(ctrl->opts->tls_key));
>> +    key_revoke(ctrl->opts->tls_key);
>> +    key_put(ctrl->opts->tls_key);
>> +    ctrl->opts->tls_key = NULL;
>> +}
>> +
>>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>>   {
>>       struct nvmf_ctrl_options *opts = ctrl->opts;
>> @@ -2308,6 +2345,7 @@ static void nvme_tcp_error_recovery_work(struct 
>> work_struct *work)
>>                   struct nvme_tcp_ctrl, err_work);
>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>> +    nvme_tcp_revoke_generated_tls_key(ctrl);
>>       nvme_stop_keep_alive(ctrl);
>>       flush_work(&ctrl->async_event_work);
>>       nvme_tcp_teardown_io_queues(ctrl, false);
>> @@ -2348,6 +2386,7 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, reset_work);
>>       int ret;
>> +    nvme_tcp_revoke_generated_tls_key(ctrl);
>>       nvme_stop_ctrl(ctrl);
>>       nvme_tcp_teardown_ctrl(ctrl, false);
>> @@ -2638,6 +2677,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl 
>> *ctrl, char *buf, int size)
>>       len = nvmf_get_address(ctrl, buf, size);
>> +    if (ctrl->state != NVME_CTRL_LIVE)
>> +        return len;
>> +
> 
> This looks unrelated.
> 
Indeed. Will be removing it

>>       mutex_lock(&queue->queue_lock);
>>       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>> @@ -2842,7 +2884,7 @@ static struct nvmf_transport_ops 
>> nvme_tcp_transport = {
>>                 NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>>                 NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>>                 NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
>> -              NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY,
>> +              NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
>>       .create_ctrl    = nvme_tcp_create_ctrl,
>>   };
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index c12a329dd463..ef85cf69cf99 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -1669,6 +1669,13 @@ enum {
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

Thanks for the review!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


