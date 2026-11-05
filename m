Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431F606D823
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=so5jzlyj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UZ0L818EexEq+UXJ3zX7cGKiO6YKJ6Dqmq04WDhB+Cg=; b=so5jzlyjsA9T+4
	puHJB7uNBjHnqXpjej8mioENy6cIuJr3zGGnc3GGceCQeuM7u1+Xqnp115so767m3n8uIJ4OQTHBw
	b3jUPg+u38q8zF3Iv7HQdRmRW1KcAhwW3+Gr/vROJnxIR2VKR0B06XpZ8RbhIugKsKrrohP2jtPKt
	tPb/qbRL7BgHMvDSDDte5m1P22J4L/6QD8j1JUZqTkEB/ObixwGi39Y8yGusKx8qAzOAmxkKPZxTH
	T5dgdNkDq1oEYyswPPURnFo4DEjoch4366KGh5n+EexFiycFE3FN6e1SlkvDpwL0B6XuyLdCY/nxo
	PkMZEFE92Tu68yrwQHTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzia-00000009S4t-0vcC;
	Thu, 05 Nov 2026 15:49:36 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziX-00000009S4A-2cR9
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 15:49:34 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ESnsS4122015
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 07:49:33 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4eerd5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 07:49:32 -0800 (PST)
Received: from twshared91271.16.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 15:49:30 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 690A62E7F186C;
	Thu,  5 Nov 2026 07:49:17 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
        <gjoyce@linux.ibm.com>, Nilay Shroff <nilay@linux.ibm.com>
CC: <linux-nvme@lists.infradead.org>, <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20261105123642.2120548-2-nilay@linux.ibm.com>
References: <20261105123642.2120548-2-nilay@linux.ibm.com>
Subject: Re: [PATCH] nvmet: cache passthru reference in
 __nvmet_req_complete()
Message-ID: <179389375741.2388130.5323937037398379514.b4-ty@kernel.org>
Date: Thu, 5 Nov 2026 07:49:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: VfSi0xhp1xRXNTEeR2nu7HgrgYb4duhN
X-Proofpoint-ORIG-GUID: VfSi0xhp1xRXNTEeR2nu7HgrgYb4duhN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX7TFy5BZet7ta
 4i/jLHn/QEcAiniSEAPAnaoTOH3TgoaESAQmKXE2px9z6AgFB9F+DxdEXrMf1xk6GB6qDDuU0eo
 11fZ7PATuTtfYdjEU1mCtccoQqBAitU=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aeca58c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=MYjjpZqdesER4p00gTMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX4l+PLb1eHGRr
 +w6arF/NqbJlLFPUmqg8P/gg+cLcI3sVnWqjz0SFoV/mpC43ZYn3iHwuVUj0xcBk5qUK2TB3/kH
 J/HwtSNIrhIMyAf1AwdQiL/JFqMK9apuCdYEcplwr5r+UqdMZu23CyINN+bY+9r+q6GcrXFL7XN
 R/RiOQ72agTgl7fIZjmjDSYxbRjHse9gryvaHFuvGrNT5I1owfZmr1G02eSzBsyt0napdgwjS/9
 t2zg4fkQUZRELCgkFlXmVQ8P7MoXcJoO/YieO79ovDLJrPTDCgxOab6qfTkWInrRAu0ZsC8N035
 X4BpbtJcafMzPbkR84vJyx7NApd93sZDTIT3245mZXG9NBY4J+ei4H0BrFQjXdCKgfDF1tiOMAE
 J7P1tkZSMoN/e1cKWt3XZQvmNTzduxdJ2OTl62lCGHrw8vWP/FQB6MHokBTlJVn9pcg6RLN8olA
 sTSmPzcf29hVmql+Few==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_074933_908322_C6AADF19 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.2 (-)
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 05 Nov 2026 17:54:55 +0530, Nilay Shroff wrote:
> __nvmet_req_complete() releases the passthru reference held while
> processing a passthru request. However, it currently does so after
> calling ops->queue_response().
> 
> Once ops->queue_response() is called, the transport may complete and
> recycle the request on another CPU. If the request is reused, its
> req->p.ref_held field may be reset to false before
> __nvmet_req_complete() checks it in nvmet_put_passthru_ref().
> Consequently, the passthru reference may not be released, leaving
> wait_for_completion(&passthru->disable_done) in
> __nvmet_passthru_ctrl_disable() blocked indefinitely.
> 
> [...]

Applied, thanks!

[1/1] nvmet: cache passthru reference in __nvmet_req_complete()
      commit: 93a76fb240be5b7fc1c0d3df1706f7e6396e2577

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


