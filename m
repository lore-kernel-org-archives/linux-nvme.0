Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D82E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x1IRXRIx2mJv7v2yzC9MRlhJ8v3MLcfZai3/SUJRVes=; b=Y+boBGWf2JaZ9D7rkbgsXC43U1
	sYuxUIwUixMMk9YkkaYK7DDOhpgzbu+qIglYopV22jF7SgoH+KhZnjzhXTUgU32UrtD4DbI5VLWjo
	B9xisQFeCm2dDq5arEKbXHg/1WtjaLq9TuL5y63aDeK1fXRT7xcRtaT24zAyHnv7b4lsRgQBrBGQg
	dKPKfzRBsjwHfMvpa4zJ+RspnRAuYlIjiiXEi2Kji3j0ehSD1IegDoMXJuSsuJQ4K+QIY2iy3gC0D
	dTL/Spu8PY5zvR5U0wdcssbVVJl0RqZDWPZYK1KVhSW59XTVBlFHIIj8gEQN+gnsQ+LCyhHVTUsBp
	rH9lWA9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqJI-0000000BdV9-0dBd;
	Thu, 09 Jan 2025 11:02:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqGS-0000000Bcv3-27y8
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 10:59:49 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093qwY9005687;
	Thu, 9 Jan 2025 10:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x1IRXR
	Ix2mJv7v2yzC9MRlhJ8v3MLcfZai3/SUJRVes=; b=ZVCpJPPCvTQRKsZdWKt6ox
	yuqTTx+HiD3F5T8K/oNk6i1UujBeCWEXWHuoQ1lytCZZJzq2LoG82R9O3i0roK4J
	mF+No73hHtbijqD/pRJDZeswwne6oXYXDiYhLp7CgMvx5mswE2U2HHmIpsYTgeDd
	RPYk0MekNk0HYNPdFYfurvFVD/vqhovfQH5Vym48qCYZsx19kJZTs7bg3orDH+OM
	nPzqFJhTyYvBkD2aHcI5WbeUVYjDhPLcOdel7tAnESoYP1c1Cw57QnmY9y6jAL1H
	X6gTzlVxAr28wSu9NOs1+bnICsYQu1fapDxcRraAjfoU9+4yCPcezYJbcSSgIBlw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc9pkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 10:59:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509A4B4c026179;
	Thu, 9 Jan 2025 10:59:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj12cefs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 10:59:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509AxdmE31458036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 10:59:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7E85805B;
	Thu,  9 Jan 2025 10:59:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FA2158058;
	Thu,  9 Jan 2025 10:59:37 +0000 (GMT)
Received: from [9.171.90.198] (unknown [9.171.90.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 10:59:36 +0000 (GMT)
Message-ID: <24b6834d-e66e-4a3c-9ea8-9790911673d8@linux.ibm.com>
Date: Thu, 9 Jan 2025 16:29:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: remove unused variable
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        kernel test robot <lkp@intel.com>
References: <20250109063043.95996-1-kch@nvidia.com>
 <20250109063043.95996-2-kch@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250109063043.95996-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BuwGrRUutz_nB6ICxHkV4ebsK5847A7y
X-Proofpoint-ORIG-GUID: BuwGrRUutz_nB6ICxHkV4ebsK5847A7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_025948_552530_A939790F 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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



On 1/9/25 12:00 PM, Chaitanya Kulkarni wrote:
> The variable n declared in nvme_tcp_set_queue_io_cpu() was used in the
> original calculation when tcp target was created.
> 
> With addtion of commit bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu
> spreading for multiple controllers") now all the calculation is based
> on io_cpu and mq_map local variable is n is not, resulting in the

Maybe typo: 's/"local variable is n is not,"/", and local variable n is not used,"/g'
Otherwise looks good, please feel free to add:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


