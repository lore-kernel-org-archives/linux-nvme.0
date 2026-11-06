Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B95606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BITtxKw7;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aJuy5rcH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wXjnm+VPkHgJK5EyvRL9VTGTYga4TXQGR6vCNbDDrus=; b=BITtxKw7qamfDI
	u4RZOMmVj/fMS3YfGbNhHBpRr+SKblgZByjHSOlrdsmgYldP2wBdyW1bLDj97Rsoj9jYKwAPGs2tG
	qXHd/nrqbxSf1wRJ5+ha2hrYTkvsGuHULu0+Yh3eFX4ZA63/hMaY27V/Oa59R3Y1xqZ5ubJ5S4nsk
	7n9u81e6tL8vB0r2nFpSbFErN19ZGWQxn0m7rzMD8qs9GqKrnNAgie1CATNcAP9hM7N0iFojJr+K1
	CIVYIeO6ILWQrzcWMKwwo2b+7iuiNIGpBuuRR6FNX0oGFGFTuwSWEQY+zA+hdi6GXCoCLPECQeosU
	+hH/CU8thoLfamVEqUHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJki-0000000COcG-31in;
	Fri, 06 Nov 2026 13:13:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJkf-0000000CObR-0twV
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:13:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiXKr529033;
	Fri, 6 Nov 2026 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wXjnm+
	VPkHgJK5EyvRL9VTGTYga4TXQGR6vCNbDDrus=; b=aJuy5rcHUfq6ug2Ot6oexT
	+bd9Vy2egZ/NLUk0h5cEjnybVvFdADECN2H+t5enh+OnBt2rxoyY/s8ndrfEHml2
	JT9pZLU2IoMRkW4CzWaJ25FQ6yn3rBqUWGigBA2VheZr1tyYFPeUQgdQ8+pBZ4e6
	P2i5piwhA+cg1aLjNv4ld0oT16FshVQA6cDxg0ygurUqT7GWp3OBO9Ciz9huodkS
	gjuiwazt5Rqs1YpBYgp5OQXl5ZmbSb8SHRpeaPzLwTibjheziTGkJbITrpDHwQYf
	V5r5Fvl1HSVo13JViryUUrI1gA5RTicZltzpzdmFqdtMUDUc+nfS8s/J486QMNig
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3ravbe8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:12:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYtoU3221837;
	Fri, 6 Nov 2026 13:12:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9ms3n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:12:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DCnV626739384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:12:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D5C858059;
	Fri,  6 Nov 2026 13:12:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B914B58061;
	Fri,  6 Nov 2026 13:12:46 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:12:46 +0000 (GMT)
Message-ID: <c5414418-354a-4fe0-bb1f-a7b4723569ac@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:42:45 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] nvme-pci: remove write-only NVMEQ_DELETE_ERROR
 flag
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedd252 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=64VfeNaC3tan3OCNEOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CfWcRwFKQuZAxssWv54lzW7zfJOH0F_9
X-Proofpoint-ORIG-GUID: vz62t_AV3iBx9MLhxQeRHAHhIx4taz9L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MCBTYWx0ZWRfX0VV6dZkj4EN9
 PCajlVGPVExJpjPylFkQs1ddHl+QUfAHqt6duyo0AiD6EHgO4CHL/v5YzXdxNhtzvTZmtR95oZB
 KdIukmf1F10w0uCZyOsJIPR4lAR+wE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MCBTYWx0ZWRfXw7UpO95MQhTp
 mZ74u0DCjy+uuUysCxX5O4fnLxuQr6RBDp1w/XbQ4F33Zd+/Y0iWhM5gxfCC6jHBiMa4Lz2MxX9
 zQHvx0+6pMWrDeTI2mek0ipIXGEo3dRm+oeGweYePKcLA3HdpF2ymiDuc1d/N7rXkK+sSP7nk10
 CKdpeX96TNTfGEShqhLyNotoL9rWYhpIjfa/q4avtD3T66LPUBB7Q6ssh/y7Bwcfs/Gm3L0lFcg
 PH4mOEW1dDurHSgNwJr6BVvWYnDnQ2+FTHJ807Of0ZS9VwqpPueG0kQGA9IKk590aActrLYuPyT
 U0TdoxZpogLjSAOSxY9YBwRo/xJnFBBa2Zq2NllA/u7tLEnesTuc5NyXls2KkU8eY9eQKmU9PTL
 NusI90gy7xsBNb1WWki3G8wl3ZYG26cSh7ObBmHauzhy3x0MaogYTe05kbtAxhAFXMPUnqxGKEg
 +qGjv/AMwhX41+pZgeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_051305_297973_A98172C0 
X-CRM114-Status: GOOD (  11.87  )
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

On 11/6/26 7:57 AM, Guixin Liu wrote:
> Commit fa46c6fb5d61b ("nvme/pci: move cqe check after device shutdown")
> removed the only reader of the NVMEQ_DELETE_ERROR flag, but left the
> flag and its two writes behind. Without a reader the flag carries no
> state, and nvme_del_cq_end() degenerates to a plain wrapper around
> nvme_del_queue_end(), which the SQ deletion path already uses directly.
> 
> Remove the flag, its writes, and the now redundant wrapper.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

