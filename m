Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C65606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1Uc9pZ0H;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EyxFxs+Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G/6U57wRfSEhQR7De5WP5ytRp+BxE5x4ObLpcsycQx8=; b=1Uc9pZ0Hw+OySr
	/Ru5oN+TqMSdfMUq7OgzP2gQUAgu32CyIwjNGTCvBndBW5TpqAZm7IAJvW6+o0juL6dxobBarEVmK
	yH8/mUN2p/u9LB1o3pYa+pPIHkstwiByyibhnDSKUsdvVTvjUFlW9eDrg/Zzk8++s1Xeelx7gw3fZ
	JVDMf9jgztUY3BZn/Htx/Vl6Ncns/3jpdfhZQjqyG+MTOwRPDFQW5ZWCL6E+gbV3+OlZ2nzzwURla
	VEgRtzE4x80JEc0qHf1AE4176S3FQ9m80EHlwAJ0hUMeR3FNZV8FFcJcQqNtuHjQBrpup0O/mmkEO
	7hiLmiO7AvtRbrT1xX+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqcp-0000000CGSN-2Xmp;
	Fri, 30 Oct 2026 17:42:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMqck-0000000CGRn-2GOd
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 17:42:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEiCIf3191764;
	Fri, 30 Oct 2026 17:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G/6U57
	wRfSEhQR7De5WP5ytRp+BxE5x4ObLpcsycQx8=; b=EyxFxs+YLyHTGH8M7d3R4w
	3ixDYDnf3UVwVeATh1efZCrBy7QaAS0m14ZXoyFRkK2AWJ7yHU1KzuAxCa83M0oc
	CzIs9SW+O2pUOacret48SgV/auv3LE0mkrg3Z+9oiNGgwQPqHkxCJDFGefbE+1kn
	CFEKfgco0mJqLqBe2Z55EMMFoWIe9/ee0JltObAc3X6LC9JOlYDnf65T9g4eLmIm
	OIYNmeiV+i/XJE1UWC6jR8fpUOjK3QcfmssZb06rKBZctAmrFtkqsuDsBEawgwIb
	iSyuNRE/GZ1/sKrZnZ3NTDS57TRSeSVj+plMXEXJXTtyd7g7hsIRq1MazXjTse2Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeb03y2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 17:42:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEnoLE673608;
	Fri, 30 Oct 2026 17:42:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pmc8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 17:42:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UHgUVI33424104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 17:42:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE82C58043;
	Fri, 30 Oct 2026 17:42:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65EFD5805F;
	Fri, 30 Oct 2026 17:42:27 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 17:42:27 +0000 (GMT)
Message-ID: <cd9bf3cd-50be-4891-bfa7-50a021b57765@linux.ibm.com>
Date: Fri, 30 Oct 2026 23:12:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and
 queue info export
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        linux-nvme@lists.infradead.org
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
 <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
 <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
 <104ce7b7-dea4-4a08-912b-a8222ff73db7@linux.ibm.com>
 <2f852433-b799-47b7-bf08-0b11070e49f4@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2f852433-b799-47b7-bf08-0b11070e49f4@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NaG4N9BCABEKvTjzgfkjriHJd71yeX1Z
X-Proofpoint-GUID: NaG4N9BCABEKvTjzgfkjriHJd71yeX1Z
X-Authority-Analysis: v=2.4 cv=JIyuIMKb c=1 sm=1 tr=0 ts=6ae4d708 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=nxP52XA85ioaIHJXUcIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX5h5esFnc7qdf
 mX2gcRu8eBTmhsqKGl+iW1f3jnoBcnhi8jtqEb5GtVUObfD8H3nhgtj/OSr5m8S68Rsa/bCQqrr
 OYIt7gzktKibOaTQL8C2+MV30GJoPU2gUJQXKauX9FSONrG4n8OFbpcrDkUQQ6tTzoBxqvKxlbf
 vgJGro9ws7zaorApRgV6debaRlzv0CGORyEqGRHv6bbVK0epjepTPvW7YfdO4qlnTwSV3IyetVP
 /OSO884ObuauB3lGUmKrdI0MSrYwnb0VawHrL08zf0M46pHQy98CXqg3Y8S4LEPNLOdR4WbUT/z
 baYHNk73FkR8v3uz0nSHrnsvOXWigEdItzryoHJ4JRcDlvxU8PyEVsd3Yq0UOjF6aAMEqJDYx/Y
 OqlsAzC3zMVDW/UwjfIy1AzF5aWpChwI+k1THRo8gP5tUqmubbRhpXZHIDwmrgUCFB2FnTkMFqp
 DFIkxKKEMVQYjcHst9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX0gFHDxLFVLIK
 zSPNzvl87A2JyRK1nIlcP4wFgd7BTCvqpOA9IjsfvWs3eKO9PEsvMLiWfh0D3nOtm/JpPTsvBvn
 mY4MwbG0YF1nzsJOCwxEXZHqsMeTRiI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_104242_711205_AA0F61DD 
X-CRM114-Status: GOOD (  12.79  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 9:58 PM, Daniel Wagner wrote:
> On Fri, Oct 30, 2026 at 08:35:16PM +0530, Nilay Shroff wrote:
>>> Alright, then I'll move this under sysfs and spin a new version.
> 
> FWIW, I can imagine that it might be useful to add some support in
> nvme-cli, so sysfs would be the choice for this.

Yes agreed!

Thanks,
--Nilay

