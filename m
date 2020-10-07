Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0ADC4741F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 15:54:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C627C215A4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ro9fwWFj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HD9tfI+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2YAAPN4y0wQ+0/ldNL0V3dFw62zmZHWzjL36P0Nii2Q=; b=Ro9fwWFj188gkCqqrI+0Olc2B
	WMz9/DyiwVu774VnpzsC2kjnpZsHhXlfQXXnicghoC5IBDaSdIzqPkmQsY1mJPTL5vm1IHJ4HG4Yl
	Vnp+iFNXbkKprhYo6LRZCRaKoltwOw2hQ2LKwFVRgtzp2Ty19dr/RCj0UExLJIh00a4tF6/w1e7Xn
	6Tm2JmqZpj7ezhfsu8CVi49CLQnvfuWHLrCeGCWbdA0ElNaA0ESuoi57hfdEdiQoRcAPPjyeugkmW
	y8cmesfRSGK5nJFGmFhdlbnzYeMNRhrrNRyFSugY27C+x/EGXOrcjcg4fVOW3Qq0zoYuBOwQZeVZ+
	3ZD8NekFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQBlJ-0000kG-NK; Wed, 07 Oct 2020 15:53:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBlG-0000jM-6W
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 15:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zJTcEz7rUO3DGiHLK/RyvreZiaypX+Dmx17AyGTD6II=; b=HD9tfI+NEJ/ZdYCnN4Vyd50bYD
 9djIMgLs0BWD50ZiwbQya7jiej3acTgbPxw18TmVEgwO8a420Ypd4LhODFw8VATpEPF+s3SB6HNrC
 noG3ktwUXoCsQyPK0Cbx0RTHd61kbB73QbI2oSsu7nCPPSrZB3oFnibXik0Noa9i6a07TdUnxZkME
 oSwWxUx1rJg6mRn7ry1xCvHWg4ExyP4/ow0E20qZsqq0bS+hUGu/yJ7C8j/1YD1GQX68JDHYEVRYI
 TV3CMqTd771oXRH36uFy+c/c6Ywg5+4RKH8RyNAHfP3BbAQwxweepHm5Bf+WYGAQzGOyOMDD4E90k
 9ZzsTvSw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kQBlC-00009t-E7; Wed, 07 Oct 2020 09:53:47 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-4-logang@deltatee.com>
 <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <868f8fb6-6024-d60d-a9aa-6513b9d0986f@deltatee.com>
 <BYAPR04MB49652338A4FE3805F9394A88860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2af98b64-1f3b-6570-d5be-a2e2bc4950f9@deltatee.com>
Date: Wed, 7 Oct 2020 09:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49652338A4FE3805F9394A88860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201007_115350_269974_C543B6D9 
X-CRM114-Status: GOOD (  18.06  )
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



On 2020-10-06 6:20 p.m., Chaitanya Kulkarni wrote:
> On 10/6/20 16:59, Logan Gunthorpe wrote:
>>> The mount dir should be a parameter and not the hardcode value
>>> to make it reusable.
>> I also disagree here. It is already reusable and is used in a number of
>> places; none of those places require changing the mount directory. If
>> and when a use comes up that requires a different directory (not sure
>> what that would be), a parameter can be added. It is typically standard
>> practice in the Linux community to not add features that have no users
>> as it's confusing to people reading the code.
>>
>> Logan
>>
> Well if you are making a helper it should be generic if you have a usecase,

"Generic" isn't a binary yes/no quality. Why add the mount option (that nobody is using) 
and not a size option as well that nobody uses? For that matter, fio has a ton of options
we could expose. (think io-method, read/write pattern, etc, etc). The criteria we
decide upon which options get exposed as arguments is what the code that's actually
using it needs -- not what's available or what you imagine future use cases might be.
If there are no users in the code it should not be exposed. If a use case comes along,
an argument can easily be added when the new test is added to the code base.

> mounted on different mount points not just one which is important testcase,
> 
> that will require a prep patch.

So? That's normal.
 
> Why can't we do that right now when we have a clear usecase ?

We don't have a clear use case that's being added to the code though... We 
have an imagined use case that hasn't been written. Add the feature when you
add this use case.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
