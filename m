Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BF606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=poUnQ7w7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Krn6sHNbWGL3g0USCr748bTx8WgOWOFCbpbRKspf7Bg=; b=poUnQ7w7p0ye9d
	64CW4hh2noIQQPsS4oLBp1tef4dWCoQUyenoLiErL87AvMYjlG4B4t1d9pDgiBbFr2NWnitiQ4loL
	rCc7307zdcJtthVH4l+sdPLgQ27ThBCKauKrIbj+z8tdFxX8lwS02hohCo88M4OY0FocDGoXtcAeg
	CobhEL5AOIj/eK/w6b7064NdddWRO79FZ7e/ctW4AIdO05+2tdeEmPt7mrWxuzrOflbuLQdL63Yoh
	3dcsskaUPk5PrJs8cBTZBIUUHd/mfmtRuvV4zOPAwlILZb0En1QebE/B6sha+GgC6OHo/oE1/DuYW
	BE1D/AyUcOXDohRKkXxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSySJ-000000031E7-0wys;
	Mon, 16 Nov 2026 15:17:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSySH-000000031DF-22YA
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 15:17:14 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxolY2317469
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:13 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxqtns4rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:12 -0800 (PST)
Received: from twshared94520.16.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 15:17:12 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B4D012F083091;
	Mon, 16 Nov 2026 07:16:50 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>,
        Platon Miller
	<platon.ksenzenkokk@gmail.com>
CC: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>
In-Reply-To: <20261111000941.105115-1-platon.ksenzenkokk@gmail.com>
References: <20261111000941.105115-1-platon.ksenzenkokk@gmail.com>
Subject: Re: [PATCH v2] nvme-pci: merge duplicate 1d97:2263 entries in
 nvme_id_table
Message-ID: <179484221073.249619.4485064743686192660.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 07:16:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX83CZPglk06Iv
 wH55bsPuvTNaac+iRypxmmQJT0janDkZ3c0kAz6Urqy6snDIUy6wdPWTYOaQf99Z0gsRboLyKGQ
 WNLUzULeRL6EBNrlY8y1zGyuYoKyG5k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX04KqWknlXJSB
 mUl0wRr2kow5S1jTOyaqmXZyfYBLhzGJ1zBfo/Q8wm8BT13oxWIOsKlTE+j9k9QGgsWoGKY9Hiy
 MfAPX/y6oTazNIijRu33aR+mQB38mffGrXava9hJdFEelWFCMA+azmfB0UrgfcjG+9ZwKimCco6
 0weib90mCGozaJ458QRKG8esi9rml+af5WMvk7ZrRFTdFzMskUlBJZJxpKjhsNba0nNQYJc+Qr4
 VppY3asbWV4qrFcuYliNJRNkTZ73v9eFHaaxjZFK2Mvpc6vjJgGPVQVJkTBSA77mxKZfJpIUavg
 +n7UlLFAH+TjadnuF1Jg/H9SQrg5M6fHkpxySXP5HouePvq8PNxz5tLutXZbwgBCJ8px17oEwiD
 tnXrta60QDdrXjlKLf3ovQhCeUFNzkj4Z2BifLH3Q4SwYUkCm1s/pb2uz2B4uNpM2U7ucplbzmY
 M92pf+m+GtJr6uKoaVg==
X-Proofpoint-ORIG-GUID: yAcdXVy2mbOs_C6HmQdncijxr7zushLd
X-Authority-Analysis: v=2.4 cv=U6cHnuru c=1 sm=1 tr=0 ts=6afb1e79 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=LC57ixmKOzSN-ZM-V0EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yAcdXVy2mbOs_C6HmQdncijxr7zushLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_071713_554103_543AFD53 
X-CRM114-Status: UNSURE (   9.11  )
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

On Wed, 11 Nov 2026 01:09:41 +0100, Platon Miller wrote:
> The nvme_id_table currently contains two separate entries for PCI ID
> 1d97:2263: one for SPCC with NVME_QUIRK_DISABLE_WRITE_ZEROES, and another
> later in the table for Lexar NM610 with NVME_QUIRK_BOGUS_NID.
> 
> Because pci_match_device() returns on the first match, the Lexar NM610
> entry is unreachable, leaving those drives without NVME_QUIRK_BOGUS_NID.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table
      commit: cb21777e86a33286badffe5fa76c6a0acb086cd6
--
Keith Busch <kbusch@kernel.org>


