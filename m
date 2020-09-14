Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A2EC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:05:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00616206F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7IVMGaX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KIuJSg9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00616206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+yNU/OHEA7qTZUgIgYexntYP6seZ4Ieuyidj/3+Rg7s=; b=p7IVMGaX6scQ7YxIMw3msjBiU
	O3usKP2GXj1F0Gm30l+jerhhO2hQcogBk+USjb7PryC4dRLzhO1WeQoHvBAicKbB5rM9KtLWTm4pJ
	Qyt1Sy0keIezFBCuZStru+g9yeDVeHiipkwucQSPsm5JLe1kkvW9IkQUMMXmt491uuZuCRK+Imdf4
	1R9iilclYfFmeG636QAlO0OaytaqSa2IdfKDDnUyef366JhIrsiWN098bsYow+lYnDLlqkydgtwUx
	L0YyHzV3VPxE1BcrDU0FNq/Gtt5cc3Eqb1gHuoWmfiT0xZthORIpWDz/NZPi/hdbGrOqtaVfrUQGc
	pE25h/UYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwaz-00082u-To; Mon, 14 Sep 2020 22:05:09 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwax-00082W-7j
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 22:05:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nG4K6Yxte9vWheiAlxDvydlqMsGpoYQ7ibzsTTQ7UrE=; b=KIuJSg9jyNmlMer9aghx7fzWe5
 X7sAt+smjQgvwh6biLcuhaLTLL0Hp5jl7RqaBUYGF8GRz6BzHjuaV0sNAfLQoFObqNsZRiAuTZ3IQ
 939vlFejI1Km1v2i1Mhigao0YVTxaxocKfBp2iQuvavP6nN0c0x6MXwCA7gE9Fz/j0VTGLKl2pORv
 OCgatXrXv12trs1zM61o9PPpKhGgXcFxTfMJY235wk9osu+9rnzNJHQdqyJne69hheHAeVRkG1555
 SEU9eLps8X09TM3kuNEuu8zl8x7LjDBzp2Ce5SXoeGnzNnDKBQmxCdr3szTjrRZIBZPVR1n/ADXur
 zXgFlc+Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kHwar-0005rI-I3; Mon, 14 Sep 2020 16:05:02 -0600
To: Omar Sandoval <osandov@osandov.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
Date: Mon, 14 Sep 2020 16:04:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914215145.GA148663@relinquished.localdomain>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
 osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_180507_409467_AAC134F6 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-14 3:51 p.m., Omar Sandoval wrote:
>> diff --git a/tests/nvme/002 b/tests/nvme/002
>> index 07b7fdae2d39..aaa5ec4d729a 100755
>> --- a/tests/nvme/002
>> +++ b/tests/nvme/002
>> @@ -10,7 +10,8 @@
>>  DESCRIPTION="create many subsystems and test discovery"
>>  
>>  requires() {
>> -	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
>> +	_nvme_requires
>> +	_have_modules loop
> 
> Bash functions return the status of the last executed command, and the
> requires function needs to return 0 on success and 1 on failure. So,
> this is losing the return value of _nvme_requires. Just chain multiple
> checks with && to fix this (here and the other places _nvme_requires was
> added with other checks):
> 
> requires() {
> 	_nvme_requires && _have_modules loop
> }

I noticed this too during my review, but based on my read of the current
blktest code, the return value of the requires() function is not
actually used. It seems to only check if SKIP_REASON is set.

If we want to ensure the return value of requires() is correct, perhaps
we should check it after we call it and then consult SKIP_REASON? And
WARN or fail if SKIP_REASON is set when requires() didn't return 1.

Also, we need to do more than adding &&s... _nvme_requires() will need
to be fixed up as it calls other _have_x() functions and ignores their
return value.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
