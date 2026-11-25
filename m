Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C7606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=huw20f8v;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b5jX/OvD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZtLd1G/pB/+QJ9Da7IBiGvGezeXGj8i9kitTdRqTzvg=; b=huw20f8vj2ox8x
	viQA6s5UiIwas5+z3VMWWh22Bxwjfv+6PgfVo6fF0jzjkbUejbeRr/PCIPBOtLO8otgQX0j09mKbz
	CEfOWz/WKslhWJZpRBvLUHrAE+rq/oGJXunwcy6RrGELb9Gdp9rKXr1AnWp73ZOdftwcmPumFNmF1
	El0CGym/Wx3e9u51lFa0Ei/yqeJhT/RS+MyGFO61oXnhMKeKWRRIi66J6kqvCw3d5uRlasdolqFb+
	CzUsxGI3Pr+tIfL9pUsPKyqTZklU1XNa2JoQAXcWw71uhwKPPOWCocYPQOdpE0bdvK9sEuEC0FyNU
	hx6rY3U/ti2+WBAVU1RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9fs-00000009NgZ-1ja2;
	Wed, 25 Nov 2026 09:52:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9fP-00000009NRs-43O5
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 09:51:57 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6Ymqa3467313;
	Wed, 25 Nov 2026 09:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZtLd1G
	/pB/+QJ9Da7IBiGvGezeXGj8i9kitTdRqTzvg=; b=b5jX/OvDch4CRXMWceLrYU
	2HxeEjYSmDXvBFcTeZR20TNYD5yglBYpdm0PsiOxZtQZNwW4CelbFT7eyrefH/hJ
	sv3ekTBWM3S4ou50X9/utQVVoSwQrrqW0VfAHbjAnazKozpUrh9EUBN3OSwE+l32
	qmlYuJqEOSCPbji+PkvTc1K424rU2DdIDHlY8ZcYES+ZzKhHDL6fCpPxEGRgJEJ0
	gBH79cZlpaQdRYvhsZnL0/QK53mrJJDk9jV8mpyWXH/xBtGMJPKLAGRPrN+Z+q/r
	ef2apG0LvcPOKY3HYzFlmh1e1ciCWTemanLi+NruHtotCiZooEbjeIzyHMcA5LKA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4k5vt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:51:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nW1f3650118;
	Wed, 25 Nov 2026 09:51:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa1nac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:51:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP9pgtp26804910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 09:51:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7915805E;
	Wed, 25 Nov 2026 09:51:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D67065805C;
	Wed, 25 Nov 2026 09:51:39 +0000 (GMT)
Received: from [9.61.9.230] (unknown [9.61.9.230])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 09:51:39 +0000 (GMT)
Message-ID: <47654f8f-2ad7-4c5f-b92d-f8b0c5ac06c2@linux.ibm.com>
Date: Wed, 25 Nov 2026 15:21:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: zero the reservation report tail beyond NUMD
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261125061453.230238-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261125061453.230238-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX1+Y4NhTw4fEZ
 D0ofg939Ofj2wLLcE9C1mQUtKIVuynnO7U+I9LFP8TC38dMqRz7ISolJG+mtJ7YR39g8YoMgcex
 MRT4+/6eO3J7DbiJaIM3JQY3pWpaRDg=
X-Proofpoint-GUID: an-hiZdgA6lTaem6Fka_krhhmmbmpF1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX2EtBCyyRd4y5
 +Nzq2NtBgKOEDtbDwkoNca5Blhsm1POIYe00XMXGMU0kNPHV4ga8UVJYhI0VIZDZsuGzrgMh7rM
 MsvMhOfmlEhLx2llJEIFTLY8TaPlMAuoO6MdvFTcUbKAjW9mCbL2NY2NQS3UKDpb3J2pLA1Gges
 HfAp4DVGD0PNkO39j/TljxFWyiHSuKQ1FrnsIJ8xL0U9z2+1+a4kG9YSRpZeU0aTXj2aydkBN1/
 WDSEJGbTBCV62eBhBBXMilEVywaqZIU2BUal3+mLtclYbvab9ib9dHb/YX5D9hmlsb80Hh3efUm
 ZKSzMDxhJ/mu7BaIHdZYPkD89hdkCQ0C90fC+yr/MV2y7g67Jedy1yAMYDeOMgZZ2sEXTZ5+X8+
 2Wo09Pvo4pJPK+mm0ZQJSUZmETCHaRPEQw5X6GkB+wJZb2SrtcNtZlurBHlHylv7SM6BLDV7gne
 bw5qqaU8P5uX+Zy5j2w==
X-Proofpoint-ORIG-GUID: zii9ZzjsesAFLbVsQ4R-WAei8CxtzNes
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b06afaf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=tt4zvXYUHk92gA-qOcUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_015156_150552_A964E631 
X-CRM114-Status: GOOD (  16.06  )
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

On 11/25/26 11:44 AM, Guixin Liu wrote:
> The reservation report handler allocates a buffer of 4 * (NUMD + 1)
> bytes and copies it to the command SGL, but the data is sent back to
> the host using the SGL length, which is independent of NUMD. When the
> host supplies a buffer larger than NUMD, the tail beyond the copied
> data is returned uninitialised, leaking kernel heap contents to a
> fabric host.
> 
> Zero the SGL tail beyond the transferred data, as the discovery log
> page handler already does.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

