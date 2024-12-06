Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB9E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JuAyjINnPFTb4pJ1G7jhbZOpReadPDLa6EnMHd1V6KI=; b=soqJW2wk10/hYRzAK4AyZV1xqc
	CShZAPYxkmt7WJxzF+/qLL5K/qQBRPe/H3Zp+VImaDekvBcyr/4/gZtiapzVI0keec4Vv9XAogzIb
	V6DmoMbmUSXXYwY9DMQ4r7CEByQNmQujpQhnBIw7o0TjiYjPkPj479kcoQ/E005dnbrzMt5tVyflh
	5vxO0hZ+GiJYskF+p4NCvikBBIwTa7syX9bgtq/aWH6mWLCeJQAu2svwZtbcs2Kl+is0fA7UuF1hJ
	BwRNdqrNIwrQejN2qXnogO0P9i9s5JEg5LLpJxF2arRLNqIoiieP0UpTl8Khh0LdKfDd1q88tbf5n
	LabAD5uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJVyh-00000001Ncl-04dd;
	Fri, 06 Dec 2024 10:54:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJVye-00000001NbJ-2A28
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 10:54:30 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67oFWZ028303;
	Fri, 6 Dec 2024 10:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JuAyjI
	NnPFTb4pJ1G7jhbZOpReadPDLa6EnMHd1V6KI=; b=WZyOTg0H6iPJU7V9XrIHps
	b2XEM16/ov5w86rUJkaPmZqafuVBdOF3hX5JsGaL5H19v6UvncywOmq50tswgGb3
	2zdKrvjqP6IAIhhz7y2v4iYLLlQrbCerQj7U90tN4qqAgjZ+/VXVyPOH9DbjtZ5J
	MbN552nwCk0w/A8pR4kldgAuF46LGHsBsuT807movYkm2849NicxjL/42ssfZE5w
	2al/kEaZtMdcm4Ot7DU8lKevGOf4QVOtMcevZJABKtzy60vcH68q1KsxVTHq8NSt
	bLTWn+j/ZA38tXjr4A7RzHUrq0RHK2kQGq2xpdn5pqnyQaMa7I30Odnu0gXx4Vdg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax661j3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:54:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67G1wB005213;
	Fri, 6 Dec 2024 10:54:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxw0nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:54:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6AsI1K32244360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 10:54:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D20258057;
	Fri,  6 Dec 2024 10:54:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0163858059;
	Fri,  6 Dec 2024 10:54:15 +0000 (GMT)
Received: from [9.179.0.162] (unknown [9.179.0.162])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 10:54:14 +0000 (GMT)
Message-ID: <75c00a79-ba91-4623-b813-fa3a9eb73bfa@linux.ibm.com>
Date: Fri, 6 Dec 2024 16:24:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, hch <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me"
 <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <t6a6fwlbjk2h5esktnig3hllojjarp3utllgbgnneerdbkcpf3@fxfrnzdbcepf>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <t6a6fwlbjk2h5esktnig3hllojjarp3utllgbgnneerdbkcpf3@fxfrnzdbcepf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NueLxRteRmOLz-RhWkuECIBNngegH5PC
X-Proofpoint-GUID: NueLxRteRmOLz-RhWkuECIBNngegH5PC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=845 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_025428_565112_F9AFBD66 
X-CRM114-Status: GOOD (  26.15  )
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



On 12/6/24 07:23, Shinichiro Kawasaki wrote:
> Thanks for this v2 patch. I took a quick look. Please find my comments in line.
> Will do another round of review when v3 comes out.
> 
> On Dec 04, 2024 / 17:17, Nilay Shroff wrote:
>> This is a regression test for commit 505363957fad ("nvmet: fix nvme
>> status code when namespace is disabled")[1].
>>
>> This test creates a regular file backed loop target namespace, disables
>> the asynchronous event notification for ns-changed events and then write
>> to the namespace just after disabling it.
>>
>> [1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  tests/nvme/055     | 117 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/nvme/055.out |   2 +
>>  2 files changed, 119 insertions(+)
>>  create mode 100755 tests/nvme/055
>>  create mode 100644 tests/nvme/055.out
>>
>> diff --git a/tests/nvme/055 b/tests/nvme/055
>> new file mode 100755
>> index 0000000..f1f19fe
>> --- /dev/null
>> +++ b/tests/nvme/055
>> @@ -0,0 +1,117 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Nilay Shroff
>> +#
>> +# Regression test for commit 505363957fad ("nvmet: fix nvme
>> +# status code when namespace is disabled").
> 
> As I commented for v1 series after this v2 came out, I suggest to describe that
> this test intents to be independent from udev rules.
> 
Sure, in the next patch I will update the comment.
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test nvme write to a loop target ns just after ns is disabled"
>> +
>> +QUICK=1
>> +
> 
> [...]
> 
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	local iteration=1 i=0
>> +
>> +	_setup_nvmet
>> +
>> +	_nvmet_target_setup
>> +
>> +	_nvme_connect_subsys
>> +
>> +	img="$(mktemp /tmp/blk_img_XXXXXX)"
>> +	dd if=/dev/urandom of="$img" bs=512 count=1 status=none
> 
> mktemp is not recommended, since blktests provides $TMPDIR as described
> in the "new" file.
> 
>> +
>> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
>> +	ns_path="${subsys_path}/namespaces/${def_nsid}"
>> +
>> +	while (( i < iteration )); do
>> +		# Wait until async request is processed and default ns
>> +		# is created
> 
> [...]
> 
>> +
>> +		# disable target namespace and write to it
>> +		echo 0 > ${ns_path}/enable
>> +		nvme write --start-block=1 --block-count=0 \
>> +			--data-size=512 --data="$img" "$disk" 2>>"$FULL"
> 
> Instead of --data="$img", can we use"--data=/dev/urandam"? If it works,
> we can avoid the img file.
> 
Yeah I just tested with "/dev/urandom" and that seems to work. So 
we don't need img file. I will update this in the next patch.
>> +
>> +		((i++))
>> +	done
>> +
>> +	rm "$img"
> 
> If we need img file, let's use $TMPDIR to skip this rm command.
As /dev/urandom works, I would remove the use of img file. 
> 
>> +
>> +	_nvme_disconnect_subsys >> "$FULL" 2>&1
>> +
>> +	_nvmet_target_cleanup
>> +
>> +	echo "Test complete"
>> +}
> 
> [...]

Thanks,
--Nilay


