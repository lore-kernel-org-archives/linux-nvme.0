Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BA606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aw0/GCk2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bybJ74v1qaLFWWjXXCxTlpKe40sCyNMaTyKfkM33dek=; b=aw0/GCk2pnIuyb
	06u4SRnaT4H6SwhYBqh5He2ndk3DYzc8lcX6QPxLE6iWSP4sVBuBaMF3QR0hLyavyLnz3NGJNefGU
	AfXj/IK1/H0MJ2fQGkcBiR81iFLOFxHP7I83fczonPmN0s86bpYn0I9gNzCHs2O17NDgC8d74Db3y
	KlubnYiUYLj42U90rvq3t8fTx8az9LN7OV57c1ekGSdMIfWDhOsEDzIVtFJJfS4By6JDx8kYoqPBg
	6GOQej1wJmohMqE33LLNNJP7ynfWGQFIwZKZdOcnqct6WTj1k6TnNvn6c6NmjfxYOhP14sR9M4OSR
	5XYQmO7inu5TM5km+qHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZg-0000000D0Ig-1Zyd;
	Fri, 06 Nov 2026 16:13:56 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZZ-0000000D0Df-0jmO
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:13:54 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A6F2O3E1024418
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 08:13:47 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hs3r0vq5g-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:13:47 -0800 (PST)
Received: from twshared119346.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:13:43 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 505BB2E8C4A3C;
	Fri,  6 Nov 2026 08:13:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Yingjie Wang <1075151112@qq.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Marc Olson <marcolso@amazon.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <tencent_1B8D08FB52E404EC3FE4933548D6CACB7305@qq.com>
References: <tencent_1B8D08FB52E404EC3FE4933548D6CACB7305@qq.com>
Subject: Re: [PATCH] nvme: avoid wrapping admin_timeout and io_timeout
Message-ID: <179398160932.3651019.13151076267565610184.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:13:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=Cucq4X4D c=1 sm=1 tr=0 ts=6aedfcbb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=tWdNHjRbpVsFhML1pWAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: FXRSa_fyMEeWkFl61cZIIXwOFUUfm7Xo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX/N6Up6LXcegH
 YSZp0SvY8+jjWCwPFFuckFHLD8gt5JkP2zBPSkS0gnwvjMbVltcTKjvfqiGM4alQBJEkDR7HGsW
 Jmagly8afk3hmZT/LSiHCiR6P61JPK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX8ocCH6GMnKje
 fg7mmU4Y699tN2jUqrEUkIwPo5+UWKkpuQV8o7onbxD4HJPUq7D8IECWQeJ1KeprRk8t8gTdI96
 PAHMYZVuqd3PbtKz179i1G1F3FSe4cAbQLQvvdT5XYRNhRupIjRMKhIGZ1ymu3Q7xT9yNUEG4CF
 B7KLohIU1oBfbHG4ItP0ouxUpzpQSFAMgiasz3bQAgQNgPxbjXRU7o9E2Ad+dKy0CMx5jAfDeR8
 hAmkp9c04qyoJjT9Nvb8VABqgSJG6FyotfRdOXPSugPEbdmlNwarjygJ6KpL9gF4YVEQRvfBiEN
 pcxArpM69a0HKH5UzFMBNk27Z5/tMjOqzbB4jiee4ZRAhpz1yS983gaCWzbW74DvvFtn2ugqKqs
 jkVSSoLaQnvpKP5LzpM06/3Z2ZoW2TAseRHqgp92PcTs/iXn/IB7GYgYwqqN8SUmOG6qRCTHCgk
 nSnCOgnCuR0ju0qTW0Q==
X-Proofpoint-ORIG-GUID: FXRSa_fyMEeWkFl61cZIIXwOFUUfm7Xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_081349_361859_9A2CDDF1 
X-CRM114-Status: UNSURE (   9.52  )
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

On Fri, 6 Nov 2026 14:25:16 +0800, Yingjie Wang wrote:
> NVME_ADMIN_TIMEOUT and NVME_IO_TIMEOUT multiply the admin_timeout and
> io_timeout module parameters by HZ in unsigned int arithmetic, and
> nvme_fw_act_work() does the same through secs_to_jiffies(). The parameters
> accept any unsigned int, so values above UINT_MAX / HZ wrap. With HZ=1000,
> io_timeout=4294968 becomes 704 jiffies, and a controller created afterwards
> times out I/O after 0.7 seconds instead of about 49.7 days. On 32-bit
> systems, results above MAX_JIFFY_OFFSET are also unsafe relative delays and
> can be treated as already expired.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: avoid wrapping admin_timeout and io_timeout
      commit: 4a5aeebf1a00360bcc53c9e29fcd8d47aefa4c1d
--
Keith Busch <kbusch@kernel.org>


