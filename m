Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51278D6EBE5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 07:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S162lEykbbUIwtjqTy60eSL+RFAw/ewG9cU7TZXYEH4=; b=HyvDQqgQ+N7cFZconzXGRXMLmJ
	w8tlfhPMUmfcpwsriiY1HK1GaCSaKf3zz1bhKhgyT13GYxD4ZNCmR5qEChgaYE5cQFfr1CG6eEKJG
	i01eClFbTha6BO410HEWg3HR7LyHpT3CRjPgOtI4oo1EKAZdUTXM0wZpusLVl24nbf3kVsI9xlvXJ
	FUukPvGLoEJbp4bFwfnZeF+SYyXOY1nJiWZeVjUUDKIgy8SDpMuFq4Y/rGkS8MXkOG5sOTKOGG/10
	EJD0v69jfafyEu4IN2W0qnl5VixVe7Ab8l1R3R9gQ5TStJmTfsosW3GwoauM1SZhYlKzB9XsD8WX3
	pmfZTJKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvqu-0000000H6oe-3DP8;
	Fri, 29 Nov 2024 07:55:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvqs-0000000H6o0-2spI
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 07:55:47 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASKUJfP026300;
	Fri, 29 Nov 2024 07:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S162lE
	ykbbUIwtjqTy60eSL+RFAw/ewG9cU7TZXYEH4=; b=DsakWj3TXUNFbpBE27Er1B
	9CrcjtkTju3xJJOKBQVlD01irkCTutcKFBKhxJAOYbOYHADx0cobYfBbx8FN4IYO
	Et8iQ/t3gLB8Ay0XRw1YpsCjc/cVxrSKq9c/c1bII5NpcNXqznZMwKzB/pi+Jjh5
	UGcLIM6t0IUoZAsnFt1ATevtxcUCSSFiHtuNZAC/3Da64wYuFzYO5ktjfudzmtLG
	v4+ZNiPnfIyVtjaJWjmsqIw4odOh0y6BEMvg0xgjq0/Rg5N+yhgEIsY5M2Xy2AsS
	kPB53qFX40pf3Yd5eR3qllOg/30N2jYGVCWloA7pYZKkyL52zYivZKL4aQCz42Yw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436ym5acvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:55:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASMQBrW020364;
	Fri, 29 Nov 2024 07:55:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gbffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 07:55:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AT7thN852560134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 07:55:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F8EE5805C;
	Fri, 29 Nov 2024 07:55:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC50558059;
	Fri, 29 Nov 2024 07:55:40 +0000 (GMT)
Received: from [9.171.64.111] (unknown [9.171.64.111])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 07:55:40 +0000 (GMT)
Message-ID: <6dee5d52-3fe2-4c3b-9eb3-47de7d7c5c62@linux.ibm.com>
Date: Fri, 29 Nov 2024 13:25:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SseiB5tslUBzSKGd-O-7-DSzefp6-zmG
X-Proofpoint-ORIG-GUID: SseiB5tslUBzSKGd-O-7-DSzefp6-zmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_235546_743265_8B717F18 
X-CRM114-Status: GOOD (  14.54  )
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

Hi Shinichiro,

On 11/26/24 07:49, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: 83781f257857) with the v6.12 kernel. Also,
> I checked CKI project runs for the kernel. I observed five failures below.
> 
> Comparing with the previous report using the v6.12-rc1 kernel [1], two failures
> were resolved: nvme/014 and srp group. On the other hand, four new failures were
> observed.
> 
> [1] https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> 
> 
> List of failures
> ================
> #1: nvme/031 (fc transport)
> #2: nvme/037 (fc transport)
> #3: nvme/041 (fc transport)
> #4: nvme/052 (loop transport)
> #5: throtl/001 (CKI project, s390 arch)
> 
> Failure description
> ===================
> 
<snip>
> #4: nvme/052 (loop transport)
> 
>   The test case fails due to the "BUG: sleeping function called from invalid
>   context" [5]. A fix candidate was posted which sets NVME_F_BLOCKING to loop
>   transport, but it is not the best solution [6]. It is desired to have a better
>   fix and the test case to confirm it.
> 
>   [5] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/
>   [6] https://lore.kernel.org/linux-nvme/20241017172052.2603389-1-kbusch@meta.com/
> 
I have developed a blktest to recreate this bug and also probable fix as suggested by Christoph[1].
I will send the blktest and patch later today.

[1] https://lore.kernel.org/linux-nvme/20241022070252.GA11389@lst.de/

Thanks,
--Nilay

