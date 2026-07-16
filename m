Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E877C44512
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtqHyIkihXoZLO5678mESSfCBfY3aCVcC9Zn7ONeKYw=; b=2k6HN0U+t09h2mq/AEeLK+c05J
	HNA0SnUzQSpC5s35yTqFYtdGMJxECCl+IhzOthsaXXTHtaTPq54tQD9hbbVGqQe1EQIGUJypzJiB2
	9yK8rFahO0Zrha2ruRwtIM+3fECcJ2XBcAqVmFlcuXf7XQT6KE8yIGKh6ib5dA5/bShrwG04AMZ9I
	9cwWK4anUzGAZ/Fu3HVQiHy5KZmY71h6c+Yka173xbbFuCRYdsTRrcdiMCWRO2AdCdw1iT86O0FbJ
	EwGBxZcshCYQfSJV99ukq87S2ONC5FcvEvL0uOKroMHhhD6dlm+b1veChhEFhDMw0fGO28o1gjPYu
	A5sEUzJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNdG-0000000Ha7G-2sHP;
	Thu, 16 Jul 2026 15:04:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNdE-0000000Ha6L-0qRU
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 15:04:13 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfhMk3273407;
	Thu, 16 Jul 2026 15:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mtqHyI
	kihXoZLO5678mESSfCBfY3aCVcC9Zn7ONeKYw=; b=i1YxmjBbBKgaIZJ7/eMffw
	arof6OhDjeSRensljZ3V1yArkInYgKAErs4fV2yuiHxF3BgqWfPsa21ehTBIsbn1
	ur/gZ1t/qZRZ4wOxsL3Y2OAZROHu7ktQoZ+4dP9D0/0TRWN3CBG1e3Yg8A3zLxlZ
	R3z++om2o4SK1e8WxiWDi8F7RyAft2fuG3Sh/do5uzmz+yUDyU2bRMos+Ejc/73u
	kIjZJ42eOMRP4iok5EE8p5N39TFqHaFojZKltzP/Mjx1l2MAXL37iFyveUAbZMP6
	8m5xLkM/KZRk4pMSjEvCyQWa2BbveaQRYz72bhXxji0TFs3s6KIr/Sf4ABGDjYyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx0pws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:04:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEnZt2032503;
	Thu, 16 Jul 2026 15:04:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qdqse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 15:04:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GF42UA394068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 15:04:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76975805C;
	Thu, 16 Jul 2026 15:04:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B5315805A;
	Thu, 16 Jul 2026 15:04:00 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 15:03:59 +0000 (GMT)
Message-ID: <40b561da-e7f6-410f-aaca-35a2d52c41a7@linux.ibm.com>
Date: Thu, 16 Jul 2026 20:33:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme: add nvme_get_ns_head()
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
 <20260713104238.3034640-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260713104238.3034640-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ETjhGrJPKQMhkXJzzqMh4r79Nwx8VL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX/+OE+sfyWqoh
 2NOm6o1wIiy6qYsmzuZglEqvZoaI6D6xcprbLJzlzklYWHZ07P5hGaaDnuO+hN/peRWSpy5pIHG
 PnQm1kfGfMUVK/bp5lzhhMHEKZ8UchZ8sJGuLLh6m5xsSR3y5OwQIgeiKp8Baxq09f60/EAPWZP
 kx4sxhdQxD+wyIODtvp/EcEWceqGhCAZWU28yoZ5cC/yl1cukRD8YLCWMXAZYQSbj2IpLOq1fEg
 dKL/QQ8g3D+7IQuIHC1dCANE26TIRp/x26mVO2W6IIL6ODPn+ht0GTfo0T05wPPY+fFe/OEVM/o
 gIqplS+Su28QRB/tCVq0+9zFJPAWEhnsYlGJkNZtk7ECNo8IOPieJ5BuIdud4b+CMV/rK16lEkR
 adRAkqxElusMM28TYaHTBjws/5DniRRH1gphIHaPLbxytH2A++LpWqp+iQ79oM1z6m27VTZMPXc
 IYMovRkScMrV4nnMvqw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58f2e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=V5jUQfiWTLx1vHHZqB4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4ETjhGrJPKQMhkXJzzqMh4r79Nwx8VL7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX61QBbhj7Ey5H
 lIE5XxE3w1rhYtfhjx1ZBLXdDdmd6sPeDQ+TlafRiNfMLzwYHBSG1s3Q1DtnX2KUaFJnPNOEBqP
 KhT5sqWcuIbl34La3ksJuCPcaibLaTk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_080412_362316_B51911E4 
X-CRM114-Status: GOOD (  12.06  )
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

On 7/13/26 4:12 PM, John Garry wrote:
> Add a wrapper for getting a reference to the NS head.
> 
> This would be used in scenarios when we know that getting a reference
> would not fail.
> 
> Signed-off-by: John Garry<john.g.garry@oracle.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

