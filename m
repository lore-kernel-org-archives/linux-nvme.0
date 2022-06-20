Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5542BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:MIME-Version:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y4lhY8cxJHZ1NEF4C+K2sZLXeS17NlLW3Nk92h2Au08=; b=f0vqc8nXjoWhbd/f+q/9yxua55
	Tk/RN5ZbinaIPhJyDlkeskPgi1V+/+ygt4G22oDyWulSqgZyavQGzvo6sXFm/H67vThUgdTGaDZka
	i49JlHX9lj5hp3iR1jUBbEdC8o6+3sVUW8BObaHzFPH5FODwK4ZvhCiMjjcE9OZNc27uPQ2urbAWH
	Ti6D5jIRPYlQjEX3Elgv+r19O5HXQH/L+TxCEjV6kzND3q1IqeSYhKRQYWFOMUsXPyghgcx6u7YXD
	TfqdoF8cAaNvktRrYYsIKbrodQIa9JkAmOHGxiDYD3rwTEYwhX/HBiKYKByXHpY1H+iU2k6pNV5m+
	12zIwXWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3N5x-0020m0-Tj; Mon, 20 Jun 2022 19:29:57 +0000
Received: from smtpout02.a1.net ([80.75.33.2])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3N5v-0020l8-0z
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 19:29:56 +0000
Received: from localhost (unknown [100.77.12.61])
	by smtpout02.a1.net (Postfix) with ESMTPSA id 4LRfq82HzjzGrqp5
	for <linux-nvme@lists.infradead.org>; Mon, 20 Jun 2022 21:29:39 +0200 (CEST)
From: Leo Savernik <l.savernik@aon.at>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] NVMe quirk needed for multiple Micron MTFDKBA2T0TFH SSDs
Date: Mon, 20 Jun 2022 21:29:38 +0200
MIME-Version: 1.0
Message-ID: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
User-Agent: Trojita/v0.7-468-gd9d6944a; Qt/5.15.3; xcb; Linux; Ubuntu 22.04 LTS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_122955_261421_4CE0DE8A 
X-CRM114-Status: UNSURE (   6.84  )
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

Hello

As suggested by Keith Busch, I'm posting a patch to make multiple Micron=20
MTFDKBA2T0TFH devices work to the mailing list for inclusion in the latest=20=

kernel versions.

This patch applies cleanly against 5.15.48 and 5.19-rc1

Please see bug 216147 [1] for details.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D216147

Leo


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b925a5f4afc3..2e5c33f3b868 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3372,5 +3372,7 @@ static const struct pci_device_id nvme_id_table[] =3D {=
=20
NVME_QUIRK_128_BYTES_SQES |
 =09=09=09=09NVME_QUIRK_NO_DEEPEST_PS |
 =09=09=09=09NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+=09{ PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+=09=09.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN },
 =09{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 =09{ 0, }
 };


