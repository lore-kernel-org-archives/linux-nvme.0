Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930DBC87FD2
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2GWUsTDbFSH2QQsKj4axLmCHXGWtvHwtmulAuYElfs=; b=wDctCiYVaCMJELj7+gYZWIgat3
	JUDcTzRKLb25Ob/PoksYcWYj+sddbdwoqAgipeO3Iua7c+GYPG+iIxpGdp2x7GAEIYi7bejWlb2dI
	eHjmjRZuqyUKwZqugtXqXKIRqnr+8TKwaCZ4h4EFFyY0sZms5862ksBmDZoVhtQ27Pw1PEg+mdwGi
	kfF8T6bi7wM3c2Kbccp70QF7YUPth3sRB1q6/4vRqy9uqcUKPFrKIKbiFE9D0GjnOVk+dW5B6vBf4
	gnrZg2ljZ2BjC/sN7taxVwDoaP+VRnajykd6Mca+OwsoQWFUX2EZoky1krIp41IWarBj+sNsvOtpQ
	nHloZHOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujF3y-0000000CVZX-2GB6;
	Tue, 05 Aug 2025 10:38:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujEkh-0000000CT6S-457i
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 10:18:41 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754tFX9032248;
	Tue, 5 Aug 2025 10:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I2GWUs
	TDbFSH2QQsKj4axLmCHXGWtvHwtmulAuYElfs=; b=hPckeuIUkXzsxQleX2TGrr
	6wG8vPjcBfWhHZSniv2wNzfYwjvKvmUeTO5+5WifC0UO/oLTB7BN+6vyNJmC2GBL
	cqODGs27rau+IR/Z6jzTcd8ifSWVT6DbHJZCccKg4C69aMY3INvCc3ps7iWZIb92
	8ueoHPj14pN/L4OqzFxJq6443fi5kwZA3g/mXqEy4nJQujzBzmbbP2WI806eSrZr
	IEu2/qP7X7uz5ypZDp1gBZY1iJphLn1QMOU5MLqpfAebIjjJA+HycBb9e8a/a16m
	s6L70N+/4zXTCbfhz1ttTaTF7EYTZugXBChdGaRSUdTLfepPK4mQ0JmtHzcBjJdw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1amn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 10:18:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5758k5hu009541;
	Tue, 5 Aug 2025 10:18:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0p1xm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 10:18:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575AIZes15729230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 10:18:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26A925805B;
	Tue,  5 Aug 2025 10:18:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B930758061;
	Tue,  5 Aug 2025 10:18:32 +0000 (GMT)
Received: from [9.43.82.116] (unknown [9.43.82.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 10:18:32 +0000 (GMT)
Message-ID: <a5e50d75-bccd-416e-911f-ceaa15b36c4c@linux.ibm.com>
Date: Tue, 5 Aug 2025 15:48:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-list: fix verbose JSON output for 'nvme list'
 command
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, msmurthy@imap.linux.ibm.com,
        gjoyce@ibm.com, tbzatek@redhat.com
References: <20250721102946.1003295-1-nilay@linux.ibm.com>
 <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
 <cc396386-3924-4198-bc05-e1a3137d59b7@flourine.local>
 <9d5dfce1-4a6c-4b3a-af46-3c3d9ad67e2e@linux.ibm.com>
 <37b53f3c-8654-4a14-8c54-9179e7bf5a5f@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <37b53f3c-8654-4a14-8c54-9179e7bf5a5f@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QBtXcMzSme4EKGCRWa0NL5y4KFp3NEsH
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891da7e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=LxeeNMavuGCN3YOBJBkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QBtXcMzSme4EKGCRWa0NL5y4KFp3NEsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MSBTYWx0ZWRfX/vDqEMg9M8yH
 95yUExRmdF3RI9XSmvLY0KlL8dRqV8TRimcdm2rbLwY5aLD9WpJR7MQKFrt6tmNat6OwVgy0a3h
 7bynguX620MGjWippfEmlEosC72Pr+OUh+j3w4PCMKwdfcU707k6hwvs0VanGX7bRwVSrA1b7nL
 b2lk1++Bsug01QR2vZZuhNBRN/t56ZoDmMfWoXl7pQWPX6ITxQ5RK/gFzkNUalnlFqSbRNLlmdB
 m6L7SNwgAUlLVoTnLuboyhaWz7ISAiZRNwBResEFcL1ULwT17JVvpfZwMjI/mBrp4gek2R5ZwI5
 yjxXN06wqt0L0V8TSJFYY4Bkdt39eBR6YFx1xEAqUDzTvPWtQMIu5laX51DAOsp5qwAyJTsNq5d
 Wg4mTkbWvTgQ3ewptDq5VQPbA1Y68xsbml1NxODcB7bazWcbHX6NoQUMgH/HYKnu1xX4o5hR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=772 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_031840_487360_03DB0276 
X-CRM114-Status: GOOD (  15.78  )
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



On 8/5/25 12:57 PM, Daniel Wagner wrote:
> On Tue, Aug 05, 2025 at 10:00:53AM +0530, Nilay Shroff wrote:
>>> https://github.com/linux-nvme/nvme-cli/issues/2886
>>
>> Okay so does it make sense to retain the old output with the
>> default --output-format-version=1? But then if the user selects
>> --output-format-version=2 then we'd switch to the new output 
>> format?
> 
> Yes, the default output for nvme-cli v2 should be
> --output-format-version=1. As suggested by Tomáš we can set default
> format version to 2, for the next major nvme-cli release.
> 
Okay so I have made changes for ensuring backward compatibility.
The changes are on its way...

Thanks,
--Nilay


