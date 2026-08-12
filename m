Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C8C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3qvV71eCKyUb01WI+/gvPzpgMcX9TfTnuF6jIrXGmgc=; b=JYaLHzpL+lzrfmxuwP+zVPNlKF
	n6y1xeOewPzmdyeS9bUDOuRhHFkwuVSP0xbVg4KKC5dvhA08ydVEUyWw3a1xMXUG+g7CMuZJ3YSRD
	+mM/39HOdekekNcA+UPMETOGYlR3jUIdJhaCuX0GZV8/YvDXxF+W009MW3Q2hFePLASi4snrZ8UIU
	PEhXwPTt6nLbf1I07zcgmo+l8whg4SEIWRd8yC9aPaeLkBGqUvxQDRXWlVY55ANbHchk0x5LLYjTH
	6yTuD7UrrQV+lm707/5n1oOdUmqI4+7SOv8vpbU7qmob0ogyRIpauX0jnAMGCtEJFu+UHUJL4DdnY
	j8H+a43Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuA0I-0000000GOku-4538;
	Wed, 12 Aug 2026 14:32:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuA0H-0000000GOkU-0Lvf
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 14:32:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1wo33594490;
	Wed, 12 Aug 2026 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3qvV71
	eCKyUb01WI+/gvPzpgMcX9TfTnuF6jIrXGmgc=; b=rOFZwuwgzIjRrWgjJOKhMF
	Oan+IRn4jkwFBSPufUFpEq+qZdRtR/RYeEfraHz2wU2iBowCv01QnKxW5Wu1PmcN
	bGd9aUICvlDh2yiAV96ylyn7ToQLoU93bQacCn/i99OB9jX6BfHBhWOo4oEZxkAz
	l6VAAjlbqlFBoegqeRGm7hBndHRdufP3akh2vprzwqgyoGnJYDzKyI/XunjpQjEq
	IK09OrZsbYhhIBj9/Vs7x1/+S8tgV4sw4zW0gTAXTecuSVzp4WuVJgl4h0AjDqFl
	GzuL/caymdPytWQ0nlmWzUuMIUZoqFKuNnLm3QB/dcwogSovDIbqHrv4M3z+i+lQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32401-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 14:32:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CEQcoD011580;
	Wed, 12 Aug 2026 14:32:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy67d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 14:32:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CEWIpL12976788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 14:32:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6826858054;
	Wed, 12 Aug 2026 14:32:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCE75803F;
	Wed, 12 Aug 2026 14:32:17 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 14:32:17 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 09:32:17 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@linux.ibm.com,
        wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
In-Reply-To: <0c8b8a88-8f0c-40cc-b6ba-59b12b8f555f@oracle.com>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <92d55da9-2cb6-43aa-8fee-51f2c86101f8@oracle.com>
 <936b1d36a4292c9501eec5a5df3d7b47@linux.ibm.com>
 <0c8b8a88-8f0c-40cc-b6ba-59b12b8f555f@oracle.com>
Message-ID: <47b2e26ba57947f21c70ba0c4bc8cc04@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c83f6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-4Vlp2r9S2EJxY58cDgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sR4Qwc6ehOWCgdAJMp3AmfhovJ3isViw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExOSBTYWx0ZWRfX+BrsMuAiapxW
 P1YCha3c5tBkayIdcgQXmzGhbZYOHgYEUy6QOr58NEsHE49sAgmR18SV5rGh4J2JwHPC9+FZcG6
 JUwFFMaDxMWCDW04qV6qh4nFGmD8brtuh3aZfPKr3RRyR5hzgAoVOCTcsm5e/JjykNmFTilKT77
 eFaDbcC1j3nm+axq+kB4DJ+fgR5HKOzqP5rZZ1KTUCGC5DguzpDX/sZqpaVdpzkaAgpPK02Bjxt
 tIJ8TEM4/8TCxkPKuL46hmF67QldppZdDmLUyIp8FHYhTjfv7/9wnYiIdLJs9zf/6ttV2aeRcNQ
 9v24kMhHqwJ3B7ElOyHk1qxmvAScDwovhtnqnP0xEAhHeVmIKX/ev49YiFIMeFexiOCcDlg/IHG
 i/ccXlFgzzY3puI0rGb5UwqInOBs2xRBMaqEEvw0naE2hqDyUkSm+C3L+caSMN9SucYh+PaIBSM
 +pv7ExPliZEzunx2BxA==
X-Proofpoint-ORIG-GUID: sR4Qwc6ehOWCgdAJMp3AmfhovJ3isViw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExOSBTYWx0ZWRfX4B1mwdVve3os
 7YCDeUjBqo/2RpaxRv1R0+PQmARNKjNcBIShayb8boN0nqU8NnnLUfo7eggHJouufER0Z9anD1i
 bqnCnJ3IYh7mWlW7LzE+hgiNRiAhTbg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_073225_268923_4873A11A 
X-CRM114-Status: GOOD (  13.70  )
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

On 2026-08-12 03:43, John Garry wrote:

> Can't the tester also just unbind the device from the driver, which
> does the same (as unloading the driver)?
> 
> Example:
> echo 0000:00:04.0  > /sys/bus/pci/drivers/nvme/unbind
> 
> For this PCI case, we call nvme_remove() -> nvme_remove_namespaces()
> -> nvme_ns_remove(), which removes the NS path and deletes the gendisk
> if the last path. Same effect, as I see.
> 
Yes. Both rmmod nvme and unbind are test cases for the tester.

rmmod nvme should not be allowed when the module reference count is 
non-zero. However, unbind is allowed even when the reference count is 
non-zero; it should decrease the reference count.

