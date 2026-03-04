Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4609AEDEC1E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PPCeHP33qvofEgSpuMY+ASCX/FXcAPOF9YknZCof3s=; b=RlcGqJv5Xa2/84imrzM8ag21T2
	z9O5i1qaJ5ZqUYK9brnNupPY5wjLG8YGydxmx9KQr57x3N53FXu1hnov+KNOeUDAo/9y3efVaHmRR
	cDiU8GjFwQIUI+6gudd8p+OQUnBoO6if/71n+2Y51hPQ/LtP9hCHtpijadXgh6bSABJKmxZIF/bIu
	sAPFhB8R6PM5NodygF54xE+E83IGyF7nUYvwQkQAmralDqyIgBhepq1hgl0DVFrJjQdHIuG0ZrGUj
	USSQKOS64q+hRv//dmXdisL2wLglE68emx2UKq/0k4Vy7qcjwluu67um5O3gfW5zEttpPbPSwQmfE
	JqjuK7QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgmc-0000000Gc9Z-47Kk;
	Wed, 04 Mar 2026 07:36:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgmY-0000000Gc89-3qTN
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 07:36:37 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260304073626epoutp03a6ce63c08f7e7764e5aae227b580b497~ZkzWg7lMW2966129661epoutp03c
	for <linux-nvme@lists.infradead.org>; Wed,  4 Mar 2026 07:36:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260304073626epoutp03a6ce63c08f7e7764e5aae227b580b497~ZkzWg7lMW2966129661epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772609786;
	bh=+PPCeHP33qvofEgSpuMY+ASCX/FXcAPOF9YknZCof3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRVX1Rtnu9detBkc2qBJvq4YsPCA7PRpyRao8N3SWTi2Mbtj55SvKLspQSXYirup6
	 BVjk/aLti+eyxi2ywZ3AjLAEjpN3pfCWwi0FLIDIblkI92kWywWrKZdZPE1zRU+WwF
	 vcllJ5rB7AZtxOnPWGUg5FWUcBxmNryboWXMlQnk=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260304073626epcas5p3f6a8cb566088d737039ce9ffd83ae053~ZkzWBeIO30816108161epcas5p3A;
	Wed,  4 Mar 2026 07:36:26 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fQkxj0zFXz6B9mP; Wed,  4 Mar
	2026 07:36:25 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7~ZkzUNpxt01983519835epcas5p4c;
	Wed,  4 Mar 2026 07:36:24 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260304073622epsmtip139f0fe4255dd6a1be4c1a08abba5f0d5~ZkzSx_EfP1851818518epsmtip1X;
	Wed,  4 Mar 2026 07:36:22 +0000 (GMT)
Date: Wed, 4 Mar 2026 13:01:59 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Jens
	Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
Message-ID: <20260304073159.olmzwf4xr6gvswut@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
X-CMS-MailID: 20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
	<CGME20260304073624epcas5p45099e56c0d1c772b233d03f0cd847ea7@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_233635_440292_97AE6581 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 03/03/26 08:03PM, Thorsten Blum wrote:
>When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
>DHCHAP shared secret. Remove the log to avoid exposing key material.
>
>Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_
Content-Type: text/plain; charset="utf-8"


------x4gpVB5grIOn2U3qr3muLlEaegkXp-1X2jjZVqcl5_K7UNzi=_68ce0_--

