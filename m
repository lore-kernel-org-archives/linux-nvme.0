Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B0ECD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sH0kSHCQlV3pCKscntmWc6wgEP0GrwvBnsZqFO3F+JU=; b=IpzrPzAYzI7MEo5xqmmuwO00rr
	5ZtBi9efoPZZ/YwaMN5iN7hweZsW+Ge0YeHGHfgRVdZ8nqozXvHfaKLIEJwxQllwzu7ulhbNRuXXJ
	SKKzdSJff7udp1RusIwiqCz+Rr4FwytM3rHKyXCeH2vwwcaHMOxcAyxh6ZNoDWD3Neg8iplDEDPfC
	wQQoM6wX1Qq55OHoBzQSKfQfipb6LOdvIuTSGxR69/gM1xKxsxKoVCA/TuMaUmDoTz9i6jFFA9Zto
	I2+ZSCDAgHmWuNYoXlRdfEIu4Fr6NippgCHTMTgPbPuoASgCIdtMiEqUm/xE+Tv5jqCk1Fo3Gjwjk
	y7xFxZOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRMw-0000000Gm4v-1BIL;
	Mon, 25 May 2026 09:13:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRMv-0000000Gm4f-1YEv
	for linux-nvme@bombadil.infradead.org;
	Mon, 25 May 2026 09:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sH0kSHCQlV3pCKscntmWc6wgEP0GrwvBnsZqFO3F+JU=; b=GuJHx/4zQEB/4rb3At6ZlJj6GO
	o5XCqnA4QhDWmAIwIAKyTxkJq+KxsnBSqpeK9aPbSRSM6QLtEjmCdLtowyduOzZXlogUsf/8h3B86
	M99n8WzDgcjeh1beG1z8fxhSmL30ED7DLeQlIirUS8z49OnhQueZzDinXp/qESmPBsIV2gyc8nMlj
	IbXbuKtD+UtexUHM7RUbsroTIqvHnBgCaRWG89H06hlQpBqH59XjIpZal6DcNEl5ScdtaydOe2th5
	tgvy8dKRbOxbGgmD9aFIolwzcgYbIGGXgYyrpJNhbROmbGkCDUXGYGFTG6piuEciqVfgIh7SKYEv1
	1yA1e7xQ==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRMr-00000008rqK-2Dkt
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 09:13:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJGDh61617929;
	Mon, 25 May 2026 09:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sH0kSH
	CQlV3pCKscntmWc6wgEP0GrwvBnsZqFO3F+JU=; b=IyFu0PW+4Bd+Kbm7TffQ11
	4ddnPRzBEC8dMof4BkbOkb0UgK/0qBKVYXWS9NfvYaUCr1Nz1H6Yrq57jsJENx5r
	HFU0h0ffkvDq2M1SZXqqpilA+WoDWyuZQXgwAb16Qb8MVg10c8ZQ6snhBzCJ/7SP
	9nl0HCZbWTARnAEjRgfKNR+eMqp0/MM3R2Ruew3eAdM44QPh9otUuB5y+h4z+iQn
	ACtyCkROWNwDW5oXH+1Em0kTovCcWP3WKxRiThDpykBJi6T2T+ULIQ7HGeXrJ5RN
	PxxAs2C9V/zYIc/C4H3aDWtfantekH3HxRkuH4K/a4cUTZ7vnokk7IGFcrKlDFlg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qbq001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:12:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64P994Ro003614;
	Mon, 25 May 2026 09:12:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebs8y49w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:12:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64P9Cbp564291140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 09:12:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628C55805D;
	Mon, 25 May 2026 09:12:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EFE558052;
	Mon, 25 May 2026 09:12:33 +0000 (GMT)
Received: from [9.61.252.224] (unknown [9.61.252.224])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 May 2026 09:12:32 +0000 (GMT)
Message-ID: <72318dfe-aaa7-4c11-8254-ea3163b31eba@linux.ibm.com>
Date: Mon, 25 May 2026 14:42:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/8] nvme: export additional diagnostic counters via
 sysfs
Content-Language: en-GB
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260516183709.269937-1-nilay@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5MiBTYWx0ZWRfX+axedWMDf6Hj
 lenUtAQzyIH2f9M25LqMXJzNb5QRYb69rNtOqa/Yl2I7qyqYiXNGEzInzxI2UWcMPkFr89ZEl/B
 nZ+FRJPqv+BtPxuTBPk2W3jQ/sUSrwFRdhf2a5bHYyarlbw0eGewu0ms571vF5XjFFj6yP+LRfs
 SfzNTQiedN8KPulYrLLxn/KwSLlNLnHJIiIcHrmihufzCI8UWDIupWyMxB9oOTjAofI0y6ZGxUq
 Q6owWyxGEcniFqRBj1xZNPujoEUuyC2gBOJ3mMIJvD6htL+laf/FRn6JjSS3zfylx7j8MgEa2Hf
 h90jzSX5wteUL4W9DGTgWQnsYNd1jdbiz3n598+p7OwtU/eYlAekKxS86pTLGiICNawUkPM77Zy
 xZiD1aaHeraf3927nOB2qj+zqFaZ+3G0QHxFiX2ozXWNEIVTVu5z1/C9pd3HuLx8fYSseMRIpFO
 ecILRPHgCaIouf8OQFw==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a141288 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LHj3_5zPocH3-y24VosA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PaakXpgrF0g9-99kW_sz7ubVnnxjj8v9
X-Proofpoint-GUID: PaakXpgrF0g9-99kW_sz7ubVnnxjj8v9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_101302_264265_6B2B5793 
X-CRM114-Status: GOOD (  25.69  )
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


