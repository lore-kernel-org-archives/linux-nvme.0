Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0DC021B2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IkZhwQnmhk/3MZ3WmRVfeHWvCbna6N7BrQR1jWwYokU=; b=YNDQO+lNZQjOnvhHGsC+RpGmiW
	06/lzX1Vpji+J0DBF0rXhciBSbLj7bt5CTqF2DbCpQ3XYrmeU3JoAydEdxK4EmPc385Jcw+T0sjuz
	zJdK0tBMh5CAQE09sxzw2md7yZq5lwUC8QZvVoKhrrael2yYDA125VJN+9cfBAOVO4p594skpsiKV
	5FOu36q6AdsbfHUWNIdJFPgajJ38aQdndyEd2lSlWbqtSDWIKW5EEOaQAzExNTlWSXhrJ0pzLcouU
	2zelSRtuTziLrm5HKWf6MSw24+f/YSK4bbA6F28pY3WFd0hnrWjPpxFHhLNDbM+8FAFm60XJuZLcZ
	T+ttv5BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jb-00000001vOq-0YCo;
	Wed, 26 Feb 2025 00:57:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Mw-00000001KwH-1heU;
	Tue, 25 Feb 2025 20:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=IkZhwQnmhk/3MZ3WmRVfeHWvCbna6N7BrQR1jWwYokU=; b=VTGHmuBv4dsiI1UZj1jsJbk/4S
	BS5ZmPnFRkKdUEcERt405q+Gf7hpUUiRtb23azalfJVXxRBl+IJAoJ3jCj7N01s7ZxF/yh7DK/W0P
	sjM0WLZVgf/xnB9vuxpO+pzcO2TvW2Hph8/aN5K5jw/tQKivfnEOF/NFyi2Di0G+zkje8MRzlGsKA
	oI/R0ARuhiLwIFSDCOjpt4rHMZwvuhndfnzWLhJhdurhAMNS6bPEic2da0hf9eLVkfrwBZIfjIgF1
	x/tDHVM5hZbs2IzjfmVQEu+lYbMlWH28J+50Yvv6QuwNhstWkB06wtfYZyXH2Tz0NSJe06nMbDsdh
	vlel861Q==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Ms-00000003PK8-1D3k;
	Tue, 25 Feb 2025 20:17:29 +0000
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE0A12069413;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE0A12069413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514641;
	bh=IkZhwQnmhk/3MZ3WmRVfeHWvCbna6N7BrQR1jWwYokU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PDr+YdzwKTpyZBicDKqcQQUqPL1iwuSQme5BjsML0hXlTVF9AZr0RQ2wXUwNPrDi5
	 2fLTg4V0dpM1tBw+RLkMSD0aTsmmkxoeSBgL2Xo1cPwMxPo/cff0ffzHQNbO3K0hfD
	 6uIhiei0TRTMFdIWngeYvXNz/apT7GwtHrM4bEfU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:22 +0000
Subject: [PATCH v3 08/16] ata: libata-zpodd: convert timeouts to
 secs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-8-a43967e36c88@linux.microsoft.com>
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
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_201726_703367_B5D5B45A 
X-CRM114-Status: GOOD (  10.84  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/ata/libata-zpodd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 4b83b517caec66c82b126666f6dffd09729bf845..799531218ea2d5cc1b7e693a2b2aff7f376f7d76 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -160,8 +160,7 @@ void zpodd_on_suspend(struct ata_device *dev)
 		return;
 	}
 
-	expires = zpodd->last_ready +
-		  msecs_to_jiffies(zpodd_poweroff_delay * 1000);
+	expires = zpodd->last_ready + secs_to_jiffies(zpodd_poweroff_delay);
 	if (time_before(jiffies, expires))
 		return;
 

-- 
2.43.0


