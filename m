Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2375606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xubRvWkr;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PxpD47J4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=o+qwrL3lCXyrrAZTV4zs8IXDTxZASwRM2rWjqeKz6Jc=; b=xubRvWkroPUAbD
	mCCtScGv7jJ5eCPCbN3TmRALKdd0cC2GhOuRHhqcmgEg+lKaCU16u3qTLBO/n+MmcNojeY8Artobw
	TgLIeX2O6DkKdqA/7eMMbSEH3IokYTQoVuu8YydG91A1QaCsU0gz1V/gw02OGglzbKmRmqJvcuFru
	sjEUmvI1EZ4dSMvrTWNsaCzA8aMWTAxGwCfaAsaIdv5sSB9mEdEPv/BpQoAwbrMsZxbrAxc4eW/rC
	sRqSHtT3NidSGFHJJuPiNvXpzfY89/uYRinlylA8GAyDuij/x6Fpi/mZHKl3mWBnA2k5ygXVg4NOH
	cduiG28GuQylvZDsq2Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQg2S-00000002nU4-3hKM;
	Tue, 10 Nov 2026 07:13:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQg2O-00000002nSG-2z8e
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 07:13:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA527sv3985577;
	Tue, 10 Nov 2026 07:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o+qwrL
	3lCXyrrAZTV4zs8IXDTxZASwRM2rWjqeKz6Jc=; b=PxpD47J4RE5+BMjtWCVlM+
	lCdrOgkO13ihEMrUy4ZIck6VdMIev0Tr8e2AX0n/2UhMHATxP4QSaNcBx9PX55So
	fO63k+xuOE/pQqP6MZh6TIleHLWQIw69vLEcK19IMahLzRcKLnW3QMSnipQ0Jrzn
	zBp+ucz4NCKtRrLrzTkSKLYg4oR7TDALqAUkZEbQqRsoUe0zSUfsdmKVTnmHK3ee
	BfZNNyPZZ4TqQgL5mTkEdBOPDkaNxyABLWNORG48Vbx7aKoR/p9lpsCr8ZnTBbVj
	y0hRs01o2Npt/XIjr8eb8DE8W/iEhON7lvhBOOu786WYb8n12qWeEEWNnqbgO+nw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt3q9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 07:12:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4K3O31274435;
	Tue, 10 Nov 2026 07:12:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y5841-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 07:12:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA7CohY33751784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 07:12:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8271358059;
	Tue, 10 Nov 2026 07:12:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40F0C58057;
	Tue, 10 Nov 2026 07:12:47 +0000 (GMT)
Received: from [9.61.143.141] (unknown [9.61.143.141])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 07:12:46 +0000 (GMT)
Message-ID: <039cc1c9-770d-4e89-8900-94610abcd3d6@linux.ibm.com>
Date: Tue, 10 Nov 2026 12:42:45 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] nvmet: add context annotation for nvmet_ns::file
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-28-nilay@linux.ibm.com>
 <3ae6e8db-ee33-40fc-baf4-2ec43a32eac7@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3ae6e8db-ee33-40fc-baf4-2ec43a32eac7@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX7C/jLNjqJBWN
 Vt2AxTy4C7410Yejm+OE/JoTjuYexRrA/jwHD1+xhw9dxVCTwUvA85N7SqB/shnRoU1MAPIXwFh
 u/103nsaFEbsLM/7bJl4+rzhGHnmsPG7YrzfCaUOZu+h6CNIwnr4rAbImzf+cLQI2ms8yoomjdJ
 nj7vv56EWDgN8nw21Y8HYdHhxnWtsIJ1DCjCme3HRveyzYMW2qAl4EfGht4xjjbL3ssKLsl41kF
 zFL3K84dOguPqex2FFuZqnLgUY5/zo/r0A63dnl1l0+ZwRfswzKoquEdWcmgcsctzFu93iEV07T
 uAQLlgn/3nDsO562GWI8/2i7O6cms21odHZR6LH3rtLNRbAT9A6kn6NJOl70pvzQv8rbTaMrmGC
 jikX5qL1nL2/BNZ+t8jbkyORnYJQNv9hqPxzylqOPAMO60X59DQKACGY4g64lDX1Pz7bazcXJET
 4MI7usGbpsbjlPTF+Gw==
X-Proofpoint-ORIG-GUID: xFJ9qc-WLq8zcUw2e7hCZ5inOXOkjr9O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX9m0cmH2p/Rc2
 a/e1SPQE6EWSx9fOVyCFgPGOBdCljFzA0hXYnAzoJ/ohR2oW9j2h2T7kKowVSbp+vFJdf47QT+T
 FHAv7oInmk1kgBnavMNir736C/4oewE=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2c3f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=DyS7KQLB6urRRLMGpYEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D9rIBMcYIkzCbBgNh_a4eKV6IlVSj6Xj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_231300_757579_30BD5E00 
X-CRM114-Status: GOOD (  21.27  )
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 3:23 AM, Bart Van Assche wrote:
> On 11/8/26 7:28 PM, Nilay Shroff wrote:
>  > @@ -258,6 +258,19 @@ static void nvmet_file_flush_work(struct work_struct *w)
>  >  {
>  >      struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
>  >
>  > +    /*
>  > +     * The flush work is scheduled from the I/O hotpath after acquiring
>  > +     * a reference to the namespace. This ensures that the namespace
>  > +     * cannot be modified while the I/O is in flight.
>  > +     *
>  > +     * nvmet_file_flush() requires callers to hold ns->subsys->lock.
>  > +     * Since we already hold a namespace reference, explicitly assert
>  > +     * the lock capability here to satisfy the context analyzer.
>  > +     *
>  > +     * Other callers of nvmet_file_flush() that do not hold a namespace
>  > +     * reference must acquire ns->subsys->lock before invoking it.
>  > +     */
>  > +    __assume_ctx_lock(&req->ns->subsys->lock);
>  >      nvmet_req_complete(req, nvmet_file_flush(req));
>  >  }
> 
> This assertion is incorrect. __assume_ctx_lock() informs the compiler
> that a capability is held when it is actually held (e.g. through an alias).
> Here, nvmet_file_flush_work() runs in a workqueue without holding
> subsys->lock. If lockdep_assert_held() were used here, Lockdep would
> trigger a warning.
> 
> nvmet_file_flush() should not be annotated with __must_hold(&req->ns->subsys->lock).
> This was a tricky case because nvmet_file_flush() is called from both the I/O
hotpath and the control path. The I/O hotpath holds a namespace reference, so
it does not necessarily need to hold subsys->lock. However, the control path
invokes nvmet_file_flush() while holding subsys->lock.

I agree that using __assume_ctx_lock() in nvmet_file_flush_work() is incorrect,
since the workqueue callback does not hold subsys->lock. I'll remove the
__must_hold() annotation from nvmet_file_flush() and update the code accordingly
in the next revision.

Thanks,
--Nilay


