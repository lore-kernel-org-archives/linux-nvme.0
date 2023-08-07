Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2BFEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqgrmChlom0Uag0HteDMqUOy4+D6Pma8KFXMq0HDuak=; b=eDvTbVkMu4oDzq/sUUn/r4fkOc
	MoNl4ZegzgbL8Q4ixDqzJ9BDccxG5LE0YRLWC+mRYQAz/Bqp/YFGV4qZqbJ6se/WIBIM3ZoeEKzj/
	ntGU3h9pjExYjasZGiGeQRl7or23uxo6E765hLUxgQTNgF5wpgB8Pf/Auck2qTEYg7adhqWB+eTIg
	aqBdY+AileIHPIA2NWV3AjNfSx2FNEt49RA4Yx8oYlMLjPMrThj46bcI1SpRcL3BpsFm5uSnhgf6M
	5pU0Al5b4PCBS3lVSH0hasLbTUUh6RmIWON7nOokcY2GovED+09+s/CpOXVbfA41QlKUDYnCGngWA
	brFrJ8yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvha-00GSuq-2L;
	Mon, 07 Aug 2023 08:34:58 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvhV-00GStb-0T
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:34:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB1B81F460;
	Mon,  7 Aug 2023 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691397290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqgrmChlom0Uag0HteDMqUOy4+D6Pma8KFXMq0HDuak=;
	b=COsdfiVa5mzdqaSJSmTbb10vxXIbQXWQoAaOaJS1MQQNgOX7qRUMgJuCVZ+ie1smO4Cfp4
	1aC3wjskBCL2pUtlpD5K1xZMLJRJC8rNEZPd95h2Vc8lX4gGWN6Hojo9kZ1Achv6lgyfRI
	dltXq0JtYkeDWr2zinplcM6HB8Tb3JY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691397290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqgrmChlom0Uag0HteDMqUOy4+D6Pma8KFXMq0HDuak=;
	b=P05K+RfkUghhzsXAncb1DsqIeauVoHwG/1p+Y3Qw/0IVH5ox9hrKHwgE/pvNjGYL8C0D9b
	TwT/NUwbzUCBKVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48E6013487;
	Mon,  7 Aug 2023 08:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iN38Daqs0GQVCAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 07 Aug 2023 08:34:50 +0000
Message-ID: <d27ba40a-b9bc-bff7-bc90-5d307f79e96d@suse.de>
Date: Mon, 7 Aug 2023 10:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 10/14] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-11-hare@suse.de>
 <9f7b64a3-2433-93eb-4cfd-4fe6408b1598@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9f7b64a3-2433-93eb-4cfd-4fe6408b1598@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_013453_327201_D01055C5 
X-CRM114-Status: GOOD (  17.71  )
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

On 8/7/23 10:23, Sagi Grimberg wrote:
> 
> 
> On 8/3/23 13:50, Hannes Reinecke wrote:
>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>> referenced keys in the options structure.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/fabrics.h |  6 ++++
>>   drivers/nvme/host/tcp.c     | 11 ++++--
>>   3 files changed, 82 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ddad482c3537..6bdcd505a477 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -643,6 +643,10 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_NR_WRITE_QUEUES,    "nr_write_queues=%d"    },
>>       { NVMF_OPT_NR_POLL_QUEUES,    "nr_poll_queues=%d"    },
>>       { NVMF_OPT_TOS,            "tos=%d"        },
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    { NVMF_OPT_KEYRING,        "keyring=%d"        },
>> +    { NVMF_OPT_TLS_KEY,        "tls_key=%d"        },
>> +#endif
>>       { NVMF_OPT_FAIL_FAST_TMO,    "fast_io_fail_tmo=%d"    },
>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>> @@ -660,9 +664,10 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       char *options, *o, *p;
>>       int token, ret = 0;
>>       size_t nqnlen  = 0;
>> -    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>> +    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>>       uuid_t hostid;
>>       char hostnqn[NVMF_NQN_SIZE];
>> +    struct key *key = NULL;
>>       /* Set defaults */
>>       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>> @@ -928,6 +933,66 @@ static int nvmf_parse_options(struct 
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
> 
> Maybe move to helper(s)? looks pretty similar.
> 
I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


