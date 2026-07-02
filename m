Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90930C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 13:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thkoHNKUDK4Kj2cjdrPvKV0lBDyGm2YheU2iksR5GQA=; b=dgz/Un2nqQbY6T+NGlZcfwGYIo
	Dn5+H9QX11IVYJQZ0Gs6ETJBM+3KKgdlNJriVgCv3ZLsEismWtFrWmUZS6LIhjG6z+kC6sz4TsLut
	k2gZC/YpgY8x+snHk4bar42rIrwxe///dvWI/qD+77Z/r9rBwOoUpw7ROV96ErPry77iJkkTOB7EW
	glplPrT5dsCWKheCGJQ4XRSShHygm039XRyj94eLRvmvk7DZ7Cmb78YOexHYIe/Qqfs4MKHFISBnd
	F87oOta5wv3x9/rUl6NylDIQfI6a+DP9ZsMErNtnsDLQdE4KbOUIeui49ljiCneayt+4CCVvhrlbU
	pmxpdQWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHnD-00000004Yhn-1M5W;
	Thu, 02 Jul 2026 13:49:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHnA-00000004YhG-2N48
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 13:49:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621LQrl2348538;
	Thu, 2 Jul 2026 13:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=thkoHN
	KUDK4Kj2cjdrPvKV0lBDyGm2YheU2iksR5GQA=; b=QxChTcgtfHTEP0EQKCfNzt
	YyHHg8+0g8A8oBjYEDpuspDF31FSlqbrgOkFWpq7aoF6CIQMsqmbXXCKwARu+z8I
	HnYU8Etss968/u/TTAkUs0OqO0GL7oMtRxe7vltXWj2l1DJiPN7FMC9eTnq31Du7
	Ajc1pcsAMVHEEVDAj/RvzMTvaqXt7pJk/S/S2Rx4XVx5DO1oeS68/XR87dGk/oqi
	ymVCYboVK75JQjxMTxWP66rURJ1aXxvUAPHuCSXkc4pn+IBmSWkYWbQ9vSJ957eb
	tnTseiPhMFRjvMCi0zKzXC9n7k+xcnvwKc8i+CiJRqURTpcqme3jCQvxUcWd+5Ig
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk1txd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 13:49:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662DYiVo029550;
	Thu, 2 Jul 2026 13:49:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wcac5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 13:49:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662DnAF250725132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 13:49:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE8555805D;
	Thu,  2 Jul 2026 13:49:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1001B58055;
	Thu,  2 Jul 2026 13:49:05 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 13:49:04 +0000 (GMT)
Message-ID: <7d312569-a32d-4e08-bdfa-febb1389b83c@linux.ibm.com>
Date: Thu, 2 Jul 2026 19:19:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add ABI documentation for host sysfs
 interfaces
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com,
        oliver.yang@linux.alibaba.com
References: <20260702095541.1145128-1-kanie@linux.alibaba.com>
 <20260702095541.1145128-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260702095541.1145128-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX6X7bu7NEElQl
 C+hl4j6jLJ8Ax37Lxi/5XCx+HepmFH2qFs055IuNGfeIOsBQrDERSqt9GSg4ush4hu/jb4m++jo
 NHuiJ4fGiTw9UUWW3/YKV/9YAzPtAqaW6weB+rj8jS3D81c4iCh6KtuA1CGrM576g46Vwl8o5QN
 sdEicQaAileJueWbvobb3xHT/szUtzSnyo9VW39h7eI+fyezMLo9SvEUkCJ0WGQuxtnqfMyMkAY
 oKukqP6zOx571g/W6xHCE8K20MDduil2LtpSdQRZN66ksXClptVD8i2PEjTlyAQwWQhGtOv+NT2
 s5H9Z083hfeAgWW8ByEIxsbuJtAa/WPzFkT6MvwrH1H7Dp0utDb8YXe0VedlzUg2etUB4mYgr+M
 LlHi3XzteeRo/lopC5duZqZ9vWW2T6D4K9rKehxQNgMx4IlDsQdRAZ3d/lpAAy3T0GkH7wcF/cM
 aR1RbRsZXJ4R4QhhxrA==
