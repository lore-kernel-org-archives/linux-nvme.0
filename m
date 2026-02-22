Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795BDC61DFD
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Feb 2026 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blJqo2QMa8aSGszy/tiLCSRkRRfgcMUzNxyugd46V+c=; b=Tx2wjtj7pwj7JPFU7rhAViFhSf
	jk1y7irJ0KHqlA+K14U4G0sUICcLrzX1Kfo/naYgQP4kD408gGbLFoQYYZjZ/3dsVwD1TCP8xcUOx
	2nuwvVu7lfNRLXlqcScYKAFJA41+gKMMdofTD7kr07cxWfMvx8D5j8CJmsNrb58vvPFozowoK6LPb
	WU5+fYJBqDy+KzSf/HqW412c2rWkfnzdGmj1+JssiQHeM2yYBnkHkRj+N0yB03u2J5hOBwpv8o8Y9
	9scq+YvWTuVQ8W+Z3jA9yguZZ3LqfYBtS6rLQe7PzXiKKb8RFnZ63PQXW8/yeEdNcBRECUKf/lAnP
	DjhjCqwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vu8iC-0000000GhUD-3358;
	Sun, 22 Feb 2026 12:37:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vu8i3-0000000GhTo-18JT
	for linux-nvme@lists.infradead.org;
	Sun, 22 Feb 2026 12:37:16 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M8u4WC1477949;
	Sun, 22 Feb 2026 12:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=blJqo2
	QMa8aSGszy/tiLCSRkRRfgcMUzNxyugd46V+c=; b=rDx1E/vFN3bp31dgVOAsyr
	P5RfLf5i+rQHYOyWGajhuSYLpxzRaygO+uOAQqdf2ng1GgM0UR1bWDdexQk1NUn/
	QHoEfqcTdcBWKp52wF3tMDDMhV6IkcxLIpycR32KLAo3LJgoP1i2T97mDG5hjhgV
	xywKlnkDoY2qR6mb2eOdn6BMbqPyUqQTG/NM/0TDBXlC3fK+9tlN2NrlcOZSalvS
	50qH0o4GQ5KvH5P1GgKuuE1gLYes54P4ngQRHkX42JQO5njlaW3gu6lsaGWu0eiH
	3ALs0oe+RFJq3GaeAv2hWNahwWC4jCTqeRTI03r7sfx0EN/vF32J+5I8rFz/0bBQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471ky72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 12:36:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61M7lNNW013448;
	Sun, 22 Feb 2026 12:36:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdxsem9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 12:36:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61MCas9O16908910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 12:36:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F0A5805A;
	Sun, 22 Feb 2026 12:36:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D12735805E;
	Sun, 22 Feb 2026 12:36:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.255.192])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 22 Feb 2026 12:36:50 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
Date: Sun, 22 Feb 2026 18:06:38 +0530
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <37EF3123-DD53-4280-8299-DF49868CFF8E@linux.ibm.com>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OtoOhzEPnYPsuW82rZIvQJW9aRWuLwo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDExNyBTYWx0ZWRfXwi5PSH4QBVfR
 qKNvITAeRAYezbcklFDJQhwnAA+W+y7Q6nbTQCySqqUrZ9juGRjdiLHPdd6b397R7tIJMVqI/WS
 etzwF6gLn9YkU36QHehPD4iRaKKxro7CG59iZLRP1dieb7Wcpa1iEJAQIM8Gt8ws8t+w6K8LxyL
 TZg1p+GgtobSh/Y3PvnW5BbjgVB1IQIxyCsK02nXEud0gDWXV/lIokHoBmc54I6EEOMTlCpgM+t
 6wbK5/BWTNVZWEOxs2tCxzYw9g+dX/SRvFyvETJtJF15NmOHNkmEeEpo9jt3u8mq1ZYza6RTx4j
 G8g0MOqgIQYoI87wVwxIaZGTDwuPE+NiJ6c6H60nV/W3QvZa89CLcskjR7IuZUhxngKcFjt2I/I
 DeLXX4USoC3uOtrG3OFhjjA2dRNf4s15k592bGU09R+dwzUtlsrHXkAGL7U1CiPPnNfWpWLt6ig
 VQVe35RcohQ/HWWkMbQ==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699af869 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rfewDElZ52AdZIvqx84A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OtoOhzEPnYPsuW82rZIvQJW9aRWuLwo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602220117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_043715_318135_4ACCAB30 
X-CRM114-Status: GOOD (  21.86  )
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



