Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F764EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3QS97xmi1vEecs82Kfk+Ki1RDui9M0JEtFa2BEWHsmM=; b=Dzt7Y8PpBUaUXoBY87Ali+5WRv
	Iw5FJDj/0i1UnxpyIpIvpy08+Iq32+iP/mGNjCagk9RX22p/KGPsZmcn3iYA2b1+ofz8peCPRQjtW
	wu9/0k9Il17FhSdUOLTI/iZKDz4Ka8eSyrzHwRyw8wLEMorew7hXJOJOzgqbOqtHyqpoUXewzTP6Z
	TntxxVetg2zibve+0QlFbBjJcFyCoJwdpfp+FEalLNYkSX3V0AzzS0Ujc/kLg+gY5aNCrGKwLQi4D
	YBzJNneNq5dQWDWQwgwwSGej3upvxyUYkiK6XKhaK2P7S8JvfZL2bcaWKGflSfYdlZpjF8VjExXSH
	m7tC+eYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQG2-00F8Ga-2P;
	Wed, 28 Jun 2023 08:10:34 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQG0-00F8FS-00
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 08:10:33 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-313ec24b36bso904882f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 01:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939828; x=1690531828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QS97xmi1vEecs82Kfk+Ki1RDui9M0JEtFa2BEWHsmM=;
        b=SuvR/5hOJvJtVBPt18Bk3uogyO5EwP7P1+ePuk9P1bm2/RjrJ3TScgrfII94JYt/dF
         6k20EYDBpT85FeMLif2KXJSZVYib7rc9PotBocHcumODFqsDwGp4w85F+j7Z3iq6/XiQ
         5RTaMDR9l9rnum96NFYDs25G4Iq3CzgX1BjKdSLyL1FAKr1nEVpFD1VlmEcev+RQwgSc
         TSTk0l2/xhoW11yPDyRg9NggpwyZAFwXtY87t3/Kz16jh9lNAkGRu6HdLe2Y9xbOVViK
         wtOSj6Y/LzV9PToN3US9WWRgI9RB/ZqiKFCqP9XuezLopgsRJzrBi4DNrxVi8Yeh2xot
         koXg==
X-Gm-Message-State: AC+VfDwPnd/KTr2UyokjzcXoMqp9+QtbL6lWcKQJLx/rmgly+A06on11
	UB1PqYWeBh/mqLprwABkwM7q6M7ryWs=
X-Google-Smtp-Source: ACHHUZ6WphTYtFO6n/MMjfQ+R5+eshjhLAvMJfXmqpi5oScovqSjW9WB+SOZLiYg+zaRdOe2hjgN0g==
X-Received: by 2002:a5d:4605:0:b0:314:f14:c24f with SMTP id t5-20020a5d4605000000b003140f14c24fmr466020wrq.0.1687939828364;
        Wed, 28 Jun 2023 01:10:28 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d6986000000b0031130b9b173sm12581658wru.34.2023.06.28.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:10:27 -0700 (PDT)
Message-ID: <c571727c-9bcf-ce16-cce8-b38ecfc078a6@grimberg.me>
Date: Wed, 28 Jun 2023 11:10:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
 stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <20230628073957.GB25314@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230628073957.GB25314@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_011032_037896_D8695CDD 
X-CRM114-Status: GOOD (  16.12  )
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


>> @@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	 * removing the namespaces' disks; fail all the queues now to avoid
>>   	 * potentially having to clean up the failed sync later.
>>   	 */
>> -	if (ctrl->state == NVME_CTRL_DEAD) {
>> +	if (ctrl->state == NVME_CTRL_DEAD ||
>> +			ctrl->old_state != NVME_CTRL_LIVE) {
> 
> Style nitpick: this is really nasty to read, pleas align things
> properly:
> 
> 	if (ctrl->state == NVME_CTRL_DEAD ||
> 	    ctrl->old_state != NVME_CTRL_LIVE) {
> 
> But I'm really worried about this completely uncodumented and fragile
> magic here.  The existing magic NVME_CTRL_DEAD is bad enough, but
> backtracking to the previous state just makes this worse.

Agree.

> I think a big problem is that the call to nvme_mark_namespaces_dead
> and nvme_unquiesce_io_queues is hidden inside of
> nvme_remove_namespaces, and I think there's no good way around
> us unwinding the currently unpair quiesce calls and fixing this
> for real.

My suggestion initially was to add a ctrl interface to say if the
transport can accept I/O: ctrl.ops.io_capable() and mark dead_unquiesce
based on that instead of the state. But I'm not sure it is better.

