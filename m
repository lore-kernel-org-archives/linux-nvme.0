Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC5BC54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0wFRj+p4FBHp9GPgyuiv6IYY2jAPyyQrtzPd4uBVoOQ=; b=DqDt61lp5mXFEVa2XF31Y/YtWl
	vGB3WghPBBTVM683Jm4s/rATUvHri2d3eel54+/BZNgB/85O9bQtoUU+bZEpszQtYowiXZwFPrd1R
	aEZJeBZe4fQgbT8YfHPK8g2J98i9ye0sotGmeutWnWxp8Nnrgi0o221vvHEnx8rWjRLJ7qvLGZ2UM
	8OsiPGYmzfgcusITCASO98jxFCxLva830icV+5kZ8LVlFD7UPM4yt493KCEgtSErCvcHV7IlH1gaf
	4zhUqwWRuklZPwGEb7LIhtM4mFts218LDypOHXEr1TiUWxWXslgZb1ygiLX3jE7OkFy31oayMYwhI
	zjZW2C+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpgSW-0000000Brxa-2ydC;
	Fri, 31 Jul 2026 06:11:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpgSN-0000000BrxB-2bD0
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 06:11:03 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5HdUo853886;
	Fri, 31 Jul 2026 06:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0wFRj+
	p4FBHp9GPgyuiv6IYY2jAPyyQrtzPd4uBVoOQ=; b=lIEmq6f1E9oLIOKfYOcw+Y
	ySUj1zpk/dbgzLtbBkh0fR0rICZ/Y3pgizDOZYa6hwCz1AWSHrvrLEILqyMpMHPx
	4/nBDoRnxUYYBg0RL/uxQNVFsKa5yEi9I4zwjZVvBHfDm2INE1C1RhUhX73hvGUN
	zkgyXiGMoqJFxnb8sc2d8omKyMbr/H/C+HC+CTO5MBXpboaCzyRj9+U/WA0ghuiT
	YnU9+RwVEF7gCMMJKPOd519hLSpGblvblvgQBm9Fs4q+1ygMXpKVlMo0LiFO4Msf
	k+ghi/KgcaGIt7RWxZyVeLjm3KeMk22caTqd6jsjKFkyVdgzb5EQw9heHuNn41Zg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjjkeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 06:10:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V5uJBC025638;
	Fri, 31 Jul 2026 06:10:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwev4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 06:10:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V6Ad8D45416712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 06:10:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB94B5805A;
	Fri, 31 Jul 2026 06:10:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2645805E;
	Fri, 31 Jul 2026 06:10:35 +0000 (GMT)
Received: from [9.43.39.116] (unknown [9.43.39.116])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 06:10:34 +0000 (GMT)
Message-ID: <4a7eee2a-6b63-4a65-a522-ff04497a8ce1@linux.ibm.com>
Date: Fri, 31 Jul 2026 11:40:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: add helper for device lookup by destination
 address
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
 <20260727151652.3660476-2-nilay@linux.ibm.com>
 <20260730161521.22695fff@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730161521.22695fff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzNyBTYWx0ZWRfX2/2PvEAd5nnR
 6CPfzItEAjzMxQvc4md0sEF/N/PH45TtHMsirUhgQ5PtCpGGpMhuv9gykvt3YHVuGwquO2N87Ec
 4A3FUzDQxJgYlu+xp3RtfvK/KvROP5M=
X-Proofpoint-GUID: DenvK_pKDSC39pnJD23TFz6lakMiY3Dt
X-Proofpoint-ORIG-GUID: dUIDfTHkieRugOc337awhMmKZJ5W3V6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzNyBTYWx0ZWRfX4augOfr5YHIo
 4w4fWOl674h7l5/AI1BwNmS7id37kJIcLoTEr0DSwOlewg1AaLc1hq1ugSxZNJ0mdz79Et6ZWSj
 MG02gU3/RkenYmBG7+NyHj9RK2QTtvRMi4MGnemTl25yrBSZ06//0XJr7ahwqDeZF7dVsVer4Hq
 gMyXM8Ymcr5SO7SN5bfcSctroWwXQV5V6j33ik2JGcmyB1r5FIwVnDbrSNSH0S0wd69VvP30CcC
 pa5Wkq+ghaOGHRgMAO4Fs9V26ElMjvdRLhB5QVINxhEPuTQXD8wEZepxrCkPTrslZt34pmEITH1
 Oks/8FfeB/3QMLDMEPzafUncEBF7b9jQ75OjRGtiqVa1nxTWRK89re5gAbsu+/2cDuxdEXfhYDd
 T7KXpjBXyHWEErCnzefmz7IQuJlH0P7XVAUe+RUECW8VeSoevPExwK19X1LZm5ORuafXPmQXRml
 IX+elINv3jIhMLdY6YQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c3c61 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=fTXjkXMZjpTdXAl4l6kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_231101_897313_14052A4C 
X-CRM114-Status: GOOD (  12.40  )
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

On 7/31/26 4:45 AM, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 20:46:44 +0530 Nilay Shroff wrote:
>> Add netdev_get_by_addr(), a helper that looks up the routing table to
>> retrieve the network device associated with a destination address. The
>> helper also supports netdev reference tracking.
> 
> This does not explain why you're doing this.
> Please CC the whole series to netdev or write better commit messages.

Yeah sure my bad, I would resend the series including all netdev folks in Cc.

Thanks,
--Nilay

