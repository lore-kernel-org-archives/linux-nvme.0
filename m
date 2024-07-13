Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF5C3DA45
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jul 2024 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2DkVKMeSZLdTkmkibS3yN5duPZ98hT8azZgpJe/6Ne4=; b=dFPeS/fOEX04AtON6tl7nQCYM6
	coHX4fTklnMvXl0OOcD9TSbM68xnufMpqdRkxoucEZOWhM3dT/wKyxemtoxLxzAOS+M03G6n9efFk
	U8WfXbf+Ho8p2+L65toWZn+/W0dZSIkkXtpiXBq72sQDI2CLJ2cyqJq7S6NWoT+F5yzIneLWAjPq5
	O8NGz2FWaykDMij5CSGVmG+sIZugZpFKqKAfx4nr/dEWNyIErPgEG/hDY076j3RlWHDOu4/Hk406O
	wr4hzsZmoYXie7xbZ+uotsTm1pPZfujPix7Osgr67l7pzo/VsgUwM3MN1olFdIFfb/zpf263SOLoM
	RIDU/EtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSd9E-00000002dOX-2GFP;
	Sat, 13 Jul 2024 13:50:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSd9A-00000002dOJ-1mXd
	for linux-nvme@bombadil.infradead.org;
	Sat, 13 Jul 2024 13:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2DkVKMeSZLdTkmkibS3yN5duPZ98hT8azZgpJe/6Ne4=; b=UVDKnQQuJfSFbsqcqS8yDyt4fT
	J0c85yos0tg8GTS2qmzVjtbGt6kgXHHWewbRWKnRpmmc4ImByGZ4W01DF3A9qdFoYHf+W5XcrNRfB
	Lepk27G7tl/AR/NaONcy8wekPEwQdPv5/YGGMvlOqKvkuXW6A+AG2kXdEJq4Dc4FQDTmu5iZU4IrN
	DoV7I1REzgXjKv3mMprWucczmyxzGhKiwoVk4wcP6l4/Kq6lMVSen5ddM/3i/2XFFX+oFTFUveE8Z
	bSkl1I2Nf+WRQVyRojOkU9qI+/UhN2IBTfL1fTP7ISCWOWFcsT8BzuTwKcG92F6E2AvyClBASWifw
	1hMr73aA==;
Received: from mout.web.de ([212.227.17.11])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSd97-00000001TP5-0fFA
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jul 2024 13:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720878625; x=1721483425; i=markus.elfring@web.de;
	bh=2DkVKMeSZLdTkmkibS3yN5duPZ98hT8azZgpJe/6Ne4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oVKD2X0mTNKOGyW+A2lRub+vSt8nRJ3u1RmIjcfHbrj80xzT/GIjmfEVRRePuCkW
	 DcbyNcsFnipJ466fmsWjrJYn+LSRTIJcjjcQvF9a+pvEgaP/MXguHgOyCEsW/0MXA
	 H7sxhs3PK/kDpBkLEdtYdvsXiEzk36OXOGfZsVMTT3UFjqTE4kXzi/wx78rpsG9v5
	 yHg4PcEljd3xJxpSHUnHgDh7LPMJx9X19NTUlHK1kGgfiMl26+o3HbQgRRTKWSRII
	 ojciR2Bwc2Z1GxHCuTDxGVZWTWi3DPeLs3JrMEcFaf5yShMlJM1lRvVPDj3KyArzM
	 qjzmoXcleRC3xt+lZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1sWWt03lty-00GaSe; Sat, 13
 Jul 2024 15:50:24 +0200
Message-ID: <45f97bd8-21eb-4ef6-bc7d-9201e7447c08@web.de>
Date: Sat, 13 Jul 2024 15:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nvme-fabrics: Use seq_putc() in __nvmf_concat_opt_tokens()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JdDdT3GUzpkpOCWjWe73M1t1rMwD8wjznYly5YMkYxte7etCvLg
 cet9s3eO2FDEIbS9AiOD0GrGdcPp13qepmsYUQtb4HxQYWE4F3JMBdNrw2sjPIQYMXO0NYy
 1Z8NGLa6i+6afWzt+Bx5gkGFmx5xa+E0xr+AoLgacbxXiqjLWj/8lIIZIq0fjIhSvdh7xl7
 suiDGhITR/WGZphwVA5mg==
UI-OutboundReport: notjunk:1;M01:P0:uCU1KQ/BpF8=;ODwdkhcsbvCG4oe2kr5D2e7eFzg
 PMFYW+OgDj873lsKpNxLJwCw7Da8SXNXKwM3QSur9WkmwssCtEwRVrsWl0N+xSS9bi9yhEn10
 pw0RTuB8Bct1+XgieILC+yBjujpQkLzFoT5fz7AqnPF+bEpU2VbKyNJq+pkF0ZKjr8B+9Z6sb
 HoNDoC42ZUvYtLi2RuxvQg+3PfQxoCTfpygJZSCnrwFeqCKIjtJCLRJ2Fldx5cDIWl+rUN8AE
 TRadzXXm8+6y9sjJOhhbjoLpJQfpt5qDRVG7nBuBUTWM9jQ5zPR9UD8MCmhHRFsU83hY2I+6Q
 jx6ufLSV8n03wNfO/3iDuXg+h7Z6a36HkS1vLNhsIAIqLPXEjOOjOm8eSGo0owjxT4+pQT4vn
 cYYD8tG/ZPaEFhhKKqVYWz2093Wpe9DKyyu+r2Qolqlcko4NaZ/HoG2Qn09McwL0cis7bQSKi
 1rsIUGZ0/+gara7YD8sLoBYLq8q+Y+J/fVV4arustcvVPSXrZSlYq4Il1+yYBLQVUFRG2CAUa
 Jvv4gT+09xzJeYzKHs6GC7RjUjQalKT8Ryc7aHo4aarf5KyyUHh1hjuT2/ElHfurORKGHP7Lh
 bI9CzcnWYrQ+R4xzPSlMAEHSBPZaAB1nyBYgzJu8LCxQzet+o3ExuN0tA7J3fzLS97WvWMfSi
 5+8uktOBlN57/t8fCSzAiEXghc7PsEcSG1+z6KYr8DMChT9ZKzBuMe75vWR5uSBCFdppbXexQ
 RgjlQNuG4z4pnh6GGT6B0Gw4h2QP8XwRwGKDgQ1TTVdei8JuiWpMUG8LGYWOYahZ4cujYS5x6
 hb3oTzfgNxr2neW8JYmpNszQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240713_145041_503150_52BC8786 
X-CRM114-Status: UNSURE (   7.83  )
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
Date: Sat, 13 Jul 2024 15:43:17 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 44e342a46f39..f5f545fa0103 100644
=2D-- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1403,10 +1403,10 @@ static void __nvmf_concat_opt_tokens(struct seq_fi=
le *seq_file)
 		tok =3D &opt_tokens[idx];
 		if (tok->token =3D=3D NVMF_OPT_ERR)
 			continue;
-		seq_puts(seq_file, ",");
+		seq_putc(seq_file, ',');
 		seq_puts(seq_file, tok->pattern);
 	}
-	seq_puts(seq_file, "\n");
+	seq_putc(seq_file, '\n');
 }

 static int nvmf_dev_show(struct seq_file *seq_file, void *private)
=2D-
2.45.2


