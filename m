Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B914FC74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26c/PJlmYgWkbBmERwUyqF2dpBsoOH9Y3u2+yXmk3wc=; b=0uko9dpOtj7Zy4BxyOovYWok6U
	C5+v+KMVqe11s0S47jXh59Y1jUumhWe00OFU+PaEqYhm4yZxTpGb5AhgchyddyBYKKFLgx6Rt2pCi
	uidhBIoGtfcsbGTEFRKkecAuRLNbCX8XPWJDWGprkP/HhPYmtFnMmDKhUgmpXxQug6XQoablZDRR5
	03UnnjMzVAefZaM0meru2l82qYZwZvhgwjk6CBVC92krY2eIQ/PGG/GD1adfTeoSqmqUOg+U/y2yn
	BnoyDVozVc2QHTpdnb6FbyfHjRxS1KBirScW7ZWBLXv1zUMWLndHCk1Y0a2kJHqenfsj5FRPYyl4Q
	Rg/YXceg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peb4I-00CKVo-2q;
	Tue, 21 Mar 2023 12:26:22 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peb4F-00CKUN-0M
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:26:20 +0000
Received: by mail-ed1-f44.google.com with SMTP id eh3so58875025edb.11
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 05:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401575; x=1681993575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26c/PJlmYgWkbBmERwUyqF2dpBsoOH9Y3u2+yXmk3wc=;
        b=2bhTBds8FC71cdGtmeHlrmrhWdRH9vx1/pGdykEWCzxR1bTg/Y+WuL6DoMOr5OIYJP
         SBfCJRjAh4LngGiWMd1PG6qMLdANbxZm0clUqvkShu7dXu/JFMAH5sqCYLHkZ+tLMw1T
         pzDBVOO/D8o7W84ieAgXgRrR1nWdOvslsmBd/ut2IUETHz63+s+v0bT6BtYrmdxMWmFm
         /t7sMb06k/HU7qiM1+3I/d/RiVLW5YHrChCf0uAtZoBmffEpqgQSueHsm2o/AR+K8Bu/
         0+P8knp844N93xfiE4TN7UypP5RTTj38XnNf6aVWOacMnlnoUuHigK3XE4eFACxsYxT1
         LQoQ==
X-Gm-Message-State: AO0yUKUacrUgxblhjMrEihNuTyxhvHaDXc89pbL2hYoDio2UzNCcrBcA
	86BlqXl2Jxgbl2YYX4zWFhJ+0RsfJWc=
X-Google-Smtp-Source: AK7set9BR+aUaX9jSI1+8SuxIhEkOn8iOy7MhwLuv4P3XYOXwQIiS4APbSbxzBudsHD9WeybjYQJMw==
X-Received: by 2002:a17:906:10d0:b0:931:4285:ea16 with SMTP id v16-20020a17090610d000b009314285ea16mr2362836ejv.7.1679401574832;
        Tue, 21 Mar 2023 05:26:14 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm795854ejb.111.2023.03.21.05.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 05:26:14 -0700 (PDT)
Message-ID: <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
Date: Tue, 21 Mar 2023 14:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH] nvme: fix heap-use-after-free and oops in
 bio_endio for nvme multipath
Content-Language: en-US
To: Lei Lei2 Yin <yinlei2@lenovo.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
 <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_052619_174138_550F2E64 
X-CRM114-Status: GOOD (  15.75  )
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


> 	Thank you for your reply
> 
> 	This problem occurs in nvme over rdma and nvme over tcp with nvme generate multipath. Delete the ns gendisk is caused by nvmf target subsystem is faulty, then host detect all path keep alive overtime and io timeout. After ctrl-loss-tmo seconds, host will remove fail ctrl and ns gendisk.

That is fine, but it is a problem if it does not correctly drain
inflight I/O, weather it was split or not. And this looks like the wrong
place to address this.

> 	We have reappear this proble in Linux-5.10.136, Linux-5.10.167 and the latest commit in linux-5.10.y, and this patch is only applicable to Linux-5.10.y

So my understanding that this does not reproduce upstream?

> 
> 	Yes , this is absolutely the wrong place to do this . Can i move this modification after nvme_trace_bio_complete?
> 
> 	Do I need to resubmit a patch, if modifications are needed?

Yes, but a backport fix needs to be sent to stable mailing list
(stable@vger.kernel.org) and cc'd to linux-nvme mailing list.

But I don't think that this fix is the correct one. What is needed is
to identify where this was fixed upstream and backport that fix instead.
If that is too involving because of code dependencies, it may be
possible to send an alternative surgical fix, but it needs to be
justified.

