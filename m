Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B37CC35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIBnmlg0TBh/Ri6uX8U2LEzh1zqBgfWstotLF6REUtQ=; b=SriPToSb8qb0Al9l3VvpzE7/7v
	DHpgIRsjhLEwD9MogfpjAMOEx7RROyGlki65JsJ0Uz/9xVliPPTtxoRXMMJu7QC0YvEopniCynhl/
	3jkn2suByCOQ8HVfJijnk4M6H5HrIX5KVq95EnHeyLVQFAP8/bNWMadJpMvp81nTlvayTlu+J6gQ8
	e0pMte9U1RWBU/dUGzTx358E7H5eVJUJ9Z/YKG2ze4glurgBY1r0riRGfIwiyTkSakcAtlF6L+tk9
	lNS31bQSvCqlMAJgKYWcq4AuzPOpbHgmMn4bZy7A59Jc/aIMhXY9JHyDeFXnEy0E0B5LctA2z3hem
	bp6nE2Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw720-00000000Nsm-2Bv9;
	Sat, 22 Mar 2025 22:09:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw71x-00000000NsI-1HL0
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 22:09:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MKaqZR004917;
	Sat, 22 Mar 2025 22:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eIBnml
	g0TBh/Ri6uX8U2LEzh1zqBgfWstotLF6REUtQ=; b=FLi7zmLVwM3QlNT+oQWt25
	G7iLgnUmlxzxEhlbmKmjTxYLBCJ7ueGnC6wr/ti5kywihyyvW/7dPy18864Q+hKh
	Kq36DhkZOzdl8mMIi3x6G4Hyb+tBhrZJT+8s562IBBXvx9ZuIPKHOumV1ehtutUz
	KtAE9xMKdsSDmgg3IwvN8Zv30QkxHxVunMrGY5M0/ltL2rZWVAmUMdhQMMnzuihv
	dZwOD1fBPq4gqxrPNwip0A5b0HHNe6BI0Ar6FALMzKhBS5y5zJyhtJY6aztlxRnE
	7QOq6ztTR46HNv+717ikF6hEwbXaJd5f5RosnmNrleUBS0AhJBzHGODKc4s66yEA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4cp07ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 22:09:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52MIhHtY008997;
	Sat, 22 Mar 2025 22:09:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45hn6tk503-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 22:09:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52MM92Zh12649202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 22:09:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCF7958058;
	Sat, 22 Mar 2025 22:09:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE22E5805B;
	Sat, 22 Mar 2025 22:08:59 +0000 (GMT)
Received: from [9.171.47.152] (unknown [9.171.47.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Mar 2025 22:08:59 +0000 (GMT)
Message-ID: <e51e3390-0f0d-4a5d-99bf-7ea69c63592f@linux.ibm.com>
Date: Sun, 23 Mar 2025 03:38:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com>
 <yq1wmch7sga.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <yq1wmch7sga.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4urnbvzEKj1_Op4fSdYktBL9wUYzYir2
X-Proofpoint-GUID: 4urnbvzEKj1_Op4fSdYktBL9wUYzYir2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_09,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=899
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503220165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_150925_479242_795A483F 
X-CRM114-Status: UNSURE (   9.78  )
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



On 3/22/25 7:18 AM, Martin K. Petersen wrote:
> 
> Nilay,
> 
>> A new sysfs attribute, named "delayed_shutdown_sec" is added for user
>> who wish to configure time for the delayed removal of head disk node.
> 
> Shutdown has a fairly specific meaning in the context of NVMe devices.
> Maybe "defer_removal_secs" or "delay_removal_secs"?
> 
Yeah 'delay_removal_secs' sounds good!

Thanks,
--Nilay

