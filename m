Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A99C28E83
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633D120748
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8l8e3FC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KWjz3pED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633D120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:Date:Message-ID:
	From:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vUjmpD5Y2v89WI/g2nbz6k7uQni2B00RpMLlR7efnc4=; b=u8l8e3FCjFT/jDsaT/l+HBHkh
	YC8opoZ0+DZjoHPRdceJ0tznjFoSu0suV85jp6biuH/iVSWSVwJKVKKpbMqu/UgWj/vpER1UlNbsX
	PNZ/RF2AegzMVaAp0Sr7pHq7QoIqMN0VgphiIn3Nd5HYdFuil3DuJl+uw4zeHvvyY/DsLJlbvHnfH
	0VLRJtX1PbO00z8fK/aM51Y7mHpVwefDsVZwhp9Ln17RFWwytwc23w7ySEC8XwZxCC4qnTdFFqpNN
	5Ss4wnhCF9le2EGz7YS6Gg8Tbw5A+NCBl4dIIiL/zyrQzRtXZsJVXeL1Xaw3z5R1q9gxyvWP1Z599
	POcI4GEcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE7kC-0004tG-NF; Fri, 04 Sep 2020 09:10:52 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE7k6-0004s0-Sa
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 09:10:47 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200904091043euoutp0211e83565adc24da9cea6d870658e2a67~xiZtry0Cx1739517395euoutp02l
 for <linux-nvme@lists.infradead.org>; Fri,  4 Sep 2020 09:10:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200904091043euoutp0211e83565adc24da9cea6d870658e2a67~xiZtry0Cx1739517395euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1599210643;
 bh=54l8SETdxAS+gjIWH+2DCQYz9GkWo3yKuyvsIE4SZBg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=KWjz3pEDnOgrHXu+pMjHKB19lJGYyIJId0XhaHQPHBXYRZW6RiSzGD8xHazOVQCo2
 7N0lmqolDD7FEBgt7Ia+oVoo9SU31KByr8//i2mvaU3eLsnvxmBPME7lLF3y1PtJXk
 4Jsgbzb3Y8TcX4AoyE/ZyMxXXUxadCpGP5FBBknM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200904091043eucas1p2b9138e4464dde746fd8f8717a037d24a~xiZtjQG393034830348eucas1p2P;
 Fri,  4 Sep 2020 09:10:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.82.06318.394025F5; Fri,  4
 Sep 2020 10:10:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200904091042eucas1p20b93792a739ddc6627731c980ba7abbc~xiZtKDepu3022330223eucas1p2M;
 Fri,  4 Sep 2020 09:10:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200904091042eusmtrp1ecd6445472be4fde762655912639fcba~xiZtJeORq2938029380eusmtrp1L;
 Fri,  4 Sep 2020 09:10:42 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-12-5f5204938b03
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.E8.06314.294025F5; Fri,  4
 Sep 2020 10:10:42 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200904091042eusmtip15c4f202aa3b6934c463ecd12f52f7f36~xiZsq47eV1936719367eusmtip1B;
 Fri,  4 Sep 2020 09:10:42 +0000 (GMT)
Subject: Re: Is it needed to zero out the dma buffer for
 DMA_ATTR_NO_KERNEL_MAPPING
