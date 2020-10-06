Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9677C4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:51:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D21920E65
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppv/5nDw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WomVnvTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D21920E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jf9tFXW6/brjFJrPIAHfAdN3EyL+4JKPjlcN3sFtMJ0=; b=ppv/5nDwSmJPU1Sx+LfuTC1H6
	fjGbP9CzBN81ONmMiAXExeDGhrEMmUrWKCwtJoRQJow04/V+OKOTV+4rZzUBg1uGmTyWqj8yK7BEH
	b2QHGRHTm+zPsP3d8ptIT7fZW1SsTm0Y/k8x68BdGMWmeuEu4sh87KTUUdgFeIU5YsquA7puB+8Tr
	r6Up2IpJ6uiZbehMmSRqc9KqWC27dfIDrFhjHMM4X1XF06QBOf21LirPJL5fEQMTj1SCR8Ox1lRJS
	V0GjqORvrgocUIXPQSsUzMtqGZlxIxTs8Slkh4Jd1u+a5w7GrMoPFWpqzsgHXYE1f9QZES9RfC1f9
	6tE+XP7nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwk0-0008Va-TI; Tue, 06 Oct 2020 23:51:32 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwjy-0008V5-D5
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hUEDYTtYWRLTZhUJ1PsnTG6DKx8J9AiKmozhxnd9g4Y=; b=WomVnvTxGhGIUQZu62C6lncFUu
 W/EtMAVRX4r5X2yCavZqOW/QOtThugT/K6DAWw+hbKyAl5tBV+P2Z51HP2X19GPw652+tB9w3iGMg
 6YGVy+e33IEhaOmr1vKnHWF4NROcNJzeikdaR65s/8LLn+YYy36RYoEBqSVRF48uizjJyjuL5kRP0
 GikLOIGvasauzQVTy+nTD3m+Gi2CrRHLhd+FcTm142tYKDyNxhA1mjBXXhLB98SBi74UQ6OPfV/V7
 O4hHkrvHx8DXhuy0+t+CkUatb8nrM5A+vWoZ3LRCIEyvhDio6gzuEBaDaMU2FZpaa2WK/tioAwhiU
 yJ9ydGQA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kPwjn-0006fK-Tc; Tue, 06 Oct 2020 17:51:20 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
 <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b809f785-fc8b-4fa5-5de2-26dc9a4aed94@deltatee.com>
Date: Tue, 6 Oct 2020 17:51:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_195130_496756_E17B7E80 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-06 5:44 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>>  
>>  requires() {
>>  	_nvme_requires
>> -	_have_program mkfs.xfs && _have_fio
>> +	_have_xfs
>> +	_have_fio
> Can you make _have_xfs return true false ? so it can be used with && ?

_have_xfs() does return true/false and can be used with && or in a
conditional.

Per [1], my opinion is that using && in the requires() function where
the return value is ignored is confusing so I prefer not to do it in new
code.

If we want to reconsider this we, should add a check to ensure the
return value of requires() matches the expectation of the global
variable it uses.

Logan

[1]
https://lore.kernel.org/linux-block/92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
