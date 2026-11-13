Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD1606A321
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vb0lKzzh;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ODBh6LFd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jlDiw50da1bpygT1Ba82wOS+ut81qFxGdkrF9mZOhak=; b=vb0lKzzhaAUXtc
	caaNflSTIroJzt2ONf0MfjZPUTXpXBXu4+DJsA+GYc4zEKGWUZEITEsDeAcWU1unuvM2491BCLwJK
	X6bEa4aYtNZrVDgGQBgooGm1aBzyCLGIZW9bz2UXNr22Z4X6o3BhKxa+nqENDzV597P4SIgckv8uv
	G3Dcz0PtBdHUTtAluEsl1bz7Oz8IrjUa2vN6HzrfrmZHwTDPiMMEGdZ9qXU3ITPbtz9qXVxHPsSB7
	cr4TIvz9d8P84ifjMUgG55OPWjUB2vvukkZvrwe/mZaEJd453j4F8Hvb9qKjmD13mA/V+CSxx41nr
	pHFNuk8YHV0xh1thTq5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoOh-0000000CLD6-2rog;
	Fri, 13 Nov 2026 10:20:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoOU-0000000CLAP-0sHO
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:20:31 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD9XjGO2433727;
	Fri, 13 Nov 2026 10:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jlDiw5
	0da1bpygT1Ba82wOS+ut81qFxGdkrF9mZOhak=; b=ODBh6LFdawtSJwGa89ZoIT
	v3WUt+HSxcECnQK3ZupbpMWijCwcp+HA1JHti9lIHxw++wwPOprgP94D0qZXDuF+
	KABu7na3qAK20sLTIE6vWylQ+QzrBwDxglKzvKvO5MH45yCmZJcZOmCQP2EyFWSU
	jvo0nupQy1OYc4Xud0U8f7BhBMg/eCAFt/rmoDosZMhMaxHE9a2jwrI2eSMi/2eW
	32JCgum7OQwvj6sSnDZn+Z0JLxeVNyU5MRfDUwLqgt8Y08x3/7mLh1e9uygQiWwL
	uq8QP3siBfjKLY0BhILDvAzqbQ1+X/TxcMzSDd8bOBqfSDnwMA2Sl7faNEK49EaQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdm26p1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:19:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8YxVd2053888;
	Fri, 13 Nov 2026 10:19:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwjcf2c9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 10:19:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADAJol654591878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 10:19:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 132E758062;
	Fri, 13 Nov 2026 10:19:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D42958057;
	Fri, 13 Nov 2026 10:19:43 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 10:19:42 +0000 (GMT)
Message-ID: <469c4d3f-e181-4683-85e0-42046520c096@linux.ibm.com>
Date: Fri, 13 Nov 2026 15:49:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: clamp the last ANA group index against the real
 array size
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aurelien Aptel <aaptel@nvidia.com>, Jesse Taube <jtaubepe@redhat.com>,
        Rongzheng Wang <testwrzwrz@gmail.com>, Kees Cook <kees@kernel.org>,
        Rosen Penev <rosenp@gmail.com>, Guixin Liu <kanie@linux.alibaba.com>,
        Qing Zhang <diasyzhang@tencent.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Julian Sun <sunjunchao@bytedance.com>, Yu Zhang <yuz08559@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af6e448 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=R5C9hjxsAAAA:8 a=VnNF1IyMAAAA:8 a=8NlKVBlaoI20-McazTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfXzw13hhiyG+wF
 rXEIcoV/5K8+0UCyjBuXbPWx4FGnIi/qjW2MnzXTv+p0fCP6vdhX93agcYUNvWIQwia2Tt6wtxw
 n/4mjdMY8OUGuNMTMYc6jMdax+TD6BwyT8YxZnzgPgNA2VVRndRUUQY73pJPRb7zqR3Pl9FUkz1
 8qvtotw3vi+6blxLs+oIrivZ4SakK95T/j0mEMtVaNfryQdf04qCSvFlj6tVVyhu/ElRk1Rzivb
 Q4yrXkWTlopjGcpauW6Fnzk5aYMrXDPt9xhUo6xG7Ty13nhPGEJ0I2QTvj88Ozt/lN8Zp9/f4PC
 re1IqvxTRI1uk82AmY3YHe//L2hmzvZN1s+ET8iPTWyqczWhLH5Ywp3wj3EjuIouNAMjZFXa4Z0
 RcFS0DAJ8cPZZWy70nFHwg9M5Ec7eGNEAum5Ptg1bi0Wh8giq0olr0ft3N2Vf8Ixn9gvVFpJ9Ie
 VI2uEfkSOwjSfJ0rvjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MCBTYWx0ZWRfX90dKP0kLBoiq
 zMWhdYAlAGC398LqSAPp0d1FcDjSmHv4amKjuMx9jaUj9mvOxBa9pzphQ0cL0o2H4RBXX+2dUBn
 i2/pbPOZ+vcITl7z0+5RkxjS+a9yEQg=
X-Proofpoint-ORIG-GUID: WGqD4QEluci3Qqt_HTrF8yLOAi9106CQ
X-Proofpoint-GUID: 4irKpK-_jkCRuBryP-AgixV6US0C8Wy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_022030_374895_241CE1CB 
X-CRM114-Status: GOOD (  17.59  )
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

On 11/6/26 12:10 PM, Yuehong Wu wrote:
> NVMET_MAX_ANAGRPS is the highest valid ANA group id, not the size of
> nvmet_ana_group_enabled[]: the array has NVMET_MAX_ANAGRPS + 1 entries
> and the controller advertises anagrpmax == NVMET_MAX_ANAGRPS.  Both
> array_index_nospec() calls however pass NVMET_MAX_ANAGRPS as the size,
> so for the last group the mask is 0 and the index quietly becomes 0:
> 
>   - nvmet_ana_groups_make_group() increments enabled[0] while the group
>     keeps grpid == 128, so the later nvmet_ana_group_release() decrements
>     enabled[128], which underflows to 0xffffffff.  The ANA log page then
>     reports group 128 as inaccessible forever even though the configfs
>     group no longer exists, and the increment on enabled[0] is never
>     undone.
> 
>   - nvmet_ns_ana_grpid_store() accepts 128, stores 0 in ns->anagrpid and
>     returns success, so the namespace silently stays in the default ANA
>     group instead of the one the user asked for.
> 
> Both failures are silent, and they change what the target reports in its
> ANA log page, which is what a host uses to select paths.
> 
> Pass the real array size in both calls, so the masking is kept but the
> last group is no longer folded onto index 0.
> 
> Fixes: 20dc66f2d76b ("nvme: prevent potential spectre v1 gadget")
> Cc:stable@vger.kernel.org
> Signed-off-by: Yuehong Wu<wuyuehong@cmss.chinamobile.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

