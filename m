Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F92606A336
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tjt7fqhr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fFHVGW/qi2aH67mIa0HBYC7MRfeVrxQhZqbVRq/tVTw=; b=tjt7fqhrjNydjI
	Gfl+Nhr5elgXrXrf5iDyNIwm1AkElbiTtHMDsRXR/xjmS1/coop6wo0bLpSBHdQdcmBHmWPBqewQy
	lS5/xy6y20YXK9Ytr9VLR46cFNcahDVKQwwN0T6f35Bwc/narzmQDyWqy6KfKGGBnIV60v5R3f3IH
	XTG2VRipbSB07RfeJciRuFkBxc3UOmWqsgUpJGWPzhbT1QqGukwoiImkfR+T7vAukkO1xT3WH3GLQ
	T+sKlc4ImkqIHUCXbW+m1YsRxDi3UEeIj1GH6Gqratb/j1qjRb6hQydD0JltvGfNXWEPpk/p23p2g
	xws2iU62LfRhaIaH0/+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPr-00000003BFl-2hiE;
	Mon, 16 Nov 2026 16:18:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPp-00000003BDV-0URV
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:18:46 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIgSG2850982
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:44 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxqtnsmhf-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:44 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:34 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 7A3D72F08A7B7;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Mani Tofigh <mt4022@columbia.edu>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <tz2294@columbia.edu>, <stable@vger.kernel.org>
In-Reply-To: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
References: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
Subject: Re: [PATCH] nvme: fix deadlock on nvme_subsystems_lock in
 nvme_init_subsystem()
Message-ID: <179484590948.648177.11478558432754935680.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXy5ssgLS80mx3
 mIFwgjwt8S4W7cgvTh0WoY3An/Mus/WYaBv2zdFRdFf/H1h+HYIK1GGGsGXdv1bvKH+JWo31h7f
 MV6RdbIl4JvYjTc+kgbnY2Z0Ua5XxO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX3S3e18I7mOup
 KqWyn76S0PPPtAE84eeF0dOWCzEdU/KCX6GavPXEwzukkQ+1tGXKllea7Q7RinEv5w94rGhDrpQ
 Sf2UDDY5mtzNJ9yoa4lT7xtGaDgWK8zEM77/QWSN1NkKZPXM4SIig8qEkknkeTpPFK0y0g4byow
 NKQ0kG8bHjF3047vb5qZ4+4PnMcIXKnN9qu0JrPf8fzZRxWolB3zXgZ73dbegWgROT6KZO8SudK
 a9QyNxJ6caUgJqYisuhhhbPXyXO5Qh+AqW4m0JO1+K3qnlFpUTPDri1jh+Vg1G4wCBxZmtjAw78
 0JrO9rwyNtJdpNmYHIY69a8x/7vwAZajNXl3xGRnvJIW3VdnicbWJPZHIuLS4oMy1XOVXlPpPD+
 1o0wOPu94fD+4S+4rPWYZMmTummglryfBWKFMjIfOuyvY3ejEA+c/JmykfeyycFM81T+4wuMP3B
 4cvzdx5hGh8KR1N0egg==
X-Proofpoint-ORIG-GUID: VIuByZ53JdKh1Ftnj9JQ-nU9EpHralL-
X-Authority-Analysis: v=2.4 cv=U6cHnuru c=1 sm=1 tr=0 ts=6afb2ce4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=csGGxczj0hs6o8ZFVk8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VIuByZ53JdKh1Ftnj9JQ-nU9EpHralL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081845_179751_436D9D1F 
X-CRM114-Status: GOOD (  10.76  )
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

On Wed, 11 Nov 2026 17:46:31 -0500, Mani Tofigh wrote:
> Connecting a controller to a new subsystem deadlocks when
> sysfs_create_link() fails in nvme_init_subsystem(), e.g., on an
> allocation failure.  The error path drops the last subsystem reference
> with nvme_subsystems_lock held and nvme_destroy_subsystem() takes the
> same lock again:
> 
>   nvme nvme0: failed to create sysfs link from subsystem.
>   ============================================
>   WARNING: possible recursive locking detected
>   ...
>   nvmesubsys/95 is trying to acquire lock:
>   (nvme_subsystems_lock){+.+.}-{4:4}, at: nvme_destroy_subsystem+0x1b/0x1e0
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: fix deadlock on nvme_subsystems_lock in nvme_init_subsystem()
      commit: ba1213be15c613a1c03db69ea6480ca140a6ca00
--
Keith Busch <kbusch@kernel.org>


