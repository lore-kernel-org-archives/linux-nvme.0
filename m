Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE501606A33B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IdEUJrOR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=es+zIQRw7IaTBC32drouG0t5KhieHio0Lk9afbuliIQ=; b=IdEUJrORFc/MUZ
	vIuBLJRUg2ERYUW9xOYEvtZOCZICgPb31zaU2+kSbOgOngq/SLM2bxM6LXjiWrJTb7Zo7APcsL7+L
	sjw01/2uemU8ButmiqnWbwcJ1gzJ6rg8FJhylmrsDlJyenBEEkBPLFgAfEmAaLb19G9KtzafMK6MZ
	phjBxOWiiZLqn+hB8AqfzQTJKuybhsL4a0zhtyRsvDLUPvmZqwi8TzQ168O2HHol9OvoDx4HSSDv1
	QpV19NE4imXBNzQYzmRDnUIINnaSSS3s1UDEyjsy9nzG5emEM+MWrDHRKwGkQoZYQ78vjIZ5w/Qdm
	OfxFcbv1rd6fAaJx7DJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPr-00000003BFT-272i;
	Mon, 16 Nov 2026 16:18:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPp-00000003BDT-0UUV
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:18:46 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIg5n2653387
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:44 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxnmcsyvu-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:44 -0800 (PST)
Received: from twshared26372.02.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id AEA4A2F08A7BC;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
Subject: Re: (subset) [PATCH 0/2] nvme: use the parsed offset for DH-CHAP
 secrets
Message-ID: <179484590971.648177.3828440087409001566.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: AJh-fWhZRj8WQ3phUdpWsyXIDxLaBog1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX7xVY4PFwNe+u
 WgzyzIHC+pQ8TcQarbHS4MyBw/2S/kQC9bfA5urqMKyvB6DfSIL+t9sHKgPSqx3VmlMsIEERT7r
 Y/9rZ+1Q3zIWG/pzSQAcpywJ457MUwE=
X-Proofpoint-GUID: AJh-fWhZRj8WQ3phUdpWsyXIDxLaBog1
X-Authority-Analysis: v=2.4 cv=EMKTQFZC c=1 sm=1 tr=0 ts=6afb2ce4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=Ru7rdtjBa1pdOxYo90UA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX5Pnz/VcdiYC3
 FA9CvrgXXEI7z0zbQBt33blidJ5nwoACAtFIqwi3bS467gMvL0YDLdCd3+s+AM9RbI89HvpUT2D
 MXcGtOtYZKRstUrNkUAdB75hb+hsFzao0wBtvfy1SmHW8az42bHWa54WCKZok3y14gTvSZYtWMv
 8c5gAMMCQrXFWqUoqoPF87oksV51fgorkP/Lu8PawvY3YWTtmIhfezVk1c9X9MmLRxAMAsTfr/Y
 V3bK0SRhWJ/+lDuppDQFX+C90v40NHPCJYkmP2wU7/jpyahcA32+lRrUL+6W8aNxoR7gdRPoJFd
 gfKJdD4ctuy1XaHooOrdbHyhP504zUDaU1IFmtw+intjJjPuJRdN/FLERSkPOiKNZ6yqMpnF/xg
 ruXBcOKpNA9y5hQlAozhDvkj5Bdz+5HQsB57qzP0zBfhziTsgwSfkN8UlKPHiAgt9s5gdX94hSD
 2JpWun0B0bxmqg1LJ1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081845_176858_85A8C3AB 
X-CRM114-Status: UNSURE (   9.65  )
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

On Mon, 9 Nov 2026 22:59:14 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> Both the host and the target parse a DH-HMAC-CHAP secret with
> sscanf("DHHC-1:%hhd:...") and then skip a hardcoded ten characters to
> reach the key.  The prefix is only nine characters when the hash
> identifier is one digit, so a short but accepted secret makes the key
> pointer point past the end of the string and the follow-up strlen() read
> past the allocation.
> 
> [...]

Thanks, applied to nvme-7.4.

[2/2] nvmet-auth: store the DH-CHAP key offset instead of hardcoding it
      commit: 62dae895f986f7459fea1deebd89a0bce76a886f
--
Keith Busch <kbusch@kernel.org>


