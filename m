Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D6EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:Subject:Cc:To:From:Date:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CFrk7let83bVBNwsUVD/Ie2SkONdVXOar69FggpFX64=; b=fyoPxUxOo6bMQJmkzbzZ1ISCXE
	4EkNajaoO1P/qXwnvBpkur9upO791wP0yy8hGuJbAMR1YMvu49Th/xW58SEpOO67LQ+xkztYqGrhl
	rwsJ/S7G7NuBiNbM600ye4d+8E3exkkkFUuqZ8YmCLutW01BG1JZuLfOupOn/qkw2yeoA9E51I1lv
	FR6wN4k8TDUkvSKnyWwUEbL1Q+SdCP8ntzl22ePr5aiyaONOE7vVWtsdiebNGjJZFOuze8A+hVIj6
	R2qv5WyEOO51gz8H/kFW49WxgFiB5y+jw0nG/RBoO7Ni77JYgeFjSR0McPLSjaVPhQK53W32DDpzn
	q/sch9YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0DQP-000U9b-0e;
	Tue, 07 Nov 2023 04:10:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0DQM-000U8U-0U
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 04:10:47 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A72mQBP006460
	for <linux-nvme@lists.infradead.org>; Tue, 7 Nov 2023 04:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : message-id : content-type :
 content-transfer-encoding; s=pp1;
 bh=CFrk7let83bVBNwsUVD/Ie2SkONdVXOar69FggpFX64=;
 b=o/hbfj/K7rVkN/HlIsHNWicGL2rHoiHOho1mWoa4TnO3c0z8ta08CVzknXtQJOFXVcml
 htamDGKP138DT5ih7qnr3TXLVfRwIsiQ2b+fQwhQ8+EpYhS0hmeEbsUWJD36qCr9l70h
 QuoJRdY2X9y2swP8MzuawsdUJBfJvZW2yaVHddBSVAfVkdqPWb2OiWvd8XOXq8b6fQZx
 OhvIwOwkD3CJ1HkSVT1lAfvQSkl5Yz1l3kEcjQjh1fbxQ8hxACweC/duP9odPyNvM9Fv
 lIYjteIAKLI3xgqmwoAWivElyGFZJh5W/VvVsMO1Xhxazfm3Oxwbm9CoFFH0Eg8yYs9k yA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7cry23jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 04:10:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A72cGEv016959
	for <linux-nvme@lists.infradead.org>; Tue, 7 Nov 2023 04:10:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301nj9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 04:10:36 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A74AYo420513428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Nov 2023 04:10:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284575805C;
	Tue,  7 Nov 2023 04:10:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC1B05805D;
	Tue,  7 Nov 2023 04:10:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Nov 2023 04:10:33 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 06 Nov 2023 22:10:33 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: Wenxiong <wenxiong@us.ibm.com>
Subject: Saw I/O errors while delete/create/attach a namespace on nvme device.
Message-ID: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bOJ7BCA_w8p1ihayIcN4gBYimW6dEmdV
X-Proofpoint-ORIG-GUID: bOJ7BCA_w8p1ihayIcN4gBYimW6dEmdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=441 mlxscore=0 spamscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_201046_443315_632AC8D6 
X-CRM114-Status: GOOD (  16.52  )
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

Hi All,

I am working on new nvme device and found this: nguid is changed while 
delete/create/attach a namespace, we saw some error messages in linux 
log.

Should we see these errors messages since recreating namespaces or are 
there some issues in error path?

# dmesg
[10524.330156] nvme nvme0: rescanning namespaces.
[10524.338810] nvme nvme0: identifiers changed for nsid 1
[10524.343448] block nvme0n1: no usable path - requeuing I/O
[10524.480468] block nvme0n1: no available path - failing I/O
[10524.480497] block nvme0n1: no available path - failing I/O
[10524.480501] Buffer I/O error on dev nvme0n1, logical block 781402912, 
async page read
[10524.480508] block nvme0n1: no available path - failing I/O
[10524.480510] Buffer I/O error on dev nvme0n1, logical block 781402913, 
async page read
[10524.480515] block nvme0n1: no available path - failing I/O
[10524.480517] Buffer I/O error on dev nvme0n1, logical block 781402914, 
async page read
[10524.480524] block nvme0n1: no available path - failing I/O
[10524.480525] Buffer I/O error on dev nvme0n1, logical block 781402915, 
async page read
[10524.480528] block nvme0n1: no available path - failing I/O
[10524.480529] Buffer I/O error on dev nvme0n1, logical block 781402916, 
async page read
[10524.480531] block nvme0n1: no available path - failing I/O
[10524.480535] Buffer I/O error on dev nvme0n1, logical block 781402917, 
async page read
[10524.480539] block nvme0n1: no available path - failing I/O
[10524.480541] Buffer I/O error on dev nvme0n1, logical block 781402918, 
async page read
[10524.480546] block nvme0n1: no available path - failing I/O
[10524.480548] Buffer I/O error on dev nvme0n1, logical block 781402919, 
async page read

Thanks for your help
Wendy


