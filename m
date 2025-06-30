Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE29C7EE39
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 11:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHdHJz5ysz9xPoq9mTwRGvN5YR/Q4LqY7CVC/9/YPeM=; b=Ja/z24voM/obn0IU+2FKtN75Qf
	c8FNZIWZwvXs3yvhNnaVWEGUs+c1z9x0xk2p+FkSTuT23FZXMy4At7cKJj3jnfmsDZ9+BwP0SiC9U
	GwWldMZXZP9twY5KXyCfBi0+7kuI7ZXHZi4ycmYdFi68RsjfGLfaiec4rX3ig0KoeujPU4iCi+mdb
	bIGIKdDL+D6wCBh37+qLagu3mWssBZUnhCa+M/GVKa7XcM1IMFMYhrTbq0/sF0Au0BMmzcvGQmZib
	oCUxq+3eMxqMgmfvKuB1h1jzIT57oxo703BeNbW4TwOTgejmJwRjMoJiCum87RSV7xUb/smYN7624
	B0HO0+Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWCUe-00000001zT6-36kz;
	Mon, 30 Jun 2025 11:16:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWC0y-00000001vvD-0V7N
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 10:45:33 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U0Xvvc029587;
	Mon, 30 Jun 2025 10:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bHdHJz
	5ysz9xPoq9mTwRGvN5YR/Q4LqY7CVC/9/YPeM=; b=fZXf5II8laijWo133DSNqU
	97wtr75ruB3RbtNtQKdsSARQBsz2inCGIMzWb6RJCfryVJAnY7r0O58/9Pqpw1aC
	7OuKFtM5KKFRZ8nQTGagqdnhFsMfgJulKWE437wg878TDOzmm5n51W8QmN3uD2ML
	oftziR/XDRIkVxCy9Fs/BaIc7lzo+Rxe+Efne0Raji3pcTPze4WjUc3pRFOO2ZQr
	LYQtzeBaQKbZSNStyhSs33J0WrvJf8VAQoO9k8AjcTAeDgPCJ6lxc3zH3+duCZ9X
	J0ge0wmZtbYBM7z43nqreupmv+vFGkhc5YyL/1sxmHF0Q0FH0gGG33Z3JQRxj8iQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830gqvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:45:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6M4nR006928;
	Mon, 30 Jun 2025 10:45:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm593f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:45:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UAjFpL28508882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 10:45:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 040355805A;
	Mon, 30 Jun 2025 10:45:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B137B58056;
	Mon, 30 Jun 2025 10:45:11 +0000 (GMT)
Received: from [9.43.10.179] (unknown [9.43.10.179])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 10:45:11 +0000 (GMT)
Message-ID: <663d6aec-3c94-4180-ad23-c526d4a19350@linux.ibm.com>
Date: Mon, 30 Jun 2025 16:15:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix suspicious RCU usage warning
To: Geliang Tang <geliang@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org
References: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 44NWvNSb6j6B62DpqnXfhoOMsvgDkhaH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NSBTYWx0ZWRfX4QUSeLy7TY0Y IEPb2KiFKy1bZ0MrMf9OUiByh/X52J31ujlpMQq2U/OHGaQYCAPQBC1RQuq1HdlER5YTCd6hk8R OJ4URCXvQlN5FRnTG4No+J7Xohf9aXqPI386ADoVtDXJuq+QabHhQSkVu6+L/+nyVP9jKMrUOZY
 o+XcFY17Lp0K2edwIrs0ldP1GWKYb4Clzl8tE2dJdJ2aUHayjN5NLRZmrcZC8nQPBIshfwY6pVn s7y+y0nRCLqbOpvEC4+9HHqOVUvXRcFsoyHH/Dq29Chl/VdRIPoPUjYd1ZODwqp3409lPnk/9BA yHCARR+5JeR8Kfig2loYwrvPeH3/LS++HqCdbWlYARUPdABy+xr4Mq8snTc1uSwHLHAqC8U70Eu
 TYYR4L4FIcq2sOGqZMvKxuGOMXGv0RaJaG03Oz1gSRWDSJU2O9V6jKgvjjGt4JBSfTEXY7MN
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=68626abc cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=B1-Q23LviioRdc4vKs0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 44NWvNSb6j6B62DpqnXfhoOMsvgDkhaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=737 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_034532_168961_9E237F7F 
X-CRM114-Status: GOOD (  11.98  )
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



On 6/30/25 1:18 PM, Geliang Tang wrote:
> This patch uses sleepable RCU version of helper list_for_each_entry_srcu()
> instead of list_for_each_entry_rcu() to fix it.
> 
> Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


