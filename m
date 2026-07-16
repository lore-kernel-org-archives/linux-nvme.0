Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C6C44512
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lg0fKccqfEnzwPCKm65jsM9/nIHTBN3S18vdQ+py3HQ=; b=aKc3beDElIdUudbociyoLjwVtZ
	HWItVc8MrQSXqFiAg1YxGzak9T3p+4ROPdhkOba4QJxrT9m5tgzlCMSMtURRNxr2f2Wg51XHvSlZY
	4ICy43GxzZd5s/awINmVkb4diokoOH8x7Y884odpIWeiXfBP02tOuQNpV8Tb3qSdLm85yPpx2jVt3
	5wOWeOHgCJ8uEAT2BWd4Ryah97Ef+09jK2HmBGXWir/N+I945lVlY4PBPN5oa5dhji/7EXWPVxktY
	yDJKu82Nj7WbMe2VaV0nJV5/RATgECltPrFoZEBoUsX7MpQTXMWMUSFiRgZVfe//ixxiLe15Pg7kp
	ced+b1Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNcT-0000000HZsq-25mF;
	Thu, 16 Jul 2026 15:03:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNcR-0000000HZr1-1KIu
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 15:03:24 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfdXG3359867;
	Thu, 16 Jul 2026 15:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lg0fKc
	cqfEnzwPCKm65jsM9/nIHTBN3S18vdQ+py3HQ=; b=E1uIi/qkpWoRyP4n85W7oX
	ZhjzJXasviUZhbKMDFJwn1cWBpov4E+clx8Ja59xRir1wXOy7MYDYwNb3kAnUv0i
	FE6uDAg2fojgTELi3qJrL+OW3Q69YI8uM25ulDD+j4XF4bhk5MfQVyAP6mV1T1bM
	CAteUftPKrKBsBeN3bUaf+OSU+MDCagSx4yJ/9tpZCOG+UmzSGe5jlfoN0zdQpV7
	NnM82rpZQ9ORyJYgiRxaFOpS5r9exu9ml1h1HQSMMtQ0/qMDxsK9LMFMKAJ7oS0y
	q4/WPbnfBK9cBtiwXRp3rF2y4znQrqDzzn2tLL8UFzmh6kA6YjvMawr8maJcRhXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxsgkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:03:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEnZ8P032507;
	Thu, 16 Jul 2026 15:03:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdqn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:03:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GF3DT465339756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 15:03:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F2B45806A;
	Thu, 16 Jul 2026 15:03:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7C45806C;
	Thu, 16 Jul 2026 15:03:10 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 15:03:10 +0000 (GMT)
Message-ID: <01c56065-b785-4cc6-87b7-47a0078ebc67@linux.ibm.com>
Date: Thu, 16 Jul 2026 20:33:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: fix cdev lifetime
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
 <20260713104238.3034640-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260713104238.3034640-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ouXCiUIHfhhGam0A5Kdxm8y_vE94NtBA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX1jxmZ8KXuX+h
 FbwXakIcVzlhlzbekQ6AZJPnlpvdHCtWDyCzPvQjI8qlnjzAeWqqW3EOROfm9ry+6cAUiehHEyT
 KJLwqF68EuEw6WDwxoi3tltPSV/EuHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX3fmp1xlxBsPB
 DnxIJ6L96NCsR/NbobmEp/r/6otOkhu0Umv7i202JEgmjPF2nXFLJyMTU44jR/ufGaYyxeddGz7
 V41PVi2ELqn2wXttkRN4t74fNjsETWLU5bqZBBvAC0Lsuz0Qso6d4RNNx/oB3GeiKdbYPnbJQxB
 yArVuVctyctNGFPsyU/A+FUqFcBb1KGM4cIvKp60Gqm3Nz0zT4/fUmR9a1yg5G8WeofPjESpvqp
 pNNnPUBDrNRkrfO0JSGsyPPUcfTgF6pqUseaMiCpgMx3rRsjaWd5EHXnC6DBNK8MbCoq+M2z4gd
 zqyu1JTO2DxDdOkjDdAA1d64Hn9hGtCOWTUaNEmR2zGfrM+dG4ekHhboS5AX0vNr+l/HlTfcugM
 0aTPcbHUkNmrQMiZV8/dbwc5k+JdJi676biJz8basHtWpA71m56q71dq3ZmS8Or5IunOBn0ohUZ
 8JlqsvyVFE1XotsWPhQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58f2b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=tfFcBDwWTW7q6L8D75MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ouXCiUIHfhhGam0A5Kdxm8y_vE94NtBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_080323_378795_F1D80CF2 
X-CRM114-Status: GOOD (  12.99  )
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

On 7/13/26 4:12 PM, John Garry wrote:
> Fix the lifetime for the cdev by making adding the cdev add take a
> reference to the NS head and drop that reference in the
> nvme_ns_head.cdev_device release function.
> 
> The same problem exists for the NS cdev lifetime, so resolve that issue
> through a similar method by taking a reference to the NS for the lifetime
> of the cdev. Note that nvme_ns_chr_open() -> nvme_ns_open() also takes a
> reference to the NS. Now that should not be needed, but that code is
> common to bdev ioctl, so keep as is.

The bdev ioctl uses nvme_ns_open() and nvme_ns_release(). So, IMO, you may also
remove nvme_ns_chr_open() and nvme_ns_chr_release() methods.

Otherwise this looks good.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


