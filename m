Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB04606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XV3Gy3us;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IB2VA4Um
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3JF/thpYHBSgE8fKTAFHtOwA7xtaNfrDL0lErPTPhmA=; b=XV3Gy3usRFVvcj
	+SXMhcrWdHfWUqTDgISZG8oQNROQ/mwOjF21lygLRjUjOmhyLdyHiQ3NuTSVtio3dvia4aToR3fyk
	MbT+TzZRKgXtOorop9MMmlNG5RmNVK41lBQL3Y/GfeK0krgRTWkwwoN0hzDtm2iUpdwjUO5SZotWK
	XxR1SnUQWKtIieVKtxtC/lTBQa7Tpcutvir3nC7i4axM5FgBnysIn2qeoo67cpCwLaLpPlOUrkoyN
	MTGkUPTKVCe2C0aSTFusjp8/VRx8d6ZaTNBBXtGgRM8gGkATu8WRA5CPU7jONZuSZD1pAa58MB4mn
	r5MyE1xkqk9I15Ld0ypg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsOM-00000006sqa-1Tsl;
	Tue, 24 Nov 2026 15:25:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsOI-00000006spm-36U5
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 15:25:09 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOF4Wj22789567;
	Tue, 24 Nov 2026 15:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3JF/th
	pYHBSgE8fKTAFHtOwA7xtaNfrDL0lErPTPhmA=; b=IB2VA4UmTD55GT0UwmzUMq
	JklEzLNrmtDd0uMtvqhTmqNKTWc57glSoXzQFz151rLemOOkl26wssgT7GU5qExB
	6hjwTb6AhvfzsKqeRKzPFQPRV+rBiww7xKPJG6noXOAB+cxRKduVoJ2dGrWeeBE0
	OcCHX1lTvKA6TdmfZ0jmxhG0CqkUaJBZTK81YmeO+TLvUPqHSJptfccljIcCM8+Q
	lC2npNQNqIbBjb37Op8evFsugsw+6t6Nbsztxf46SEJ52xXM7dR7q/MF2K90GFzO
	wXH68t0mobQqed04zie3GB5It0oHNEJ50nTX4SmF1eJTxdgx+R5bSPb/rqazFTYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkgak0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:24:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJF4n3535936;
	Tue, 24 Nov 2026 15:24:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkrek2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:24:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFNqrp25363014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:23:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBDA5805A;
	Tue, 24 Nov 2026 15:24:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6920D5805C;
	Tue, 24 Nov 2026 15:24:41 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:24:41 +0000 (GMT)
Message-ID: <a1292a87-1ad4-4137-93b0-3f34786a7090@linux.ibm.com>
Date: Tue, 24 Nov 2026 20:54:40 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: define the SMART / Health Status async event
 subtypes
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
 <20261124120032.1824788-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261124120032.1824788-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX5+4QJfHcJtO8
 PsdF4bs2hVxgCQureQGUqUpKTUi4p3Mx6KQ8tAay5et4tjkbRUrm8q9es+nOD9oyLvHUjRhi4cl
 Or+oIvTPJB128CDYhYTbhYla/YEjw1XnvWGzMsP8kvQyUrRZq8GeA6QdQRgaAwXp2auO6C4XhNm
 KQHcj50tw8rxzwtpCfL1Y6U4xFThHUGURDoRpN+ybP34/GVH75BX3nFVHdfiSkma0kcZY1MK4NJ
 fj3I9il8hECWOMlz2EUzI5GRRJCiYaPsNNqdXsr5J1HIwO70YGj6iWbL9St2jsGcddvSqeK5Pni
 ZpjXRStzWduGkwv0+gCtw9LqRFMQR7EVPD28EExxgux4946n8ha27QC/et1bzBvoFqmXkqMvs5i
 vxKbpFMGStD96vsK3xNrsI2j2pFilaI+cPE8GvvZfdygfkAG359KImQfCxsUlw0BvMEBWX8M8YZ
 633Ats4cm/eSpej0lVw==
X-Proofpoint-ORIG-GUID: mK8IYabfUnrwCKUahIH_MEET9TyAONGY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX7wfRerjFqCH5
 +WBm2wIpfaiR7SQH9it8uZdVrKMGtxq+O4S+10VYWzoLRP8lQO8zJZ0eweBDN9tgTmdK7Di4f89
 GVtEGZmNaypiiQcgX2NOHGMqiu8CzkQ=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b05ac3e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=Rq5Q-GilbGGBDAlGypAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cpU15TJ_OGIwuAopsSRToIxyzl8M0xBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_072507_989619_219A94C7 
X-CRM114-Status: GOOD (  10.67  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 5:30 PM, Guixin Liu wrote:
> Add the asynchronous event information values of the SMART / Health
> Status event type (NVMe 2.x, Figure 154) alongside the notice
> subtypes, and the events bit for the temperature warning.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

