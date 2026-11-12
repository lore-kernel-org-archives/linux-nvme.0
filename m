Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815D606A333
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OAuxw2CA;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MwIDoCeY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aHLBow8ll7eUj2sIsH39XczXkWkcXAPRGA5fSNz3K9M=; b=OAuxw2CA29YMJm
	habMrig4NwhEDk3VMzQj+hDfYJmdk5ijx2foZNHi0NvQ/pLHL5ieLloUzk894Z6C1Tm5obKe4VMke
	fleZUYw0fJGlK9brCIp4bDjJ+2d661FeWGcPiOaHijbDL+xBavresTL8RHsX8zlYCjCXklkNAEtbB
	JAWw3A+Yh/ln0jCXal1YAUCy1fkta40wWSMVjxhnRcb5+G8riL8ei/TxH+o1j2x/+FxNo3A0slNmw
	FFHiqYoKu+i/pPuCtDCpNa6v+sIBQJDXEqlVnBrblClBWHC9bKKySY+54UvnqydZ8J1OQp9CDGC4A
	6pE1qok8AA5UUhI6htnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXyI-0000000AfnF-1IGb;
	Thu, 12 Nov 2026 16:48:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXxe-0000000Aff3-3Mhb
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 16:47:47 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFiMSn441811;
	Thu, 12 Nov 2026 16:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aHLBow
	8ll7eUj2sIsH39XczXkWkcXAPRGA5fSNz3K9M=; b=MwIDoCeYjrQhuCmTSnvljR
	Jg9lmxka799RWLfxGC4MwsE5myPm0RzPw9xLW0O29eupePayi7Jp0SLUZ2bEXfyk
	OwkEgDG9rBPZPgRIDLcX7oJ0fq+Z0jMbdoCa1scUoS/hgR9SQate+WFkt2YdHF/I
	B3hC2/zgusZcn+G66qv1qPcDT/T3bPR1A38QQBugyofY1+3tBSbNf6uLEz9/uu/s
	U4/6wQKlJERXcHlS0Mqji2GMynJ852kiPxE+6Kb6nYiMlM14Ou5f7UWsAcc3CPmR
	VTYwD63g28Nyst3cxLstesjCfv2KDrnQ/wVEnW8l1GQBuUxhhFxmd319j5sHRM0g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6gjpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 16:47:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFc5bM898457;
	Thu, 12 Nov 2026 16:47:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd858wae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 16:47:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACGlU5Z57540930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 16:47:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C3758059;
	Thu, 12 Nov 2026 16:47:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A0758057;
	Thu, 12 Nov 2026 16:47:28 +0000 (GMT)
Received: from [9.61.136.41] (unknown [9.61.136.41])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 16:47:27 +0000 (GMT)
Message-ID: <ed0a7940-4c8a-4767-8ef4-2c52514a25d7@linux.ibm.com>
Date: Thu, 12 Nov 2026 22:17:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-multipath: don't wait for a grace period in
 nvme_mpath_set_live()
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
 <20261111-bug-nvme-mpath-set-live-srcu-v2-2-fc772914d293@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-2-fc772914d293@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XJJVuKkmzNoGmjsf-5zzmKYszzAEZnsq
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af5eda4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=SyHPSGQle83xrfl2-lcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XJJVuKkmzNoGmjsf-5zzmKYszzAEZnsq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX4bsFNpezATSe
 SU33Mif5jekZC5LfOyym04bJ98C24UoaOz4yiWNV/Lsy8WkHonuSwj+dUXqQqp9cb54zYMC+TR9
 Qlf2ypOp+YJcNJBP/UxmGtkhPXQBvy3q8fEuOlXNKA9SpbSHu0kQTZFCRxp1tKhf6ofdBKodide
 OaH9bm8o5rCKwM6ojXZCz5nQgSVFOA+LWUZ8Xt+pDg0ZqJH1jaaramd0q+/ApGTGskwlWm/LUda
 kolZHbjqI6gm16CNl9vkUbSYkhXdjhqB56JwSsW+BvR0e5Epxe6MISAOeT0KxnZ13e48SwdOrcH
 10vZ0yJ2hBb3YPt+EMH6vLm7FJKJrBbLzqRCHf6J2HqfY7HqoxakpuBqZ16RUzjKXGe2WHFb99L
 CUWLXD2CDIaIbg1sQOk2DsaCaKkawH87c6Bn5PIhVRXqv/2jsb6chLg59iNG3Apm9eNl6ztrCn2
 iPW8zCnxtt5/fCGXTTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX6BVqibdTQRCc
 iAOGy+5ebP8zYiLrh9iM2BNGzVQCACMkiBJbBScCyKHuKbKxC56q78RnfvDDtIe6kydMIPjhy6A
 5MO5+NRkYxNkATFTKAY58bnIcz0h4+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_084745_739185_C08972BE 
X-CRM114-Status: GOOD (  17.34  )
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

On 11/11/26 6:40 PM, Qiliang Yuan wrote:
> When a path goes live, nvme_mpath_set_live() waits for an SRCU grace
> period of the namespace head before kicking the requeue work, so that
> bios which found no usable path are on the requeue list by the time it
> runs.
> 
> The ANA work calls nvme_mpath_set_live() for every namespace that
> becomes optimized or non-optimized, one after another, so an ANA change
> waits for one grace period per namespace.
> 
> Start the grace period with start_poll_synchronize_srcu() instead and
> have nvme_requeue_work() wait for it only if it has not completed yet.
> Take the cookie under head->lock, so that concurrent callers store
> their cookies in order and the requeue work never sees an older one.
> The grace periods of all namespaces then run in parallel, and requeue
> work kicked for other reasons finds the cookie completed and does not
> wait.
> 
> Flipping an ANA group from inaccessible to optimized ten times over
> nvme-tcp loopback, nvme_read_ana_log() takes (median, min-max in
> parentheses):
> 
>    namespaces  before (ms)          after (ms)        change
>           256  51.9 (42.5-85.4)     8.9 (2.6-12.0)      -83%
>          1024  157.5 (133.5-179.6)  49.5 (32.8-67.1)    -69%
> 
> Signed-off-by: Qiliang Yuan<qiliang.yuan@linux.dev>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

