Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED18C4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C742E20739
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CetTiVr6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="indJGTPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C742E20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/yUgHiSxBD3wFTpxwcjf+nINYkVboG3z22eHLFqpCP0=; b=CetTiVr6vKDI1t/feO4oDgv3t
	Zx1EpvuyHzTyw/cXFLZfbtnQCo+zhVGrRNoqCZ7IKgWSwLJ/GQ5KPeg27PFHHSKlRH5+koDaQ0W5Z
	5+loEHIuCudTKAdNHfQSks59U90sCtZ3z6wMNMuE/JKwrNduxKqCuSKcMS4UqAgeHDDoQOlrN/8Xe
	O/VVZPohkZyfplS2OJJSg9jBXnLpXOrBkPA8fLd53xEsY2jGUbXPAnfee3vv8y6dSKqxipPBzn1Xr
	TGfC1HwAoRnraXhMO2uXmHpK5cp/j5V2LbIs5bGp6As18nS5/aOelPiF/tkgxRs6REDwIOs+Ttg/E
	ePqKd5WJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPx2E-0002HT-99; Wed, 07 Oct 2020 00:10:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPx2C-0002Gn-2t
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 00:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j3Cr2cb8eBkvIoAig81+fwGrbmja7dlTy4mkKB0Hfy8=; b=indJGTPgJ9/eZYGcv3e0s7U2+T
 kcZQxuBq5DpObf9GiacIowKEqLciTiPlUnvdcP5fL3lT+ABtGvSVkZ9cEO95rjbmw2vbFpyebcT3U
 OFDLg3Oe/sDDXb8EuNbr6alvuWv6D1H/w/4Ri+yF42X7+PL6FveAxzxWva0Y1T0ma97VbqOFdV1RO
 5hS+7eha5PR364vK6YPnUJvgEcleB9ju3qocpQrkg28t2DhA9aUpMbbmjsatWt/jRnR5M7K5fv/xk
 5g6UtUgPKo7L7+KdrUvkMzH3AafaOJhS8Ev24rn0r79CoWp8Xqp/yPcbCETJe8RctZ5Cpaov4wQMp
 R4SBm0zg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kPx28-0007AV-Qe; Tue, 06 Oct 2020 18:10:17 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-5-logang@deltatee.com>
 <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <517a5fd9-50eb-eb5e-5911-093dc5d1a759@deltatee.com>
Date: Tue, 6 Oct 2020 18:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_201020_129411_CF4F6F05 
X-CRM114-Status: GOOD (  15.91  )
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



On 2020-10-06 5:55 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>> This ensures we find the correct nvme loop device if others exist on a
>> given system (which is generally not expected on test systems).
>>
>> Additionally, this will be required in the upcomming test nvme/037 which
>> will have controllers racing with ones being destroyed.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> If I create a passthru testcase with :-
> 
> 1. Create nvme-loop based nvme ctrl backed by null_blk say /dev/nvme1
> 
> 2. Create a nvme-loop based passthru ctrl backed by /dev/nvme1 say nvme2.
> 
> 
> With this patch or this series will I be able to write the testcase ?

This patch helps with that but other helpers introduced in this series
would require minor changes.

As far as I can see, you'd only have to adjust _create_nvmet_passthru()
to take an optional argument because, presently, it always uses
$_test_dev_nvme_ctrl for the backing device.

This can easily be done if and when someone writes such a test.

However, I'm not even sure right now if that test would pass in the
kernel as is -- it seems like an odd thing to do.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
