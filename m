Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFBACD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQaBgm+w2IN+RG3ZCaGq5IQks1UT8XqVIkBR1qHuMbU=; b=Ho3Mj9M+JBYY4lFkwTGiBoGW84
	Ll1k2L7d5nglkvhhG8iTFIhlH22JK4ycNn8wxw9ipyVFMbPVJHWlwINmwGXMJvkq88KadGj39Kc4P
	v+SY0vdQWwzWyIUMSOFQqEkm3diJExM6Dw92qhZ9B49vEkpHNeWUOWoHdlcRd/aVV5qtVs4A6vgV+
	hfKSfT9sTvgBPHnzNrjHrgOUOkjtSq6pkmqfImrW8LCeA7jIkobpxunuWCyuql/ieKiq1uRJbH+pe
	Yi+DiFw3LVxnHb43jWjYMKyKBgSKsu1RZ+CDj3TU+TP21QAqRSv0DzeDiM/0tQCXNfw/8mTL0TsfI
	JhLHo7dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7YL-00000003O3l-1S0H;
	Wed, 27 May 2026 06:15:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7YI-00000003O3J-3eTb
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:15:40 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4dU3735816;
	Wed, 27 May 2026 06:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wQaBgm
	+w2IN+RG3ZCaGq5IQks1UT8XqVIkBR1qHuMbU=; b=I3hDHzw6OV1tCexnJhZFY6
	fXd+wKRT24kGiJFIBhZi9+X98KP/ZlGoqoCkxPQORZ5emLc58jqkQrt3tP/Wu+d/
	C7vGu1S+ueKFWuvHLNnAGkwhECFg+vecHVg+670qsWeu/1r9ZBeQX9HY9q8YVcvz
	hPR8S3AFo25H503YTC484luEmuQU3mfuC0qULI7xeWRV91BC9fmNplF3zV1jrgng
	eAteseWhgDBJuURiHjn+Nb1pWETsTohMfpXRO5M9dQfcPKgktDBeHE/SMcOJgKHu
	/NB/vLFVwK/UOVFQ8o7liNE2JTn0aTXyH4Z7jcmrLzkRgcHUzmVb1A+AegM7HsaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc6nvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R69C0E030435;
	Wed, 27 May 2026 06:15:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1nbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R6FYmi4588034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 06:15:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349BD58055;
	Wed, 27 May 2026 06:15:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3E65803F;
	Wed, 27 May 2026 06:15:32 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 06:15:31 +0000 (GMT)
Message-ID: <2a604079-2fcf-493b-a514-9f351badbada@linux.ibm.com>
Date: Wed, 27 May 2026 11:45:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-3-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260526153921.2402015-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a168c07 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FLEIk54Q6ZzNztR9B-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 73zkKmA_qBLjSMqdDprZUPTbRwAbIBCn
X-Proofpoint-GUID: 73zkKmA_qBLjSMqdDprZUPTbRwAbIBCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1NyBTYWx0ZWRfX80VLGnnV+qSb
 o3S5QTk8T1gZYwn06y35K+n6ZR+CVJ9Afwm4fj2ljKrxZLiLoLMAYianaVCxt453CxbQvYV65nz
 SU1K4UUE8l2iOxJzKka91HAZx1kKOpyJwNZEPPnr2ucXFqxQQteCGYnLXVbRna0NY9V8KPpZKu/
 VkjDNKkSn7+jvY0bb9/CecYz6KkLPkCeLQTLWlYgoeB5jFiPmwg5HdPeDoqxJwIaMqRcxHrfOyH
 PqZnbxgethetgkHtPDEMz03E0YJzdpe+650ATWbflf0endtPpCE1AfTSOABQk73EqoNLBvZdiM5
 Aqa56xqZ1zu5wjyZrNCXZyIzMe8EsNvmCh03lzs3VvMRC2dIduWz29X8vqJkJX13t7eO7fGxBRr
 +c/xjkCc0GRf8nxy3Wz42ciTWM0ZWuXncE3KFnACZu40Rqm+eoKx+0KHTX2zlPSiAmXs3bqSZ7v
 bRhPjXnqZZXhLHiBceA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_231539_035611_6899F98F 
X-CRM114-Status: GOOD (  10.80  )
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

On 5/26/26 9:09 PM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> Don't skip io accounting for passthrough commands if the user enabled
> tracking these.
> 
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---
>   drivers/nvme/host/ioctl.c     | 4 ++++
>   drivers/nvme/host/multipath.c | 5 ++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

