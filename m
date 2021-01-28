Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:39:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C08D64DE2
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C08D64DE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DFxV16cnPTKFYoFm7OSPbMQg13iUxvlN8Xc5bNacXms=; b=Jn5dC/GgWtzRr5Nd4jwQLuGnk
	MHru3OiG8tR+RxJTJ6+e70p1QHi/C5wAFwBjXCz5uqV9JjCI+rltV/5hO5UEVH5o7x2llNkpPftBa
	j5xEh7BHmmSdWabAP1xHDdg5l+Uk1SbKoLA+DzG8fNdLgNaHjeAtGqKN63q0mboydK37yiUFlapjm
	+xuyT+WRe/MPRmKX8WYmhdkR98eWNWQ+YzIQQru5LR23l40Bb4cG/3Z0KVWElK8YuQB4GDWexC29g
	YbERhTDqQlU76ZpBYtpSb+eOGT3X0p3evyjEVftYwm9cRDtFp7Z5C414nhJoXACjE6JX8PzxQ3vQJ
	9i5WFJFcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l52q0-0004AJ-Qo; Thu, 28 Jan 2021 08:39:36 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l52px-00049A-Jv
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 08:39:34 +0000
Received: by mail-wr1-f54.google.com with SMTP id d16so4469697wro.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 00:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mu+S+hqRggK7XQj7o+cIO4Mbz3GyYl5LYdtGdY1J+hs=;
 b=r8M5KIzlhTBXLcv5B/mvm1abdD67xGBXpII2iNLTvqarkcODA4gHRYC41+Dgr79gFe
 5gMyPM2NaDuEt6S/FgUl6sPePlGdG2l1Y0XTaqh2vT+V8oUcjuIk+YOZ1ENQE3ljfiqN
 dmU/tYieAEvE0sGxJLsqN/yj9ea3duducwcSHmPtwXAfFf/aI4yUU2teH2o+s0rpVapr
 vZs9NKOyyWpwOJgg+rDTbGOo6k0OTDO4OU3gG7pr3+Rie4Bv0Tqg6jRHEAz7oIYswZ5K
 BCzK+KI2f0SImmtSipjwT4znQ1UxSh81H1p93++VW3mKtcrlcBGjw4/WcN5WVzfjZWQy
 YhmQ==
X-Gm-Message-State: AOAM530+erojfm9cmCdUnH0blQT4oQhoZ3wj6A5wE8/syq5LKn3pFyog
 q2wCKvIbYKztGqZwNOyURI+biE7g/2k=
X-Google-Smtp-Source: ABdhPJwJX/zZdKjn3i78+g76uoWeeUxUJ5+E5kUzS9g9Zxp/h8jaZ+7p9Nlocg7OB1gmdOesHPwH0A==
X-Received: by 2002:adf:f749:: with SMTP id z9mr14713756wrp.327.1611823172369; 
 Thu, 28 Jan 2021 00:39:32 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:4d86:226e:ca4b:6bef?
 ([2601:647:4802:9070:4d86:226e:ca4b:6bef])
 by smtp.gmail.com with ESMTPSA id w20sm5072019wmm.12.2021.01.28.00.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 00:39:31 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
Date: Thu, 28 Jan 2021 00:39:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126081539.13320-5-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_033933_704213_47AF9BEA 
X-CRM114-Status: GOOD (  11.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -2084,8 +2085,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   
>   	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>   			req->mr ? &req->reg_wr.wr : NULL);
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> +		driver_error = true;
>   		goto err_unmap;

Why not just call set the status and call nvme_rdma_complete_rq and
return here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
