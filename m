Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19DEC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6X7LJkr3npsZpEKhaRnpkTRKw7IxWQow4Y0JL/FPhLw=; b=WPtvMJkFnlJPh9xyFo5vUlHSBS
	zReojU+lZovqKepDWH/C6zXDEQQ7wSfzipj9VDOnv8bjXzNjZRjfHE8d7FZ6J3fbGKE05uYJgzgwk
	KuaFl76PseO5sp85WwyPVy59SZcJNmqCxKS5wr5bkRMNv50aXp2JaXtjILZAjbAdIN1ZPkUQsmLAj
	PJxEBlOuAwyLq7oKQt+EeKmRmjiBuu9ztsksodiZHFZP8MTOw16Y11risFViyIEd0Vut3vFbLIkot
	eJWkYjRuhycl3Jc4qO4gI4MlNSBoayyNQKdwdmfaF8sAfCinK/PQFaDdNAxzDH2Fvhj1p7mELV4fL
	SyAWjvNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8Wv-0000000BYRE-3wk8;
	Fri, 26 Jun 2026 15:31:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8Wt-0000000BYQs-2L23
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 15:31:44 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFIIZ83356041;
	Fri, 26 Jun 2026 15:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6X7LJk
	r3npsZpEKhaRnpkTRKw7IxWQow4Y0JL/FPhLw=; b=sRwEpxCwxGc7KRVCqFfcDE
	Rfuo8qPlobuJCq3lQr6hBGs7Ysvodovcu8H7ER93rGKNBGWd3kPbU1PSKmyvo2sq
	7b5SVrCcpHi+vb4JaA29ICEpgx3pXL6qc690W3F6j3gLJtMZSmlkAoLVVoRe+Utm
	IcSAq5GYSfN2LBNDYrHNr0egarCiN4SNHQ8OqL6ogmN1TXpOw6W0FV/E6I1VSYCG
	bwigKKO7HKHZ0M6LBM9pdQT3dYuM6OB5ykdeKBW46KR7ToqOIN3VIKcqKyfOUi6R
	/Z5kASPSNBMDW+XwwySlas7rDLzJraZJIFPYNv2jQVcRgFqrk76mLDc6PE+aE5iQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4yt30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:31:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QFK53s004545;
	Fri, 26 Jun 2026 15:31:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w03d5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:31:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QFVQ2r34865712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 15:31:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10CD658058;
	Fri, 26 Jun 2026 15:31:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DF0758059;
	Fri, 26 Jun 2026 15:31:22 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 15:31:22 +0000 (GMT)
Message-ID: <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
Date: Fri, 26 Jun 2026 21:01:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-15-nilay@linux.ibm.com>
 <20260626064916.GC11106@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626064916.GC11106@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX1wN9iun0GV/L
 00px3QCAxKwwj6BXcPFFp92+w/shn0/Duy3gxcuRm2LIzIvPb6LkB76NiIBulnVf2Td0CfzyqxR
 kC3B9Jv2nXOf4RnVIpXi1RD+zseWl7E=
X-Proofpoint-ORIG-GUID: R8kQGUhds-7UMn--yWbhi4o6ymzbEToL
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e9b50 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=-n5wGlbkvxvokmWffCcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfXyWmEmHgFDJKK
 Ue+byjYgqL8muAu5iroHOBjx239NP0g73KQAVKd1X+PxEpZ6KjuyI/qDclBwPa0FTfgtJufsE7Q
 wjwz/3U5KbGnlgpuEEz0521UX5gMuOcSm3nbwjL0pmIoXtpCx+nosMTSX9JfB4c9MzFCkP6/LjR
 fhrYIw8tpLRY1iKy/5glUeKUPcFtQJJBJcIeXIRIfGGIGFQKYTiKL+s5W0kXTlhCA174eEnYLCs
 R21bbzbZusAH5sTOF1EL9fhUHpB59Ce7u+OWAtr1lc0inFDAz7dEZiFOuPb7AHZ7q2uJFVO53qt
 jteb/MkULLs7Sqhrw7TxQbjD0fRZisDD+IDO9ZqVdjLEOwaVqIKU55khBucNxz4qiHXkKbi31SJ
 N/rgFay0wpckLuQUxQsgCNzjkThkwUCCjomWYRRAAp0Ue/PF1rVY4o98hOi1cULYMWA3TyBhZbS
 cdSTe/9rmfAVlfie/aA==
X-Proofpoint-GUID: 5L6l3PSFeMygQPeJc8pdrOH-6YPSaAr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_083143_624555_9EDC32DD 
X-CRM114-Status: GOOD (  13.91  )
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

On 6/26/26 12:19 PM, Christoph Hellwig wrote:
> On Sun, Jun 14, 2026 at 06:45:29PM +0530, Nilay Shroff wrote:
>> After adding Clang lock context annotations in rdma.c, Clang reports
>> the following warning when context analysis is enabled:
>>
>> drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
>> 	  [-Wthread-safety-pointer]
>>    972 |         if (list_empty(&ctrl->list))
>> 	  |                               ^
>>
>> The warning is triggered because ctrl->list is annotated as being
>> protected by nvme_rdma_ctrl_mutex, but list_empty(&ctrl->list) is
>> invoked without holding that mutex.
> 
> Does switching to list_empty_careful fix this?  If not, does
> list_empty_careful need annotations to make this work?
> 

I tried using list_empty_careful() but clang still throws the
same warning. And yes it needs same annotation to suppress
the warning.

Thanks,
--Nilay

