Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D500C982D0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yn9lmiYxAwLXKxiieoNf32Ajz85wxlvrCJpaULMU200=; b=wlE+A1s+gQUkePErhvJsjCaJP5
	ju+2qJNFmphiV7m7uSLLRlhELs0pKd9VDHOQYhPs+t0zSmV7MYrisoj/cav0f2lwLPThBCUgIGSG2
	T8yaA0qLLM6lQWOKsRhgjqulZgMcfvhbfrQwFwz3B/6TpR59rGqlzZADixVNgyrOVNvCdYMQWso98
	8j4bM6lePiHVZ7ZHs5umBJngaanUJ+axyET71tjFjQOsutBSyS4fO7wBs4yRi1S7uFfL/om/gzIl3
	6QGMfuKA88/0V4MNyGtmg/DWJCWTBA0umXH5207JmaFDaJFDiiYMEG8ZF8quNzGhen6AqWrE8b+o/
	bJjOBwAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77Gb-0000000Arjg-3jLE;
	Thu, 17 Sep 2026 08:14:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77GY-0000000ArjK-3AL0
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:14:48 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H621BQ1702777;
	Thu, 17 Sep 2026 08:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yn9lmi
	YxAwLXKxiieoNf32Ajz85wxlvrCJpaULMU200=; b=DPghrBM+8Pgyj/TQZtyQPB
	RJj8SsiYzr2qL5a/3SeX/6uFNV8TjfU/t5mREwQ42JVP3yfKCWaaNa1MXPJUMcMg
	APqoYtYcx87JpRVfKDMZHcJStkKX52VxMGB7VLTGBfCC6jmEt9gqGVvYwR6MAVYL
	I4TNkzhrNkuNbZRftaxwecU3V4zL/wfnmeWdWrBnTGDvMXllZONNKCW3zTqf4CyU
	8ocjmmpAdVyKZv4VcGS8x+Dy4juoSjZDEZOpTE5qA6K5Zy7SX2zUzaZcXavLXdZy
	dMBENILJ8qyCw1NMBX1L3gBV20ZuunAx/0komoqu3flyRsP2P0X1twuLOHE2vkdg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx84172k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:14:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H653wB2660555;
	Thu, 17 Sep 2026 08:14:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjhg4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:14:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H8EbSv1442658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 08:14:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35E558043;
	Thu, 17 Sep 2026 08:14:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0209B5805D;
	Thu, 17 Sep 2026 08:14:33 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 08:14:32 +0000 (GMT)
Message-ID: <cab6a2ab-2326-4702-8c96-3d7ce2644f41@linux.ibm.com>
Date: Thu, 17 Sep 2026 13:44:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: work around all -Wformat-security warnings
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Maurizio Lombardi <mlombard@redhat.com>,
        John Garry
 <john.g.garry@oracle.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260917061459.1486026-1-arnd@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260917061459.1486026-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfX4m8wdQ3arOYs
 mu+Ed6KNnfxPk1TV340RFMUwDvyv1SmH8OMhTRueRsYaoUi54UifvlbigAsRyJpoIbt3Egc4b4p
 1E+ZCNVBkw6a1mMwprMB6ch12Fo0LLEyPejQX2aJ9+E/8TfteCNHa8HwjWvVKmNZb6E/Sgueylf
 oHLFyZs6Gx1Amr7XZRr6Pnj5vSrNUU9fC2btK1JdX6GrKoph+Z+H5Oims6wiFfk7RNUIu11n2qK
 I8KUxWjBV/ZuFm0a6mV1uLdsx3nnrdJT5ctEsinsoWSz0rAdZQCchm+5wXNjnFBWJ0HQT6Ntw3K
 by7W0SNv8wtoGk9oyuR5nCGB4A52NH3zxS667fiFUDDNkrmw9DqtLu6sEn3bBt/D1fu0nhK7UhG
 HCMSEaAo7PEsCbwKWiGHe8CX2wUtvwp3T7BTHXOWoJ4/uoptc106WBIoeUmRQpR/0uRvIPYF0NA
 /3x/uU7NLbfA2GdKiuQ==
X-Proofpoint-ORIG-GUID: RfExPr82GTHD7THJCC6KIoG1KsUy4uKA
X-Proofpoint-GUID: RfExPr82GTHD7THJCC6KIoG1KsUy4uKA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfX+VSWT+0A9dK8
 VgWu6FlkW5GMFER3noTqEEtewsYfIKhncwtwCZbJfWcufVKxAApkZHYr6hxvXFzpm8VUdymbhqD
 ImNgadA5hkRhZs/FBx4IDonL23TnAOc=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaba16f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=06IV_GjJFQZO7jKsSJMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_011446_973061_6D68381F 
X-CRM114-Status: GOOD (  14.53  )
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

On 9/17/26 11:34 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> The sysfs code passes two string variables into sysfs_emit(), which is safe
> in this instance but causes the compiler to warn when -Wformat-security
> is enabled:
> 
> host/sysfs.c: In function ‘cntrltype_show’:
> host/sysfs.c:682:9: error: format not a string literal and no format arguments [-Werror=format-security]
>     682 |         return sysfs_emit(buf, type[ctrl->cntrltype]);
> 
> Print these using a "%s" format like all other instances in the same file.
> 
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

