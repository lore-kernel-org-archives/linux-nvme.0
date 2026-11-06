Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3F606A32D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2e7DHBD;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fR3cC455
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=w+x8gV30sakLI6AZSOCSDxuugvF6d/1Gbj1xrTuzNoQ=; b=E2e7DHBDGz5baR
	cicZ9Tbh6n/lOo2cqQgVihlOkp/u3GvWIcAwUNUb1wUexuGWqWWHrQCpJ6yrXaG0qogSf+0Crig4O
	W41eZKyNp1Ypnkl7dxHXTd/7wR+DIajxXcBIgWNXJyNBSa4QHs73LYahip1IjcNVUJD9+UB2qX/60
	DZrYS2Jrqi2t9FI8yM2LLMCWGkzRvPbXYqgbPFxMVVHMm7AMM7fqIAY0yENjJXysVH1COV5ci0Lfa
	VtNSp9yXuOd6YSFlT9LJlciT8SDezKYS4YhT7DkEahIkLb4FlKK/HlVlUQSkf/S5nL+4A14eRTqRH
	CqN2WM1a1MwRSa/KxJcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJoj-0000000CP9t-2DOf;
	Fri, 06 Nov 2026 13:17:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJoh-0000000CP9Q-2ISs
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:17:16 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai9J7976619;
	Fri, 6 Nov 2026 13:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w+x8gV
	30sakLI6AZSOCSDxuugvF6d/1Gbj1xrTuzNoQ=; b=fR3cC455GdkP5gsujRzHrF
	Ls7yJK7x2TEbNpTafPgoc4hNn/MtW5XK/vhG1BPZVqrThccAC7F4M3jXJI3XoKYd
	LX7t9KCxXB82MdkgYfTKosktwbSfhqTy0c4RRYA3yP018XgJ59UpP5KS+gzL28Ya
	MNdQYTPbdGSuJ3Gp0KhlB0HpmYmMaWkvgV2m0MZJ/KR86wi1Wp1YVUTk3554BD4k
	QfDQs6P0LHorsPRf5DcDd2kx5vrVN6hCDWm4zIZ1UWSNGOKKDsAKJM1DAELlTBks
	S4T9hf8f+XmTc/RzRy1l4vsJYAjqmUh2OW8/twNxCtbT4YwHyTZezTVjrGOhlYaA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbv9pe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYuUB3268910;
	Fri, 6 Nov 2026 13:17:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka713ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DH9CS31916776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:17:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA0D58057;
	Fri,  6 Nov 2026 13:17:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB9BC58061;
	Fri,  6 Nov 2026 13:17:06 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:17:06 +0000 (GMT)
Message-ID: <eb8ece39-4b20-4028-b1e4-f881606d652a@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:47:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] nvme-fabrics: remove dead hostnqn already-assigned
 check
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-5-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-5-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nEAvO0puJUUU7JQu4ZhnonXxSJBPK7LQ
X-Proofpoint-GUID: uO6Lvr0IrwUa0yCVwMp4mXx_DzyKL1mO
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedd356 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=GnIZ0VSDCOssvsiqXMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX/NDadtG4RtdE
 OQhaCc0X8CdQJnlG+mehX2sMgdydPQfxQ1G1LgkfUASc56qvNcydJ2PlEgeNN7p4+1+Sb6/3+ym
 LD70jKCF6kYG36vrXvxq4cJAwKZtX5g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX3PJQIoWKF5da
 p0Ny7vOqucv/1bEu4cQe3tUjtFboT4WPt/jH7jTu5zmD1zYTDhPHS6DOu+Xb358LDDQT7zkHrA8
 L0Ahdl+IPQj5yMAsojw3EQHJaCxhkG3CYhKAqfftnE1tF1iGOsO56OmS0UW8c17Pp3aEwh2Hecm
 988S6/3PlYpTN0n+p0Dh7EzCYxtiMLvqk8ZDrYGX98a2zkz0liKTQ2w2lwDwbJ2Siubbuct/q1l
 f8PiWTt4wl1HFMA3bQeL5vzIfMB+EJfN1HfaNmcMT+qqSwQXV2Gkel3w7nhVq5uh+HaZeYOW/bm
 erZL8PPm8sti1p9AM2QVmPOJvuhK14u1jH4H/TiN2mCZrENLe32b4sg5kucRHszj1aXOaCLvgbY
 FPf2m5/KSXqIoe6W29iyDYgP4/qm3KuVhXZ4fSEGawvgIy3dIg0UVqItHKFBSMf7w1yM2Pb5/bu
 D6m3RTfmuev2P1aKzAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_051715_705311_89BACFA4 
X-CRM114-Status: GOOD (  12.67  )
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
> The opts->host check in the NVMF_OPT_HOSTNQN handler can never fire:
> options are parsed into a freshly allocated struct, and opts->host is
> only assigned after the parsing loop completes. A duplicate hostnqn
> option is already silently overridden by the strscpy() into the local
> buffer. Remove the dead check.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


