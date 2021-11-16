Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A45C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:42:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A4960F44
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A4960F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTuDbRhkINv1mNjnQEob3aU1PxWXoYn7KcHUj9KPuxg=; b=trgBYDNhuCPOrOcXJS2FisrG5E
	+CQ6FqCbltMdQKH0hQzBg+kAZkEdxP61YEzUVLz4fKxyjvE4hVl8EQnv0WtnqRTRUMVxoizL+F7iW
	c/vT7/jGKZvucIqz/D9FVQe++PsmshKajeUMdubeuKZe7eC94YP/IPu+ZlFD76a/RL4UkZ3zPYaou
	iA92T+l9ah9ZBgBl4BRijQi0PLIRIGddJD6ZKl05+STYK2NsuL6epyeMufGm16CaAbNnyfRokY40B
	WobnfbGsZhnceCswjjlLWmIdMyj+FQVDfwNOaMJT1PwfZQJyhYL3qFgCMu/Fmq2LiiVa469Expwz9
	bq6vMVeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvvO-001FiL-UZ; Tue, 16 Nov 2021 10:42:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvtx-001FLl-F6
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:41:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28474218D5;
 Tue, 16 Nov 2021 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637059280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTuDbRhkINv1mNjnQEob3aU1PxWXoYn7KcHUj9KPuxg=;
 b=MHtdgan+RqrGAyqdgZouZWNckibOpSVsFR1XtJ1w2IcRnB0K03IjR7cIOX/DWV2kxoqwtD
 u4OAnxBY0Yivg/635AzqarIznVeNmOWm5DOJ42+jXuM17jdS8XlRkgFv37gadsB2U2cPrd
 SJ4TDYMUtQovkLtNFAtnRVpoMJSi+KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637059280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTuDbRhkINv1mNjnQEob3aU1PxWXoYn7KcHUj9KPuxg=;
 b=JFAchyTqD507FNUmTztRfsLKFRcfxeWP32Fr33utScYK47VQPLOcH7Ks8KuN5hVbyXNqje
 awQTGL7d4w2+AIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 139C213BA1;
 Tue, 16 Nov 2021 10:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iw55BNCKk2HYLgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 16 Nov 2021 10:41:20 +0000
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <20211112125928.97318-8-hare@suse.de>
 <ce8ad3e5-6f18-0ffa-33b4-11e52b39e1b4@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b7323907-6036-1181-7967-cda5985acb2e@suse.de>
Date: Tue, 16 Nov 2021 11:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ce8ad3e5-6f18-0ffa-33b4-11e52b39e1b4@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_024121_699222_F42DD5C1 
X-CRM114-Status: GOOD (  15.93  )
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

On 11/16/21 11:35 AM, Sagi Grimberg wrote:
> 
>> +static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
>> +        struct nvme_dhchap_queue_context *chap)
> 
> Maybe better to call it nvme_auth_dhchap_setup_host_response()?
> 
Ok.

>> +{
>> +    SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
>> +    u8 buf[4], *challenge = chap->c1;
>> +    int ret;
>> +
>> +    dev_dbg(ctrl->device, "%s: qid %d host response seq %d
>> transaction %d\n",
>> +        __func__, chap->qid, chap->s1, chap->transaction);
>> +
>> +    if (!chap->host_response) {
>> +        chap->host_response = nvme_auth_transform_key(ctrl->dhchap_key,
>> +                    ctrl->dhchap_key_len,
>> +                    ctrl->dhchap_key_hash,
>> +                    ctrl->opts->host->nqn);
>> +        if (IS_ERR(chap->host_response)) {
>> +            ret = PTR_ERR(chap->host_response);
>> +            chap->host_response = NULL;
>> +            return ret;
>> +        }
>> +    } else {
>> +        dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
>> +            __func__, chap->qid);
>> +    }
>> +
>> +    ret = crypto_shash_setkey(chap->shash_tfm,
>> +            chap->host_response, ctrl->dhchap_key_len);
>> +    if (ret) {
>> +        dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>> +             chap->qid, ret);
>> +        goto out;
>> +    }
>> +
>> +    shash->tfm = chap->shash_tfm;
>> +    ret = crypto_shash_init(shash);
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_update(shash, challenge, chap->hash_len);
>> +    if (ret)
>> +        goto out;
>> +    put_unaligned_le32(chap->s1, buf);
>> +    ret = crypto_shash_update(shash, buf, 4);
>> +    if (ret)
>> +        goto out;
>> +    put_unaligned_le16(chap->transaction, buf);
>> +    ret = crypto_shash_update(shash, buf, 2);
>> +    if (ret)
>> +        goto out;
>> +    memset(buf, 0, sizeof(buf));
>> +    ret = crypto_shash_update(shash, buf, 1);
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_update(shash, "HostHost", 8);
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
>> +                  strlen(ctrl->opts->host->nqn));
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_update(shash, buf, 1);
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
>> +                strlen(ctrl->opts->subsysnqn));
>> +    if (ret)
>> +        goto out;
>> +    ret = crypto_shash_final(shash, chap->response);
>> +out:
>> +    if (challenge != chap->c1)
>> +        kfree(challenge);
>> +    return ret;
>> +}
>> +
>> +static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
>> +        struct nvme_dhchap_queue_context *chap)
> 
> Maybe better to call it nvme_auth_dhchap_validate_ctrl_response()?

Will be doing so for the next round.

Thanks for the review.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

