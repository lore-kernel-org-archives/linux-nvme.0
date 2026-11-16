Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16796606A322
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aR47GEBA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2/Ptu2/zmuklqy6bzoMqM+lQ4eEViV98DmCxF38tMdk=; b=aR47GEBAqNP8Eg
	vutRARvruAzD9igqpSQebcFsdqcHORb0e3BOqcdPCua+6AFymfPjmbS9fA20gSfqR2EqHjdaHiQq5
	3Hyz8evDu7gpc+TlJYwst2x/7qNPrqdR724+YKndBzvKoITY6tLSud2RgjyLnSaoTp1W9s+eOoGGZ
	BhaI47j8HskArJXh+srrGzWYuOwIR7tB1HrFl0LylLzKNOrt7z1LqZW0hkUgH7HNH7I0GQzb4XD5x
	B1p3sMnV7S5FmTFk4Y4GD7WCssveCNo8gp2qO9BnQPS9+CdW6/Rgc7DzJvTnCO1dZxp01Xfd87Jp5
	SG0ektCiGcTw5xXlgxdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPz-00000003BLm-39Pb;
	Mon, 16 Nov 2026 16:18:55 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPq-00000003BED-3zow
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:18:48 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIgun2345161
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:46 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp8hjfdw-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:45 -0800 (PST)
Received: from twshared76683.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id A0AAF2F08A7B9;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
        Martin
 Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
CC: Martin Belanger <martin.nvme.dev@gmail.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Martin
 Belanger <martin.belanger@dell.com>, <stable@vger.kernel.org>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
Subject: Re: [PATCH v3 0/3] nvme-tcp: consume TLS records without
 application data on a live queue
Message-ID: <179484590965.648177.17811082474327168521.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: LC8sS8DGJEct7LvWRwM3zcFa6MBI3dJ3
X-Proofpoint-GUID: LC8sS8DGJEct7LvWRwM3zcFa6MBI3dJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX7nteGbxVnvS0
 UTArBye6WojlU6sEU1h3Y2PUXorbVRmBoFPdoXKJNYe8tpsOrMnuIh+IVKuIPHzy+I9LtnSlCeT
 3lFIAO3YY/ZAbSS90aLlUatQ562ZluIZU6j1JdwapreoiUcfUkvsUYcsDhTkI47g7Vx9l/QK9Nd
 jMC1YJu5RTQ1ZaonGHOyUsSzWkk+AO5Al5K9sGgvjZQEeSRE1EQCRkSOGEu88b8mVB34U4glzLa
 J8SQTU9MjOcZqAuquxoSWJk8YFkAAZzB8xIEKWvOu5Ch8rirp14XXyfdH/aHWLWDwcpRx2AeSJx
 LKIpxyrt7Xe2DS+JNvTnGzKfi8y7A0ROh5DbAVhW4NJABreX0RhAW2wvwxGJ1Kgtg34z1rS0QRG
 TrMRPo34V/8gQ4KPU/7qZ98h1kFi3MZaOERg1ZZ1FSGNpElADhQiaKnL9oRiH8yfg1lRDOB4g6g
 RDvPVZB3TWr+v05wGqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX20VrEYJL1tyr
 fwZMCqPgZzaD50eU2fi+/sUkbqNp6B1dby6iIl6CM32I1MsQJHS/rAGNoQPrPIzENh3W6AVlFE0
 vFrprzjZ0tLCD2yfoOqxrUOpkdjA7bw=
X-Authority-Analysis: v=2.4 cv=J+4/fwnS c=1 sm=1 tr=0 ts=6afb2ce6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=LpAHWP_P3Tk2c61k-qoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081847_110937_00CFD739 
X-CRM114-Status: GOOD (  10.14  )
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

On Thu, 12 Nov 2026 16:13:33 -0500, Martin Belanger via B4 Relay wrote:
> After the TLS handshake, a peer may send records that carry no
> application data: a NewSessionTicket, a KeyUpdate or an alert.
> tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
> It returns -EINVAL and leaves the record at the head of the receive
> queue. Since commit 288cfa187208 ("nvme-tcp: start error recovery when
> read_sock fails"), nvme-tcp then starts error recovery, and the
> controller reconnects.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/3] nvme-tcp: use an aligned buffer for the TLS record type
      commit: 1193566c35ead643e954ff8356bb54b1cd78378a
[2/3] nvme-tcp: move the TLS record read loop into a helper
      commit: 76afef5e29221e68f9a19df767f94b092c31e974
[3/3] nvme-tcp: consume TLS records without application data
      commit: 687e743e4089b2a854982b321cb2d681ae5d6136
--
Keith Busch <kbusch@kernel.org>


