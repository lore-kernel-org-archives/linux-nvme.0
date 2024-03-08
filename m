Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0427C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcF+Jh5KVqnj5qEIoLbh7diMIiQ5FzkKMgKKLPLvypo=; b=kz6fk7q6Jl2afrxXgkGxaIiER8
	Hb4g/R3MeAwfAFFarVSkNvdvqTn2xVduwGgNPYgJq7ULrUBmpJC2BzgfsZBwdCJ6SM2Ab1P0mSofK
	gHEsb2BvhbyriJVy8SLqq4LVp+PgeK7whZRJJ3YNYT+StJkAezePXdaPvg2memmI+4tVjbNoFVDZW
	LYH7UeiolCNe4HXu3pIFGzuO4v4sfolBJzaXYiNJMwnCeJ//p3to5NTmXxTgftmTWAStOSuh3Je7t
	wWP+wtPYTp9WNGoI98q9/dG/DFZB94R7gBTygMg4aAyAdqqviJ3NsruQl4muKx+okCppNs5HZ8ziW
	EbVK8Smw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rias7-00000009Sfp-2FjX;
	Fri, 08 Mar 2024 14:06:51 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rias2-00000009Sd0-1wEd
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:06:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AAF75D6CA;
	Fri,  8 Mar 2024 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709906803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcF+Jh5KVqnj5qEIoLbh7diMIiQ5FzkKMgKKLPLvypo=;
	b=Nk1ol2wA0s7Dshac9u7omp3FGfUIRHkQ9YA4ENnEBA9XKTzb8VEo1kSZke/7JixUtHkv72
	rkFDk9wGBOA6c79+Oyz/xLYXWT2LzfA3Xp/DJAwGjDtnoqPgY9CHNfAbtri/ROmiDKPXZs
	sf7UIlPq33N3Y/UYn5iiUsAk2UOte2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709906803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcF+Jh5KVqnj5qEIoLbh7diMIiQ5FzkKMgKKLPLvypo=;
	b=FH5HUShmiLy8XYIN86zyLanjxx9w9kjiE7Ka8pbFCLyEN11XG4BgM8nIZgFLq0gtXREz4w
	L9t3B0lQ9VbFcVBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709906803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcF+Jh5KVqnj5qEIoLbh7diMIiQ5FzkKMgKKLPLvypo=;
	b=Nk1ol2wA0s7Dshac9u7omp3FGfUIRHkQ9YA4ENnEBA9XKTzb8VEo1kSZke/7JixUtHkv72
	rkFDk9wGBOA6c79+Oyz/xLYXWT2LzfA3Xp/DJAwGjDtnoqPgY9CHNfAbtri/ROmiDKPXZs
	sf7UIlPq33N3Y/UYn5iiUsAk2UOte2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709906803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcF+Jh5KVqnj5qEIoLbh7diMIiQ5FzkKMgKKLPLvypo=;
	b=FH5HUShmiLy8XYIN86zyLanjxx9w9kjiE7Ka8pbFCLyEN11XG4BgM8nIZgFLq0gtXREz4w
	L9t3B0lQ9VbFcVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6352F13310;
	Fri,  8 Mar 2024 14:06:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t7lgFnMb62XlKQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 08 Mar 2024 14:06:43 +0000
Message-ID: <b3669b3a-7c75-413f-a5d3-6ee5fac6a279@suse.de>
Date: Fri, 8 Mar 2024 15:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add sysfs attribute 'tls_keyring'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240308121006.69442-1-hare@kernel.org>
 <50f03f5d-f356-4f2e-8239-c8bbdc780a13@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <50f03f5d-f356-4f2e-8239-c8bbdc780a13@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nk1ol2wA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FH5HUShm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 9AAF75D6CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_060646_688981_AE53E932 
X-CRM114-Status: GOOD (  24.08  )
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