To: Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bee6cbc9-f637-9217-5f1b-086d93295f70@samsung.com>
Date: Fri, 4 Sep 2020 11:10:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904022801.15828-1-hdanton@sina.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87qTWYLiDe6+Y7FYufook8WBn89Z
 LDb2c1ic6c61uLxrDpvF/GVP2S1+/5jD5sDuMbvhIovHtEmn2Dw2r9Dy2Lyk3mP3zQY2j0kv
 3D0+b5ILYI/isklJzcksSy3St0vgylh/9jJTwWTmipkP97I2MO5m6mLk5JAQMJGY1XCcsYuR
 i0NIYAWjxK2mucwQzhdGiV0PGpkgnM+MEsu37mKEabn99BxUy3JGiS3d+6Gc94wSj5q72UGq
 hAVCJY5dmA40i4NDRMBZYuZ5AZAaZoETjBIff65mAalhEzCU6HrbxQZi8wrYSfQ+/gi2gUVA
 RaKz6SnYgaICcRLHTj1igagRlDg58wmYzSlgJnHi/nuwemYBeYntb+cwQ9jiEreezAc7W0Jg
 H7vEkcdXWCDOdpE4PKEZ6gVhiVfHt7BD2DISpyf3sEA0NDNKPDy3lh3C6WGUuNw0A6rDWuLO
 uV9sIO8wC2hKrN+lDxF2lDg07w4LSFhCgE/ixltBiCP4JCZtg3heQoBXoqNNCKJaTWLW8XVw
 aw9euMQ8gVFpFpLXZiF5ZxaSd2Yh7F3AyLKKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMj
 MCGd/nf86w7GfX+SDjEKcDAq8fDeeB8QL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4
 otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGI9tL+0xc9N4bvJ4o+6X+x2O
 yeu4E+N/6ilqcxx69mTmujWze///kJDZez4uv9TrS1+22E2RP01hm6wPLYpr/9EuLiDJHO8b
 naqb51Onv1r58hffue+n3Zpw0/DX6h7pRcpM57vnBL15cfues9LK7OcO/1wDLxok17rvZLc6
 zulYZpWU5HiuT4mlOCPRUIu5qDgRACDvXFBEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7qTWILiDR7eVbNYufook8WBn89Z
 LDb2c1ic6c61uLxrDpvF/GVP2S1+/5jD5sDuMbvhIovHtEmn2Dw2r9Dy2Lyk3mP3zQY2j0kv
 3D0+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
 t0vQy1h/9jJTwWTmipkP97I2MO5m6mLk5JAQMJG4/fQcYxcjF4eQwFJGiaMXj7JDJGQkTk5r
 YIWwhSX+XOtigyh6yyjx/P1VFpCEsECoxLEL05m7GDk4RAScJWaeFwAJMwucYJT4ucwDxBYS
 6GSUmNAuB2KzCRhKdL0FmcPJwStgJ9H7+CMjiM0ioCLR2fQU7CBRgTiJMz0voGoEJU7OfAK2
 ilPATOLE/feMEPPNJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsY
 RVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2/bsZ+bdzBe2hh8iFGAg1GJh/fG+4B4IdbEsuLK
 3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAx5JXEG5oamltYGpob
 mxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYGzR37o7ZaZDx0LxHctnrV6TdP1qp9/G
 ypZZ0bW1ovqpF9yF3/f7rPj5qt/yeAH/ujMWMc51F9d7WTIxt4Sys39m9r69vz7+qQen8uMd
 vPGpLy00+59mP1zrJ8wV23v/r8YLIenHb93WLno37/2XFM7o3Uve5GbvYrpw4pkk60urvR5b
 67dyf1FiKc5INNRiLipOBAD5Ap/c1AIAAA==
X-CMS-MailID: 20200904091042eucas1p20b93792a739ddc6627731c980ba7abbc
X-Msg-Generator: CA
X-RootMTR: 20200904022817eucas1p1a565e1405b27460e17ecb3447831b8ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904022817eucas1p1a565e1405b27460e17ecb3447831b8ba
References: <CGME20200904022817eucas1p1a565e1405b27460e17ecb3447831b8ba@eucas1p1.samsung.com>
 <20200904022801.15828-1-hdanton@sina.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_051047_135140_07D9F892 
X-CRM114-Status: GOOD (  14.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

On 04.09.2020 04:28, Hillf Danton wrote:
> Currently the DMA_ATTR_NO_KERNEL_MAPPING buffer allocated is not
> cleared while dma core always zero it out for coherent allocations.
>
> Is it making sense to do memset for the attr?

If it is not cleared then this is a bug. Please propose a patch fixing 
this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
