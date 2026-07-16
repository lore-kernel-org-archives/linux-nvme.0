Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA35BC44511
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OeIlLkZwYNRUp4uYbCxDXPuxa7JqLzEAYzOMj7ZIT8c=; b=psSuXPYnb1kX3FlwFWVM39ofAE
	zLw3ULtCZtTdOf3XPkZtkvFsAixGghPmOYp83uom1aDYoUlP1tbZbCSnCLy1OToWSbIiWkBETleO9
	q8E1gVFy2p0TLOxmuJ8N/qGUKgP92c0M7058KI61j6wQe0aA/oZemUfkA8krzr4cr40a8425ok3id
	/aqHzr07UWVeg0DcG3I5UKzt4TA0z/HteLjVWerZILi3/GerpKCKwSDpUYrV53az9PtXyc+82e0CB
	SXrZbx/SyKDX//UbIAIS9s11VMFn1tqLEKw2ipDTZuK63vQ+xmGVGwCxwObuWDIMdRN0xDv/ANuzn
	uNfJ5UhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNp7-000000001Vg-2q99;
	Thu, 16 Jul 2026 15:16:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNp4-000000001Uh-2l6O
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 15:16:27 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfr383285157;
	Thu, 16 Jul 2026 15:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OeIlLk
	ZwYNRUp4uYbCxDXPuxa7JqLzEAYzOMj7ZIT8c=; b=JXnAslOU2cOu1Mb+iAxS/y
	I8UfOMsywERrPC3zWkagKhhzDlQ8Lp6fZYkuiANqD2Rc1JrWWIEw16V1nmc8/GD7
	aOYTermT7x3tDDtMlXWaFalZUMf/Ble5ZuUmfiwaczLkqxlZG3VU08ctZtsVHKKs
	QWubgvy16TpXKlf6neZIICNATbYXhDqKeEy5BEeSfv/M0dVnDhE8SLKBL6xIdnba
	X9m9G8RHtBShe5802p/c3rRYqnl9ticB00r+v0snRTeyCcjpYy6ouigwhgXBF41Q
	3VzSKpL4ocjGZfxS91iL6Fmo0RtjyqpQ3hNhs+pnlsVltG15VHF/BZSYQAmI/0TA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2agtsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:16:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GF4eqW000800;
	Thu, 16 Jul 2026 15:16:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdpn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:16:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GFGMoH8454838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 15:16:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09FA15805F;
	Thu, 16 Jul 2026 15:16:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585FB58054;
	Thu, 16 Jul 2026 15:16:19 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 15:16:18 +0000 (GMT)
Message-ID: <a4f4f444-967f-43a8-becf-465a3007ade8@linux.ibm.com>
Date: Thu, 16 Jul 2026 20:46:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme/069: add a test for multipath cdev lifetime
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260716082927.4053505-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260716082927.4053505-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1NiBTYWx0ZWRfX349cFwQqVb0b
 Ac7+fTbAViq/KSCihxCQoTxX2fV4oqW6636ZjhgVaOyo4aIpzdERuTu4Z06n8XDVPX5U5Im0kYB
 NgaIxeewpXD5UDuMegchDl+0wem7iiM=
X-Proofpoint-GUID: BJ5vKzo4cLaUeD8fFnbOc3i3D4NVGG0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1NiBTYWx0ZWRfX+7fkkDgSlXNY
 Z5hFCK6oRp5mQR7owTIRxa+OjEYMzRePrYL1/rZsKi8189ZcteTws8odBUisDVjA1QxEHwaHrcE
 yo1zv8iffr/rMkXK7xdHKHHNWuwQS+lDF9ZgPNasAVQto3I/9lxbbNUw5BzPRYM6GHT7g0uiImJ
 /sTo3br61o2cj5teA8Tmo4eubAvv1Z4SnxpUTi4sncJs5V9EwTWZpLn61RQpEpa4+V4iQ9dgPq1
 tdFmZnKDPzSQdrTigoziEN5PKzfkuQgdg53fenO04mbS+4OCz2FeRuVl0/smx1FYalhRRj1Mb8i
 IZzpHN5fQa70q9qWdHi5Fi32zPSndnx4QNvhc7i5Il213VH7WttfZmRf+9UMdbXjGN1deUNncaC
 uftTMFS+gh8vo7sVSpuFMkUZIalR3fWCThQVizOpUeVYgh1xE5NHsxXMJKoHK2w6SR0qvKVly6k
 O9m45Cb97lzHWRjsT7A==
X-Proofpoint-ORIG-GUID: BJ5vKzo4cLaUeD8fFnbOc3i3D4NVGG0N
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58f5c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=USU_oUL85gQPAiYJZBAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160156
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_081626_815371_9DCFF648 
X-CRM114-Status: GOOD (  17.42  )
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

On 7/16/26 1:59 PM, John Garry wrote:
> +#include <inttypes.h>
> +#include <sys/ioctl.h>
> +#include <linux/types.h>
> +
> +#ifndef _LINUX_NVME_IOCTL_H
> +#define _LINUX_NVME_IOCTL_H
> +#define NVME_IOCTL_ID		_IO('N', 0x40)
> +#endif /* _UAPI_LINUX_NVME_IOCTL_H */
> +
> +int main(int argc, char **argv)
> +{
> +	int fd, fd1;
> +	int count;
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "usage: %s /dev/ngXnX", argv[0]);
> +		return EINVAL;
> +	}
> +
> +	fd = open(argv[1], O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +
> +	/*
> +	 * Steps:
> +	 * a. Signal to parent that we have opened the file so that it may
> +	 *    start the teardown.
> +	 * b. Try to open device until disallowed/gone.
> +	 * c. Sleep to allow nvme-subsystem be torn down.
> +	 * d. Issue the ioctl on original fd.
> +	 */
> +	kill(getppid(), SIGUSR2);
> +	count = 0;
> +	for (;;) {
> +		fd1 = open(argv[1], O_RDONLY);
> +		usleep(500000);
> +		if (fd1 < 0)
> +			break;

Does it make sense to check for errno set to ENODEV or ENOENT
before breaking out here?

Thanks,
--Nilay

