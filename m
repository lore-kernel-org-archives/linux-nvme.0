Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:57:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF469206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ncpEWVwf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="q7PGZHvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF469206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v2Y0ERWeM32vDxVgoM4tgTjGSfPHOJVVIo6mKQ3Yl2Q=; b=ncpEWVwfRk1e/Z5bRezEmzGNq
	l4DVBUXx8/Y0EBeHlYkutVvrOb4GZmWESplSYc6j7OZN8qsqMU/6pdZVEEBbDl0sYw8WRhB03zHrx
	v1elVbgophoM2VjFt6tbYT9ROfai5p55xVATDBV+HJvaNUFkCz90LzfSjTZI/d3sevnWYsB8rU7l6
	m0qn33TRrcZ1Bwqy8thkh5cudG/6laY6BtbfBKkvCpJx65PM3T4gwdiZHp8bCO+Uwc5Ev7D6cgNFx
	on8fWZMc+uSb2dgsUhb9YdYxEsvIUGqz98dDr943I7iHX0DfGC1FJ1QdRxzl8VIS2hhgQbz2sqX8W
	TvR/M1fMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GjN-0006hP-45; Mon, 10 Aug 2020 22:57:25 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GjK-0006gv-Qe
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:57:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EZh3ZxGNN/tPHxnGvYjmlCfdh4Qolj12uC5J/EGyn/g=; b=q7PGZHvdmlkAJsMfKxGDM/tvqS
 Yv8ruSU/sQM6hk1n6NWzV6m6Gmb+qBulQ+vKVOuth+KfV2ua1JDKy6TSVIdQOjQ2dJqUDNBre8Tdl
 EDHul3TxjVeqnvbKxx2VLdN2TkokicTjAN+vwosqggI4KBOZigHDw5pngwYuuyMoQE2SIbD3Kn8lT
 f1ljq31IrikiKlUTcNJUktAlbaE+AU545zvMrMkO036IpbDEgE6miaUXatNt/Dm3RRLDZqh5LXZUs
 jp627LCmLggmmqIkawolXgYN5B+209Lg5vL68WOIgXdMFuOWq5VplaYZEOzSEroHkxhcx0RGNd3zc
 35IUQj/w==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5GjI-0001L4-KF; Mon, 10 Aug 2020 16:57:21 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
 <31ec987e-edf7-0f02-4edf-de33c9c6d533@deltatee.com>
 <BYAPR04MB4965062CCACF7B2DF5F144D586440@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f6f1ef01-952e-6caa-27c8-1f51e705637c@deltatee.com>
Date: Mon, 10 Aug 2020 16:57:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965062CCACF7B2DF5F144D586440@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_185722_916457_B9DB29CA 
X-CRM114-Status: GOOD (  10.91  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 4:56 p.m., Chaitanya Kulkarni wrote:
> On 8/10/20 14:55, Logan Gunthorpe wrote:
>> Why is this an improvement? Seems to me a loop variable should use the
>> fastest type (ie an int).
>>
>> Logan
>>
> It is a type miss-match, why we need fast type ? its not in fast path.

It's just normal to use an int for a loop variable instead of something
specific like a u8. The type mismatch isn't really an issue here...

Logan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