> On 20 Feb 2026, at 11:18=E2=80=AFPM, Nilay Shroff =
<nilay@linux.ibm.com> wrote:
>=20
> Hi,
>=20
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to =
userspace
> via sysfs. Lack of visibility into these events can make it difficult =
to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
>=20
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.
>=20
> Specifically, this series proposes to export the following counters =
via
> sysfs:
>  - Command retry count
>  - Multipath failover count
>  - Command error count
>  - I/O requeue count
>  - I/O failure count
>  - Controller reset event counts
>  - Controller reconnect counts
>=20
> The patchset consists of seven patches:
>  Patch 1: Export command retry count
>  Patch 2: Export multipath failover count
>  Patch 3: Export command error count
>  Patch 4: Export I/O requeue count
>  Patch 5: Export I/O failure count
>  Patch 6: Export controller reset event counts
>  Patch 7: Export controller reconnect event count
>=20
> Please note that this patchset doesn't make any functional change but
> rather export relevant counters to user space via sysfs.
>=20
> As usual, feedback/comments/suggestions are welcome!
>=20
> Changes from v2:
>  - Allow user to write to sysfs attributes so that user could
>    reset stat counters, if needed (Sagi)
>  - The controller reconnect counter nr_reconnects could reset
>    to zero once connection is re-established, so instead of
>    exposing nr_reconnects counter via sysfs introduce a new
>    counter which accumulates the reconnect attempts and export=20
>    this accumulated counter via sysfs (Sagi)
> Link to v2: =
https://lore.kernel.org/all/20260205124810.682559-1-nilay@linux.ibm.com/
>=20
> Changes from v1:
>  - Remove export of stats for admin command rerty count (Keith)
>  - Use size_add() to ensure stat counters don't overflow (Keith)
> Link to v1: =
https://lore.kernel.org/all/20260130182028.885089-1-nilay@linux.ibm.com/ =
=20
>=20
> Nilay Shroff (7):
>  nvme: export command retry count via sysfs
>  nvme: export multipath failover count via sysfs
>  nvme: export command error counters via sysfs
>  nvme: export I/O requeue count when no path is available via sysfs
>  nvme: export I/O failure count when no path is available via sysfs
>  nvme: export controller reset event count via sysfs
>  nvme: export controller reconnect event count via sysfs
>=20
> drivers/nvme/host/core.c      |  18 +++-
> drivers/nvme/host/fc.c        |   5 +
> drivers/nvme/host/multipath.c |  89 ++++++++++++++++++
> drivers/nvme/host/nvme.h      |  13 ++-
> drivers/nvme/host/rdma.c      |   4 +
> drivers/nvme/host/sysfs.c     | 167 ++++++++++++++++++++++++++++++++++
> drivers/nvme/host/tcp.c       |   3 +
> 7 files changed, 297 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.52.0
>=20
>=20

Hello Nilay,

I tested this patch series and found couple of attributes are missing.=20=


Missing diag counters:

1. I/O requeue count
2. I/O failure count

Rest all diag counters are exposed via sysfs properly.

Controller-level counters observed:
  - reset_events
  - reconnect_events
  - command_error_count

Namespace-instance counters observed:
  - command_retries
  - multipath_failover_count
  - command_error_count


Logs:

ll /sys/class/nvme/nvme3/=20
total 0
-r--r--r-- 1 root root 65536 Feb 22 05:49 address
-r--r--r-- 1 root root 65536 Feb 22 05:58 cntlid
-r--r--r-- 1 root root 65536 Feb 22 05:49 cntrltype
-rw-r--r-- 1 root root 65536 Feb 22 06:10 command_error_count
-rw-r--r-- 1 root root 65536 Feb 22 05:58 ctrl_loss_tmo
-r--r--r-- 1 root root 65536 Feb 22 05:49 dctype
--w------- 1 root root 65536 Feb 22 05:58 delete_controller
-r--r--r-- 1 root root 65536 Feb 22 05:58 dev
lrwxrwxrwx 1 root root     0 Feb 22 05:50 device -> ../../ctl
-rw-r--r-- 1 root root 65536 Feb 22 05:58 fast_io_fail_tmo
-r--r--r-- 1 root root 65536 Feb 22 05:49 firmware_rev
-r--r--r-- 1 root root 65536 Feb 22 05:51 hostid
-r--r--r-- 1 root root 65536 Feb 22 05:51 hostnqn
-r--r--r-- 1 root root 65536 Feb 22 05:58 kato
-r--r--r-- 1 root root 65536 Feb 22 05:49 model
-r--r--r-- 1 root root 65536 Feb 22 05:49 numa_node
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n1
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n10
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n2
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n3
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n4
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n5
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n6
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n7
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n8
drwxr-xr-x 9 root root     0 Feb 22 05:49 nvme3c3n9
-rw-r--r-- 1 root root 65536 Feb 22 05:58 passthru_err_log_enabled
drwxr-xr-x 2 root root     0 Feb 22 05:58 power
-r--r--r-- 1 root root 65536 Feb 22 05:49 queue_count
-rw-r--r-- 1 root root 65536 Feb 22 05:58 reconnect_delay
-rw-r--r-- 1 root root 65536 Feb 22 06:11 reconnect_events
--w------- 1 root root 65536 Feb 22 05:58 rescan_controller
--w------- 1 root root 65536 Feb 22 06:11 reset_controller
-rw-r--r-- 1 root root 65536 Feb 22 06:10 reset_events
-r--r--r-- 1 root root 65536 Feb 22 05:49 serial
-r--r--r-- 1 root root 65536 Feb 22 05:49 sqsize
-r--r--r-- 1 root root 65536 Feb 22 05:49 state
-r--r--r-- 1 root root 65536 Feb 22 05:51 subsysnqn
lrwxrwxrwx 1 root root     0 Feb 22 05:49 subsystem -> =
../../../../../class/nvme
-r--r--r-- 1 root root 65536 Feb 22 05:51 transport
-rw-r--r-- 1 root root 65536 Feb 22 05:49 uevent


