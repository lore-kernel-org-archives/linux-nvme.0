Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0381606A334
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eM4807rW;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E+G78zlg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DrT8ZM8cDvhBpebJ/JAgKGgO2oakX6rj/O7FwVmS+YM=; b=eM4807rW/FPmhM
	HfaBfwah/isskOy7LRNYqga0qcCELvKOreJsQoMq2eOO1vtH8FNwAAIh4q4tdNaKD0n853kVzJf6Q
	dzL7gIiAb9toDslG/Ha4gc6wgWj7/IWHEn07sAoHBmsppmpogtI+F2Djeqi6vidCZBiTqI56IKquL
	F8q8jqtjE7/oiZSAgNwPqYLvLIMYm+g99Xe/r1rKIsjHdUsT+Lzpo2YveLQeEbfYkYS6B6PqoSdT9
	ZIt3SdCSfNF6ENexMFQhMN3vUd3tzK4BwoxK6s0dl+uBYXxE+ajwVuPKVgQ+mftnCLuk1qaQYkeF1
	Ckrepfmgkrp667oZ5SSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJpS-0000000CPI5-2qE6;
	Fri, 06 Nov 2026 13:18:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJp8-0000000CPEV-1Jeu
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:17:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AisAH2160384;
	Fri, 6 Nov 2026 13:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DrT8ZM
	8cDvhBpebJ/JAgKGgO2oakX6rj/O7FwVmS+YM=; b=E+G78zlgO/zz4C+x8zzv+X
	FCa3YPPxHNbebao7wRuWLiOBjvnGgjcc/FY+FuJxGZqRpRi+CFedoBnr5h2tBh9h
	vP1W85104EqNSg7S5uKd0GwgQzk9BQ578KrvyqYD0eahO+EAOwfFsES+Y0xpYBjY
	psv4Mb1ToBQYJtE7NL+y1/Wy02i0beJqLnwIdt5vyvfpoBmA3Xk8ovZHqBsi/rTi
	kSeGyDRn7N2dMO+4bMHRi6NFwLm405NTz9LFJC70WY9TIdbfubbQBFisJ1mpTbET
	l4g346v2F/QzasVIpdgYjvyBa9JijvqjrJfjbtzUH6VixHrIRwLW8Rzm6Rw/SIpA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r9cadm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYsON3221823;
	Fri, 6 Nov 2026 13:17:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9ms42u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DHaiL24707804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:17:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E20C58058;
	Fri,  6 Nov 2026 13:17:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D604D5805D;
	Fri,  6 Nov 2026 13:17:33 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:17:33 +0000 (GMT)
Message-ID: <5b50df13-0110-4115-aa8c-75c064bdd48c@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:47:32 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] nvme: drop unreachable "off" case in
 reconnect_delay_show()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-6-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-6-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LKHz05W9 c=1 sm=1 tr=0 ts=6aedd371 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=la1Ic17G8sF4isaCf_AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1qj3TlMMCFzxMdyz9c8bg6V70cuHqQ7J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX5+IlCV9+ZY31
 PCJ49gNYE5ZUboFV6jLzNClv2TeBLyQzb2c192LMRm4AYvMZ0bZy5km3p8/+Epv1Bg241y9M8kV
 n18AByT1fM2sUBDKbUdISVHQLuiuap0=
X-Proofpoint-ORIG-GUID: 07DdY6G71-s2Tp0LnzbVrQmJRQ2m1Pq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX2hVESP6X7oU/
 y67R+2ZE8h0RD+srKx5mDc5IwOiUctjKhH8zADxusr8MSv4PuAl9BqVIu3T31ibVeW2YTQCtlfM
 qvyIxa8+MCLUBxKepVvKWxNrqaNgWplmSWP/zneDfNZd4uIii3mdQ9vIzc/3xiKVlFqmBjLarYD
 kXEIELweD0EeIhCjWJsGnPkH2FasNR9ymThLqetpYgXtsDcDLVUB5oss2X4W7bnUQTQAFeWIVGM
 i8//LehUPgSckaUJ3g3GYkdvA8Uxf9zn9yoPlGPaw4FMBfZ/AfCTY0FUzmyBC0XTzFjJ21AQddc
 z1laDruwIGZLwooPiksk5+/L2d3zhzQY61J+Poi/fCnUDSQGD2GcNPdovEnEk68ZGk1b6FzDJwm
 FUJhF4w0fTSy5S0TG/wjdqVZHCZ0vaAmjITrQxJt7K+lmrJGAU1mR16O03/ICDwE5OzSaSfolRn
 vhg+ZIlWHfeKuA+YjCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_051742_743114_D5D516AA 
X-CRM114-Status: GOOD (  14.17  )
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
> The "off" case was copied from fast_io_fail_tmo_show(), but unlike
> fast_io_fail_tmo, reconnect_delay is an unsigned int that the option
> parser bounds to positive values and that has no off state. The
> comparison can only trigger when the raw value 4294967295 is written
> through sysfs, which is not a meaningful delay. Drop the case and
> the matching sentence in the ABI documentation.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


