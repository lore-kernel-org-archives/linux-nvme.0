Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFFFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCJ0kxoNhxlaN6HUzh28+2u9bgLInd78a4P4vS2peww=; b=MCxdFw5t07c6z5/WwXO4MKeG/V
	y5RBbKAn8TKX8wF4vlJGQ67cFgValozallomkyVsIdXkGqh4JcNze5lFeGyijPlTV1TDid8o9SIp3
	9hDOwvpl1iAjlplhI/KKux4EcDNuFFms/v0e8yNpThTFhb//U0YBbvoB2QXqjBBWHSeE9YTyWm20N
	lQbEmoHbbclbpL04yHoT9dBXESKHd6Dk1sJ+qDsWdFN6ZL2sSwgOJrYKfd56ZaibkXqN3KR3FNxm0
	Ymz0UUntPPG/3HyIZ1fBriDge3LntNUOl3p1Xf1TOgCy1pEYG4FMI0Nm5FMR5tycZJggLYIsQE5aV
	boLtIFLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw65y-00C6L0-FK; Tue, 31 May 2022 17:55:54 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw65t-00C6Jj-7l
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 17:55:50 +0000
Received: by mail-pl1-f175.google.com with SMTP id h1so4300289plf.11
        for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 10:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=dCJ0kxoNhxlaN6HUzh28+2u9bgLInd78a4P4vS2peww=;
        b=lEWmBQLOEJl6HmYTX2s6/CnxlgZz9sgNlB0AkEVn08ka/t1PxKkIcmmdtuoBXyfQ9X
         OSWiKpJyRdbxzZE9NDC86HBbySkzlBtyA3OaMibQpw9qJ9Kj7lyerZz0boAlje+bDwVZ
         RY9HeuFbQMV11YaMJmKfMiOOux+Vx69uTHwEqY7wTvgMG7zQ+ZFhRTVjKzvEqZidrzlA
         qT6ZPVyO8oZk/E0ytRttuoqK1qmZAQe+j4bUG4MDx9a9sFODNMvgUvRaGSKSKiIKy8yN
         dMyHY1ZQ5/JDz+6ewPUtNEPmZ94n4dKXKvT+lP6XtRgwMtXEm8eh1s+LZLd0kYbyypxu
         XDUw==
X-Gm-Message-State: AOAM533rs5bNAXTZ2YBd0OxqHFAO54Fp8urAcoEgH9Y0jtgdit4tcXBH
	k/UPOJqIZYxB7/IOtu+5Y6nj1dpGcZ7e+g==
X-Google-Smtp-Source: ABdhPJwExwLDU+mzF/g9QchT/DTKC6Kf2nIjCtULXhjUroLBP/wbJMwEwdhtw402flcK9Weu66IRnA==
X-Received: by 2002:a17:902:da8e:b0:164:537:d910 with SMTP id j14-20020a170902da8e00b001640537d910mr4413681plx.75.1654019748170;
        Tue, 31 May 2022 10:55:48 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x27-20020aa78f1b000000b0051b8987efc0sm1874597pfr.218.2022.05.31.10.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 10:55:47 -0700 (PDT)
Message-ID: <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
Date: Tue, 31 May 2022 10:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
Content-Language: en-US
In-Reply-To: <20220531123544.GH2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_105549_331281_FFEEAC6C 
X-CRM114-Status: GOOD (  17.18  )
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

On 5/31/22 05:35, Jason Gunthorpe wrote:
> On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
>> On 5/27/22 14:52, Jason Gunthorpe wrote:
>>> That only works if you can detect actual different lock classes during
>>> lock creation. It doesn't seem applicable in this case.
>>
>> Why doesn't it seem applicable in this case? The default behavior of
>> mutex_init() and related initialization functions is to create one lock
>> class per synchronization object initialization caller.
>> lockdep_register_key() can be used to create one lock class per
>> synchronization object instance. I introduced lockdep_register_key() myself
>> a few years ago.
> 
> I don't think this should be used to create one key per instance of
> the object which would be required here. The overhead would be very
> high.

Are we perhaps referring to different code changes? I'm referring to the
code change below. The runtime and memory overhead of the patch below
should be minimal.

Thanks,

Bart.


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index fabca5e51e3d..d476c64cd84a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -860,6 +860,8 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
  	init_completion(&id_priv->comp);
  	refcount_set(&id_priv->refcount, 1);
  	mutex_init(&id_priv->handler_mutex);
+	lockdep_register_key(&id_priv->handler_key);
+	lockdep_set_class(&id_priv->handler_mutex, &id_priv->handler_key);
  	INIT_LIST_HEAD(&id_priv->device_item);
  	INIT_LIST_HEAD(&id_priv->listen_list);
  	INIT_LIST_HEAD(&id_priv->mc_list);
@@ -1899,12 +1901,16 @@ static void _destroy_id(struct rdma_id_private *id_priv,
  	cma_id_put(id_priv);
  	wait_for_completion(&id_priv->comp);

+	mutex_destroy(&id_priv->handler_mutex);
+	lockdep_unregister_key(&id_priv->handler_key);
+
  	if (id_priv->internal_id)
  		cma_id_put(id_priv->id.context);

  	kfree(id_priv->id.route.path_rec);

  	put_net(id_priv->id.route.addr.dev_addr.net);
+
  	kfree(id_priv);
  }

diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 757a0ef79872..4affecd044eb 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -75,6 +75,7 @@ struct rdma_id_private {
  	struct completion	comp;
  	refcount_t refcount;
  	struct mutex		handler_mutex;
+	struct lock_class_key	handler_key;

  	int			backlog;
  	int			timeout_ms;