X-Proofpoint-GUID: 94RAnEuYOZ1DXGX8RkJFh_7xWqZg-352
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a466c57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=p4nbOPCeIyYNxS3vn2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX2nYGUBsLaUnt
 Oc5kJXArYgI1yEg64YSC32iuzkFsM9VCxBX6ExJCuQ1uticovPovUJe1nJKXhQwZ0wNjzw7gW1t
 ugtU2kPuriQNqZEp+vl6HQEaSyGKSQA=
X-Proofpoint-ORIG-GUID: MrvY7lylOV2Kz3osTQ5qj8rOeBM6Vcrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_064924_745742_764EC765 
X-CRM114-Status: GOOD (  16.01  )
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

On 7/2/26 3:25 PM, Guixin Liu wrote:
> +What:		/sys/block/nvmeXnY/diag/command_retries_count
> +What:		/sys/block/nvmeXnY/diag/command_error_count
> +What:		/sys/block/nvmeXnY/diag/multipath_failover_count
> +What:		/sys/block/nvmeXnY/diag/io_requeue_no_usable_path_count
> +What:		/sys/block/nvmeXnY/diag/io_fail_no_available_path_count
> +Date:		May 2026
> +KernelVersion:	7.2
> +Contact:	Nilay Shroff<nilay@linux.ibm.com>
> +Description:
> +		Namespace diagnostic counters.
> +
> +		command_retries_count: I/O command retry counter. Only
> +		visible on per-path devices.
> +
> +		command_error_count: I/O command error counter. Only
> +		visible on per-path devices.
> +
> +		multipath_failover_count: Multipath failover counter.
> +		Only visible on per-path devices. Requires
> +		CONFIG_NVME_MULTIPATH.
> +
> +		io_requeue_no_usable_path_count: Counter of I/Os requeued
> +		because no usable path was available. Only visible on
> +		multipath head devices. Requires CONFIG_NVME_MULTIPATH.
> +
> +		io_fail_no_available_path_count: Counter of I/Os failed
> +		because no available path existed. Only visible on
> +		multipath head devices. Requires CONFIG_NVME_MULTIPATH.
> +
> +		All counters can be reset by writing a value.
> +

How about splitting the above diagnostic counters into two sections instead? Since the sysfs
layout differs depending on whether multipath is enabled, I think documenting them separately
may make the interface clearer.

For instance, how about documenting it as follows:

One block covering non-multipath configurations:

What:           /sys/block/nvmeXnY/diag/command_retries_count
What:           /sys/block/nvmeXnY/diag/command_error_count

Description:
         Namespace diagnostic counters for non-multipath
         configurations (when CONFIG_NVME_MULTIPATH is
         not configured).

         command_retries_count: I/O command retry counter.

         command_error_count: I/O command error counter.

         All counters can be reset by writing any value.

For multipath configurations:

What:           /sys/block/nvmeXcYnZ/diag/command_retries_count
What:           /sys/block/nvmeXcYnZ/diag/command_error_count
What:           /sys/block/nvmeXcYnZ/diag/multipath_failover_count
What:           /sys/block/nvmeXnY/diag/io_requeue_no_usable_path_count
What:           /sys/block/nvmeXnY/diag/io_fail_no_available_path_count

Description:
         Namespace diagnostic counters for multipath
         configurations (when CONFIG_NVME_MULTIPATH is
         configured).

         command_retries_count: I/O command retry counter.

         command_error_count: I/O command error counter.

         multipath_failover_count: Multipath failover counter.

         io_requeue_no_usable_path_count: Counter of I/Os
         requeued because no usable path was available.

         io_fail_no_available_path_count: Counter of I/Os
         failed because no available path existed.

         All counters can be reset by writing any value.

I think this better reflects the actual sysfs interface and makes it immediately obvious where each
attribute is exposed, without having to describe the differences between per-path and multipath head
devices in the individual attribute descriptions.

One other suggestion: could we keep all of the diagnostic counters grouped together in the ABI
documentation? I noticed that in your first revision they were all documented together, but in
this revision they're separated. I'm referring to the controller diagnostic counters under:
/sys/class/nvme/nvmeX/diag/*

IMO, keeping all of the diagnostic counters adjacent would make the documentation easier to
browse.

And yes thanks for documenting all this!

--Nilay


