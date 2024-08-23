Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799C3C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ml8aME6CkcZn0CiUXBYWpDsskLSscE04s646w9nv9sI=; b=b/HalMUG/e4VfU3ij7n4Nusrmm
	mzco8xizilEVa+e5qSr21XuATELP/R6H6H03LDmh9hDnqiBusgWKKXqv4BEiHVbzT4KWTcnw60Q9E
	4JHLnXh+KpOMT9uKMB+ue03/KNASSS0tl8c1IHr0AUIyFPlyTBtlt6sWWwza1rgIGynVBSJRs4eU9
	VcsBgQun68IuOZzRPRsalM9FtgzGKegXq3fRIoxYfMqsf3kYrG0ej+rJI7awTCd8F9jqY7ud6wg8m
	CAbDZafwZZVN9cXAzNeAe21Lk35A5uCQq/yf3LeMxRPCMvbWr2tE6kZjNqdNO2UJgMidG7wXTECjF
	x/bquGVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUWG-0000000GuPA-3cip;
	Fri, 23 Aug 2024 13:40:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUWE-0000000GuO6-0lRu
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 13:39:59 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8PjPN011130;
	Fri, 23 Aug 2024 13:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	l8aME6CkcZn0CiUXBYWpDsskLSscE04s646w9nv9sI=; b=i6wtZcH5bHOIZQoRE
	+clsI11dICrWEOJ6P4KggEKbdSpgBHhYgjIJxfUktgqpFacUajxd6mrl7xLcr50V
	GJYd1z3ml8qFLmb0B4lsoswX7t3Ht7P5AIWmYRgGD3BG2JQN5PoVZ5Ln6kdLsWtj
	Q7OwYGrXSQZrDPGa9w8GzLRYQ7WgeODjIUl+LSicuTLRZJNJbgXJrgOnT9OZMuwx
	N+8w0oKpRGBIqnIxUpXvxbjBinK8hzsaDIfTainUQppuo+R1yHwkO512oT3mdBeA
	DjlCoD8uGiUILMxv33wAQBKnZ9XK8bCEPXVJkexRPZfORb/k+I/rtCiKmREAA1Nb
	6IyzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc547mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:39:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBHcdI019050;
	Fri, 23 Aug 2024 13:39:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376qa3km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:39:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NDdqR812386912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:39:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2AF658067;
	Fri, 23 Aug 2024 13:39:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8971C58065;
	Fri, 23 Aug 2024 13:39:49 +0000 (GMT)
Received: from [9.171.23.201] (unknown [9.171.23.201])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:39:49 +0000 (GMT)
Message-ID: <d3d56275-b88b-4f95-941d-6f4a0d2e2868@linux.ibm.com>
Date: Fri, 23 Aug 2024 19:09:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
From: Nilay Shroff <nilay@linux.ibm.com>
To: Martin Wilck <martin.wilck@suse.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Martin Wilck <mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-3-mwilck@suse.com>
 <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9c260acf-48c1-4b4e-8e02-594bff222af3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 641EkEgyRCZL65KGt3sICMd-kOf1tNZM
X-Proofpoint-GUID: 641EkEgyRCZL65KGt3sICMd-kOf1tNZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_063958_588693_A55AEC71 
X-CRM114-Status: GOOD (  31.74  )
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



On 8/23/24 15:48, Nilay Shroff wrote:
> 
> 
> On 8/23/24 01:08, Martin Wilck wrote:
>> Add a test that repeatedly rescans nvme controllers while doing IO
>> on an nvme namespace connected to these controllers. The purpose
>> of the test is to make sure that no I/O errors or data corruption
>> occurs because of the rescan operations.
>>
>> Signed-off-by: Martin Wilck <mwilck@suse.com>
>> ---
>>  tests/nvme/053 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/nvme/rc  | 18 ++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>  create mode 100755 tests/nvme/053
>>
>> diff --git a/tests/nvme/053 b/tests/nvme/053
>> new file mode 100755
>> index 0000000..41dc8f2
>> --- /dev/null
>> +++ b/tests/nvme/053
>> @@ -0,0 +1,56 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Martin Wilck, SUSE LLC
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test controller rescan under I/O load"
>> +TIMED=1
>> +: "${TIMEOUT:=60}"
>> +
>> +rescan_controller() {
>> +	local finish
>> +
>> +	[[ -f "$1/rescan_controller" ]] || {
>> +		echo "cannot rescan $1"
>> +		return 1
>> +	}
>> +
>> +	finish=$(($(date +%s) + TIMEOUT))
>> +	while [[ $(date +%s) -le $finish ]]; do
>> +		# sleep interval between 0.1 and 5s
>> +		usleep "$(((RANDOM%50 + 1)*100000))"
>> +		echo 1 >"$1/rescan_controller"
>> +	done
>> +}
> I think here usleep may not be available by default on all systems.
> For instance, on fedora/rhel I don't have usleep installed in the 
> defualt configuration and so I have to first install it. So you may
> want to add "usleep" as per-requisite for this test. Moreover, after 
> I installed usleep on fedora and ran the above test I see this warning:
> 
> warning: usleep is deprecated, and will be removed in near future!
> 
> Due to above warning the test fails. So is it possible to replace 
> usleep with sleep?
>  
>> +
>> +test_device() {
>> +	local -a ctrls
>> +	local c
>> +
>> +	echo "Running ${TEST_NAME}"
>> +	ctrls=($(_nvme_get_ctrl_list))
>> +
>> +	_run_fio_verify_io --filename="$TEST_DEV" --time_based &> "$FULL" &
>> +
>> +	for c in "${ctrls[@]}"; do
>> +		rescan_controller "$c" &
>> +	done
>> +
>> +	while true; do
>> +		wait -n &>/dev/null
>> +		st=$?
>> +		case $st in
>> +			127)
>> +				break
>> +				;;
>> +			0)
>> +				;;
>> +			*)
>> +				echo "child process exited with $st!"
>> +				;;
>> +		esac
>> +	done
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index e7d2ab1..93b0571 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -192,6 +192,24 @@ _test_dev_nvme_nsid() {
>>  	cat "${TEST_DEV_SYSFS}/nsid"
>>  }
>>  
>> +_nvme_get_ctrl_list() {
>> +	local subsys
>> +	local c
>> +
>> +	subsys=$(readlink  "${TEST_DEV_SYSFS}/device/subsystem")
>> +	case $subsys in
>> +		*/nvme)
>> +			readlink -f "${TEST_DEV_SYSFS}/device"
>> +			;;
>> +		*/nvme-subsystem)
>> +			for c in "${TEST_DEV_SYSFS}"/device/nvme*; do
>> +				[[ -L "$c" ]] || continue
>> +				[[ -f "$c/dev" ]] && readlink -f "$c"
>> +			done
>> +			;;
>> +	esac
>> +}
>> +
> I don't know if I am missing anything here but just curious to know 
> for which case $subsys would point to link ending in */nvme?
> I think that for all cases $subsys shall point to link which ends 
> in */nvme-subsystem, isn't it? I assume here that $TEST_DEV_SYSFS would 
> always resolve to a nvme block device.
> 
I think I got the answer for the above query, when I disabled the nvme 
multipath in the kernel config, I could see we hit the first case when 
$subsys would point to the link ending in */nvme, so this is not an issue.

> And the last point: I don't see 053.out file in your patchset. Did you forget
> to add this file?
> 
> Thanks,
> --Nilay
> 
> 
> 
> 
> 

