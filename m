Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D355606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pzCScwsZ;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jy7pZZ0K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ka8W/afCSEus+U4hNU+je3eVgyPoXjIltSkljBbKH50=; b=pzCScwsZL88Rl/
	gywb+KaN9a0kD2dXiF6InHtv22Mmri8z9612+wDwAPHAQCo+G5bSYFArDoiDZuKyUA8aTkYx3/D/E
	pvFRDV31dMQRUtrlOZe1T+aSJ99uP4qEQw3HB6hSU+oPdvNqCoVsijS4TckcGMZ8IxQ8BAFaGYNH5
	NaejcUSgY0sWdEfcnYAwNi5oEYN8gw5QPPzYpmTvDIIfgRBy0Iv48tqUYP/ZELR0f9QD1sRH7VP07
	eu1eQYrWZVEP2ppTgdb6weEr+LWTurCicLvbk99cuyK/gdNgzT/8uujAax9vPzb84dvljjDwwU8ln
	f1SvVdjTNUTuGAcOhv7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Xj-00000009LqT-2mw1;
	Wed, 25 Nov 2026 09:43:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Xg-00000009LpV-1VEk
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 09:43:57 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6Z5na3467814;
	Wed, 25 Nov 2026 09:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ka8W/a
	fCSEus+U4hNU+je3eVgyPoXjIltSkljBbKH50=; b=Jy7pZZ0KsANua+JNLp78YT
	iO4McxZHVRk1ZC5F/uSP32U8OG9qtwFs74S60IWzfTuitftumcCDwXYGNFBve+Kg
	38f4h/p1M/gma36eCK/bZi6UAiyJ5sGs1ChqM5WQC/wI2by09HJnvdA0ZS/v+9A5
	XIcJ5t9L1sxK38/1w6lGRtxMSf1Plt+yJGD0n01IlzC0YDj6TdIsz5qckuH9TM2W
	91Et3/VmsfgNNB8dtZkYml8MRZ/ryvYMvPhv7Yo4Fw4H/5wEODIwwnT14G3bXfOK
	4wKraoFEY+TjkIJcRfvrJEkxnt1SwgglmkzA9mFoOmGx39RX/gkjsyMQiZYVlhZA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4k52e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:43:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8Bbb33967599;
	Wed, 25 Nov 2026 09:43:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx07v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:43:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP9hdvf29164160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 09:43:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4F058051;
	Wed, 25 Nov 2026 09:43:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93445805E;
	Wed, 25 Nov 2026 09:43:36 +0000 (GMT)
Received: from [9.61.9.230] (unknown [9.61.9.230])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 09:43:36 +0000 (GMT)
Message-ID: <a0f493ac-7792-4390-a28f-5ee94e32ad52@linux.ibm.com>
Date: Wed, 25 Nov 2026 15:13:35 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: protect ana_log_buf teardown with
 ana_lock
To: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20261125060153.206699-1-kanie@linux.alibaba.com>
 <20261125072348.GA21866@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261125072348.GA21866@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX2GPtGePk65mQ
 b8mWnBfGmjuSOvkaxj5XKjOLoC7y1udfiayMKBaJDHJ0Ir+wNCwqzWM5IykzjTA7C+FA018K6Ws
 E+qf3D8UdDVtLHvCMKrU2rsmTsBM3KA=
X-Proofpoint-GUID: dFgbf4I4o6pAXjc1ChloA6n-Uy6UxPnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX3t6RUKSQX7qs
 izH7o3ZDqeIc7nes9kfVhwzneXIahW0ozXSPWJRiuY7TBEeba+TDcCtFJnQVSmQANkGm8kf+Zqt
 iMnxWGwxFH7ef9TWSo5mrHuf8cVsBoGEpqSZZLR3z6eTtEPSgWscJYAvuSMZGg5KV9Qtujt5B0U
 nU4hLVFjPXOmFMixHSEx2xwixLCZBRvFti7CYORubnjj/9QXlXMEkjii4D96ggdo+IR1p0gAv2q
 CRIxwIstCV3HRFtKN7oo4UJMj2XvlnVbjVl+VYxB1JD/pPJ6SA5L+sBtoCiwGtK10pogg8V2uFq
 xdwVy9CMPzyaiRCOBolDg8kB4OhBgCmMwUUt3pG0FKrFOQ69v15DxgYBSG5gIfFfKERGrCIP7Fx
 ytFQbzGmkU/tKfhSDiJfapvV7985qqFsnpmSAiVSL98gXQ8byNGudIuVAc2KMCzN+qK0cDAVgGe
 r4hyXam483ulEnxKj0g==
X-Proofpoint-ORIG-GUID: X0v43FoLjDQPYC6ooQ131X2iVq_m_wh4
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b06adcc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=tEMpcI3arwDOPAcOxycA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_014356_531905_6460249F 
X-CRM114-Status: GOOD (  13.72  )
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

On 11/25/26 12:53 PM, Christoph Hellwig wrote:
> On Wed, Nov 25, 2026 at 02:01:53PM +0800, Guixin Liu wrote:
>> Reported by Sashiko AI review as a pre-existing issue (not introduced by
>> the ANATT timer fix). Confirmed by source analysis and reproduced in a
>> KASAN guest with nvmet-tcp loopback and ANA enabled.
> 
> Sashiko thinks this is still not enough, and it's probably right.
> 
Yes and I think we should add __guarded_by(&ctrl->ana_lock) context annotation
around ctrl->ana_log_buf and ctrl->ana_log_size.

Thanks,
--Nilay

