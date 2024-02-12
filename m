Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C2BC48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zoVRmRi8SldJa0D8D0wv+7S4X/v7cfA5ay35VLyY9l4=; b=qMEsmS5Xa42334uy8HMrRRfemR
	eVZ/LNj/azsOTEc3XZHzAVV0XauxKWgJ7KVNj2VJgk0aK5iBpIoud3zxT+fF5KubB0yen71N2iS2v
	E5d0cQVPM6/+kM6Fvqaqrg/m4TYfexaYA6zV/qDJ8a6b9uAPnzf8ekbpnfvLjSPXHHwUix6+6C9WU
	qxCdYOrwfVwSdcrWAf1VtrRMg7tFkmMinbe8SM/EYWW329eDLfFczzmZLS5+WCsd3K+tU8NE5yRrv
	y3LOlJ7atfcrGU7DC8dmfZ7+Deo/aeMOCvqyXARbAYpn7ljy9a+w+QuB2eSko/fOrDkf+XQ1zTpZN
	BdKsDV7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTxv-00000004ztj-1Yrz;
	Mon, 12 Feb 2024 10:55:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTxs-00000004zsj-3K81
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:55:10 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAgHcb004087;
	Mon, 12 Feb 2024 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zoVRmRi8SldJa0D8D0wv+7S4X/v7cfA5ay35VLyY9l4=;
 b=Xu1kwmSu6Aorj1i1sDCBWstHrix6T+AEiVK037yo4yRHX0CITslpJXem8tD1ezVBm4L3
 HnQUueSsPp9naidq8IUXdLJYQooagAzKEUZT7XH0hlUI0mieGpEJPVdVb4s9xF9BcbCu
 ExrxuxvKvNAOPivEVVoKJ9afYDqymfFjwD/K9RwjX6vOSv4Vxx4ZfE9d1hYmTUmzaULm
 UlLF6lbcybPIlA1MycZ79RrgEcw9wO71m9Gd/mnikW/DyWzRmiFc0HYleSSZZO65E9ok
 JZlfW81n1F0GCw1i9ebyfqhanHJeSo0msDhqOSKnjJthsxbmD38DYVqWL85Ge23A7ODR Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7htf8fnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CAgxmI006433;
	Mon, 12 Feb 2024 10:54:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7htf8fmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41C8j2ov009728;
	Mon, 12 Feb 2024 10:54:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62fk2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:54:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CAsom918023054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 10:54:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16E7F20043;
	Mon, 12 Feb 2024 10:54:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C12292004B;
	Mon, 12 Feb 2024 10:54:45 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 10:54:45 +0000 (GMT)
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
Subject: Re:[PATCH v3 09/15] block: Add checks to merging of atomic writes
Date: Mon, 12 Feb 2024 16:24:44 +0530
Message-ID: <20240212105444.43262-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113841.31824-10-john.g.garry@oracle.com>
References: <20240124113841.31824-10-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l6UR2kJ2av9VC-Gz59rrtIFBEPbdj0UY
X-Proofpoint-ORIG-GUID: Q0gM8ieRkli4blZ8gcHTGllf5lrbi8pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_025508_978651_FC6381E9 
X-CRM114-Status: GOOD (  16.33  )
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

>+static bool rq_straddles_atomic_write_boundary(struct request *rq,=0D
>+					unsigned int front,=0D
>+					unsigned int back)=0D
>+{=0D
>+	unsigned int boundary =3D queue_atomic_write_boundary_bytes(rq->q);=0D
>+	unsigned int mask, imask;=0D
>+	loff_t start, end;=0D
>+=0D
>+	if (!boundary)=0D
>+		return false;=0D
>+=0D
>+	start =3D rq->__sector << SECTOR_SHIFT;=0D
>+	end =3D start + rq->__data_len;=0D
>+=0D
>+	start -=3D front;=0D
>+	end +=3D back;=0D
>+=0D
>+	/* We're longer than the boundary, so must be crossing it */=0D
>+	if (end - start > boundary)=0D
>+		return true;=0D
>+=0D
>+	mask =3D boundary - 1;=0D
>+=0D
>+	/* start/end are boundary-aligned, so cannot be crossing */=0D
>+	if (!(start & mask) || !(end & mask))=0D
>+		return false;=0D
>+=0D
>+	imask =3D ~mask;=0D
>+=0D
>+	/* Top bits are different, so crossed a boundary */=0D
>+	if ((start & imask) !=3D (end & imask))=0D
>+		return true;=0D
>+=0D
>+	return false;=0D
>+}=0D
>+=0D
=0D
Shall we ensure here that we don't cross max limit of atomic write supporte=
d by =0D
device? It seems that if the boundary size is not advertized by the device =
=0D
(in fact, I have one NVMe drive which has boundary size zero i.e. nabo/nabs=
pf/=0D
nawupf are all zero but awupf is non-zero) then we (unconditionally) allow =
=0D
merging. However it may be possible that post merging the total size of the=
 =0D
request may exceed the atomic-write-unit-max-size supported by the device a=
nd =0D
if that happens then most probably we would be able to catch it very late i=
n =0D
the driver code (if the device is NVMe). =0D
=0D
So is it a good idea to validate here whether we could potentially exceed =
=0D
the atomic-write-max-unit-size supported by device before we allow merging?=
 =0D
In case we exceed the atomic-write-max-unit-size post merge then don't allo=
w=0D
merging?=0D
 =0D
Thanks,=0D
--Nilay=0D
=0D

