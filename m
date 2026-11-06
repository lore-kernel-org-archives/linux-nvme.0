Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCD606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p0Ouq+pE;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h8APma2c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fJBjUA8QEWKbwBIZ1SbToH43oG2cnKoP9O5z384uz7Q=; b=p0Ouq+pEhO3Mrw
	UF6SLeaivjnWpCFAYGOOzeL85j+S2ZW6TzViUmJ1TSI87oL9sKt8o9ZDjmHvyKDUAHA1f4e5AlnQf
	yWt09Jc59B3gMcrYdNwWhzD+/+YQwVZitpsrdwtWo3o7cfX/j7WdK43QDa3a1F6pUHFY2kAhmYS8Z
	9b5Ag0DNmThCtF3PT8InIaHaH0jIfxh/h2DMTCaIqCZa4DR98TYlmcebzCm7FIaRK6pTnaDYqP7F3
	hcCYs9nRrZgGW9MOuuqTQGj6YliwbxDV2+gMyzlNu19Ds5rg7YhKBoy4SYY+vgKNFZRSV4knr5ASb
	cDYcUFdgBEJQPgYPqY7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK3z-0000000CS1O-1JGk;
	Fri, 06 Nov 2026 13:33:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK3v-0000000CS0h-4B0B
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:33:01 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiQ9X2368805;
	Fri, 6 Nov 2026 13:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fJBjUA
	8QEWKbwBIZ1SbToH43oG2cnKoP9O5z384uz7Q=; b=h8APma2cSIjCPR14uG3G90
	rn+4RxgbpL0/D0urOjEYbCh61TKtAQ9zzES4pmNHr7l7mQYmGCPkvoj1Kj2f+5if
	1Jkt4+Sv3sQJgTW1lhHzaqPqVyznPpkk/idIeqDS39LsHefMuDAuFXd3fSpS6oFN
	ozQ03TvTjGPL7R7oYF1JiUpkIvLshL2JH2hbnBqSAFvWv1y9Vof8rEWeWlr3oqC4
	Qj/YSC3tDlrOFlWRxsSYa3q56K+NLL7ykXonrEirMJpJp+k73yvA+/ED8fmtTiRf
	QHBo4ev+qCI42TI9Y5SnveEAThL9x93bqtQerCvq+u+7da2SY8R7u0w3qB8V90yw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rccebc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:32:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AnpF73260571;
	Fri, 6 Nov 2026 13:32:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v78xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:32:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DWqpr44171668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:32:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B79C58057;
	Fri,  6 Nov 2026 13:32:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A5958065;
	Fri,  6 Nov 2026 13:32:49 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:32:49 +0000 (GMT)
Message-ID: <18d7f357-d865-42ed-a6d0-f7976ae8c86e@linux.ibm.com>
Date: Fri, 6 Nov 2026 19:02:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] nvme: reject a reconnect_delay of 0 through sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106015842.3534898-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UK4XHgfy0rg6nc35mQ6Q0P0w4nQiuRPe
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedd706 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=MW07dkSSlTKKS71Z_JIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rBA4Igz0Ar-aGufSVOHYVIxW7YkmnRFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX/B58U2VBuXJn
 7MyeyiZlbvMRQ+O7HUdxmew0Fp0qOnU3KdgIej9IxlaQinxD2v4+6Ea1m6LZM6sX6y3YWi+g+Wa
 Mrt6mZtqiJB0of+n6J3YFdLl1gHvlC8IZ53L2e610Z3cZKLiAc9MP3suw0XKOm+ieFVZi6iqMgt
 Up//5kfhfJvNWXTw3WHpP46edBEyS71xEJENsYraVP+S4zh06y4558ni65wK/9VjMQV5xUtbXm6
 lBYufwa+jetoU6pe80ZOWzYJCwgdaV9iRPkzg0InGWgoeTKU9eW8SUs/FhVQLm/H2nwfN6yNwYN
 3nZq7Hj0i7N+gZkhEwS7rmwwZ55v+uITFDBQsWaHyGqnMCjTsY/Wl8Hu1cFKXs7GghNyaMQp+7D
 EBLl9a2xbfQppZw6mTtWq7ZAPFm/o1NTUJ9d79HW4S0JiOUTu3YBYt30W3wlZT7jNxEaJNRKwW6
 XrV3CTPgbjv0cIrc1RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX3CfwWanBSTSr
 bpHme1D8sBXgsycpv9rv5ce1rMKIJ9q7gwvMjE3JsF/4AogOfaaNc9FhPfKhORXw4g9aJ8+axZ+
 l+o6B/uSOtR5dGqii0VV4daGEQDCL6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_053300_406897_BE9D6DD2 
X-CRM114-Status: GOOD (  12.31  )
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

On 11/6/26 7:28 AM, Guixin Liu wrote:
> nvme_ctrl_reconnect_delay_store() accepts any value the option parser
> also accepts, except that it misses the lower bound: writing 0 is
> rejected by nvmf_parse_options() but not by the sysfs attribute.
> nvme_ctrl_loss_tmo_store() then divides by opts->reconnect_delay in
> DIV_ROUND_UP(), so writing 0 followed by any ctrl_loss_tmo update
> crashes the kernel with a division by zero.
> 
> Reject 0 like the option parser does.
> 
> Fixes: 42a45274c2258 ("nvme-fabrics: Allow ctrl loss timeout configuration")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


