Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76AC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:31:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B142078B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qc6anCcb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KPlshpnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B142078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pvt7VHIICcV5kUBqrWZhPDuyMZewY82RH9a63Ivyjis=; b=Qc6anCcbBPyGiAlFCAqRGscyE
	OrAMgobQ2J3bsc0Wztc8HUImhE6NtN1d95Day2JPLNR9WiIUmRmlyxP1+FpcJ6UPn0TdaduLtt4JC
	p6kf0WsWMZaep8VXyvGC5jfyteJVbi/1ScDcL2W5KfV/mdRyx/H91718ETZNomMbIRSYcUSgyXSoU
	SZ5esWGboipP3mtDOR6ol1bvigf9tl/TpC4be+Id01BAFG+wulkkLaXS1zv0ndpAIR5R/yS20Z7r1
	WpsiCyz2mAEyOvqm7+Tt8TgL3FXnlvmOArCKQh8eJn00LQesBwSN2LH1a+o3cfyaA5uH1Zf7RzTpk
	zhqMw3h0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDDs2-0005HS-LX; Tue, 01 Sep 2020 21:31:14 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDDs0-0005Gy-Ul
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 21:31:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QR08Cc6vhsK3JHoj11oXkwdLUmJ/o0JqOxWumSqb0E4=; b=KPlshpntHGwaaGaGaTbZVolSXs
 fYS8G+V7+kzeFnzVc6aqqZX9sfFMJAwyx/xDdzOTvgsxGxNi2Uc5rcSClY1mwsaN/dnCaGaxdxW/S
 a9SuKJpz/cUBdE+K0EGGg0U0/dZB38OmPkDKuUdQ4Ma3yf7CGk4KDDQ0T8/OVJqfKG89kvX8jq71q
 Q8oLffXH8bj2BO9i1kv1o9mzp5Ao+bpgmiW+rx/w1KPDWFEFGMJ4gipiB/KBzQsNMJcvHYKokdd1Q
 sHWxFbgj8I9Ra+HpPdz/46cgri//DfbMESvuRgaLqWUGbnY74LhXy3e44qbnHRN+uZvmWOecFyAsj
 yPTSOTPg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kDDrx-00031F-8b; Tue, 01 Sep 2020 15:31:10 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <kbusch@kernel.org>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-4-chaitanya.kulkarni@wdc.com>
 <20200901155557.GB2831246@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB4965C6CFC808F34EFAD4B44E862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c282caab-abbb-d1b6-0716-7e051877daa2@deltatee.com>
Date: Tue, 1 Sep 2020 15:31:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965C6CFC808F34EFAD4B44E862E0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 03/12] nvmet: use consistent type with id->nlbaf
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_173113_009371_4EC6DBB4 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-01 3:17 p.m., Chaitanya Kulkarni wrote:
> On 9/1/20 08:56, Keith Busch wrote:
>> On Mon, Aug 31, 2020 at 03:26:58PM -0700, Chaitanya Kulkarni wrote:
>>> In function nvmet_passthru_override_id_ns() while iterating
>>> over namespace lba format loop variable is declared as int that is
>>> inconsistent with the id->nlbaf type which is u8.
>>>
>>> Make loop variable of the same type as id->nlbaf.
>> The loop is id->nlbaf + 1, so it'd overflow if the nlbaf value is the max
>> u8. Sure, it doesn't get that large today, but they're always trying to
>> make it bigger. And there's really nothing wrong with counting for loops
>> with 'int i' anyway.
>>
> 
> In past when ppl run proprietary static checker it has generated
> warnings for such cases.

I'd ignore such warnings. Sounds like the proprietary tool is producing
ridiculous false positives. And, per Keith's example, is just making the
code wrong for no reason.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
