Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96424C77B75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Date:Cc:To:From:Subject:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=atWf1O9Mitsf09v2Hgyf8m9448lJraj4ITT/pP6YoFo=; b=alwmJ6eUz4dwHnNFZvAqNaoQi3
	8xaqdcVBRQv8WaHyueE8Pkj23ZOzu2WjstyjRH2Q0gm2JLUpyV43Ie5HGwxM8wyRoGhc3XOHIu7Ri
	39A7ecmtMdIFg43JJTer8Fmeg2HZLVcfSu6Z5VnS/lpHamCoAs1rnYqreFEasLCyqQ41irzOBqSmz
	8QfbeQ2CM5R7OplOrxpfbxJqELuCtJ4MIzUOO2eoZTp526JlmsVAItURJvijCDc1bTEGOvM7tcDvz
	vIhJf//BJxlpDY9mdVTrZxJkE3KZPZi+W949QrpglxaXpShDRzPoxf6i6Xw/XGwk7igG35x7zG6wm
	6jNY7agQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pusrx-00AOoH-1m;
	Fri, 05 May 2023 10:40:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pusrt-00AOjT-0d
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 10:40:55 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345AdVQi021785;
	Fri, 5 May 2023 10:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=atWf1O9Mitsf09v2Hgyf8m9448lJraj4ITT/pP6YoFo=;
 b=BJAAQ1m+IopPzjAGGqW4NyebIZgmX5wu3c3Kd4/hBg6RiNvxWxOXPEtt3vzLYyEc0Bzx
 sm4KVMa3qia6H6UgKZ5febrDG2ejVHNNgx09FJB+OCisIcScQwiMk5BCPAZuITIfODws
 lFKt8z1/4R3ZwGxnuIzN0DykreWqgWCfXxAMUAK0l0zPf18VOyWI4a/xLkOaNPdL04iE
 HKXA+tvsc5oMrbCk0x9AF56vYRQH90wRmkqQkvf2YhNNXAfOjZFNcZ8tUyisH7Xs2Y5j
 eWXKLdl4D/hSjcaW7gwrxqgPJZllymEMnO7hU1gRdQocJQl4+dZx5oA2C0R6cd36N5I4 Jg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qd087r18b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 May 2023 10:40:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3457UUFo000857;
	Fri, 5 May 2023 10:40:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6udaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 May 2023 10:40:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 345Aei9D21562068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 May 2023 10:40:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009A520040;
	Fri,  5 May 2023 10:40:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B376420043;
	Fri,  5 May 2023 10:40:43 +0000 (GMT)
