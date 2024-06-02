Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114AAC25B74
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jun 2024 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OOIamolSmIsdDNneb1zZPLdnns4+ZKhOIH/+0czP5sQ=; b=kAiKmoakOooGvuZ64Jr/r+WShe
	6B/T9RVKTsxHMiK1/wNKfX3DDos8u7fAaw/QgkPpkvpcJYnUAN3juPVrTmar8GOnqUQuw2ag4BAF7
	WHFTx7LAMrlaRTHZw88uTZqlz6eY5Zzyvcma3fUpsgq6GUvINS7Ywuj6Olv+Xktz0NqCkTReywMok
	/Rxo2982iWr5Qdj5DJ3H9y/Fm9cOeNxEtvuTaflHNt/l0IVKR3ICOwo2WKH3CxsPnUETgmhIRKLaR
	qzFCWIjPO9iE4MkXjYWNJLea7J0tlSjE3FZzX9UPwmNhKt9NRWfD8w863zGXgPGKdFV11xbqzQj1B
	xEDZYolw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDgxi-0000000Dy3E-3RzZ;
	Sun, 02 Jun 2024 08:53:10 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDgxf-0000000Dy2V-3YAA
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jun 2024 08:53:09 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e544aa9a9so22455f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 02 Jun 2024 01:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717318386; x=1717923186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOIamolSmIsdDNneb1zZPLdnns4+ZKhOIH/+0czP5sQ=;
        b=Py9ZEWTwb/j9zINRELpIucQVSqG6U2huu7PyY0lK4MlFS0HJdwTsjkBsbQnDBobs3K
         PppMr0dVCiCazhsff8UJzbJDf1E7sX52hnt16fozwUYxRKZcHGtIm0MQ5Ia+m1CnxPGH
         x8Ny1Zht4kOCn+uugJMIur5ds8MM63SvmB0gwq//6SBFd7iUvwPEh39iSDmqC/JbVbPd
         0ZOtMw8PLIrqeZFUT58ClwmLFRdW75t/eM9vIZwCwB0xJMYFaPHoZJVUxP7bmn4f2hyy
         0LOz4s+PCNJ9b4kPWsVAbyI9xvRkaeZv1v2iTkxP0ocUxY2g/l72hsYFh24Q0OE5Bzhm
         RpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMAun1QLI4nB7lFNcqc+JeFgQSA+nKy8HL7n3eLT4KmSAjIemmoVHcPLhEXzf10AN+C854Yes91LIugboOodHJBK6QGbf4IWhuNCURPk=
X-Gm-Message-State: AOJu0Yx5caNwfgoMyubQmTAyHPX3e3zRU10VBQ8yD8fPGOhFPhdS1wql
	/AD/VCdxb3g1iTwAMaz7CE4M2zPimFqu1HX/K40hbeqQsfqzktXP9rpRcIUB
X-Google-Smtp-Source: AGHT+IHbz9uMhwf26n1Cr16NAx9q2t8OQyZScigkCl0IpAocC9EBaxPM4nvKbehFDMySz3V1IFlxDQ==
X-Received: by 2002:a05:600c:3ba5:b0:421:2b37:80fd with SMTP id 5b1f17b1804b1-4212e0ae001mr47636405e9.2.1717318385707;
        Sun, 02 Jun 2024 01:53:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213a5b9f88sm10931535e9.16.2024.06.02.01.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 01:53:05 -0700 (PDT)
Message-ID: <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
Date: Sun, 2 Jun 2024 11:53:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Israel Rukshin <israelr@nvidia.com>, Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240602081934.GJ3884@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_015307_910975_FE942FDD 
X-CRM114-Status: GOOD (  19.74  )
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



On 02/06/2024 11:19, Leon Romanovsky wrote:
> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>> ib_drain_qp does not do drain a shared recv queue (because it is
>> shared). However in the absence of any guarantees that the recv
>> completions were consumed, the ulp can reference these completions
>> after draining the qp and freeing its associated resources, which
>> is a uaf [1].
>>
>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>> once the qp moved to error state, we reap the recv_cq once in
>> order to prevent consumption of recv completions after the drain.
>>
>> [1]:
>> --
>> [199856.569999] Unable to handle kernel paging request at virtual address 002248778adfd6d0
>> <....>
>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>> <....>
>> [199856.827281] Call trace:
>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>> [199856.860587]  process_one_work+0x1ec/0x4a0
>> [199856.864694]  worker_thread+0x48/0x490
>> [199856.868453]  kthread+0x158/0x160
>> [199856.871779]  ret_from_fork+0x10/0x18
>> --
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Note this patch is not yet tested, but sending it for visibility and
>> early feedback. While nothing prevents ib_drain_cq to process a cq
>> directly (even if it has another context) I am not convinced if all
>> the upper layers don't have any assumptions about a single context
>> consuming the cq, even if it is while it is drained. It is also
>> possible to to add ib_reap_cq that fences the cq poll context before
>> reaping the cq, but this may have other side-effects.
> Did you have a chance to test this patch?
> I looked at the code and it seems to be correct change, but I also don't
> know about all ULP assumptions.

Not yet...

One thing that is problematic with this patch though is that there is no
stopping condition to the direct poll. So if the CQ is shared among a 
number of
qps (and srq's), nothing prevents the polling from consume completions 
forever...

So we probably need it to be:
--
diff --git a/drivers/infiniband/core/verbs.c 
b/drivers/infiniband/core/verbs.c
index 580e9019e96a..f411fef35938 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
                  * guarantees that the ulp will free resources and only 
then
                  * consume the recv completion.
                  */
-               ib_process_cq_direct(qp->recv_cq, -1);
+               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
         }
  }
  EXPORT_SYMBOL(ib_drain_qp);
--

While this can also be an overkill, because a shared CQ can be considerably
larger the the QP size. But at least it is finite.

