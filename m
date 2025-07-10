Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A3C83F09
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jul 2025 05:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AvMH84qBE5GCm9uR9TayaoG4QyZk0jcQyCZthSAENPg=; b=WBNXwvN53LrTO6mfObz6NuUVnf
	lYGL/MSt1CULv9lGG6fNk3QtfaBeQoSQqovd88Uy/ke2TuDzoHTHiZDU07pQqir5KMAIPvfaxChQO
	IQHvqWbWaYpjKg4cFmaQYzGmWjfr+fvSAi1OEKkWeMk46/KqXh99LdwJM4/bTLsHPYPuvHHofyLxD
	Zuyl0H8a1j5xUZtdzK2LDPi87YvrZqnD1NON6nRi105nvce4I5qFdXrNlHIPxNJQKFk1UBa/xLm0S
	JlMWlNdjL35ZaghaCuEJdD/4L75j+9+FNWueMlbqTcVRBFrqckP00okCUGyB9P+RKAbezVLWsIWSQ
	PENpVkOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZjVM-0000000AhYE-1eCK;
	Thu, 10 Jul 2025 05:07:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZjVJ-0000000AhXN-1pEP
	for linux-nvme@lists.infradead.org;
	Thu, 10 Jul 2025 05:07:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Ms1ne011211;
	Thu, 10 Jul 2025 05:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AvMH84
	qBE5GCm9uR9TayaoG4QyZk0jcQyCZthSAENPg=; b=ReICOneDcM8p5im+J8NC/g
	knFqWgERkAE3hcSO0xInki6qjWLD+sWArbAX1XpUO76r2wagldfDVIv301/1/QEi
	3XG1+sy+7nykGzBqLl2U/xpbMz1E/TWcmerH+L9jTRu3yj3oGNhw6CfZUQ/RTXXs
	fwtaSZijFf2taqDqnkfu6xRxlhYKYC662KGpGGXCivjznsMRA+5QwsTiMStiOX6P
	09ph8duPBUj2CNHDbd5rbYAKwiVoDEbFGuOuAiqKYp2neFd4aEaRFsgj1F6GIhNu
	gzxgP0tn8BKkMs4mk4w+f/55B86WL/xwN4LAQwT9CRzU9jD7lv3c6euk/Aaf1bLg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnhpjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:07:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A3Frde024277;
	Thu, 10 Jul 2025 05:07:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32knhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:07:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A57NJT29688508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 05:07:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACFA158045;
	Thu, 10 Jul 2025 05:07:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1123958060;
	Thu, 10 Jul 2025 05:07:21 +0000 (GMT)
Received: from [9.204.207.151] (unknown [9.204.207.151])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 05:07:20 +0000 (GMT)
Message-ID: <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
Date: Thu, 10 Jul 2025 10:37:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aG7fArgdSWIjXcp9@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686f4a8d cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=RmKR18SSKyEKqrCuxJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _O4R_Qh21PqzV8-PSyDBTaOw4XqyJAW2
X-Proofpoint-ORIG-GUID: _O4R_Qh21PqzV8-PSyDBTaOw4XqyJAW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzOSBTYWx0ZWRfX0liXGqYKcM62 h5pMCO2VuhK9X1AQm4xFrKpAPjtLGMgtLBoeA87KTgqTo3v4eO1h8NpyUavHDjS72QSe/IOsKU6 FJos5bd/wK5/damL/E1rYpLC7FcVRuU5y+C+CBhgKji85JTcjexh8dcYP+uzCXqfu1hOOdS6o2c
 vvH5QGwptIjxTtq9HHNzAjEhOZxs7NnYgsIbOnDv36lC6gWHlC12g6TQaYnyjqKgGoovCy8eGa7 zhCTGRDu7PR3fMyQY9D4g0OFMEqARtunyFO27vtTja3vruoHsrp/eN2NPQX0LsJ/uSGxdszg1P5 aolUJESrYOa9Sz8gJ6QrYJKJ/cWcVssmMb4ryIeFT1btsEbDRTQLyRWL2uUiq6IJUkghG/GNH5N
 oOvEPUulju6zX6GaXom7Jv0TRR8hgpgDGHDpymJkJ7kkNIObku+iyq5SBoBcjNEVuTGmbEMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_220729_596227_3D51D222 
X-CRM114-Status: GOOD (  25.95  )
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



On 7/10/25 2:58 AM, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 01:21:17PM +0530, Nilay Shroff wrote:
>> I believe there are multi-controller NVMe disks in the field (including the 
>> one I have) that do not exhibit such inconsistencies, i.e., they report a
>> consistent AWUPF value across controllers and do not change it based on 
>> namespace format. The NVMe specification states this (quoting it from 
>> NVM-Command-Set-Specification-1.0e):
>>
>> "The values (referencing AWUPF / AWUN) reported in the Identify Controller
>> data structure are valid across all namespaces with any supported namespace
>> format, forming a baseline value that is guaranteed not to change."
> 
> I don't think that's a backward compatible requirement. Controllers
> often rescale these after a format command, and it was the only way for
> 1.0 and 1.1 controllers to report atomic sizes.
> 
> Lets say the controller can do 128k byte atomic writes, If all
> namespaces used 512b LBA format, then AWUPF would be 255. If you change
> one namespace format to 4k, AWUPF scales down to 31, yielding a
> sub-optimal result for all the other namespaces.
> 
On the multi-controller disk I’ve been testing, each controller consistently
reports an AWUPF value of 63. I created shared namespaces with mixed LBA formats
— some using 512-byte LBAs and others using 4KB LBAs — and observed that the 
AWUPF value remained constant at 63 across all controllers and formats.

This implies that:
- A namespace with 4KB LBA format can support up to 256KB of  atomic
  writes (4KB × 64),
- A namespace with 512-byte LBA format can only support up to 32KB of
  atomic writes (512B × 64).

So in this case, it's actually the opposite of what one might assume:
Users of namespaces with 4KB LBA format would see the best possible atomic write
performance, while those using 512-byte LBA format may observe sub-optimal 
performance, since the maximum atomic write size scales down with smaller LBAs.

>> While the spec doesn´t explicitly require that AWUPF be consistent across
>> controllers within the same subsystem, it seems to be implied. That said,
>> I agree this should have been stated explicitly in the specification.
> 
> Considering multi-controller subsystems, some controllers might have
> namespaces with only 512b formats attached, and other controllers might
> have some 4k mixed in, so then they can't all consistently report the
> desired AWUPF value. They'd have to just scale AWUPF based on the
> largest sector size supported. Which I guess is what the current wording
> is guiding toward, but that just suggests host drivers disregard the
> value and use NAWUPF instead. So still option III.

Yes, I agree — option III seems to be the best possible way forward. 
However, does this mean we would disregard atomic write support for any
multi-controller NVMe vendor that consistently reports a valid AWUPF value
across all controllers and namespace formats, but sets NAWUPF to zero?

Thanks,
--Nilay

