Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD727C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlTPk22reBS5D3PcSyOlT8Lu4aAsE97jAXjbvpBQ2hM=; b=rxbeVqqqfFnTOhxsqhqVvOQm+1
	hMgEqUr9b1bnijKLkI6Cn4rkTU9S65SBQQijDthGJJ1AJqI93Lb/GdDbj2ELKOpVZlyJ+H4klZeaQ
	3rTJTcegkjZnRIdxmHMyVS9pLu3Ewx6GBd3QDlKQFZBlfBTs98ehsYPJ8bdnlZyJWBpcRKoQGObou
	5EGkSAr0b/V+a2JXOyfplwpSaelU4Qv7Q/bEB9TSDucp48s9G2jeBVDtZ8NTk5FXUMi9x1EVIu8/L
	OV+mdHrFDxm0vZs6JPsXX18879nOTZw4iSj+yXeKBTXKfCOjMc739nhkkY8N9ICLPMAZOmqJc3w83
	Q8Ivw/TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTV2O-003M0y-DH; Sun, 13 Mar 2022 20:42:00 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTV2L-003M0c-KD
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 20:41:58 +0000
Received: by mail-ej1-f54.google.com with SMTP id qx21so29800619ejb.13
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 13:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qlTPk22reBS5D3PcSyOlT8Lu4aAsE97jAXjbvpBQ2hM=;
 b=R1arkoCLPIUxvGNIIvZFT46kTe6eFFxxc5iOv1xQp3A+feA7zUOGb87YORbMQcYSQJ
 0KrdEantCQnLn2YNGZl3lH7TKiOw+r4WV9r3lyNCgCu1XMXAgEzVTU9eJnommmTOvStd
 M85CVhUHkiJORBYOZ8M6qyxEdAbHnFozPaUMAZI/42/uNKH4cn6/j3RNaOm6UJeVbq1G
 udI1YSjPc2+74RZneF8+LKuD9my2nB5fD/NMKKILCZ/A65GzCoORpbJfheM5neuaPRNJ
 vQ/HWi461cR8HE0arMt1nxmQ7qCVeQeOgZYOC874vsj2WME9v0FsPwVxroOThUgIvr66
 5oBQ==
X-Gm-Message-State: AOAM530KG9iFnzS36YUhfWUEUVMYoet90K0ykC92JpKFH+Z2S/W+jeRk
 VuHnJDWbGZKv5cxzSvvnpsk=
X-Google-Smtp-Source: ABdhPJwXutQM51btq1MBqYQBU3KdgUqmtv6zeNmyQa1/cygkDAK+Oj6fxMBkychQAEv3ZmJuQUaBAw==
X-Received: by 2002:a17:906:7852:b0:5bb:1bdb:e95f with SMTP id
 p18-20020a170906785200b005bb1bdbe95fmr16984740ejm.435.1647204115156; 
 Sun, 13 Mar 2022 13:41:55 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119]) by smtp.gmail.com with ESMTPSA id
 j20-20020a508a94000000b00416c19650e8sm5121944edj.71.2022.03.13.13.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 13:41:54 -0700 (PDT)
Message-ID: <d5b1b564-cad6-87c2-11e8-f2d9d92f389c@grimberg.me>
Date: Sun, 13 Mar 2022 22:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <20220310125130.16786-1-dossche.niels@gmail.com>
 <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
 <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
 <e40f3aea-ba33-f49f-7859-49b47a64cf04@grimberg.me>
 <278c7d10-b361-6d44-ed27-9d3d0ce25b82@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <278c7d10-b361-6d44-ed27-9d3d0ce25b82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_134157_697215_A3E406A8 
X-CRM114-Status: GOOD (  12.70  )
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


>>> My commit message in v2 did not clearly state that nvmet_ns_revalidate has 3 callers, of which
>>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns. The other caller
>>> nvmet_ns_revalidate_size_store does acquire the lock. Maybe I caused some confusion because of the unclear wording.
>>
>> It is simpler to just move that call-site outside of the lock imo.
> 
> The callsite that has the lock is nvmet_ns_revalidate_size_store. It checks for the enabled flag under that lock.
> If nvmet_ns_revalidate_size_store calls nvmet_ns_revalidate without that lock taken, but with the lock acquired inside the nvmet_ns_revalidate_size_store function itself, is it not possible that the ns->enabled flag changes in between the ns->enabled check and the call to nvmet_ns_revalidate_size_store? I thought the locking in that function was to also make sure that the enabled flag does not change during the execution of nvmet_ns_revalidate?

The lock just protects subsys->ctrls traversal, can't see any
harm with sending 2 aens out of order, twice...


