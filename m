Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E460A2627
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1EirkDpx;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FWF5NL8t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qry513D0Zb8OCMgbWXRkzan35yGeMe0Uo97yFS6Gqyk=; b=1EirkDpxytpHNY
	trEt5KLP9TFpirdHsx2XY5voDjetjB5oJMwAJGcRWjtLNqLXDy7P2og6JgwHS58tbNLCv0VyQAcJA
	1eAAbkdQbkhxOgZQ1OfiasQdLqeMhTjuHEv/deIplgwD1lTg5sOYSexXU93dkeV2lNELVP0yvAeIf
	eCJxw0220avfWfMgiXHAUk9kWQ9KNLcZDNaKJOk4WZG4kKVJatJBrNQ5jzQnoGqkExW6qw5v+rVQp
	BbeixgY/71Gk/UuQy1mOPZjv+g6Jtk3m027/zKMxJ0kxCh/rqv7oHBSrCY9syKr2Gzc3d+B/FY7Wz
	LIxRssyfMF/IK8sFrRBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTTp-00000009uio-1qj3;
	Thu, 29 Oct 2026 16:59:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTTm-00000009uiJ-2tFJ
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 16:59:55 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGEOLV409940;
	Thu, 29 Oct 2026 16:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qry513
	D0Zb8OCMgbWXRkzan35yGeMe0Uo97yFS6Gqyk=; b=FWF5NL8tdO2MVHOniKdka1
	Vl3pB//3CzVilCS2D70PDXFnfWwgZkd7bR6ua5rWU0IVoxZLv4I+ctFx8LfMEzsz
	TMInIc263jewpd2TBCrHwTGN84I/6FZj98eMAvfMduxpaZfGIw1Nef+xiO5C1jRs
	S0Yo+hUCraOUMGe/NELTJjHONDHubPqXNGirG0lL0vR8UjQZJ0CtXoFVjd7BgBUU
	kYZiQj0Ko8gRIZCk575KzR5gYKvNXDvLgnUhQ/SJ5gEmXOBoyXCkWvEyNZNV3G6T
	IJx3CjzRGFIBPdVk0lFXuOrIXuUp0R0ko6x6Azocp/7qPz9XO29HmCrGCrjFacBQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkr32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:59:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGJrjd3329800;
	Thu, 29 Oct 2026 16:59:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm8qp8cfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:59:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGxZHm18088678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:59:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650DB58055;
	Thu, 29 Oct 2026 16:59:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE0158043;
	Thu, 29 Oct 2026 16:59:33 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:59:32 +0000 (GMT)
Message-ID: <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
Date: Thu, 29 Oct 2026 22:29:31 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling and
 queue info export
To: Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        linux-nvme@lists.infradead.org
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX8Lt+F2F05scI
 ETfRTtQStToR+OovcCqG7abINCOr7LCoRkRUK9xVhBfI/GQdLsVWlvVmemyi3af6e12ErmTShL1
 r/329XHqAP5CV0Dx3GuPg5YA6S6QidE=
X-Proofpoint-ORIG-GUID: xISAHyldDlOmKTJaqr9iRsVlstZoxiI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX5ntrqi4gEqnl
 9kUVwkGdQiUlKS1lSRe20mT7rt3Cc8RNeO0ImEsmWrYYkRFT1mKMD/79s0bPSH/YrsKlCdndeXE
 E0a39cYqLWQUSacy3hL+eSJt0JhbOifuQWo7j0sHZ6BnFRR4iRj9RUMO3N7vi7D4w6khNGQnmzC
 YfRbVDPBSylklSN2sfqREwInn8pTJ6Bgp2afgNfFclyB1jS0fsQ05azTnQq+k8Zq7ahFpw933Vr
 JmvJUkceRKFv3rEcXLkDMY8v2SAetHwZyAX4tUa6AzF1zOLOH/yN2OyQXbn9jeiqx000zkWzXBX
 VrNE7Mv9wObLSAAbQk7GCznXMPfBRgu8WhEIvuz1tB6Q5OV3Gy/ATPjfs5N5QxdulZ/ffIYWGgb
 A0VOgi0hbk7xbxTUrpe1clNV73QNEg==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37b78 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=WUf5vLJwIp2Ygoj-k0QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xISAHyldDlOmKTJaqr9iRsVlstZoxiI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_095954_844628_3953E10B 
X-CRM114-Status: GOOD (  19.79  )
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

On 10/29/26 9:41 PM, Daniel Wagner wrote:
> On Mon, Oct 26, 2026 at 06:03:21PM +0530, Nilay Shroff wrote:
>> Following the feedback, the logic for determining the number of fabric I/O
>> queues (nr-io-queues) has been moved to userspace in nvme-cli [2]. As a
>> result, the first two patches from the previous series, which implemented
>> this logic in the kernel driver, have been dropped. This series contains
>> the remaining two patches, which export NVMe/TCP I/O queue information
>> through debugfs to facilitate host-side network tuning.
>>
>> The first patch introduces debugfs helper functions that can be used by
>> drivers to export debugfs attributes.
> 
> What is the expectation, what's the use case here? Should this
> information be available in a productive system? In this case debugfs
> might not be the right choice.

Ideally, this information should be available on production systems to
facilitate network stack tuning.

Would you recommend exposing it through sysfs rather than debugfs? During
the last LSFMM, I received feedback suggesting debugfs, so I implemented
the interface accordingly in this patch series. However, I'm open to moving
it to sysfs if we agree that it is the more appropriate interface.

Thanks,
--Nilay

