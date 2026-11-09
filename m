Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910A606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Y4hkCtO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FTp+WiVP3QwAuW12y2foExBAgbRglHig0doQXznt+X8=; b=2Y4hkCtOpROdJM
	kFOShBR3WZf9zNnRHifvLtpdUg0nKlsgjdfXEe5n5gaFx4d7GFrXmZ8WQSGqlJhc7dXRU/TvYE/vx
	/yjzP8m4qvmFkWnFu6Qo2w/Bf4/kVrrDCMO8f0jHfuzqhhSiI3iI8N8zJzwQJdCgMCTMoi0Q7Bsn9
	pZAAly3AdJE+SQB1SkjAZED9Oqh8jYSVEphleixiWKfhf7akyQXY211IXpm7E5NUn607We+EAuoKA
	EF6bZs0jxIMH+etdROGgKyFTUczK2gHwXO1ZPssfhHgl/43gac/jxpvu6X4X6zfpKVNxCJmuyYxOX
	LCaXEZpmGy8rQUMhSaFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTT8-00000001NjP-1IhW;
	Mon, 09 Nov 2026 17:47:46 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTSy-00000001Nhl-2DWP
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 17:47:45 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HIaxI3438329
	for <linux-nvme@lists.infradead.org>; Mon, 9 Nov 2026 09:47:31 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ht45ntytk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 09:47:31 -0800 (PST)
Received: from twshared14188.04.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 17:47:30 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 245BA2EB1362A;
	Mon,  9 Nov 2026 09:47:13 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Guixin Liu
	<kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
Subject: Re: (subset) [PATCH v2 0/5] nvme: fabrics and target fixes
Message-ID: <179424643314.2115845.3452565339018703940.b4-ty@kernel.org>
Date: Mon, 9 Nov 2026 09:47:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfX6+4mTAxgvStP
 QY1cJyYpZyK2xMc/431ztizgYrVBAhRyBAZGNPuaUqonfapvD4UaxpXnsuG2p0rvcpzFq+3Uyh3
 P91B5AsrwlHRErD9MAUvRwvFRMxJzlI=
X-Authority-Analysis: v=2.4 cv=FtuQbGrq c=1 sm=1 tr=0 ts=6af20733 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=snonKs5_Zf5ov3HVgT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfXwfuRzpD0nC6V
 hxKx30dgmsG8ON/JTQolK1QCKznaBxW/AoXEoWlN148iMM2YxTp8WggUdUIVgabS29VheyxbVYX
 A/MuE1dzDgH5acE1wwf6U8MtWh/WVYoiwKA4HugG2WWg3dMdqHlPBeqzbC5pLyFVFWV+lnfkxAl
 xd4O9nZDsvsaAJFc5xKS0YbJm/9+7Ay4sU+pb7bHfTST3QH2O9jWFuUF91Vif/onIbtQLsLvt1N
 LZHEpAW83l9dojjaaoaWT2/z95+HzX1W+YNU/8KNZ2nnvNWE1hnXtSsxCTKr82ASAMmLRnSAOZt
 M503Cznx/vs7UJXsiHZd7MaUUOfAe3cVJo8JmOvJK4165rgSq7sPwiggt9rAkCQWRXi4aC1yKcY
 E6/7UKg7jMabtexzvO9NOX5iLW+qLW6OkXdEoSLJdvrRO4y4WrhHc/wviPPDl3zsL27WA7OV70x
 Mu9UuPkljhe2zrSYGWQ==
X-Proofpoint-GUID: fbBGQcvsLJhtfzjXNKUTYwtNJDBCifeR
X-Proofpoint-ORIG-GUID: fbBGQcvsLJhtfzjXNKUTYwtNJDBCifeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_094736_589635_8657C837 
X-CRM114-Status: GOOD (  14.45  )
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

On Mon, 9 Nov 2026 10:26:41 +0800, Guixin Liu wrote:
> Five fixes found by code inspection of the nvme host and target
> drivers:
> 
>  - a reconnect_delay of 0 is accepted through sysfs and makes the
>    ctrl_loss_tmo store divide by zero; reproduced on an unfixed
>    kernel, rejected on the patched one
>  - a use-after-free in nvme_fc_match_disconn_ls(): no iterator is
>    sound across the rport lock drop inside the loop, so the loop is
>    reworked to run entirely under the rport lock and to take a
>    reference only for the match; reproduced under KASAN through fcloop
>  - a data race on ctrl->transaction between concurrent per-queue
>    DH-HMAC-CHAP exchanges
>  - nvmet_subsys_attr_tbkas_store() walks subsys->ctrls without
>    subsys->lock, the same bug fixed for qid_max_store() in patch 4
>    of this series
>  - needless GFP_ATOMIC allocations in the nvmet persistent reservation
>    code
> 
> [...]

Thanks, applied to nvme-7.4.

[5/5] nvmet: use GFP_KERNEL for PR allocations
      commit: 976311c5594a7a26047891f087ad59a804e02baa
--
Keith Busch <kbusch@kernel.org>


