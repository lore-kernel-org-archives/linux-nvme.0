Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EFC4740A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D6120640
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MJznL81c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D6120640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPYAebrzFvZOCWSqWaDWODpjA5FQ+oodSe/MCegWf24=; b=MJznL81cLR4Fuk
	HltWCx1MMF2hYtfCekShX2d+zZpbsoDYtc5poGVpGffFkgaaWKZIPXzWzYcdbNziiTxEv58IQcemy
	kBvPDAg0x088Z+OAB1M91Emqv1kpigKAJebmBw2SdokUGPODlthAZhd1xoGbaRFMBHk232V4MSMy8
	TLQTaoW5iYL4+KXMLabqxf2PZ/FcJi8io/3Glqy3pRFnqkWigS4O57jYuQHCpnKBwBZXoMk/LaWm7
	8kHn3munbbDTaDbj87rDaXfnKhYLSHLM06nCL4iDYYNcRGzGGoKdrA9iiCS7DXtMxnidX3pkK12o3
	CJtqn9KozjL9nvM4NJIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7MIj-0004VZ-RQ; Mon, 09 Sep 2019 16:14:01 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7MIg-0004VC-IE
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 16:14:00 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1i7MIf-0004wZ-7B; Mon, 09 Sep 2019 10:13:58 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Omar Sandoval <osandov@fb.com>
References: <20190905174347.30886-1-logang@deltatee.com>
 <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ae33b82-88d7-2fa3-2bc3-da0b262d0ee8@deltatee.com>
Date: Mon, 9 Sep 2019 10:13:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: osandov@fb.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_091358_932409_47C415CD 
X-CRM114-Status: GOOD (  13.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-09-07 12:19 p.m., Chaitanya Kulkarni wrote:
> On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:
>> A number of bug fixes have been submitted to the kernel to
>> fix bugs when a controller is removed immediately after it is
>> set up. This new test ensures this doesn't regress.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>
>> ---
>>
>> This is reallly just a resend. The patches this tests for are all in
>> 5.3-rc7 or earlier and it passes on said kernel version.
>>
>> I've rebased this patch onto the latest blktests as of today with no
>> changes required.
>>
>> Thanks,
>>
>> Logan
>>
>>   tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/031.out |  2 ++
>>   2 files changed, 57 insertions(+)
>>   create mode 100755 tests/nvme/031
>>   create mode 100644 tests/nvme/031.out
>>
>> diff --git a/tests/nvme/031 b/tests/nvme/031
>> new file mode 100755
>> index 000000000000..16390dcb380e
>> --- /dev/null
>> +++ b/tests/nvme/031
>> @@ -0,0 +1,55 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2019 Logan Gunthorpe
>> +#
>> +# Regression test for the following patches:
>> +#    nvme: fix controller removal race with scan work
>> +#    nvme: fix regression upon hot device removal and insertion
>> +#    nvme-core: Fix extra device_put() call on error path
>> +#    nvmet-loop: Flush nvme_delete_wq when removing the port
>> +#    nvmet: Fix use-after-free bug when a port is removed
>> +#
>> +# All these patches fix issues related to deleting a controller
>> +# immediately after setting it up.
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_program nvme &&
>> +	_have_modules loop nvme-loop nvmet &&
>> +	_have_configfs
>> +}
>> +
>> +test() {
>> +	local subsys="blktests-subsystem-"
>> +	local iterations=10
>> +	local loop_dev
>> +	local port
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	truncate -s 1G "$TMPDIR/img"
>> +
>> +	local loop_dev
> Duplicate declaration of the local variable ?

Oops, yes, nice catch. I'll send an updated patch later this week.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