ll /sys/class/nvme/nvme3/nvme3c3n8
total 0
-r--r--r--  1 root root 65536 Feb 22 06:02 alignment_offset
-r--r--r--  1 root root 65536 Feb 22 05:51 ana_grpid
-r--r--r--  1 root root 65536 Feb 22 05:51 ana_state
-r--r--r--  1 root root 65536 Feb 22 06:02 capability
-rw-r--r--  1 root root 65536 Feb 22 06:07 command_error_count
-rw-r--r--  1 root root 65536 Feb 22 06:07 command_retries
-r--r--r--  1 root root 65536 Feb 22 06:02 csi
lrwxrwxrwx  1 root root     0 Feb 22 05:50 device -> ../../nvme3
-r--r--r--  1 root root 65536 Feb 22 06:02 discard_alignment
-r--r--r--  1 root root 65536 Feb 22 06:02 diskseq
-r--r--r--  1 root root 65536 Feb 22 06:02 events
-r--r--r--  1 root root 65536 Feb 22 06:02 events_async
-rw-r--r--  1 root root 65536 Feb 22 06:02 events_poll_msecs
-r--r--r--  1 root root 65536 Feb 22 06:02 ext_range
-r--r--r--  1 root root 65536 Feb 22 06:02 hidden
drwxr-xr-x  2 root root     0 Feb 22 06:02 holders
-r--r--r--  1 root root 65536 Feb 22 06:02 inflight
drwxr-xr-x  2 root root     0 Feb 22 06:02 integrity
-r--r--r--  1 root root 65536 Feb 22 06:02 metadata_bytes
drwxr-xr-x 18 root root     0 Feb 22 06:02 mq
-rw-r--r--  1 root root 65536 Feb 22 06:07 multipath_failover_count
-r--r--r--  1 root root 65536 Feb 22 06:02 nguid
-r--r--r--  1 root root 65536 Feb 22 06:02 nsid
-r--r--r--  1 root root 65536 Feb 22 06:02 numa_nodes
-r--r--r--  1 root root 65536 Feb 22 06:02 nuse
-r--r--r--  1 root root 65536 Feb 22 06:02 partscan
-rw-r--r--  1 root root 65536 Feb 22 06:02 passthru_err_log_enabled
drwxr-xr-x  2 root root     0 Feb 22 06:02 power
drwxr-xr-x  2 root root     0 Feb 22 05:49 queue
-r--r--r--  1 root root 65536 Feb 22 06:02 queue_depth
-r--r--r--  1 root root 65536 Feb 22 06:02 range
-r--r--r--  1 root root 65536 Feb 22 05:49 removable
-r--r--r--  1 root root 65536 Feb 22 06:02 ro
-r--r--r--  1 root root 65536 Feb 22 05:50 size
drwxr-xr-x  2 root root     0 Feb 22 06:02 slaves
-r--r--r--  1 root root 65536 Feb 22 06:02 stat
lrwxrwxrwx  1 root root     0 Feb 22 05:49 subsystem -> =
../../../../../../class/block
drwxr-xr-x  2 root root     0 Feb 22 06:02 trace
-rw-r--r--  1 root root 65536 Feb 22 05:49 uevent
-r--r--r--  1 root root 65536 Feb 22 06:02 uuid
-r--r--r--  1 root root 65536 Feb 22 06:02 wwid


Regards,
Venkat.


