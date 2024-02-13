Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81E1C48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dT3athFFB1S90PGKQU187mvJ77v2TNl0tjUJCAHu78Q=; b=vIgvSrtBlSgr++GZsVEowOGxHI
	wlF1dyWN0mIX3h13Y9P6IoLb7nozrEDH54V1e5zcFf3w4rGpi36FQFu/3bXiwcvdQqtkooWFSs8Qd
	4Ox/GaejzOtyVQwU6v8N3P1J7L4TevmJFMQhDKIxDflkg6qhcOG5KFIuKjo+cCEo0/ni0sJgiLY6C
	uMK/PnpILJoMTvy7b/gT5U070r5Zih57Dvq8pu3lSuDV6ssKOVbZwfaYX1q0e9ug6hZgBvWafaTQr
	xFDFtTx7jB3+7ZpIMNWuWU5Anviuczi/QiomPNjSD2A6p7vmOmPyrK8OvKL1N2GvXNMo+vV/QL1Ii
	SKpo482A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZpOp-00000008ftR-2S13;
	Tue, 13 Feb 2024 09:48:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZpOn-00000008fsT-1zT8
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 09:48:22 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9bvfX002328;
	Tue, 13 Feb 2024 09:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dT3athFFB1S90PGKQU187mvJ77v2TNl0tjUJCAHu78Q=;
 b=tbmsOADyQroCb2P3YSOtaq9OGEEPInlOGFMIr4tf8vayEG0/u5BV3S896OqzcacZCt6N
 nzuikdevQyfoWuU88iPHvKPL/ZMP0xGi96xJywauO0x0jh86pmFNhSku5cALaxQpmutN
 kBBvVRJAWZP95F5Oasi2XrWSPnDOQrmz9VJMpAJHxo18S7lnaxXozq8DJ247ug3DEVhI
 7uKQ1k5XxY1Gqfj/Kw0wLb6KtnOEIdKXNlUqld70iARDf0RoHk0sNlSxkDPCnQgjvGCn
 MAcHKqj7PB0EtG1rG5/CYKgSbW5rVq1gcyI4Qp4qKmrrsN7j+zMFfEyhXftAYSVdX+i6 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85y4gbr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:48:11 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D9eKse010951;
	Tue, 13 Feb 2024 09:48:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85y4gbqm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:48:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8bokT016184;
	Tue, 13 Feb 2024 09:36:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymecq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:36:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41D9aPsl13501118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 09:36:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E59A2004B;
	Tue, 13 Feb 2024 09:36:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A6AA2004E;
	Tue, 13 Feb 2024 09:36:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 09:36:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: john.g.garry@oracle.com
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re:[PATCH v3 10/15] block: Add fops atomic write support
Date: Tue, 13 Feb 2024 15:06:19 +0530
Message-ID: <20240213093619.106770-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113841.31824-11-john.g.garry@oracle.com>
References: <20240124113841.31824-11-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Y3xpgl7YZgmt7bLwj052NiHim_kCSSt
X-Proofpoint-ORIG-GUID: wcW_-f-Ig0-0IoXex2Lkk7VjzuJEeuiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=998 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_014821_652952_5C7E6B4A 
X-CRM114-Status: GOOD (  12.77  )
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

>+static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t p=
os,=0D
>+				      struct iov_iter *iter)=0D
>+{=0D
>+	struct request_queue *q =3D bdev_get_queue(bdev);=0D
>+	unsigned int min_bytes =3D queue_atomic_write_unit_min_bytes(q);=0D
>+	unsigned int max_bytes =3D queue_atomic_write_unit_max_bytes(q);=0D
>+=0D
>+	if (!iter_is_ubuf(iter))=0D
>+		return false;=0D
>+	if (iov_iter_count(iter) & (min_bytes - 1))=0D
>+		return false;=0D
>+	if (!is_power_of_2(iov_iter_count(iter)))=0D
>+		return false;=0D
>+	if (pos & (iov_iter_count(iter) - 1))=0D
>+		return false;=0D
>+	if (iov_iter_count(iter) > max_bytes)=0D
>+		return false;=0D
>+	return true;=0D
>+}=0D
=0D
Here do we need to also validate whether the IO doesn't straddle =0D
the atmic bondary limit (if it's non-zero)? We do check that IO =0D
doesn't straddle the atomic boundary limit but that happens very =0D
late in the IO code path either during blk-merge or in NVMe driver =0D
code.=0D
=0D
Thanks,=0D
--Nilay=0D
=0D

