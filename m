Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD012C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B47F206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I9FCqQWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B47F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r5W+PXRfbJ2vOp/P1Vfmzw4Krg8oGnxPUiC70UPt62c=; b=I9FCqQWgQqXDfJo8Ec6WfWXlN
	q7D+IpuJzWlhVY3TOeq3ExYwurb+OSYGx049DF9r+utOoAS1FNy5uxC3f3lBpHoGjIBBEcZ9TgRvD
	OjPuKxNE8hyBI3kKKsf40Ba1d0jPUsSp8NJGitplSO/gPP1qHJMpx7er38qX0W565DhTbg9II4tM9
	M8HdwdvldJDmOTwGVNE/07a1LRvQWYSscEq21gmD/9UUdQCoPDT2TCRv07mHrWrHzsEuH5+LCNrOX
	O8rbncKSgGUlrqlKy3c4Fdvb8KiI47Z86EG5qWYDy7MIDv9YkDZn715GCefEQDNbQ8ii3ChI9uvVo
	NDrJLsn4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGVlN-0006aC-Sd; Mon, 23 Mar 2020 22:41:41 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGVlL-0006Zb-9z
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 22:41:40 +0000
Received: by mail-wr1-f66.google.com with SMTP id h15so6990988wrx.9
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 15:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=blgCLHGES0Wqz/nJb8MfwyY0D+/5cheLh1rw3Lb+E7A=;
 b=sngAvUnuAQiWYmlEvcpZQoRBoU0RP/6Ym+JRRekZF21IMADOPSuwQidc3qS40Q5VUg
 H8+dnRaH1z2UaTwWs6bgX5woDMviBG4xagRtRdY6TFWPPxJSDbf4NecMG/NxVR+T15hb
 sgCjTK+TxVcpW3942GjsGqP2a03qYbw+ItOmR6ghwPLYYnhAsy/67yIaudPonr7y5oAJ
 yT707mBzLFqelWm17RzedcgcAh5Lxn44lv2jMP8+6trtE3a1sK88RFRU3pbnNez2r390
 FyDlqgTI/7OMuLgu1+jgAM6a7JQmSA+fXXBVQs56JVzxSQtndH1KCpYKUzgzCRsVOcEG
 yKNA==
X-Gm-Message-State: ANhLgQ0yEvhumKAy7w0KRtZ62eb2ILq/aBDou/j2WwJEOFEvY/xT442T
 mVCBlKbZZdjaxAeXtPIvc6sn7n12
X-Google-Smtp-Source: ADFU+vsJ+IQ4I4L+VEL5oaH83GC1FEbYlvkXf/EGj2DGfKMPV2uxI93x6JUFGZvn5WqAhMKDREBvWg==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr28001662wrv.178.1585003297525; 
 Mon, 23 Mar 2020 15:41:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id t5sm19666317wrr.93.2020.03.23.15.41.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 15:41:36 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] nvmet-rdma: use SRQ per completion vector
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de
References: <20200323172234.172786-1-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38b0b042-a046-472f-3a52-760eca7aa187@grimberg.me>
Date: Mon, 23 Mar 2020 15:41:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200323172234.172786-1-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_154139_348351_D0DA5011 
X-CRM114-Status: GOOD (  11.16  )
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
Cc: jgg@mellanox.com, bvanassche@acm.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
> +{
> +	int i;
> +
> +	if (!ndev->srqs)
>   		return;
>   
> -	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
> -	ib_destroy_srq(ndev->srq);
> +	for (i = 0; i < ndev->srq_count; i++)
> +		nvmet_rdma_destroy_srq(ndev->srqs[i]);
> +
> +	kfree(ndev->srqs);
> +	ndev->srqs = NULL;

Any particular reason why this clearing is needed?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
