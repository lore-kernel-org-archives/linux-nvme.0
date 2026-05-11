Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1D8CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 05:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgKxGPpSdhzP6IlYOSe+S1yRrhXRbrG8CZWwUwVhrD0=; b=dT5VDG6O+XrI9FDPIsWw0v2OGf
	sOEIUoqJ3YntD5yicQokwWwJ5TaR5XXUsMgqi8p3LC3+Xmq+81EBbNcHJXGtEyogjxrCKYDOy3GCQ
	a6GgE1UU2NTnjMxM60u3DkldF0iWpMBfNSNCEpTPLd8hmzFt8m+Vy9eptDziZlI7Oq/lFavRYHIwV
	aAoKKPxjxZWj0huGnNP3g4uRx1uQA1Fwq/rZQBIB2bT6aoJjTAD4OIUYmUxNqmDnxyFOnnR/0GnSA
	VowGPBlArKSAHk1kezwGBdvUvkvdJqzd/sU3UozXCbyDOoBIYjbh9r+yXxTdSLgzf1M21LUZJfJcC
	JPAJKMUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMJTo-0000000CPbE-0b5s;
	Mon, 11 May 2026 05:47:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMJTk-0000000CPad-1sPC
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 05:46:58 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AHNiFE3570526;
	Mon, 11 May 2026 05:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JgKxGP
	pSdhzP6IlYOSe+S1yRrhXRbrG8CZWwUwVhrD0=; b=jDcs4nA/BX4Ls+rgy/I4SO
	s172SkmZjRE+kLnrf78Ht7cyDJY9Mypc4dm+v55E03eZAVTGKqQALaHpzalap77C
	QL5WPOh+WXzDgJFFbyCde8Qd3xcI8ysBsPfZ64M8GEy3a4CVy9LZdKT+0kGjqDm1
	I4zeSUjbjjxfQafKHpdj2Pth8twCmcsZe7m3xQvUHpauzVMp3pEfD/9FpXSv9AoL
	kLCtw3h/4C3ZjNTDnf1shKJDHXyQy/P3omcB/HdZdDrAfWAV26cVMvmuwslnDOL2
	FAsSUFZuqYkijypP8Fuc0beCjHcLCQz7D9OAijb0WIrqUGtb4JKBcLWrPiQFq5iQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju67rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 05:46:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B5Occx022194;
	Mon, 11 May 2026 05:46:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvv04x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 05:46:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B5ko9D30474784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 05:46:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81D25805A;
	Mon, 11 May 2026 05:46:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6733058054;
	Mon, 11 May 2026 05:46:48 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 05:46:48 +0000 (GMT)
Message-ID: <5a9092bc-872e-4c12-904d-054dcd7b2379@linux.ibm.com>
Date: Mon, 11 May 2026 11:16:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
To: Daniel Wagner <dwagner@suse.de>
Cc: hare@suse.com, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com,
        wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
 <4eedc5eb-4e13-44d8-99ad-145494ff1156@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4eedc5eb-4e13-44d8-99ad-145494ff1156@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a016d4c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=ZOzq94BIP34y-jytqi0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m-EP-uyCdQ1IA55oSzVrbEA6FiEhHJEx
X-Proofpoint-ORIG-GUID: m-EP-uyCdQ1IA55oSzVrbEA6FiEhHJEx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA1OSBTYWx0ZWRfX9Oqe6UUGXJHr
 4Q9WUX04rsI0AcQPgEnaoqVaRQkj7DoaZqWfgg38/ML60cQdC3HLPg0pJ/ufIiSlxZzFwfajO/W
 6D1l+Z5gM+LPHhlyxngqtazM59bG85o6p0D/A3f642WUNdYdM7tzi9RMsvHdyQt1vc/PbOrI6Fk
 mzXipvqLaCETPMX067EVO98anKU2PxJOejLCculkr1ukCK8pV+012zCTCIrbAvohXIUE+NQ6n0u
 Xu3uRJhBhYOcbD5G3dlfiHjcvn2RJLNgW/9DoYbm/sG6zaGKU1gqfrJQHPH6X5VccmgTK4qFUfD
 SztKI6A6a3POv/EvQjDjWE8iuUlhgdfTSZuEWRBoFwF/KffaPMQZ4jsstBBOWlUWEih/Z8/uql0
 HGV9/4V23ri74y7chAx6SNSXVunA7zF+qaAyYO6mGYZ9aRdKE9kuPpt/CWe6MKqsqBlycjPFil+
 Uqd/aSuRkR6ugrcY5gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_224656_634618_E44CAA14 
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

Hi Daniel,

On 5/7/26 9:58 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> 
> On 4/30/26 12:52 PM, Nilay Shroff wrote:
>> As usual feedback, comments, and suggestions are welcome!
> 
> I've uploaded the series to github to run the CI builds and also asked the LLM of the day to review it. There are a bunch of valid points it brought up:
> 
> https://github.com/linux-nvme/nvme-cli/pull/3333
> 
> Could you look into it and update the series accordingly?
> 
yeah, I'll address those and re-spin a new patchset.

> And as discussed during LSFMM I'll apply it then and we improve/fix stuff from there in the tree.
> 
sure.

Thanks,
--Nilay


