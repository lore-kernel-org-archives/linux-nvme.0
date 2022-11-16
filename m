Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F8C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	MIME-version:Message-id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LpcpAH4zxrcMxDLOPMA5F656Hw2TrxzTLadot3yE8cA=; b=OmvyorbBF9xtVgSJPhk10y6z5N
	WCfSoloKhP7KDZ4PQNa7mVI906fHg3q8bsM2Kdp6hxqGjC650KQciRjE8KQ3Jz4067W8QUUkhHZWr
	J3pLg1TDNrmi8bPEMcSBsR+PaTAlJFUyYqqodyBHr3RZzUkH/UZAPnj79K30lUpFEySVsRwKfBvJ5
	nEMe4GZGzE7E/Q5UJgxIYmgPDegbSmpFQZt2/zBA+JHtQaPK66l+53HiZxgTri9QtbXC+jB25JOMV
	1nN+fFicqFolkyFE3mxczhYlgjvBRokLp4pxsUA3cMbV3tRDWOhSvxPjPc3uW5/TeFmhmqd2VzXSp
	rWovkanA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMHn-006SVc-DA; Wed, 16 Nov 2022 17:33:19 +0000
Received: from abi149hd127.arn1.oracleemaildelivery.com ([129.149.84.127])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMHk-006SSF-7a
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 17:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LpcpAH4zxrcMxDLOPMA5F656Hw2TrxzTLadot3yE8cA=;
 b=vbCP7qhK75aPjwVaVVnjK9avPEKVW8DQTky20IKg23NM1BRDoEtaSMbscBQj/zKwoOPm3WbDLt1A
   LE1tT4s4sbnbe49Ak5JhgjfZ84JLs19DdSmL5CpyzoglRYPvbQjOqNIPZZ9ZTBb/yyEZsEsxZIZq
   kqNGxth1PEL9V1wde1yYZOccazC550JgZ9s9xvC4z8y6qVdJR7XV2VtEWuRNCxs1u29MbpjAOR3t
   LwVzwuzWU9dQFyZzhZ2xwmyJpPqt7Yj8LuCBh04pclR77SSq3umYvF6qWAfwD6lujF2QLtfAGPlC
   RSeLNIQw6xxA/6E9xt3I5MZTMZDxfsiTKYyh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LpcpAH4zxrcMxDLOPMA5F656Hw2TrxzTLadot3yE8cA=;
 b=QDdPe5/aq6cOV5ywHAns7uvVq8CuwohXDRB5cyV3d1jP5FDz4/n9sqU9Vqh57CtCNNzmnzflOJIt
   Y9DDByKpiot8WfJzBW4Rf2EotLCdkcnYfgog2DlPoRZ1tlO6cGdqMDrXW26lP/kDvom3Gqm02ntr
   /kFQcBAsRP4eq6sJXykQ2tOivncCLeTpxouAc0wPFjvuIKQF9VH9EpIagcNoul+ZLeON5D+cUJwL
   si3ZGrB9rbnbeQ+Dl1btQ7VttXN4XF5p+K/vOMAAGK4BzpLJedV40hGiXrQlezK5HPEnU6W43XCp
   AlJiFLjou5ORUtoP0Iat8JHcgWY2Y3ozlr4m1Q==
Received: by omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLG0063IAPTE900@omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 17:17:53 +0000 (GMT)
From: August Wikerfors <git@augustwikerfors.se>
To: Keith Busch <kbusch@kernel.org>,	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,	linux-kernel@vger.kernel.org,
	August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and
 512G
Date: Wed, 16 Nov 2022 18:17:27 +0100
Message-id: <20221116171727.4083-1-git@augustwikerfors.se>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:  AAEu+0BrTkHBsWLOK63HjpEKIIURzBrIK56dK+jBm3s0DHlxjT4P2/MBeqUBNrmp
 VCVIkws4O2zsNXnjRWGiS5823k/tfg+rw6mS6z6KSVbwlN0YUSlApmvn5LGAGr/i
 gqHij2YyUqqP8L4NPV+7K0LXfOgEMPGudE7w+cSvvCu4qvVAvCMHkShL5guw5OES
 xHZPFpGJOkaWHgu4ZfLscJDlQMdjTP4Rzw5QQLqFoaD2Slrw5R87QdcujqetH9TR
 u5G1JvCShCJkFT4VZ5Ihbog5jRZ8FL0m/nuuJmIdpb84forVzAWuB+RZ61sJN7+3
 tonTUqkH5rycNc8gz5rb3J6olhfg1aqlilPPDx5D2jKpMCmW/z4oertR9Paees2a
 vCWt79e2xhi85FB1tTPlg2GAgk8ZChOCNhOmauFAqR/IusfJS9lSBVSUCWMsaX3D 4OgW1zsC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_093316_282745_74DD0D6F 
X-CRM114-Status: GOOD (  11.54  )
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

The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
reports eui as 0001000200030004 when resuming from s2idle, causing the
device to be removed with this error in dmesg:

nvme nvme0: identifiers changed for nsid 1

To fix this, add a quirk to ignore namespace identifiers for this device.

Signed-off-by: August Wikerfors <git@augustwikerfors.se>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f4335519399d..0af51b85c323 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3500,7 +3500,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
-- 
2.38.1


