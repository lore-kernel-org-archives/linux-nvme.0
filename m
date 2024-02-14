Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22EDC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRFKlhzzIOqZkfBxF3tF90gsNVo0FbFcej3DjTeQ68Q=; b=deGSuunr7YuaPFqmKyEdJB5tta
	PXRsV76so49qKHWBFJ4FhxvdXyuIIjibYD4+AWXQCtbMbXKlGp6EcXKjohHWsVNfmS4SHLX38xvfK
	DGpVxZsHQRDDwbfb3hJpKq8vc2vYdC9CLARvrxZe50v3t+tQ78WEhvTaGL/2h8UoegV0PtDEu3dGF
	YqC5BUIoZ2G3YJqOxxEILOnEX/Vlh1DL+KVK/sLwhK+zHxfqSVSN3NJBf93R8cFwTL9amWHao73H8
	CzVyXZ8pg+hT7HWZQzcbD4RlZ531RGZe/lV1VGtYMh+Bh+v9j4o0+95iyoxyafZbMZa7mj+0KABPe
	7+KeQwQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raENQ-0000000Co3u-1PpR;
	Wed, 14 Feb 2024 12:28:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raENO-0000000Co3X-1WrA
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 12:28:35 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBuYt3032116;
	Wed, 14 Feb 2024 12:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MRFKlhzzIOqZkfBxF3tF90gsNVo0FbFcej3DjTeQ68Q=;
 b=RAyyuSiuyE1/8N/E++GW0YWMFId7OBYiV3UQ9eM4Zhs8jy2oE3VqNpSDOCHFoMBsCZ1K
 o49R9lYVDaJsjzIpHnb6sE0Z6sDW038WAYhEwHV1tu3ZoO6CHGgzhQ2AVJ/cw59ftVXc
 mmFL67T7td01fQjFd3uxBGg797RCVHh2MVGw9izgCdMzLC3IMbalyXfxzqiHiXGbUHQG
 aR4Fe2YIRUpEyHbj5VypVVxevkXQ153S3iTaXWthAxmjV2p9rOwvu/AxXigBDZZA4j12
 zA8yocMdIz/NW1uEL1M16AUy/x8U/XDPLLWNxzaGR3WAqY8LelLU4BhqCQDPATwYCXZx Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8vtc0y5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:28:15 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EBudau000403;
	Wed, 14 Feb 2024 12:27:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8vtc0wwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:27:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41E9pwjn024878;
	Wed, 14 Feb 2024 12:27:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpdssn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:27:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ECRPn220054748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:27:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56B820043;
	Wed, 14 Feb 2024 12:27:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2D920040;
	Wed, 14 Feb 2024 12:27:20 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 12:27:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: john.g.garry@oracle.com
Cc: alan.adamson@oracle.com, axboe@kernel.dk, brauner@kernel.org,
        bvanassche@acm.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        jack@suse.cz, jbongio@google.com, jejb@linux.ibm.com,
        kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, ojaswin@linux.ibm.com, sagi@grimberg.me,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Date: Wed, 14 Feb 2024 17:57:19 +0530
Message-ID: <20240214122719.184946-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113841.31824-15-john.g.garry@oracle.com>
References: <20240124113841.31824-15-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OzWX2STjmdBlT2OvLENkQJSFshfYk4zr
X-Proofpoint-GUID: RSF1EXPuEZ0h1L4vhPfo9aQTI-RvmULM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=849 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_042834_564334_862D29FB 
X-CRM114-Status: GOOD (  13.54  )
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

>Support reading atomic write registers to fill in request_queue=0D
>properties.=0D
=0D
>Use following method to calculate limits:=0D
>atomic_write_max_bytes =3D flp2(NAWUPF ?: AWUPF)=0D
>atomic_write_unit_min =3D logical_block_size=0D
>atomic_write_unit_max =3D flp2(NAWUPF ?: AWUPF)=0D
>atomic_write_boundary =3D NABSPF=0D
=0D
In case the device doesn't support namespace atomic boundary size (i.e. NAB=
SPF =0D
is zero) then while merging atomic block-IO we should allow merge.=0D
 =0D
For example, while front/back merging the atomic block IO, we check whether=
 =0D
boundary is defined or not. In case if boundary is not-defined (i.e. it's z=
ero) =0D
then we simply reject merging ateempt (as implemented in =0D
rq_straddles_atomic_write_boundary()).  =0D
=0D
I am quoting this from NVMe spec (Command Set Specification, revision 1.0a,=
 =0D
Section 2.1.4.3) : "To ensure backwards compatibility, the values reported =
for =0D
AWUN, AWUPF, and ACWU shall be set such that they  are  supported  even  if=
  a  =0D
write  crosses  an  atomic  boundary.  If  a  controller  does  not  guaran=
tee =0D
atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, a=
nd =0D
ACWU to 0h (1 LBA)." =0D
=0D
Thanks,=0D
--Nilay=0D
=0D

