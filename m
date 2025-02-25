Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10180C021BE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGzSq/vFDjX4bdM3inKgi/ZFFDhHhBOzDHEuBXOOojs=; b=XrqhorRSgM2Qs6YXW6116GnY8k
	ibx578vEp3Yco20Y6WQAyNoHPvtJ3bx3P2k+hW9jhSAtJZy0G9kgiwdKeel/2Ij1PzksINMYsoIeh
	gBRiHAvEnzgc3qsn7yPi3NOP2N+wu3LoP09JL5tibz9gCj3GKIz7WVszn4N5/yISX1M4DdJNs+anv
	oVx6sxkxKbWMdbMC3JunpDEAztv4fIF2WMriXWtyDpkKGE3abkCaFynd3m9KymBwVXXpiC0TOKcO7
	e+BL2vU36kl15UHs/2zhknaV2T89HaL3w3Ceu+G8U/fiEh4Y43/lyZE4A/mnBfkAT/EAF6ZydWPc6
	QY8fq5dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jT-00000001vAS-0LrV;
	Wed, 26 Feb 2025 00:57:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Mt-00000001KuE-3LuI;
	Tue, 25 Feb 2025 20:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=VGzSq/vFDjX4bdM3inKgi/ZFFDhHhBOzDHEuBXOOojs=; b=BbGY2zLERQ4FNeivei2TtdXtVR
	nI+3yDHrdpG5hO8MPPU4kgtFXWkhmb0n4fWIEHEFz7hb+dIN9HDj/yuhx7u4BPKzKyJBR5dSupFRQ
	6cx+BaY3k6/MB9LPXV8oulbZf7+ucMgv8quzkipc2L8ojwqXpTkwfD0FTyrzlquuEll9E1iaIjY1L
	S69qFXsC4zUDvWTi+fk948B0RAxyDwnttv/wb12cN2L0g3AeFY7L93qd5eKfoYZHcdmOPA1uDzSA8
	NjC/i7gPL7WHHRzDX8s3rCkinoOZqQeaelAY8qzLvqRhSIBd5QGuzoX3lHLYO9Ykw6hHUhkPuUhfe
	bPk82jLQ==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Mq-00000003PJo-3N9x;
	Tue, 25 Feb 2025 20:17:26 +0000
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45AC820460A7;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45AC820460A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=VGzSq/vFDjX4bdM3inKgi/ZFFDhHhBOzDHEuBXOOojs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NUya4tRaF9277cBwhYqQO7yzS8lMnqfHV5bhsseG/CtxWPz/gV8ztZR14fqeo6LgV
	 741al7zU+/EmCxYJ5lbwC/kdZB/J4wUtoYc96e0caxkwVbHT9BUlIVjAK1s/XVAu/j
	 GKc43d43v39nGwyqXko3AU4FfwpCRelgSKOuWoY0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:18 +0000
Subject: [PATCH v3 04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-4-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>, 
 Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_201725_234565_A6FB9E10 
X-CRM114-Status: GOOD (  10.76  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:54 -0800
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

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
(E
- * \( 1000 \| MSEC_PER_SEC \)
)

Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 sound/pci/ac97/ac97_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
 		 * (for avoiding loud click noises for many (OSS) apps
 		 *  that open/close frequently)
 		 */
-		schedule_delayed_work(&ac97->power_work,
-				      msecs_to_jiffies(power_save * 1000));
+		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
 	else {
 		cancel_delayed_work(&ac97->power_work);
 		update_power_regs(ac97);

-- 
2.43.0


