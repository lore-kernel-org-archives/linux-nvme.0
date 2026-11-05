Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123D606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2mDptQEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aUMrNCDsaT2L4Fm3m1UuKgy4RX6seoHkuoFzSglz9J0=; b=2mDptQEM9SiaF1
	x4dPaO6EQHMUXC+uXFDR9JAfd1XqW+3pkSsSADglNixgqm4SLf3bjYW2JtMv/Db4gRAvetkfJj+DN
	OjzKFOvppTEm/YEAghVbvKXY1ixgy5Qy6kM07GHIFQmMFf1a1WQYMnB9fYPtF8EUXaVNjYnSmEK9d
	+lUkjnYJSIvdNhioGE873YTweVWxtYJH1WkTN40HBknGtQ0gg80Wp2BopCj5pIHLGgtTcdHutIimV
	eZizMC2+diDgatf5amMLj21MVI1M98WcK+xhWpt8xvm8OSWoJUxE/7Kc/2Bfe6d35pOBVFXlyeVCr
	t0Iw6Y8EKC/tCM2fn/VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzOc-00000009PHo-4AKf;
	Thu, 05 Nov 2026 15:28:58 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzOa-00000009PGc-0bT5
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 15:28:58 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ESpDK3897571
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 07:28:55 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hru4rgn0x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 07:28:54 -0800 (PST)
Received: from twshared41458.33.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 15:28:52 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 88C1C2E7EC6EF;
	Thu,  5 Nov 2026 07:11:31 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E.
 McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Qiliang Yuan <odys.yuan@gmail.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
Subject: Re: [PATCH v2 0/2] nvme: fix removing namespaces under SRCU
 readers
Message-ID: <179389149154.2132554.14217810992959275448.b4-ty@kernel.org>
Date: Thu, 5 Nov 2026 07:11:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX39LrpUqNA/tV
 xFODvwieoRByRbrdl2TSTX78k5l6mC9foSOOKOwArg+HiK0JnXk9F/ksLfbwkAVIIBD9aPjooHG
 tdjFEesX5IRrjol8aYdUlg1Ndfc+NoQrgYKKvWfBSsyk7q4yGHHRbw9VcaptVZe46sW/cgAx8X9
 AuEPCmhrzaLpT7V80FHi5Ba/7Ce8ln32PLOhZmm+8k52mDUHAdA+ayxVYokxhqWjZ/y6jDcTS4J
 OpdkVK1nR3RX68efCXObOwt6C4w8VCqI2m/3na3m/HOaKVVs/N+8+VpuREfbiIzESBvTO6Uz7t2
 HFaPlAFmu7M0oA1zwgJtPUvo+VFJlJwBs1Om5YGjqWJNJwGVc8c7dkOEuE6eJuLcmYUSk7JGXpZ
 MeAhsLqmyZG1tVhGFG0u94To8Zc6eSsTm8CxJwXJ3SquOaLZKwpPeslq2cuy4cG2ERw3qF6t6C1
 8f+5NvJcm65M2WiTtSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX7N2DB7GBLx3M
 NoQ+QHbnZOFBEPcI9Y9ZVyB+dUQHsilB1hZeWjKhGvQqtOSoZ1i5VLGN0rxCwh0KBNltZFxP+ZY
 m00bt46QsfJ4q7cBH+Da3r7QW9KKER8=
X-Proofpoint-GUID: SnmCdVjVtdVWvTP0qZVCJI70PnAMxCpv
X-Authority-Analysis: v=2.4 cv=TLPQ2Fla c=1 sm=1 tr=0 ts=6aeca0b6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=DbJdtLyL_UCRUlSBl1oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SnmCdVjVtdVWvTP0qZVCJI70PnAMxCpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_072856_300117_2AFF7282 
X-CRM114-Status: GOOD (  12.81  )
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


On Wed, 04 Nov 2026 01:30:38 -0500, Qiliang Yuan wrote:
> nvme_remove_namespaces() splices the namespace list with
> list_splice_init_rcu() and synchronize_rcu(), but the list is read
> under SRCU. A reader still on the last namespace can then walk onto the
> on-stack list head, which KASAN reports as a stack-out-of-bounds read.
> 
> Patch 1 adds list_splice_init_srcu() for lists read under SRCU, and
> patch 2 uses it in nvme. Both are needed for the fix.
> 
> [...]

Applied, thanks!

[1/2] srcu: Add list_splice_init_srcu()
      commit: d06917d0ba226206dbd606330d73a8eb1e3029c1
[2/2] nvme: wait for SRCU readers before splicing the namespace list
      commit: 8a0449832b50cd4f99f2d2952cfc1476e5f26d0f

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


