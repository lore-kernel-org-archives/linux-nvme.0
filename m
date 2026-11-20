Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAF60A2604
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FqxVa49L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gj1b5yHNCRsSxITf+NlL/XhLqaTHJQV7A7mom8aduVE=; b=FqxVa49LpOWlUI
	I9F6mpNepJTJ3epEYaKZLQiWsD1HWmfsm1X98i8QFr08GcSpuP+UuLsnt7OYn288lDcRiKjbUyzrI
	0Y1q7zrzsXmhYY1qL1IeCtgGMJIc5wDIn3TlenX5MYafcG9nH/8Da7+qg146QVY9vhqLczULgB3+F
	15NW1dQHFmHrPNF9ycs7h93RTyB1VoLQ+M+aWkZoswmC//+zoSkiwxqETOTBcnkR897c2b3CLUp4M
	mGMeTEKMx7lyvbrXDKAm8N4lFk1E877E5cP0gFoPZtAfKC/qMLC4Q1tjuM93gSL+f6+Sgiq8rtVjc
	hH80IF/0KrGosCu24ADA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh3-0000000G8lV-3qew;
	Fri, 20 Nov 2026 19:54:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh1-0000000G8jZ-0NJE
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:44 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfbKF4076606
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:39 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2p536-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:39 -0800 (PST)
Received: from twshared80817.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:38 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id BCF5F2F4934E5;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
        Hannes
 Reinecke <hare@suse.de>, Qiliang Yuan <qiliang.yuan@linux.dev>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Hannes
 Reinecke <hare@kernel.org>
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
References: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
Subject: Re: [PATCH v6 0/3] nvme-multipath: requeue work fixes
Message-ID: <179520446477.200156.16466129687568880255.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b00a57f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=ndKsy8TY3o2_kMQNOlQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX3Wks2dGKE9dV
 tTbLwsEn0+zr+XzUFUkrYR8Ej+MnFb9wV8du/vYu6nyaOSv1u3BkUpDclrcysHqplrDQpweyEQc
 N5i6XncB9F9SlPveq46Grv+eo81xAyFCFljOpZmgvcjukyqHkHqOcLxYRy4orEzjbo3duuMkYpS
 3NB9kOWkvI61IzdEoyuyDYQ8n4y335avNwe4qL0oK1GrzD9FNTcgYVvPpOhW+bnssGnYRJwIZ/1
 hPzAfJ5al44/SmSxKyTKbZfsWiLuTE8jJ+6OfmNRAmKODmpiZi8BRhf/jaKhFdQzXL9WqjXJHJf
 F138PfoNj7Z92pFH69jOpHxbDM4VV9GKHEiG1F3LpH9UX33douVgfGYAf+DGPC/PEdgoPsbjydY
 l3ceIZwTsVARqBurc4r+JlY6+H+1KxrqpheSZZhOHVFjFt/FlEJMPxLFe/f00mb3vbz8rkxLFde
 U6aS7v0sGrPKem3zvkw==
X-Proofpoint-ORIG-GUID: vDCz41G2V8ffrsTdYjp55QGmzeDD6e6t
X-Proofpoint-GUID: vDCz41G2V8ffrsTdYjp55QGmzeDD6e6t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX68wE0zI44dR6
 Od6VSLGML2E9dJ14vEi8qBr1b4StLNjCXzPq7mvbVlvf+VhUNtDBZ/7BgnKchbtBV/lcrAzhUGv
 0WWviTASlvFzMOoaWO6taRBg8/NXNww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115443_292181_E3681933 
X-CRM114-Status: GOOD (  10.68  )
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

On Thu, 19 Nov 2026 20:25:00 -0500, Qiliang Yuan wrote:
> Patch 1 keeps a large delayed_removal_secs from wrapping around into a
> short delay when it is converted to jiffies.
> 
> Patch 2 applies a new delayed_removal_secs to a head removal that is
> already pending, so that clearing it fails the I/O queued without a
> usable path right away instead of when the old delay expires.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/3] nvme-multipath: keep a large delayed_removal_secs from wrapping around
      commit: a280772ee0a8a1f2ac769be4d88a5c52ef5ed743
[2/3] nvme-multipath: apply delayed_removal_secs changes to a pending removal
      commit: 536a72ea54f81ebdf56a2a0b31d7dc0fb2837c1d
[3/3] nvme-multipath: don't wait for a grace period in nvme_mpath_set_live()
      commit: 3ca1ccf527aae210ecee2905062dd6da0934416a
--
Keith Busch <kbusch@kernel.org>