Received: from [9.152.212.201] (unknown [9.152.212.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 May 2023 10:40:43 +0000 (GMT)
Message-ID: <627049f26ca29aa8191de8dec7a4c854d669d9d6.camel@linux.ibm.com>
Subject: [bug report] workqueue lockup under fio stress on NVMe drive
From: Gerd Bayer <gbayer@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Egorenkov
	 <egorenar@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Fri, 05 May 2023 12:40:43 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.module_f38+16663+080ec715) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rFRxU3o0MxRRZ_Myz9r3Og6R3mDEoKm1
X-Proofpoint-ORIG-GUID: rFRxU3o0MxRRZ_Myz9r3Og6R3mDEoKm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_16,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_034053_372934_E9A76C14 
X-CRM114-Status: GOOD (  15.43  )
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

Hi all,

I could need some help with sorting out the following fall-out that
a recent addition to our test-suite seems to trigger consistently on
a range of recent upstream kernel-versions.
This hits with the "debug_defconfig" on ARCH=3Ds390 -=20
while "defconfig" runs clean. But then, CONFIG_WQ_WATCHDOG is
configured only in "debug_defconfig".

There might be some interaction between other config options in
"debug_defconfig", as the BUG does not show up with just the=20
CONFIG_WQ_WATCHDOG added to "defconfig".=20

I wonder if other ARCH's see similar issues with this kind of stress?
At any rate, I'm open to suggestions on how to attack this issue.

I'm also open to any advice on whether the combination of
test-case and addtional CONFIG options in "debug_defconfig" is
abusive...


For a clear base-line I just re-created this on a 6.3.0 kernel=20
with the following "workload"

fio --readonly pci_nvme_read.fiojob=20

with pci_nvme_read.fiojob specifying:

[iopstest]
filename=3D/dev/nvme0n1
rw=3Dread
size=3D512m
blocksize=3D4k
iodepth=3D32
numjobs=3D14  (and higher up to $nproc=3D18)
time_based
runtime=3D1m
ramp_time=3D10s
ioengine=3Dio_uring  (also with libaio)
direct=3D1
norandommap
group_reporting=3D1


I get the following messages logged:

2023/05/04 19:31:26 [t35lp67]: [  235.438022] BUG: workqueue lockup -
pool cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 stuck for 65s!
2023/05/04 19:31:26 [t35lp67]: [  235.438265] BUG: workqueue lockup -
pool cpus=3D7 node=3D0 flags=3D0x0 nice=3D0 stuck for 61s!
2023/05/04 19:31:26 [t35lp67]: [  235.438278] BUG: workqueue lockup -
pool cpus=3D10 node=3D0 flags=3D0x0 nice=3D0 stuck for 46s!
2023/05/04 19:31:26 [t35lp67]: [  235.438290] BUG: workqueue lockup -
pool cpus=3D10 node=3D0 flags=3D0x0 nice=3D-20 stuck for 41s!
2023/05/04 19:31:26 [t35lp67]: [  235.438438] Showing busy workqueues
and worker pools:
2023/05/04 19:31:26 [t35lp67]: [  235.438621]   pwq 20: cpus=3D10 node=3D0
flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D2
2023/05/04 19:31:26 [t35lp67]: [  235.438624]     pending:
kfree_rcu_monitor
2023/05/04 19:31:26 [t35lp67]: [  235.438493] workqueue events:
flags=3D0x0
2023/05/04 19:31:26 [t35lp67]: [  235.438634]   pwq 0: cpus=3D0 node=3D0
flags=3D0x0 nice=3D0 active=3D2/256 refcnt=3D3
2023/05/04 19:31:26 [t35lp67]: [  235.438636]     pending:
vmstat_shepherd, kfree_rcu_monitor
2023/05/04 19:31:26 [t35lp67]: [  235.438736] workqueue events_unbound:
flags=3D0x2
2023/05/04 19:31:26 [t35lp67]: [  235.438752]   pwq 760: cpus=3D0-379
flags=3D0x4 nice=3D0 active=3D1/1520 refcnt=3D3
2023/05/04 19:31:26 [t35lp67]: [  235.438754]     in-flight:
588:toggle_allocation_gate
2023/05/04 19:31:26 [t35lp67]: [  235.438944] workqueue rcu_gp:
flags=3D0x8
2023/05/04 19:31:26 [t35lp67]: [  235.439069]   pwq 20: cpus=3D10 node=3D0
flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D2
2023/05/04 19:31:26 [t35lp67]: [  235.439072]     in-flight:
259:wait_rcu_exp_gp
2023/05/04 19:31:27 [t35lp67]: [  235.439125] workqueue rcu_par_gp:
flags=3D0x8
2023/05/04 19:31:27 [t35lp67]: [  235.439251]   pwq 20: cpus=3D10 node=3D0
flags=3D0x0 nice=3D0 active=3D2/256 refcnt=3D4
2023/05/04 19:31:27 [t35lp67]: [  235.439255]     pending:
sync_rcu_exp_select_node_cpus
2023/05/04 19:31:27 [t35lp67]: [  235.439413] workqueue mm_percpu_wq:
flags=3D0x8
2023/05/04 19:31:27 [t35lp67]: [  235.439253]     in-flight:
115:sync_rcu_exp_select_node_cpus BAR(259)
2023/05/04 19:31:27 [t35lp67]: [  235.439542]   pwq 14: cpus=3D7 node=3D0
flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D2
2023/05/04 19:31:27 [t35lp67]: [  235.439544]     pending:
lru_add_drain_per_cpu
2023/05/04 19:31:27 [t35lp67]: [  235.439550]   pwq 0: cpus=3D0 node=3D0
flags=3D0x0 nice=3D0 active=3D1/256 refcnt=3D3
2023/05/04 19:31:30 [t35lp67]: [  235.439552]     pending:
lru_add_drain_per_cpu BAR(140)
2023/05/04 19:31:30 [t35lp67]: [  235.439817] workqueue writeback:
flags=3D0x4a
2023/05/04 19:31:30 [t35lp67]: [  235.439969]   pwq 760: cpus=3D0-379
flags=3D0x4 nice=3D0 active=3D1/256 refcnt=3D3
2023/05/04 19:31:30 [t35lp67]: [  235.439971]     in-flight:
1345:wb_workfn
2023/05/04 19:31:30 [t35lp67]: [  235.440110] workqueue kblockd:
flags=3D0x18
2023/05/04 19:31:30 [t35lp67]: [  235.440238]   pwq 21: cpus=3D10 node=3D0
flags=3D0x0 nice=3D-20 active=3D1/256 refcnt=3D2
2023/05/04 19:31:30 [t35lp67]: [  235.440241]     pending:
blk_mq_run_work_fn
2023/05/04 19:31:30 [t35lp67]: [  235.441046] workqueue mld:
flags=3D0x40008
2023/05/04 19:31:30 [t35lp67]: [  235.441173]   pwq 20: cpus=3D10 node=3D0
flags=3D0x0 nice=3D0 active=3D1/1 refcnt=3D2
2023/05/04 19:31:30 [t35lp67]: [  235.441175]     pending: mld_ifc_work
2023/05/04 19:31:30 [t35lp67]: [  235.441611]   pwq 760: cpus=3D0-379
flags=3D0x4 nice=3D0 active=3D1/1 refcnt=3D4
2023/05/04 19:31:30 [t35lp67]: [  235.441603] workqueue mlx5e:
flags=3D0xe000a
2023/05/04 19:31:30 [t35lp67]: [  235.441613]     in-flight:
12:mlx5e_set_rx_mode_work [mlx5_core]
2023/05/04 19:31:30 [t35lp67]: [  235.441741]     inactive:
mlx5e_set_rx_mode_work [mlx5_core]
2023/05/04 19:31:30 [t35lp67]: [  235.443027] pool 20: cpus=3D10 node=3D0
flags=3D0x0 nice=3D0 hung=3D46s workers=3D3 idle: 69
2023/05/04 19:31:30 [t35lp67]: [  235.443339] pool 760: cpus=3D0-379
flags=3D0x4 nice=3D0 hung=3D0s workers=3D19 idle: 13 568 10 586 1987 567 58=
7
1988 147 584 1321 1353 1986 1989 1990 1991

Thank you,
Gerd

