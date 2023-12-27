Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81896C46CD4
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+O0oPr+Mg6QszQgfZABvkLHy4AjtH4pOlEZxLxJuPoU=; b=tI6TeWIVJi5hwiY/xAEzKndoZv
	26LDQS2mMAA4iqA2CKTXFHn/DuTqB1BYeECcbEuuuPa7v741qndxiBrSQFOKsrMPudTTCaMkEsJFP
	WNcM8HnSXNHbCh8R2FaVrLhXBa6Q3pqFqwkpxAYXCobFfxLWcB955pS7BpGHDZJJd5yv8VZC6vRwd
	MiVFRnbNPXn/4gEBZSlQ9XrhJ0P/+hJVvJCRMhvrEWnY3psNJEvvurike7Zl3R2BTwQeNIWmza2d/
	Ct3C9TJDPsTN4bcTFDQ7b6N8rXzVyIfZ2DRVsOlsIe4GVbv+8gwiAChP31BqPaxOxz9tv0yBtpra8
	QKbOfXPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIXY7-00FB0k-0A;
	Wed, 27 Dec 2023 17:18:31 +0000
Received: from mout.web.de ([212.227.15.3])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIXY4-00FAzt-0H
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 17:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697488; x=1704302288; i=markus.elfring@web.de;
	bh=dwFepwTmoz1K5UBHElv534KOXOgEY3BfjF5zKd4bVyg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=PWyawNPC21xNRABWg/UjEGrcxM8lY6DWQkdkc0YOqXNNk7ndtp8CHqNT/7AxnVRs
	 vY+eRPVcxm08w4WnQ3bBq4Wvs9+iwu6tdrZYbDOVStXMkirOUxmwz0n2zu21Ejyno
	 5/60gSbl1KZe2Cv/yaFTKVXF/wa/OxoP9q7ZAuzIkPHwot098Mu3CfTTb2sRYiAG9
	 hyNp7SoUx4yj7gMO5tg05TXIWLN94jmPLxgMyHjk7168ZAPcSR7wcBdfuJ2kvLeCf
	 rvnkC2a57MzRgp4ISBg/lM2vSQQclUkQrZ0P8I+Pi21faj1OsSHo/VPFCMb+zraYi
	 yxo+EzVjzJwZs29JCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1rKA6Y2S34-008fhK; Wed, 27
 Dec 2023 18:18:08 +0100
Message-ID: <40059711-eec1-4e52-9ef8-1ebf066aa11d@web.de>
Date: Wed, 27 Dec 2023 18:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] nvmet-fc: Improve a size determination in
 nvmet_fc_alloc_ls_iodlist()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aUG30CfZLJU1YbJxvTKb5BgY2Fh5dGqh4jBoV4TVF1WoxvGbQjt
 ilLMXEtVceGDKtnCW5fqr736P+8WTFRJy9I7KmsiKE7AgAYPUKdMgIY4139MmtTwdukN344
 dudh+1cIBRZFvAT7dqOyQnoZXRPp2ICnsqlRjvBBSrde7naIRdQl3CI18QcrlvLVXU74kM4
 5np5ozRi0Ux0rqBYokQyg==
UI-OutboundReport: notjunk:1;M01:P0:CBX/uooqcM8=;WzKz1uEE85xPvuxjzgRPPWoEw79
 UuoBnLCA0bmw0gB2lANhPNXrTNr2RH3SG6ZX8uoL5tH391fp59GcwkPeqNJazkSfyD/6/tfAY
 U73rwP7hripkGjTGQcq98S6VJwDPqbsPESGUZgIJry43L5hU0Q/LPROkClR53dB2+cA3ZgXDO
 RiUr1Jid4uziu62aB5hC/q3s5aOYgA6AmBOn0/wLlJC+uQ2UC8StnX6zg6gs6GAWhjv3/LKaU
 Qf63cav4DChBGg3H5Ztv+hA9LbjZW+pmihnX3qf4HVlUCNJTtKIpIvBUac/yGNMlPjOhkIaKA
 Kb8VofK+gu4CQxPCLTAz68Kb1IIoAiJ5VLkpYSmduqBzklUeiATSxq1/GPaZSY6pY6RTNT6/z
 ksbzKDhyQBLX3G1yidETNZUlrWi1nDzJTQ2uDO9w65JU4dSYLsQTJaRnLX8uIrCVAjM0WK+kn
 icIQ9nt0p04ZhmOVSOISfkbZdSm6uewvnKyl2giEK9FVMtiknOREbJ9q41GrljudrUCT0rWx6
 oqLvrCv3hpkbSXOXcuJHC52OsOZWE41honvBEGq5NU3xJNWOIEkO2nEgzuUB4Xp4CMBjipRN7
 Z+HVQSJLapvTnkDL98YFQZ0SZGS3OX2OAdsuP85T5rA0gt0sgmVmk/4mtcm34orsWzbGlEMM9
 5uMjGjhb4nT7HzRYguPMoJfldS5gFPac2DEYhUQVzh0Y1ZAE1OGa2CdGlfYeWC4d9wSauLwgU
 e5wcU2vd4c+UWnpadtpobvpwr3Cg5zir4YYgD36U73I92qcJHp23inQgTeIOSCCg3cn4YaYCQ
 uR3xstgt9WcEW6mALEy5S7r9UvyOnmKN4S6g1gapasa+FQPk1IZuCWLI3GHak2HrqTC6EFYDV
 3UH/tMKfO3eof5CqwS0bOBgEFnqdxywNjTZg3v6EQ0cJavRq+Qg72y+TV+EIXaqpsCyTGUoMD
 8VZcGQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_091828_405644_492F53A9 
X-CRM114-Status: UNSURE (   9.51  )
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 18:03:10 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/target/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 856a68404f32..ada257b3c681 100644
=2D-- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -537,8 +537,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)
 	struct nvmet_fc_ls_iod *iod;
 	int i;

-	iod =3D kcalloc(NVMET_LS_CTX_COUNT, sizeof(struct nvmet_fc_ls_iod),
-			GFP_KERNEL);
+	iod =3D kcalloc(NVMET_LS_CTX_COUNT, sizeof(*iod), GFP_KERNEL);
 	if (!iod)
 		return -ENOMEM;

=2D-
2.43.0


