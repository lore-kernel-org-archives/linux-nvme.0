Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35887C41604
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDEE20789
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f8N+9V32";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WXydZ7GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDEE20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZQxNRiZmSze2NbXbSsIZFgG7EgDKQeyyRDbHxfrIagw=; b=f8N+9V32V2Kf2j4BdZDBRCj1f
	XacKBTpu6CblBHa4rDxDu7FqiopuUM/U0FMYgB0tTpXZeJYGRD4EQ6kHQIhpjtwzWnyTtjWxDACFo
	83IppAowULab73P4gfYFl4TpGKNE8SwRl+DUn36MqUO7lRifR6ED2EKjrQBW6G/fpzOu48E0Sg5jl
	xbr61SSAjLyF+j5kFSw+WwDNQz3PcZmjl57rRXuwGP5IYeB51rzlfvD2gQijaXFcs10eUnSP7MeEM
	GXlfpmdz+NfkYqtHGjZi228uJhBGu31/YmQegF3jiwWMD5G8uUzIMgjjZ+h5AfXrNpB5sT8B0bNFd
	wJG9YCEMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQBmk-00010M-BR; Wed, 07 Oct 2020 15:55:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBmh-0000ze-UM
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 15:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5udLltffkLJI9drucFdIqOZx1b8+mVHzFbzJoFwRjY=; b=WXydZ7GBEWK47T6TzK1Ygl7ZLD
 XJpRfRj7nQ8y95YWRPJ8rSMDbithPdnei+IbZAZV88PQg+pdC9eLUqC2Ilk74agTD9c8y6teLM0rS
 H70jpSMtJmcnvH27CgZAvJyMAi3jUYgu+nRyTaHcRYa9/LcvGViT2F20MWlmihXjvYD77Eo5v/+qb
 qwxfw9DUtFgICIZn+38Vh64w4roruEtmkkCDbc6Z7rFFX2rL2hN3Mb6KVWdgZMwhK+aTyIX21hy85
 GsnczW5aVnTHnEKtExl6qpkzYgOsDF3vpfA+TXsn7n4Kynjgpva4uuxaLdfDnQ5IRytwtKpYA8Ezk
 36jhqs2g==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kQBmf-0000Ah-KX; Wed, 07 Oct 2020 09:55:18 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-5-logang@deltatee.com>
 <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <517a5fd9-50eb-eb5e-5911-093dc5d1a759@deltatee.com>
 <BYAPR04MB49650C6419A84705D04FFE63860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <39ab50dd-b117-2e53-a7ca-b390ade7dd1e@deltatee.com>
Date: Wed, 7 Oct 2020 09:55:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650C6419A84705D04FFE63860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201007_115520_008994_B15E0542 
X-CRM114-Status: GOOD (  17.48  )
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



On 2020-10-06 6:24 p.m., Chaitanya Kulkarni wrote:
> On 10/6/20 17:10, Logan Gunthorpe wrote:
>>> With this patch or this series will I be able to write the testcase ?
>> This patch helps with that but other helpers introduced in this series
>> would require minor changes.
>>
>> As far as I can see, you'd only have to adjust _create_nvmet_passthru()
>> to take an optional argument because, presently, it always uses
>> $_test_dev_nvme_ctrl for the backing device.
>>
>> This can easily be done if and when someone writes such a test.
>>
>> However, I'm not even sure right now if that test would pass in the
>> kernel as is -- it seems like an odd thing to do.
>>
>> Logan
>>
> This test should pass if I remember the code correctly where we don't
> 
> have any PCIe specific checks for the passthru controller and it is an

Yes, there's no explicit restrictions, but that doesn't mean there are no bugs
with that particular stack.

> important to support this scenario in order to write device independent
> 
> testcases as rest of the testcases are.

Ok, feel free to write a test for this. It's not important to me.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
