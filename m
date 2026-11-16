Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B4606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NGvGC2Ox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qLE+dNHMVul46wdjyF1Bg8i6YNmerSwnDD32qfigVg4=; b=NGvGC2OxJHOpOo
	XlNB74eBFPEGn6ml+cF6UIlDRAaMHO6zG4vvqq4vz3XB1XL+kSD7TVB/fkv7rSiVFxfnzk+L7HmHV
	2/M2p5z2x+/WW7BqSRQXC33GcDJ3eKheIoLebKgpSOEwPkztQ1BUzr9TZveHkNINeG/l0SncZ3qoU
	F87B+v6IMAaYOeWzEZlMXeUTBMLqezPTb0ULOLxUb+R4C/A/9QFGvUPLbdayR5aVCUFvuKB6kKmLT
	DsAP9tST5mieRHmW0a/XTAxriHwaxOnycx6z7Ee4TVLVtFn6rZVwNqcxaHSeOYnFwJbcnFtmtnJ2K
	BiUXQDm1ZDMzYp0rP5wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSySP-000000031IT-1rBL;
	Mon, 16 Nov 2026 15:17:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSySL-000000031Fx-1pxt
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 15:17:18 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxoli2317469
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:17 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxqtns4rn-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:16 -0800 (PST)
Received: from twshared25295.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 15:17:13 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 3A6F42F083072;
	Mon, 16 Nov 2026 07:16:49 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
CC: <hare@kernel.org>, <hare@suse.de>, <hch@lst.de>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <sagi@grimberg.me>
In-Reply-To: <20261109142428.2612-1-sreekuttan2156239@gmail.com>
References: <20261109135536.2772-1-sreekuttan2156239@gmail.com>
 <20261109142428.2612-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH v2] nvmet: reject invalid write-protect feature values
Message-ID: <179484220923.249619.10986402925266130295.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 07:16:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfXxbZOIKIWVEM8
 OWsUo8jYWu+aVAf+6VbTAP5JaUnI1tAz7dIJQk4pEF/RodN8WxlmGW4yBgb34RJ3EAcbeSrPmNW
 QNSLPtOsucD8TuLd9TOwfpttrQbAB6M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfXzuNsntqKQ1Td
 E3szSjB5m7UvFICiZefNW0xGaw2nSHLpU6Ck+6tr2p++SrVs45ENw3Pd08g9ww4KVlrfjBCf3sO
 IOSVmbVP1mTNWeO4od9xRn7k+9rFr8wEYvr5B4gySojAzSiV9cCllS7m65Q1p+u5Zh1VK1s0zrF
 M2fgKyOm9285FemAcWv45GAExxU6w7uZ7haawWtleMcIdGFbLZ0SeOyDmvbTRCUcZHuA97y/E12
 YIe2YK9At7yXfhzADjKu47jXwrmKNtQU8nwHuq8VxNXhxv7yYm50OKNckZHuU4uTS6e06lqDHyf
 nLRYHVsCymraME80XrIdVVfijvmGbua45IHtxXIIsy+esFmXJpQdo27ESZNpnQvXEGzc7vxpoY+
 7mppeb8du90on/360H5TIu01xJm54WWq1sZ05YJvhyLP4pxLNKpMUzrNxbC8Oa3P610/3/AcgEW
 2KfaDLb/aVzdItdL00g==
X-Proofpoint-ORIG-GUID: sx56NtdKy0_22NxsoAMYAzzBSvc3H00R
X-Authority-Analysis: v=2.4 cv=U6cHnuru c=1 sm=1 tr=0 ts=6afb1e7d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=0lR0l2LAFdUcI9J53v4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sx56NtdKy0_22NxsoAMYAzzBSvc3H00R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_071717_484156_DB159202 
X-CRM114-Status: UNSURE (   8.62  )
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

On Mon, 9 Nov 2026 14:24:28 +0000, Sreeraj S Kurup wrote:
> The Set Features handler for namespace write protection currently
> accepts unsupported values. The default case in the write-protect
> switch leaves the status unchanged, causing the command to return
> success even though no valid setting was applied.
> 
> Return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR for unsupported
> values. This also prevents issuing a namespace-change notification
> for an invalid request.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: reject invalid write-protect feature values
      commit: 21f0f264962358f3af6e08805b21d32abdd0e35f
--
Keith Busch <kbusch@kernel.org>


