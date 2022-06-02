Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2C2C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAfUriOlYndXeAXZQUjIF0jEiRmnmPOACaxDfUmYHH4=; b=lScAo8EofIGqbhjtsB73aYvhmO
	Q1+U+xTyOejgTRYFU6nlxWdoo9E1DIGfgnESVa4s4f4QTSPQXcK6m9RHuvQNDN9lxBZwdbPjMQlFT
	Lr7tGYdGazBby5GFmE9inRGXC3X9FzyqWzyqvDsf98po4E9hwWkt0XGAahEN4j1Dh0EEmrr5bWPaE
	gLAIvo/R1sjIFE2rk/TqFk9Vp4ChfH3RbJo1V0CeaZZYl/Y5a6mOBayu8Bs9h5rJ20tSpC/XX4RHz
	2eDfnB3Zubgtj29uXSnTN8j+++pkOW330qhpLnnBR1V0oG3/mP5mS94Q3yzRtKlvVINTWk0eixaqn
	rprv/ivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwi13-002meS-1B; Thu, 02 Jun 2022 10:25:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwi0z-002mcr-JP
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 10:25:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDC781F8C7;
	Thu,  2 Jun 2022 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654165513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAfUriOlYndXeAXZQUjIF0jEiRmnmPOACaxDfUmYHH4=;
	b=0Mbh+r7/BqI80ArECk+5sY1X91dw40TLKB1IsBTlDXhmlb1mBKcLQWNLuYOUOifnz3pNb/
	bN+zYj5u0B/41RKrFeWaFWdc8Optu9JgHTRGWbEKWOaAnw7IZoTrvsDhWgIMEZH3jIFfDA
	O6Arcr7tNiQ+NKmPJ8jmdRczcwW71+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654165513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAfUriOlYndXeAXZQUjIF0jEiRmnmPOACaxDfUmYHH4=;
	b=/82EEphrLstGxWeghCatxNbveRdoVGUSut/cU2km3d/D8vn9HZQbxQQLQp+zYdFXEz9j42
	dtDhGoDll4vhLzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4389134F3;
	Thu,  2 Jun 2022 10:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ucsvJwmQmGKWXwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 02 Jun 2022 10:25:13 +0000
Message-ID: <d98d29ab-aca5-8c1d-755f-4e0f1b30002c@suse.de>
Date: Thu, 2 Jun 2022 12:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-core: fix oops in dhchap_ctrl_secret_show()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20220602014504.7873-1-kch@nvidia.com>
 <da0cfe3f-115e-0ecf-74de-ff18c5099da3@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <da0cfe3f-115e-0ecf-74de-ff18c5099da3@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_032517_826589_C678C47D 
X-CRM114-Status: GOOD (  19.81  )
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

On 6/2/22 10:51, Sagi Grimberg wrote:
> 
>> In current implementation when we try to disconnect the subsystem
>> that doesn't exists nvme_ctrl_dhchap_ctrl_secrete_show() ends up in
>> OOPS:-
>>
>> RIP: 0010:nvme_ctrl_dhchap_ctrl_secret_show+0x16/0x40 [nvme_core]
>> Code: c6 78 a1 16 c0 e8 5a ad 2d c1 48 98 c3 0f 1f 80 00 00 00 00 0f 
>> 1f 44 00 00 49 89 f8 48 89 d7 49 8b 40 78 48 8b 80 98 0b 00 00 <48> 8b 
>> 50 68 48 85 d2 74 0f 48 c7 c6 46 a0 16 c0 e8 25 ad 2d c1 48
>> RSP: 0018:ffffc90000f3fdb8 EFLAGS: 00010282
>> RAX: 0000000000000000 RBX: ffffffffc01731e0 RCX: 0000000000000000
>> RDX: ffff888104b44000 RSI: ffffffffc01731e0 RDI: ffff888104b44000
>> RBP: ffffffff822f7380 R08: ffff88810274a2b8 R09: ffff8881782fbdb8
>> R10: 0000000000020000 R11: 0000000000000000 R12: ffffc90000f3fe80
>> R13: ffffc90000f3fe58 R14: ffff88817f0944d8 R15: 0000000000000001
>>   ? nvme_subsys_show_type+0x50/0x50 [nvme_core]
>>   dev_attr_show+0x19/0x40
>>   sysfs_kf_seq_show+0xa8/0xe0
>>   seq_read_iter+0x11c/0x4b0
>>   new_sync_read+0x106/0x180
>>   vfs_read+0x138/0x190
>>   ksys_read+0x5f/0xe0
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x7fdeccbdf702
>> Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 2a 0a 00 e8 b5 e8 01 00 0f 1f 
>> 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 
>> 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
>> RSP: 002b:00007ffe0dfb4f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> RAX: ffffffffffffffda RBX: 00000000017df780 RCX: 00007fdeccbdf702
>> RDX: 0000000000000fff RSI: 00007ffe0dfb4f30 RDI: 0000000000000003
>> RBP: 00007ffe0dfb4f30 R08: 00000000017df9f0 R09: 00007fdecccb1a60
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>> R13: 00000000017e75a3 R14: 00000000017df760 R15: 00000000017e75a3
>>
>> Add guard to make sure opts is not NULL in the
>> nvme_ctrl_dhchap_ctrl_secret_show() to avoid the OOPs.
>>
>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>>   drivers/nvme/host/core.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 5bdeb7134ede..3df8e6bef589 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3671,9 +3671,12 @@ static ssize_t 
>> nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
>>       struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>>       struct nvmf_ctrl_options *opts = ctrl->opts;
>> -    if (!opts->dhchap_ctrl_secret)
>> -        return sysfs_emit(buf, "none\n");
>> -    return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
>> +    if (opts) {
>> +        if (!opts->dhchap_ctrl_secret)
>> +            return sysfs_emit(buf, "none\n");
>> +        return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
>> +    }
>> +    return 0;
> 
> Shouldn't this be filtered as non-visible in the first place?
> 
Indeed, the correct fix is

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 20a3565c3e87..fbd61419716d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3719,6 +3719,8 @@ static umode_t nvme_dev_attrs_are_visible(struct 
kobject *kobj,
  #ifdef CONFIG_NVME_AUTH
         if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
                 return 0;
+       if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
+               return 0;
  #endif

         return a->mode;

Will be including it in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

