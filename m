Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C22C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GL3s9AZX86KDwMOH+STEtwVrUQXmPNnDhqxTNdiyalk=; b=cEQHUbygJ2UFFlo0MG7o9uE6aK
	WDSSFqh5AbdmZBf0POHP2576vQHndDh9YbwXlWYgY5IlmO1Jwm+Mwtm/WyWOLRUPwLW2kO29ooBPx
	RrieLjHgulNVidaDgFwabSO72e6dqHfHfs0IoHphX0ojmtu6A6JRvOT0bxDWUJMANNSO/02kHFZIk
	mLu9UtXVL4GSa33+xZwHtppsGAJeqFq0Jw3UgqF8KZ3kQJFkZCCvsAd/6bGjA2RGdZJ9L8CEYREbA
	hT7Zle0qMyO+7Kfcf5DXgmKM9UROYYyXlk+jOBsz1QhbVCRVHDo9J8jNQK4RqmoDEIhjSyu0G34xL
	uV9XySBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3yVT-00A8Gb-MH; Wed, 22 Jun 2022 11:26:47 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3yVQ-00A8FW-IQ
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 11:26:45 +0000
Received: by mail-wm1-f44.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso10873056wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 04:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GL3s9AZX86KDwMOH+STEtwVrUQXmPNnDhqxTNdiyalk=;
        b=5cTBZ90r4fpAlEXLvUA5ADcnYY9gdlIT2yuFUbW4qKZVkf1bbYnrTk5qGkIcKuCMtN
         sczUdFB+HntHFn9Ver4oX6Y5e64PbiX2KUPflFz1F3HHLJKQoFZxJNpU3iAvfMdPqqMs
         VeKdWDoj/MQhFdOrxp3f0wNEpiVnDfCxoQXDz8qShKyoBd+reQYPik2r6rHvPUrrqpep
         2lSDfcGUlVLjOgOem4DQzvvjNZjwnCiBJ9L8zHhzuzJEv0paUSlRbLg7AlTfFnoGm4vc
         pvlVqQ8T9FDK8I5iPywEjG76CQQdsBq4T+VqNfw0wXCNROjM+nEkPn5LfRsOom12qVbq
         EOyg==
X-Gm-Message-State: AJIora+5lT8vKD4j5zwydYTIOy7XVBEBdJnd08RzDFGdvtOMkFo3fLwh
	E7aXiVezk1Zn4SmkyalMV40=
X-Google-Smtp-Source: AGRyM1vv2nujqVOankIyvI/FqabkZfOp0NGorYOyKa8iSDxg9swOv46oBfFQueEX10Z/uEUcO1RLuA==
X-Received: by 2002:a1c:720f:0:b0:3a0:2ac9:5231 with SMTP id n15-20020a1c720f000000b003a02ac95231mr2609300wmc.39.1655897202657;
        Wed, 22 Jun 2022 04:26:42 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b0021b956da1dcsm5948570wrr.113.2022.06.22.04.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:26:42 -0700 (PDT)
Message-ID: <63de8107-6428-2163-28f7-b2edcedc6114@grimberg.me>
Date: Wed, 22 Jun 2022 14:26:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Revert "nvme: remove the .stop_ctrl callout"
Content-Language: en-US
To: Ruozhu Li <liruozhu@huawei.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20220610095637.3714-1-liruozhu@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220610095637.3714-1-liruozhu@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_042644_654315_A595F864 
X-CRM114-Status: GOOD (  13.57  )
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


> We encountered a problem that the disconnect command hangs.
> After analyzing the log and stack, we found that the triggering
> process is as follows:
> CPU0                          CPU1
> 				nvme_rdma_error_recovery_work
>    				  nvme_rdma_teardown_io_queues
> nvme_do_delete_ctrl                 nvme_stop_queues
>    nvme_remove_namespaces
>    --clear ctrl->namespaces
> 				    nvme_start_queues
> 				    --no ns in ctrl->namespaces
>      nvme_ns_remove		    return(because ctrl is deleting)
>        blk_freeze_queue
> 	blk_mq_freeze_queue_wait
>          --wait for ns to unquiesce to clean infligt IO, hang forever
> 
> This problem was not found in older kernels because we will flush
> err work in nvme_stop_ctrl before nvme_remove_namespaces.It does not
> seem to be modified for functional reasons, the patch can be revert
> to solve the problem.
> 
> Revert commit 794a4cb3d2f7 ("nvme: remove the .stop_ctrl callout")

Indeed this analysis is correct.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Couldn't retrieve the discussion that led to this patch
or the submission of it, but it does add a regression.
Perhaps you should have the title reflect that this is a regression so
stable kernels can pick it up.


