Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F02C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:46:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCB9206B5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jgrmgGK4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Arsy43Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCB9206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X/bI4Bv7EVloWUN/y1QLabZRI4KJcOCdbERY+P2lS60=; b=jgrmgGK4yMKvdFjYtqnK10Zi3
	/9gLdqltJ17ATO7n6SjiQ/N++OoH+n8Emo6eQ9Z10Ty4lyjWLSQKI0Cjk9wFAOqXXecE7ZwrDNkG8
	+ZzfBT0gJO2mrGnSmb8zOnDtwHuVFpbkznd0TGiZ6UWM/eLjRFy6QmseF7pLULGklqdYXfZ0PMkNb
	K4gT5ZbrtYHCjwkI/jzuQncsRI6QiVB0Smrvu12MCpFlUzhcj9dEaJr5q9vQDTx1t5NukGC7m1m+F
	XvUrkpY8QP5a1VNVeCHtF6Vomd8HwJ7zcKW4xHYN3K4QFUmipInQ8zds6qeCAeC3Dh7CtgQPMQCe9
	uaeTGiAFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lpw-0000Un-LN; Thu, 06 Aug 2020 19:46:00 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lpu-0000Tc-CV
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qVur81/2HjVE9tKl2QwtjRjIZklf8gg+B8d37A0myPw=; b=Arsy43SvmIis4zT8OsIZu85mgW
 knWLH6afvPKVyu756Q12TUwrTyJ2xneOVEISlie31LxGKq+pVldC0Oo3+235C4vfDX53p5P1Y/GJ1
 AR2MCkuZy1c9ZxQtFXFIFHbe1UTaEOwEHLjeWwTgWOPfXI30lMBKldt4dCVh6ltEWu4Q1d+MV4qX3
 6aLBiW9v8VDGibU08V+rXFDZvuELwmXWMA6uvXhPMVUKWKG8zAx29OQIX7ej7BETZJDHucFWtvdfA
 /JrZ7avzzkHggNfZ3+qc9X6dQxrmxwM3pzXxP6RqwSrkzwwBjwKJ37DptdqTWZ2LsHcLM50ycYk5t
 r1LbLtlg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k3lps-0001N0-2j; Thu, 06 Aug 2020 13:45:56 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
Date: Thu, 6 Aug 2020 13:45:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_154558_529052_933DCAD3 
X-CRM114-Status: GOOD (  16.44  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-06 1:40 p.m., Chaitanya Kulkarni wrote:
> Logan,
> 
>>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
>>> index a260c09b5ab2..96bc9aa11ddb 100644
>>> --- a/drivers/nvme/target/passthru.c
>>> +++ b/drivers/nvme/target/passthru.c
>>> @@ -239,7 +239,6 @@ static void nvmet_passthru_execute_cmd(struct
>>> nvmet_req *req)
>>>
>>>   	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
>>>   	if (IS_ERR(rq)) {
>>> -		rq = NULL;
>>>   		status = NVME_SC_INTERNAL;
>>>   		goto fail_out;
>>>   	}
>>> @@ -248,7 +247,7 @@ static void nvmet_passthru_execute_cmd(struct
>>> nvmet_req *req)
>>>   		ret = nvmet_passthru_map_sg(req, rq);
>>>   		if (unlikely(ret)) {
>>>   			status = NVME_SC_INTERNAL;
>>> -			goto fail_out;
>>> +			goto fail_put_req;
>>>   		}
>>>   	}
>>>
>>> @@ -275,11 +274,12 @@ static void nvmet_passthru_execute_cmd(struct
>>> nvmet_req *req)
>>>
>>>   	return;
>>>
>>> +fail_put_req:
>>> +	blk_put_request(rq);
>>>   fail_out:
>>>   	if (ns)
>>>   		nvme_put_ns(ns);
>>>   	nvmet_req_complete(req, status);
>>> -	blk_put_request(rq);
>>>   }
>>>
>>>   /*
>>
> 
> This adds an extra label. Also I don't understand why we should change 
> the order of nvmet_req_complete() and blk_put_request() in 
> nvmet_passthru_execute_cmd() and make is inconsistent with in 
> nvmet_passthru_req_done() ?

I don't know why an extra label is an issue and I don't think the
inconsistency is important. This follows the common pattern where things
are cleaned up in the reverse order of their creation and labels are
used to control which cleanups happen based on how far it got:

rc = setup1();
if (rc)
     return -1;

rc = setup2();
if (rc)
   goto out_teardown1;


rc = setup3();
if (rc)
   goto teardown2;

return;

out_teradown2:
    teardown2();
out_teardown1:
    teardown1();
    return -1;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
