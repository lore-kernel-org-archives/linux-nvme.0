Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FCEC55172
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQmFacW/M1a8Edi/GGM43kCU4s87cuVl2ndEPxd/TUw=; b=Ul/wh6RTqZUg2e12CtatpIOM/T
	c4ZqmQ19bOkI9ognTHImuc2O50ehhoaLA+7U7V+rf41cAl10znxmIS1vADg3PduHk4yHHzKcU3Qmf
	K13drcP3sCvT37f7tU58HLsN+h+F9lzthw7f/ro37clzy1cDBdBkZYRzB7s4/W1F5DTbnqwShI/q/
	8a7tJpjRZqSzs8w50BmvkRVRhlwDpT2g3IiWZkwDYph8Fcpbsyj7BFp+N7pKCA2/tjq24D4h13B7w
	wBNzXlsMeLoKbpS8azr8nuGN4ZRk5cli5/mqnG1rspyEGqsa4YoVAEVnM4PcRrHBuLFe4CAP342kf
	a6gwZgIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr75H-000000010Gw-20Jq;
	Tue, 04 Aug 2026 04:48:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr75E-000000010GY-0ymw
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 04:48:57 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741IIMC3573077;
	Tue, 4 Aug 2026 04:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wQmFac
	W/M1a8Edi/GGM43kCU4s87cuVl2ndEPxd/TUw=; b=KC+3QTOuBEVuOd6bYFFWmD
	bqlq5RWBUiO1eFhbdtKLSEX00IZAz4k1W5GAvA5GowlIg6WNGDK8+KAKXuAxLDmm
	x+OgmnLKOx7OJPMC16YQpC4wv9zCbqQXw4Y8aLfG279dyAX+wtVOfTLVxPhZ9YAX
	GJT+A/QYbGftm0O11thuNtlUkJrkMZFRNjU81Q8JC8dy7HB9lnCo4qpljxKbFooy
	t/2awJivwUVfuEHKtEgYQkHECRxopcsGRPoBXP0t0v0bPnIzG82CszuLHo1ZtE0Y
	dRC2URfDIE1KM6z3UbQ4gbTQWkrNJEnChzGRazBT1iqHh41Etk3eK91S2q/FVc3A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hm14d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 04:48:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6744fPAq016132;
	Tue, 4 Aug 2026 04:48:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw0h88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 04:48:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6744mfDB38142486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 04:48:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3306658052;
	Tue,  4 Aug 2026 04:48:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A14605805E;
	Tue,  4 Aug 2026 04:48:36 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 04:48:36 +0000 (GMT)
Message-ID: <29dbbed9-b273-47ae-8879-f7b826f983af@linux.ibm.com>
Date: Tue, 4 Aug 2026 10:18:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/070: add a test for Identify CNS 07h NULL pointer
 dereference
To: Guixin Liu <kanie@linux.alibaba.com>, shinichiro.kawasaki@wdc.com,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
References: <20260804024644.3830277-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260804024644.3830277-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAzNSBTYWx0ZWRfX+W/IyZubYdia
 Q+q+P/+AYlpwJtkRef2U83bw8ieoNTG+GY45t0tJqDa8ymE5AZFQsSsH9R659VlUTPF6L+YklBJ
 RyjKeQ3D1T7OLNuUaJAyorCvf4SZt/Q=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a716f2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=2w2a3ps8XqzyrQ_5d0EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAzNSBTYWx0ZWRfXzs5uxwCrtBNO
 5Ze1qjRmiXQ9Ol2/YGJjex/9oaA7x7MEEcSjkwbypmYeaGRgpQ1C8tleC+gncB5s4MM8hTvANYy
 J8gm4IMLxNeow9YNZIKvn0aupGwIGslizOg+I6C0GF0MewCgPYpIIREgeuJzfMA57ubppa9vqWX
 nRG+6A6vyMC+/08LIehFsEVUy0kPDLWJ53heKEOA3ce8axU9GLvP8lKIPDYKTsJmQlnYXQ4wUM/
 hm/F497nf9AF1AmBFfJQ3ze1AeKbE6ABEPGXpDDti8kFsCXoWARwBgKqugzuJuFmRuIku7HXvFJ
 LQes8M6wtZ5OR9kLIWQVtVQGX6MafmnoaARN/+X0CHif/tvv0CZ9xjtZlwb2nXsHbrtyE45hk7b
 R3dDVRe5sIrzky3Z83dhxuw9o3HhtovCkcqP+8D2vNdoUrGKtrpNdMUXLm6WcdoHWJ65CuhEFM6
 3zYHUarpD1Cu2ibtOxA==
