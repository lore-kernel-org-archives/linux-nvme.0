Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3971FD6ED2A
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjZWeDXTjuOP6SQJrLE4fe1hyWtCkwE5C4ukO8N2bUg=; b=BaP7F85JUCnkPADmdsGg4BYBED
	7aDldSNG1QvRuQI/71J+UAmX0pgDc1Zg7ZZznZxZsG6ODW0r826ttnL+v1SqCvGkC1aQhLFD5P4ck
	Z5mJ8Xv9DjLcMlF/EObNlZmjtCaLqdw8pw0pnFTSWChMoX0/yxCRNbX64G4qbVlVceF9YhVkQo3Xk
	u/ZSqp+kz+jSVLjuDvcZgjML6GN0SGISLw2LGwuqbEo86Ny5r2p4Yu32a4/x22teG6+VgX2qn/WOx
	qj9Wdb7FMKKg2IKC0VuCKDMmERas3PVsddhE07M87zM8HN3KSq0wpnnmyAZjYfVYIeyHfh+IBnk/Z
	QhyKKJ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7Bv-000000006d2-1scn;
	Thu, 21 Nov 2024 13:25:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE78i-0000000061S-1VBY
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 13:22:33 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7AiZ5024982;
	Thu, 21 Nov 2024 13:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GjZWeD
	XTjuOP6SQJrLE4fe1hyWtCkwE5C4ukO8N2bUg=; b=ofU4XB7nUOQgv6Fpnh3/f1
	39sh4CDMh2Xj8uBr9yKmE1TEmRME2lXUbuCYwEFhKdUH9R9A3klrX/6jE/7zIyPR
	gS1sybtNwNc7J4dPD2PGQn+b/XTT2ATODrLKKMUQe9Fef2Gj5ntca4PNQqTrn/l/
	5fe1OotMYZre2aGUKvFLXeQgn+fVPXhz193sgl9tMrp04DhOpr7QeTjwOH9YbVpL
	FAtkJn3hhJmtm6fJ7mkOF5BkawDOEeJ1yEudetPINF+czhYmDls+rVQjSbSezGBf
	GZfj1dOPYeP+6eQnGTxskOarCIZs+XXPkZZ7M8fk7iItFeBNi5lFovTzLyt9l4Sw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2wc393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 13:22:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALDDFiC000626;
	Thu, 21 Nov 2024 13:22:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77mpnqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 13:22:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ALDMRnW39715110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:22:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D627558056;
	Thu, 21 Nov 2024 13:22:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0942758052;
	Thu, 21 Nov 2024 13:22:26 +0000 (GMT)
Received: from [9.171.4.248] (unknown [9.171.4.248])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Nov 2024 13:22:25 +0000 (GMT)
Message-ID: <bae5dde0-27a8-474a-8316-8c701efed2eb@linux.ibm.com>
Date: Thu, 21 Nov 2024 18:52:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest
 linux-block/for-next
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com>
 <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <9ea5ac64-283c-40e6-a70d-285b81c55c06@linux.ibm.com>
 <CAFL455kkKZ=E=7XB34NjjH8SC3QuHnwityJABRxFNf=vJNMoLg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFL455kkKZ=E=7XB34NjjH8SC3QuHnwityJABRxFNf=vJNMoLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZszoG456EebkMUUkoqn-ReLBDjGvQUTP
X-Proofpoint-GUID: ZszoG456EebkMUUkoqn-ReLBDjGvQUTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_052232_400796_64C4F579 
X-CRM114-Status: UNSURE (   9.20  )
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



On 11/21/24 18:27, Maurizio Lombardi wrote:
> čt 21. 11. 2024 v 12:11 odesílatel Nilay Shroff <nilay@linux.ibm.com> napsal:
>>
>>
>> +       zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> 
> Question, isn't this equivalent to page_to_virt(ZERO_PAGE(0)) ?
> 
Yes that would also work.. This macro maps to the same virtual address 
for the zero page. 

Thanks,
--Nilay

