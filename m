Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04646C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 15:38:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B716560F25
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 15:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B716560F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQdFsj7kFG3Gb+J+MEkY7WlzojbxbIuSOGUGniBfuzo=; b=zH2la/utWfIOIPYqCi+5IjJGo5
	e7nkJkALEXekAxbjUGiFraNkWZpb35p7zPBu8zb9mGOMIHeNUdYuk0EAiDhoe2w/+lZG4XoZGfEO2
	5s48mkpkTGD6SkPITgQxY19mfmB4Wq3kh9psqSKC72IWnzu9mERhXB3AuljKJQJFoW1kh4TtWVXjz
	OoSytWd7DIYNJG/7hUCIVJFLxkNs1FSO0MfSuOxkh+OUq2KWClvTyTDEgVNAo5/ysmHwVCUHg2fK6
	IiAF/lkl0yqkdMTJXZQTOjhXO6ZFjsS0S8uwTFG5obyUzE/7haytla4TKf3PeE+Ebq3/Ez6vqMnah
	oMC50V6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKjMr-00HXjO-SZ; Mon, 30 Aug 2021 15:38:37 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKjMo-00HXir-QG
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 15:38:36 +0000
Received: by mail-ej1-f41.google.com with SMTP id t19so32029833ejr.8
 for <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 08:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GvG3BPkL8GDwWI4NDLg3xm7QcfwfDFAgBHT+PFB/gGg=;
 b=ANhMFI/gCsK+n9KLla7gSM69t+p7WlLJbDOiHzkjQLHjwWePJuIYhB5PUf4f4DPuLW
 rvsWjCM9jWJERZ+WQACXoGAdF72StOYdmUC3uJjiwA7Rv7vMNxNPjJLI5V7wUzCNJs6x
 XCCNh1MgtebdPCnDksSwp+J+G44dlD7BsnSi+czITeQaRqFqZWvtcG+T/5V1uG8XvEV+
 JlNfsKS2qlucGhtgIny/isEFI7DVuNNE+RW5skGErrHHhmB/NHTdFsNa0ck7RPk0Lmbx
 t8KCwdXgKTyZAVYOrMdTACWKRQgoOMdYh6CI8687H/iEmowatCmabhdsX/+3mn9uf71/
 B+gg==
X-Gm-Message-State: AOAM533ugVn99k0t6I2cGaf1uRSlVtyG3c9CoswhZSa7SbMbR7U74eXH
 QgJfWqgwNSJO6Oje9KWEpd8=
X-Google-Smtp-Source: ABdhPJyrm1XsokPNLWD+oHtckSQ0hd3ttotKOY58uBZuekNmj5lQ4O29XdqY/euXZd2Od/HXv6oJGQ==
X-Received: by 2002:a17:906:2c5a:: with SMTP id
 f26mr10450012ejh.205.1630337911554; 
 Mon, 30 Aug 2021 08:38:31 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id l18sm6000367edr.83.2021.08.30.08.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 08:38:31 -0700 (PDT)
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 yi.he@emc.com, kernel test robot <lkp@intel.com>
References: <20210830133626.139828-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
Date: Mon, 30 Aug 2021 18:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830133626.139828-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_083834_906774_4A44D093 
X-CRM114-Status: GOOD (  13.34  )
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


> @@ -485,6 +486,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
> @@ -496,7 +498,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))

endian conversion a zero enum? looks weird..

But,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
