Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABCC3ABCC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuYy8oTzi8MBEY90g+fuvjsZTiBm1rL8LL0NzWMacnM=; b=CE0glDW4kcL9z96g877lMQIHuP
	RbfDZAooKJVeBnOuhGGhpuu57ogO4Idu5cKAPOEz4pUJnNAx9G+m99psoQDBkEdkv3c051MdDZN8l
	xxbW1InKGkKXU980ryzydCG550CnpLU7zDHKTtWmFEhNgCWwRtEjGryFUOKN5TM6jmOksSp6jdi/w
	qOQN2nddgiBpADmCgyTn/WDsoOQ9rPETjDrNEqJbXGEtAhxB9jVBmT0jFx3o433ohVdQ4nuekQ0D1
	I1a65iMIkIJ7xafxwRG2Jx9hAFtgHWKoqihde6muc+RQK8sTSCJhOF80zJ10wz2mBMelj9x9zvPj1
	Z0Vvs0sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEno9-0000000CFtm-240X;
	Tue, 13 May 2025 11:28:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEno6-0000000CFt6-3COE
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 11:28:24 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D058Pp001581;
	Tue, 13 May 2025 11:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SuYy8o
	Tzi8MBEY90g+fuvjsZTiBm1rL8LL0NzWMacnM=; b=JjK4mpnn+rS7h1LwlaNCIF
	yjXsZQ8yRXfVeL0KhEV6MvNYm46NNTuPkcNB/elBRpbFA1qu4CnAxF+6ke+dNk7+
	xGxO3gTtGYM3z3GfKuiwA0wUvFCc7g/Me+aQ9nc5qUODo0uU1mmFeBT142WVBMCL
	6Y0H5g0deSz9zFI+xu8yT3gajNHNEgqMs4f4NEQtFsAdm7ApcehtkXNdXB9r4gcV
	IbF1yvkK6qbzKUiXFYGBhhtYFSW6nTnrFHbobrbRoHdD8ZQyAwcY19kzZCGxtjm6
	H5Exd8RLQUFmaV9TqUb8MVjTHTVfBwSD5VuM5tdrOwK8FQqC8oG7YFQj/o0pTALQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75db70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 11:28:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7wcnK003606;
	Tue, 13 May 2025 11:28:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkjka6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 11:28:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54DBSG2m28639904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:28:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85C0158061;
	Tue, 13 May 2025 11:28:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBFF958057;
	Tue, 13 May 2025 11:28:14 +0000 (GMT)
Received: from [9.109.198.253] (unknown [9.109.198.253])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 May 2025 11:28:14 +0000 (GMT)
Message-ID: <81e2ffe5-5e71-49c1-a914-7660a9712e92@linux.ibm.com>
Date: Tue, 13 May 2025 16:58:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/4] libnvme: add support for discovering multipath of a
 shared ns
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, gjoyce@ibm.com
References: <20250425185617.1242994-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250425185617.1242994-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNiBTYWx0ZWRfX1xSZ8AnG98fs 4BnrCGctUWGOgzEVlyWafowbWFJIiLhE35wHkUuvUtHN8DXe1WZi+ycmOLovd/uMVc/dFaasvxV 04PqoWB+kxJx7I5BGdszU6FWiLL5TYGukSuOmY7ALdY1zpE0N8F+YGRwDS1+IvMTDwAEYZWFErr
 AjLOoyLiWVNYXTBAoKu3thGh1a5lGkNxmtGRiRc3EwRFteJ4tWDHCno77CinwsKP1bN3q75Whcs PH1P4zhHAASb08AQ8fpcPfdPfU1/TKh4OpzrlDIzFMNf8iCDgca1hPKHIQha95z4llQghkhc2BB F1CPUyJ4MJ57hJoR5jx6mlwDbQwJUXgL8JmEJ2i8r34rjTDwCVOfT+kzEqkenyqON3oNQ8rwfft
 HIaVVZHHDhLK4aBG/qWw8lfUA2d69lgsZqiqxQl7MYkI5mEUjb8ceQWjXbbm20BXD37LSv0e
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=68232cd2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=FA56H4mnWZk9bCmNaMkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h7bYOzHu5-rHoE-VYkP_zhQKpfHK0cs0
X-Proofpoint-GUID: h7bYOzHu5-rHoE-VYkP_zhQKpfHK0cs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_042822_928439_5CF55248 
X-CRM114-Status: GOOD (  23.75  )
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

Hi Daniel, Hannes,

A gentle ping... Do you have any further comment for this patchset?

Thanks,
--Nilay

On 4/26/25 12:26 AM, Nilay Shroff wrote:
> Hi,
> 
> Recently released Linux kernel v6.15-rc1 added support for easily discovering
> multiple paths to a shared NVMe namespace. This multipath information is
> exposed to userspace via a new sysfs group attribute named "multipath",
> located under /sys/block/<ns-blkdev>/. More details on this functionality
> can be found here [1].
> 
> This patch series leverages that new functionality to discover multiple paths
> to a shared namespace and exposes that information in libnvme so that it can
> later be used by nvme-cli.
> 
> There are four patches in this series:
> The first patch adds support for discovering NVMe paths using the sysfs
> "multipath" group attribute.
> The second patch adds a new "queue_depth" attribute under the NVMe path
> object.
> The third patch adds a new "numa_nodes" attribute under the NVMe path object.
> The fourth patch extends the sysfs tree dump test to validate multipath link
> support
> 
> [1]: https://lore.kernel.org/all/20250112124154.60690-1-nilay@linux.ibm.com/
> 
> Changes from v2:
>     - Modified queue_depth get attribure function to always return the latest
>       value insteda of cached value (Hannes Reinecke)
> 
> Changes from v1:
>     - Fixed kernel version typo in the cover letter and commit
>     - Updated the commit in first patch to explain the change in some
>       detail (Daniel Wagner)
>     - Added fourth patch to validate changes (Daniel Wagner)
> 
> 
> Nilay Shroff (4):
>   tree: add support for discovering nvme paths using sysfs multipath
>     link
>   tree: add queue-depth attribute for nvme path object
>   tree: add attribute numa_nodes for NVMe path object
>   test: extend sysfs tree dump test
> 
>  src/libnvme.map                  |   2 +
>  src/nvme/filters.c               |   6 +
>  src/nvme/filters.h               |   9 ++
>  src/nvme/json.c                  |  90 +++++++++++++--
>  src/nvme/private.h               |  11 +-
>  src/nvme/tree.c                  | 191 ++++++++++++++++++++++---------
>  src/nvme/tree.h                  |  25 ++++
>  test/sysfs/data/tree-pcie.out    |  53 +++++++--
>  test/sysfs/data/tree-pcie.tar.xz | Bin 19712 -> 12656 bytes
>  9 files changed, 315 insertions(+), 72 deletions(-)
> 


