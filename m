Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB07BCFC503
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU/qU2kG8hi5utisxU99hecTxyvs2URAxnwqBBRt48M=; b=AsICgXObV6vsdBNvh4Os19h/d5
	ld1Ar+F6yykwJ5r2w75WLEyfNOVurK+6SqVOJXHpvuGHMJgTEINS/DyIZ7Y34I2805V9B+2orK2QZ
	GCwD1RsghwU0GRUawMbQ3g8WDuOI45EKTxlNTZfWbLuW282WZCFEeM5o7E3iHF7ZS/mBeg2DKDWrV
	WBSNZ4s/DT68RWoTCED05fRSHQnXLtBtxWUKd4qM3Xzleg0grrIqtg65dmAyzQbrYtdCNZLcijzZU
	jKiPwG0cVk09q7Rl2y3PdBD9EpQpjk9dJsahgVgbSXeofBqjP4IKBQ2iez5LqP/wLXhUZYCqQ6yjt
	+Yu+5/RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Gmd-00000004MBe-3naN;
	Mon, 14 Oct 2024 08:50:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GXA-00000004IUB-2aKq
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Oct 2024 08:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nU/qU2kG8hi5utisxU99hecTxyvs2URAxnwqBBRt48M=; b=fRlJnLDUv99JOxgq7jjvxEw+vL
	7WKwx7K0a1iDKK0DYJIdm9F1rAEarRLJR4oOrpqJwUBI/JfKfP4AxFDYk7WkZqo7Re2iiLj0PK6ws
	GJmXd3RGG7Y0aka5mOxTiOSeGwhxDfha/F1CRiAj6yv2/GBTwtaUIBZfV+Wl7bBMxYeBoqPR3jlt8
	K9aJM1H74tbeORLugcRCUwkRfqfDJXbs+JAyuam8NOD5GGaQy1m10CWvBu2aHcsCdOqVJG2pcaEGs
	jNXVRuoOai13MfWaqdZJgsmgwMOccpS15/rvmVYIE1+k3+LBhQ82KBxqjZmHVsXu4fX68flOH7FcX
	U49dxkTw==;
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0GX3-00000006I0P-2kcG
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 08:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728894852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nU/qU2kG8hi5utisxU99hecTxyvs2URAxnwqBBRt48M=;
	b=VuulApzRzrSTVJL+BDyOq7XosUfqA+pDqLIhw5EStq4Cs1QKo18fQETErCUVBGavWt3k3FZ6CiI0GMVs12UmaDc/mlva0zzEN9MPNQoaYMFz/RSFVZwkNVU/gQd4fvv81t34vAaKKoN10NNkiC/TLCDPrLAQGbt1XcoBLI2AfQA=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3msgf_1728894848 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:34:09 +0800
Message-ID: <2091bf64-12d7-480f-acc7-55bca77fbf3e@linux.alibaba.com>
Date: Mon, 14 Oct 2024 16:34:08 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 "dwagner@suse.de" <dwagner@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
 <6e1e4df5-ccee-4a92-80ac-64976a526003@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6e1e4df5-ccee-4a92-80ac-64976a526003@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_093426_931224_497D3C58 
X-CRM114-Status: GOOD (  11.64  )
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


在 2024/10/14 14:43, Chaitanya Kulkarni 写道:
> On 10/12/24 04:11, Guixin Liu wrote:
>> Test the NVMe reservation feature, including register, acquire,
>> release and report.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>    tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
>>    2 files changed, 207 insertions(+)
>>    create mode 100644 tests/nvme/054
>>    create mode 100644 tests/nvme/054.out
>>
>> diff --git a/tests/nvme/054 b/tests/nvme/054
>> new file mode 100644
>> index 0000000..f352c73
>> --- /dev/null
>> +++ b/tests/nvme/054
>> @@ -0,0 +1,99 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Guixin Liu
>> +# Copyright (C) 2024 Alibaba Group.
>> +#
>> +# Test the NVMe reservation feature
>> +#
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test the NVMe reservation feature"
>> +QUICK=1
>> +nvme_trtype="loop"
>> +
>> +requires() {
>> +	_nvme_requires
>> +}
>> +
>> +resv_report() {
>> +	local nvmedev=$1
>> +	local report_arg=$2
>> +
>> +	nvme resv-report "/dev/${nvmedev}n1" "${report_arg}" | grep -v "hostid"
>> +}
>> +
>> +test_resv() {
>> +	local nvmedev=$1
>> +	local report_arg="--cdw11=1"
>> +
>> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>> +		report_arg="--eds"
>> +	fi
>> +
>> +	echo "Register"
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Replace"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Unregister"
>> +	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Acquire"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Preempt"
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Release"
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +
>> +	echo "Clear"
>> +	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
>> +	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
>> +	resv_report "${nvmedev}" "${report_arg}"
>> +	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
>> +}
>> +
>> +
> make it easier to debug totally untested :-
>
> test_resv() {
>           local nvmedev=$1
>           local report_arg="--cdw11=1"
>           test_dev="/dev/${nvmedev}n1"
>
>           if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
>                   report_arg="--eds"
>           fi
>
>           echo "Register"
>           resv_report "${nvmedev}" "${report_arg}"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Replace"
>           nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Unregister"
>           nvme resv-register "${test_dev}" --crkey=5 --rrega=1
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Acquire"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Preempt"
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Release"
>           nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
>           resv_report "${nvmedev}" "${report_arg}"
>
>           echo "Clear"
>           nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
>           nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
>           resv_report "${nvmedev}" "${report_arg}"
>           nvme resv-release "${test_dev}" --crkey=4 --rrela=1
> }
>
Thanks, changed in v4, and also change resv_report()'s firt param to

test_dev instead of nvmedev.

Best Regards,

Guixin Liu

> irrespective of that looks good :-
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>

