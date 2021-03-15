Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F7C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:24:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B999464E98
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B999464E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6qJ9WtoiGABA4926aRFerWefXY+sjiiAxK7toNtJHFU=; b=NoNcDv0HbbdBHYW/I9bjbNTtK
	h/NFQaIjz6ETAvknROjhc90Ap15+KCafveN3tgaMgYRZirSgu/2kz+luPg0f78F3+sEEWJsFsxqDG
	ABl4bPZWa/Il6WZK9On9OvANmVM726zkwCvA93wtTYKVWUjpTLMx+UReP+aNoo3vxEUY536LQHFZ1
	drxGLuWXx1R0zDII54C4IFqlIkY48RnzKsG541YwAobTRRRhW9ELTivCc3DIefwlZZt9LRveXWbJj
	TBo9y3to+rTwqqXhn+GcI1GPEGskOFTshx7m0jIueilHnEUGQQjSq9YQOqhRvtH63xjB1s/HpTU3C
	2Vj9uFbmA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqwZ-00GVCM-Tg; Mon, 15 Mar 2021 17:23:52 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqwA-00GV7a-SG
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:23:31 +0000
Received: by mail-pg1-f175.google.com with SMTP id o10so20863667pgg.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SOr19HkQ4aJtmIr0qnJna24DA1eVceSzpc1P0bsMciE=;
 b=STOLMBTe0VYymLNsO0PG+B+GOtL3l9LNsxn+qXG+25aFkCbUmlSoE25Tno/7nbg29h
 5o4e38nmzK4GGQHpkN0goH/4JXUO8yz+0UjsEQ6OYUBTPOXmw5FkS8wUQhUFrhAWnmai
 GUPMMFah77gRod7tmLqDF9nfWLrHPcDfk8d1ILV5jVspEH8mIFNcHqnmyWaxy/8GLk/k
 d/REvtvCfynrINWYWviofnNEKc8NTbP03CZIomUW/DKf17lgFqlAlBlcXDqvwyBZfsRP
 nKr6RkIvpZOpavAWffK9O9RXCtWgFhdMiSAEzdGmT2yRB9wXAH2c3i+lmKNfnwGxozaA
 RSBA==
X-Gm-Message-State: AOAM530XGt/M+haXVsYFy/YeCJaoByQXqrV2+0LFWiz8nWAjsEbLUjqd
 StbN+Wx8lm5lmIWHA7vjKO4BXxcMpkw=
X-Google-Smtp-Source: ABdhPJyRALazZX7cGSBw5fOnTu58AGZe51HdCRmgCiyKM9z1wXKsLg8C1YQ+y6a8txLlVl9HWjujkw==
X-Received: by 2002:a62:7bc4:0:b029:1f1:58ea:4010 with SMTP id
 w187-20020a627bc40000b02901f158ea4010mr11477131pfc.70.1615829004747; 
 Mon, 15 Mar 2021 10:23:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id s62sm14583972pfb.148.2021.03.15.10.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:23:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme: sanitize KATO setting
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210311103727.47381-1-hare@suse.de>
 <20210311103727.47381-2-hare@suse.de> <20210311105532.GA16515@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e42ca9f8-5a46-81f6-065d-a188bc18d899@grimberg.me>
Date: Mon, 15 Mar 2021 10:23:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311105532.GA16515@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172328_186871_7BEABB90 
X-CRM114-Status: GOOD (  17.88  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 3/11/21 2:55 AM, Christoph Hellwig wrote:
>> +/*
>> + * Recommended frequency for KATO commands
>> + *
>> + * NVMe 1.4 section 7.12.1 states:
>> + * The host should send Keep Alive commands at half of the
>> + * Keep Alive Timeout accounting for transport roundtrip times [..].
>> + */
>> +#define NVME_KATO_DELAY(k)	(((k) > 1)?(k) >> 1:(k))
> 
> This should have been an inline if added at all, and use proper
> formatting, as well as avoiding the shift obsfucation.
> 
> I think the best is to just move this into the only caller, where
> we also know that ctrl->kato can't be 0 due to the check in
> nvme_start_keep_alive:
> 
> /*
>   * Recommended frequency for KATO commands per  NVMe 1.4 section 7.12.1:
>   *
>   *     The host should send Keep Alive commands at half of the
>   *     Keep Alive Timeout accounting for transport roundtrip times [..].
> */
> static inline void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
> {
> 	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
> }
> 
> Also please keep this helper inside of core.c.

Agreed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