X-Proofpoint-ORIG-GUID: tuwSIBw3Wjrdpp24jPVti1hJdFfxeLd9
X-Proofpoint-GUID: HmQZbKMjJ12csklnUN71E6PMJJNSD3jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_214856_396432_9C83ABEA 
X-CRM114-Status: GOOD (  27.73  )
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

On 8/4/26 8:16 AM, Guixin Liu wrote:
> nvmet_execute_identify_nslist() handles both the Active Namespace ID list
> (CNS 02h) and the per-command-set variant (CNS 07h). For CNS 07h it
> filtered the list on req->ns->csi, but this handler never resolves
> req->ns, so it is always NULL. As soon as an enabled namespace with an
> NSID above the requested value exists, the target dereferenced a NULL
> pointer and oopsed.
> 
> This test connects a target with a single namespace and issues an
> Identify with CNS 07h starting from NSID 0, which is exactly the
> condition that triggered the crash. Without the kernel fix [0] the target
> oopses; with it the command completes normally.
> 
> [0] https://lore.kernel.org/linux-nvme/20260730043105.3071328-2-kanie@linux.alibaba.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1 -> v2:
>    - Use "nvme list-ns --csi=0" instead of a raw admin-passthru to issue
>      Identify CNS 07h, as suggested by Nilay and Shinichiro; it drives the
>      same target code path via the existing nvme-cli subcommand.
> 
>   tests/nvme/070     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/070.out |  2 ++
>   2 files changed, 54 insertions(+)
>   create mode 100755 tests/nvme/070
>   create mode 100644 tests/nvme/070.out
> 
> diff --git a/tests/nvme/070 b/tests/nvme/070
> new file mode 100755
> index 0000000..b7d8bc5
> --- /dev/null
> +++ b/tests/nvme/070
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Guixin Liu
> +#
> +# Regression test for the NULL pointer dereference in
> +# nvmet_execute_identify_nslist() when handling Identify CNS 07h (Active
> +# Namespace ID List for the specified I/O Command Set). The CNS 07h handler
> +# filtered the list on req->ns->csi, but this handler never resolves req->ns
> +# so it is always NULL. As soon as an enabled namespace with an NSID above the
> +# requested value exists, the target dereferenced a NULL pointer and oopsed.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="issue Identify CNS 07h (per-command-set active NS list)"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	local nvmedev
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +
> +	# "nvme list-ns --csi=0" issues Identify CNS 07h (Active Namespace ID
> +	# list for the specified I/O Command Set, here NVM), starting from NSID
> +	# 0 so the enabled namespace (NSID 1) is listed. That is exactly the
> +	# condition that used to dereference the NULL req->ns in the target.
> +	if ! nvme list-ns "/dev/${nvmedev}" --csi=0 >> "${FULL}" 2>&1; then
> +		echo "Error: Identify CNS 07h (list-ns --csi=0) failed"
> +	fi
> +
> +	_nvme_disconnect_subsys
> +
> +	_nvmet_target_cleanup
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/070.out b/tests/nvme/070.out
> new file mode 100644
> index 0000000..b765a28
> --- /dev/null
> +++ b/tests/nvme/070.out
> @@ -0,0 +1,2 @@
> +Running nvme/070
> +Test complete

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

