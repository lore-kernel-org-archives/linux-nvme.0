Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ABC606A32F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z3pqIavK;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YlMv2b0e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QA/pv6RbuSyaPqkxNO/TkqLB+PdMIcpAd1xHkaVajsI=; b=Z3pqIavKftMsw0
	A4wi2gPCke1KSEN4Y9LeaynPTHWb2EUzIKv04NEHitfJ66KNbhsMV5UQYd8ZjU055DHnydAHW5zSi
	Xm3oOgQAFD/S4P73/NfZ7AKFkQV8RPps88UIrbZqU0nTkVG8oeEVqcsBeuaDWxkB8oKzLtDozsKnx
	UBtU6RG2ikzf6uZYI3DtilPK2nq7XyS4o97ryvnVfmBhb/LJFdBLou2JY4pqGxtwBPly8XVtM4XQ/
	GZPgtM4WaKUWNgUwXDMgR2If9Y/YQrwZTlA/Sbzr9hsUHf+Bfz7XDPydM1p8I0HhOZyftYnfmouYe
	I06p3qwcV13EwFumVqpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJnw-0000000COzp-1RjI;
	Fri, 06 Nov 2026 13:16:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJnt-0000000COzC-25yK
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:16:27 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai9F5976572;
	Fri, 6 Nov 2026 13:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QA/pv6
	RbuSyaPqkxNO/TkqLB+PdMIcpAd1xHkaVajsI=; b=YlMv2b0er1Inm54ds4hqIk
	/1S8v0VxHqBZKRqs4cN3tGHSCLwez3Rim67yT/CQUGEKwH4TjFWD3U31n7z/s+q3
	HaFvB11saqVOMUxBJzIbt/T8a62JwN6j5Q/iblSfa6G9y3UwWU1O8NdYKjG3rngS
	KQL2L5psVbFGO2lWwEqmzaCz8fkmKY41TdWnipAL9ejduDGiyJqaBSX5pjHLkrxT
	4xLdjYs2kmysJX8sK1H25xiO/jvqhGkq+tJjPmXRy8kxB3Xo8AaNcCZjHhCVrH2r
	JvIPY51S1lM8euQ2pFS2hTnfe9eHux65UwaZ8LWuxV2TBj2iGooV52v1C24KKH7Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbv9ju-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:16:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYsw43221826;
	Fri, 6 Nov 2026 13:16:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9ms3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:16:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DGFPL54591822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:16:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F48E58059;
	Fri,  6 Nov 2026 13:16:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3007E58058;
	Fri,  6 Nov 2026 13:16:13 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:16:12 +0000 (GMT)
Message-ID: <d5392f42-5c41-4ef5-a5b9-3ed049524034@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:46:12 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] nvme-fc: remove dead seqno field in nvme_fc_queue
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lZhaZNYmpoXCr159YSKDScmOpRneDZo9
X-Proofpoint-GUID: 9bbE_LXoVOT9HGDzl1nBWsHxkw5Kw5Fn
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedd321 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=r5mA4LQqvhPECPWEuFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX6VeoNlomm76D
 Vh9ld5HDCzCvA2BZWAuaymhOY39B2WRCltM2nLf2haPG8K/VZQsTLLHHEgJxlgtwZiIgqggAy5Z
 Unfd6qodSjMY6dxLucyfjq4X6LG7PPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfXyuHR5hkN6enj
 GVGjAaamT55oEt04VvXIo8DHscJbZ46wYt96fcadQFpH+PxZcr3G7d6dDBpyXB3v+MATxoTC9dD
 P+k0p0H8bJ9udLlWElaMf+i1ewB2JsPasP4SPedNMe8ht2vqwx77EV4ayZz9edU+wM+1m2/fSOk
 +Kb5r2eMU73iaXQWO5SoO6Srf3nlSjK91zMlB9l6jU40boGtY8qa4IE7QMVIa5mBHhEFGJkMfP/
 7KJ18G964yNfICuTNfXI160zNy5RntVuztH2otGzSJebyuG1O8URfcWMa76QlLadR9QGtDKF/XK
 a8j2OBb94o7Wc1jlU/txxehXB9SoPnmamsYaVJUPMldJhxbMUUtyTic2E0VyfV3Gywa8hO0ugDE
 JEBbHrKuCYa00W8+uKJN+qAmnFKc3KBCEpN7wgMIoUdtusgDX5aObMn8c3BzYDfZJZJUr7dyiKx
 M10Oxbr7P6KqeccZehg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_051625_852854_FE05F24B 
X-CRM114-Status: GOOD (  11.36  )
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
> The seqno field of struct nvme_fc_queue has never been referenced
> since it was introduced in commit e399441de9115 ("nvme-fabrics: Add
> host support for FC transport"). Drop it.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