On 17/05/26 12:06 am, Nilay Shroff wrote:
> Hi,
>
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
>
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.
>
> Specifically, this series proposes to export the following counters via
> sysfs:
>    - Command retry count
>    - Multipath failover count
>    - Command error count
>    - I/O requeue count
>    - I/O failure count
>    - Controller reset event counts
>    - Controller reconnect counts
>
> The first patch in the series adds a new diag attribute group under per-path,
> ns-head and ctrl sysfs directories so that all diagnostics counters could be
> grouped together under diag sub-directory. The subsequent patches in the series
> adds diagnostics counters listed above.
>
> Please note that this patchset doesn't make any functional change but
> rather export relevant counters to user space via sysfs.
>
> As usual, feedback/comments/suggestions are welcome!
>
> Changes from v3:
>    - To be consistent in naming, all counters are suffixed with _count
>      (Keith Busch)
>    - The first patch in the series creates new attribute group named
>      diag and all counters are now grouped under this new sysfs
>      attribute group (Keith Busch)
>    - Counters are defined as atomic_long_t instead of size_t (Keith Busch)
>    - Removed RB and TB tags due to above changes
> Link to v3: https://lore.kernel.org/all/20260220175024.292898-1-nilay@linux.ibm.com/
>
> Changes from v2:
>    - Allow user to write to sysfs attributes so that user could
>      reset stat counters, if needed (Sagi)
>    - The controller reconnect counter nr_reconnects could reset
>      to zero once connection is re-established, so instead of
>      exposing nr_reconnects counter via sysfs introduce a new
>      counter which accumulates the reconnect attempts and export
>      this accumulated counter via sysfs (Sagi)
> Link to v2: https://lore.kernel.org/all/20260205124810.682559-1-nilay@linux.ibm.com/
>
> Changes from v1:
>    - Remove export of stats for admin command rerty count (Keith)
>    - Use size_add() to ensure stat counters don't overflow (Keith)
> Link to v1: https://lore.kernel.org/all/20260130182028.885089-1-nilay@linux.ibm.com/
>
> Nilay Shroff (8):
>    nvme: add diag attribute group under sysfs
>    nvme: export command retry count via sysfs
>    nvme: export multipath failover count via sysfs
>    nvme: export command error counters via sysfs
>    nvme: export I/O requeue count when no path is available via sysfs
>    nvme: export I/O failure count when no path is available via sysfs
>    nvme: export controller reset event count via sysfs
>    nvme: export controller reconnect event count via sysfs
>
>   drivers/nvme/host/core.c      |  15 ++-
>   drivers/nvme/host/fc.c        |   3 +
>   drivers/nvme/host/multipath.c |  87 ++++++++++++++
>   drivers/nvme/host/nvme.h      |  13 +++
>   drivers/nvme/host/pci.c       |   1 +
>   drivers/nvme/host/rdma.c      |   2 +
>   drivers/nvme/host/sysfs.c     | 214 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/tcp.c       |   2 +
>   8 files changed, 336 insertions(+), 1 deletion(-)
>

Hello Nilay,

Applied this patch series on top of v7.1-rc5 and boot-tested on ppc64le.

Verified the new NVMe diag sysfs hierarchy and counters exposed by this 
series.

Validation steps executed:

Read all exported NVMe diag counters: for f in $(find /sys -path 
'*nvme*diag/*_count' 2>/dev/null); do echo "$f: $(cat "$f")"; done

Reset all writable counters to zero: for f in $(find /sys -path 
'*nvme*diag/*_count' 2>/dev/null); do echo 0 > "$f" && echo "reset ok 
$f"; done

Negative test with invalid input: echo abc > 
/sys/devices/pci0525:48/0525:48:00.0/nvme/nvme0/diag/command_error_count

Observed results:

diag directories were present under:

controller paths, e.g. /sys/devices/.../nvme/nvmeX/diag/

per-path namespace paths, e.g. /sys/devices/.../nvme/nvmeX/nvmeYcZnW/diag/

namespace-head paths, e.g. 
/sys/devices/virtual/nvme-subsystem/nvme-subsysX/nvmeYnZ/diag/

Controller counters observed:
reset_count
command_error_count
reconnect_count on fabrics controllers


# ll /sys/devices/virtual/nvme-fabrics/ctl/nvme7/diag
total 0
-rw-r--r--. 1 root root 65536 May 25 03:58 command_error_count
-rw-r--r--. 1 root root 65536 May 25 03:58 reconnect_count
-rw-r--r--. 1 root root 65536 May 25 03:58 reset_count

# ll /sys/devices/pci052a:58/052a:58:00.0/nvme/nvme2/diag
total 0
-rw-r--r--. 1 root root 65536 May 25 03:58 command_error_count
-rw-r--r--. 1 root root 65536 May 25 03:58 reset_count


Per-path counters observed:
multipath_failover_count
command_error_count
command_retries_count

# ll /sys/devices/pci052a:58/052a:58:00.0/nvme/nvme2/nvme2c2n1/diag
total 0
-rw-r--r--. 1 root root 65536 May 25 03:58 command_error_count
-rw-r--r--. 1 root root 65536 May 25 03:58 command_retries_count
-rw-r--r--. 1 root root 65536 May 25 03:58 multipath_failover_count


Namespace-head counters observed:
io_fail_no_available_path_count
io_requeue_no_usable_path_count


# ll /sys/devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n2/diag
total 0
-rw-r--r--. 1 root root 65536 May 25 03:58 io_fail_no_available_path_count
-rw-r--r--. 1 root root 65536 May 25 03:58 io_requeue_no_usable_path_count


All reads returned numeric values

All reset writes to 0 succeeded

Invalid text write failed as expected: -bash: echo: write error: Invalid 
argument.


If it all looks good, please add below tag.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



Regards,

Venkat.


