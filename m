Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410F7C25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOJZuXsx4WknfSAcptYbLpmuX31U5QNyWTr6zckvtog=; b=rNfO+3Z4+V0IjLhnFVIErcaJqK
	DGqaY/GQRG9KgrApUe3J5HW/OTVqABKGEMji47BoNsxSxpKEjKFdyrGLs2eBKEN3dDMP6AZBSB2qS
	4SRDP777CyOnOe+Ul72pn82EVOeYuYUUy6ehMlXfTPBmeLnH4Cwh1SnfJNikxDiKYtv9crcE+XhJt
	LuK/F+m2MoiRADeB/78Pr6tmfHDYTMLmamaNye2icxnfQKRSr5G8/1+4YZaIT57A9H6OqUHOWn3ce
	/XYBeOjWujkJJQVjevvvA51W/ySlGNF893TKXkCfOrI5fH2JhSzoPKJlMLZktpY2hQLBR9LHcrc4B
	gxAYVKXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lc8-00000002zqh-0jYH;
	Wed, 22 May 2024 13:02:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lc4-00000002zpS-2Kg4
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 13:02:38 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCQSF3005370;
	Wed, 22 May 2024 13:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tOJZuXsx4WknfSAcptYbLpmuX31U5QNyWTr6zckvtog=;
 b=MY1OL9lq91ReNPblnY5/UTkUEDZv0bFHkWgyvDhkVUROch31OGzIvJmscnV2XA3IZAit
 xm1EFB36maXQdWhxN/M9JSEhlw3ZanK/rH2buKMtzxcrTZiwOPisejp08+94inoaUOMj
 pw8hE/Ni6RfWS3pfzc2gs1kFANkeX2vSUux17lRnl/eF8Xa42LKzyHspV7/F4GVGU5Pj
 EUJSf3k20TMSBZwI6fZfkXovCaYt63kUUsC+ayB1sYuwtwOjyS1G72iYP9y+Ah4WSrtd
 RGK3X339vXf+xj5mw5ZQjB7CHCwK7XgTI3/vdY8wTRbTLKqA8i3LignX+idLSSvDuIRU RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9gc5856n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:02:20 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MD2JZo031182;
	Wed, 22 May 2024 13:02:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9gc5856f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:02:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44M9uK9j000878;
	Wed, 22 May 2024 13:02:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y7720c77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:02:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MD2GoF23462276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:02:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E72045807A;
	Wed, 22 May 2024 13:02:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1E0B5806D;
	Wed, 22 May 2024 13:02:12 +0000 (GMT)
Received: from [9.109.198.166] (unknown [9.109.198.166])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 13:02:12 +0000 (GMT)
Message-ID: <6e01032f-c90e-4f7e-9339-d2782fd60e3f@linux.ibm.com>
Date: Wed, 22 May 2024 18:32:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
To: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc: jmeneghi@redhat.com, Keith Busch <kbusch@kernel.org>
References: <20240521180712.2423165-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240521180712.2423165-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7nEORNEpPFv5m5TDL2e4XOZjMik-xn6Y
X-Proofpoint-ORIG-GUID: 4uu0IZjQeQb8Zt97gIBLjqL1VdQQYSKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=861 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_060237_084519_CAA08462 
X-CRM114-Status: GOOD (  15.07  )
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



On 5/21/24 23:37, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are io stats accounting that needs to be handled, so don't call
> blk_mq_end_request() directly. Use the existing nvme_end_req() helper
> that already handles everything.
> 
The changes look good however I have a question about why do we retry an IO
when that IO is cancelled? For instance, when a multipath IO request is cancelled 
(from nvme_cancel_request()) we re-queue the bio in nvme_failover_req().
Similarly, for non-multipath request, we do retry request in nvme_retry_req()
until retries for a request are maxed out by nvme_max_retries. So wouldn't it be 
appropriate to drop the cancelled request instead of retrying? 

However, I do understand retrying a request on a different path when we got the 
request completion status specifying the path related error.

Thanks,
--Nilay


