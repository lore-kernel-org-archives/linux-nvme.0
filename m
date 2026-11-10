Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD26606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t1yBe+ng;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kmPbGN0k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rmAo4yIOeIYwdyIs1tLgCU+LsNGY67QnC3JhoQQjCcs=; b=t1yBe+ngfvJ36X
	kJzdCYa18hNIOS7cF+z57tZcN7+Oxu/17pYoE/1wRM6IX8Qk9w+r6S4d2s8h9c4CQV/c/AwNYPETJ
	NwUoHEEWLkjYPLwiu0POxl12zVqrXkHzaWox8BeV6FaDY+fhsu68l6rPo37352RH7ncTI+Rpb5AfO
	m5K108ECz1q8G8l4t01HFKD9V6Z+dXDJbciLmQQ/nVIExvlTwr1pWj0pb6szItVQSaSbCRbKSo0Tq
	SXjD3i6PILOYF/WACN+mbkugEVO0X6B6DAIFkOZNRXayFHb1F+ujkCa1uihCdHToDYHgVhyrxdkaA
	nTo25kNTYYWpf5jTRrlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQfVn-00000002fUE-0B4X;
	Tue, 10 Nov 2026 06:39:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQfVk-00000002fTB-3rJE
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 06:39:18 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA52RfP1633055;
	Tue, 10 Nov 2026 06:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rmAo4y
	IOeIYwdyIs1tLgCU+LsNGY67QnC3JhoQQjCcs=; b=kmPbGN0k3LMYNJ9/zCZcr9
	wvXZLXOyNpbM6pB8dIgPg2AVCX4n5qpjdR7QnRqsNe7BVmCWPNPhKMkNtk8V0LdZ
	LvAzhuTpZM0+uP8BzqRH5kHk7VlnHlRMNcsSMFHR170fUBecjUJ4NfihpGD99qtG
	cGhooWdh+XNdnm1CiYEyRFXiMwclfdNCytRM+2L9Pn1BX8MW7Utsgo+aEObbefxB
	0gouFIGtTX/w2bz+DC2QLjw2zbJIXcc/BkS/r49xTpdDWXqnKhPjeZtV9uXHRHA4
	u6fBkgOO2h0JVa0Vz0IHBSBgHPzylpaq3mKdo7Md1nUmzOjbK0oPuPAgBuj60msQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug63j4v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:38:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4Z3bl1270156;
	Tue, 10 Nov 2026 06:38:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvwk2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:38:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA6cm7e44106188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 06:38:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3716B58058;
	Tue, 10 Nov 2026 06:38:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A4758057;
	Tue, 10 Nov 2026 06:38:45 +0000 (GMT)
Received: from [9.61.143.141] (unknown [9.61.143.141])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 06:38:45 +0000 (GMT)
Message-ID: <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
Date: Tue, 10 Nov 2026 12:08:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: teWs7EFdGdWZY53MEPab8NdZvb6T2YwY
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af2bbfa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=d0YMCUcj39D29oVKZ0cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bQX-p7aNWOAeLWbTPICCJhinN5Nsq2ls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNCBTYWx0ZWRfX+cYSgF3e+bJh
 tBX2DquQqUnL36JDO89a+DdG/b66cnFXIMTqz698TjvOqKjOpIOjVBkjJVTjS+SkU01qIUPc4Sg
 fe9MizvCVyBdzerv20idl52MSQ9LwUB+kYtLZLquBdksge2jUG3HjtBl+IpRDan3F+T4bwRLpmx
 ztYnLPf7osp0emhYm5kSspwEPayx39obOoEgdjS/CRuWtuXS0obPQZOHDW+j3LgRA2vdS3uboeO
 yU2gxB00B1ABnWkvYL8LkkvP8DRT7QlTCx4/Bn1dDxr3+2ZKWS8Kx+5jIQ15/csPLPQYqEazGcX
 TZeOxef3BgQrCXoMYMmAwTuFzWzxgbrhHn6jhMMBLSaHzX4rc7KPjeLp4svLf25OzqTzolzXOj1
 fhcJphXV0Ik9CIix7bE4qgFC1gjcQuBbbHmWZ+6x274XJZbJT9u+Z7tgdXiJFnBTe/yghfIn+Ex
 8Xy6BkHMe0ljCoNp92g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNCBTYWx0ZWRfXwpduZxnZPzgk
 GRvQUWIXFwSUzYVLhNje82/Ym0C3iNRiRvIAgsijkHPWv281V+GqIG1Qv7rzmGZLgj73FcQRH+X
 aLfIPBhwVU9tLSj9t6iVDAPt6WBZ+98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_223916_992631_E38FE9D5 
X-CRM114-Status: GOOD (  22.22  )
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

On 11/10/26 3:16 AM, Bart Van Assche wrote:
> On 11/8/26 7:28 PM, Nilay Shroff wrote:
>  > The nvmet_ns::bdev field is protected by nvmet_subsys::lock. Annotate
>  > it with __guarded_by(&subsys->lock) so that the clang context analyzer
>  > can validate accesses to this field.
> 
> This patch introduces a compiler error in nvmet_get_smart_log_all() when
> built with CONFIG_WARN_CONTEXT_ANALYSIS=y:
> 
>    drivers/nvme/target/admin-cmd.c: error: reading variable 'bdev' requires
>    holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]
> 
> This is only resolved in patch 02. Please make sure this series is
> bisectable.
> 
Enabling CONFIG_WARN_CONTEXT_ANALYSIS=y only enables the context-analysis
infrastructure. The analysis is opt-in by default, and individual subsystems
or source files need to explicitly enable it through their Makefiles.

I haven't enabled context analysis for the NVMe target subsystem yet in this
series. My plan is to enable it by adding CONTEXT_ANALYSIS=y to the NVMe target
Makefile in a subsequent series, after completing the context annotations
throughout the subsystem.

Therefore, with only CONFIG_WARN_CONTEXT_ANALYSIS=y enabled (and without
CONFIG_WARN_CONTEXT_ANALYSIS_ALL=y), this patch should not trigger the reported error.
Could you check whether your build has CONFIG_WARN_CONTEXT_ANALYSIS_ALL enabled?

>  > +    /*
>  > +     * Both ctrl->subsys->lock and ns->subsys->lock refers to the same lock.
> 
> "refers to" -> "refer to".
Okay>
>  > +     * However there's no way for us to annotate such locking semantics
>  > +     * using clang context annotation. So explicitly assert the capability.
>  > +     */
>  > +    __assume_ctx_lock(&ns->subsys->lock);
> 
> __assume_ctx_lock() wouldn't be necessary if subsys would be passed
> as a function argument, isn't it? In general, I strongly prefer to
> add a function argument rather than using __assume_ctx_lock().
> 

I agree that passing the lock owner as a function argument is preferable whenever
possible. For this particular case, I tried passing subsys down the call chain to
nvmet_ns_dev() and annotating the function with __must_hold(&subsys->lock). However,
Clang still reports a locking violation when accessing ns->bdev:

drivers/nvme/target/nvmet.h:213:13: error: reading variable 'bdev'
requires holding mutex 'ns->subsys->lock'
[-Werror,-Wthread-safety-precise]
213 |         return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
|                    ^
drivers/nvme/target/nvmet.h:213:13: note: found near match 'subsys->lock'

It appears that the context analyzer cannot infer that subsys->lock and ns->subsys->lock
refer to the same mutex, even though subsys and ns->subsys refer to the same subsystem.
Consequently, I couldn't avoid using __assume_ctx_lock() in this case to explicitly
establish the lock capability expected by the field annotation.

Thanks,
--Nilay