On 3/8/24 15:01, Sagi Grimberg wrote:
> 
> 
> On 08/03/2024 14:10, Hannes Reinecke wrote:
>> Add a sysfs attribute 'tls_keyring' to hold the contents for the
>> 'keyring' fabrics option. This option is only meaningful if the
>> 'tls' option has been specified; if the 'tls_key' option is specified
>> the key is looked up directly and the keyring setting is ignored.
>> So blank out the keyring value when 'tls_key' is specified.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/sysfs.c | 55 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 6c7f1d5c056f..7b65ff7426c9 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -5,11 +5,12 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> -#include <linux/nvme-auth.h>
>> -
>>   #include "nvme.h"
>>   #include "fabrics.h"
>> +#include <linux/nvme-auth.h>
>> +#include <linux/nvme-keyring.h>
>> +
>>   static ssize_t nvme_sysfs_reset(struct device *dev,
>>                   struct device_attribute *attr, const char *buf,
>>                   size_t count)
>> @@ -677,6 +678,52 @@ static ssize_t tls_key_show(struct device *dev,
>>       return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
>>   }
>>   static DEVICE_ATTR_RO(tls_key);
>> +
>> +static ssize_t tls_keyring_show(struct device *dev,
>> +                struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +    struct key *keyring;
>> +
>> +    if (!ctrl->tls_key)
>> +        return 0;
>> +    /* Do not display the keyring for user-selected keys */
>> +    if (ctrl->opts->tls_key)
>> +        return 0;
>> +    keyring = ctrl->opts->keyring;
>> +    if (!keyring) {
>> +        keyring = key_lookup(nvme_keyring_id());
>> +        if (!keyring)
>> +            return -EINVAL;
> 
> Weird if this failed...
> 
Yeah. But feels even weirder to _not_ check it.
WARN_ON?

>> +    }
>> +    return sysfs_emit(buf, "%s", keyring->description);
>> +}
>> +
>> +static ssize_t tls_keyring_store(struct device *dev,
>> +        struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +    struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +    int err;
>> +    u32 key_id;
>> +    struct key *keyring;
>> +
>> +    if (!strlen(buf))
>> +        return -EINVAL;
>> +    err = kstrtou32(buf, 0, &key_id);
>> +    if (err)
>> +        return err;
>> +    keyring = key_lookup(key_id);
>> +    if (IS_ERR(keyring)) {
>> +        pr_err("key %08x not found\n", key_id);
>> +        return -EINVAL;
>> +    }
>> +    if (ctrl->opts->keyring)
>> +        key_put(ctrl->opts->keyring);
>> +    ctrl->opts->keyring = keyring;
>> +    return 0;
>> +}
> 
> Why should there be a _store() for this?
> 
Technically one can change the keyring. But I can drop it for now,
and revisit the issue once I get around to fully test key revokation
and key rotation.

>> +static DEVICE_ATTR(tls_keyring, S_IRUGO | S_IWUSR,
>> +        tls_keyring_show, tls_keyring_store);
>>   #endif
>>   static struct attribute *nvme_dev_attrs[] = {
>> @@ -708,6 +755,7 @@ static struct attribute *nvme_dev_attrs[] = {
>>   #endif
>>   #ifdef CONFIG_NVME_TCP_TLS
>>       &dev_attr_tls_key.attr,
>> +    &dev_attr_tls_keyring.attr,
>>   #endif
>>       &dev_attr_adm_passthru_err_log_enabled.attr,
>>       NULL
>> @@ -743,6 +791,9 @@ static umode_t nvme_dev_attrs_are_visible(struct 
>> kobject *kobj,
>>       if (a == &dev_attr_tls_key.attr &&
>>           (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>>           return 0;
>> +    if (a == &dev_attr_tls_keyring.attr &&
>> +        (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
>> +        return 0;
> 
> Wouldn't it make better sense to expose it only if tls was requested?

Sort of. But we never did for the 'tls_key' attribute, too, which would
have the same restriction. So I didn't do it here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


