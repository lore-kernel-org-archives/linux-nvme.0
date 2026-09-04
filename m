Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55012C624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kAhvbBh0y8XmQwwqp6+NOqBPmhrCPGrOA+dkTWjQAHU=; b=kLkmAOl8QQ8ka7xjFC0JHjUUxR
	0dafIQxZK9il9PctqLiooUABuY5ejr8Ycxm7iFkBDNu7vMTf9HQmq6L8NqXNlPp6FgDgJLXiG8myx
	7QnxsEKBY77SOsz1CNsXtMcV2CJs3GfzC2eYXxur+pIpnNl+iITYTXNV4UlyKvg6cxMT2DP7zZdII
	CADPXnbm99Pp9obTZWEmFEHR7Vk9IkMjVKDDvB6f4kFhNExe5/VFQoJJWW1y0FQXmjcECrVSU/qmU
	qg+zycsTXXjBUx++vF0BQvwQLGm5fbSAtuSf05dKhe3cuxhaLBFrlxaJDDXZFnP8M62qRIoBxwy7y
	JQqL1BEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2RYS-00000001kH1-1LOp;
	Fri, 04 Sep 2026 10:53:56 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2RYP-00000001kGS-1nfa
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 10:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1788519124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZSUzOt+BcavtYYJ0q6FSgeboDQjR9c1R09ZPD2Tp0lOp/2EozTaO+4U0FBnmfALyFH
    FU8LygXUfVxXRjlcn0v6MJfAPFOS9UxR/Fs/RO5RLV70NR9nSKhaAN7RpBXY/tTzkBt6
    tR0dYmU4KsWUTI7Nv71h0mVNfAslfOXE9svmxUFz34RhcTOoYaMCaEjKNUdNdgF0onMn
    Kr4xv/VaI9frOeQ+tA1wMPOpbwhhQX0Z0Tr/OituOs8TPXD17V+WJgRHC60JlLpdOO8S
    gTK10HExBO/lQeGmXjdCbJ3PyemzO7hNyFZhyt/zqrAghb3xn3OojF+o0DAX+TiXnfzJ
    R7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788519124;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kAhvbBh0y8XmQwwqp6+NOqBPmhrCPGrOA+dkTWjQAHU=;
    b=bDd5M0y9gA+uCVFCLCK1WE8U2htdjUqsJHLRv/N30B730qSlHetp4vl5YEmGZNkT+C
    wTkomcDW0VCoszl2UdGKSR0tAyzoD7UdHOVu+WUR+GDEOZiHcqaelWYi+6SZwoaIYjDl
    HsN3yQWPISTDxfKGcVT+jtWepwKMDwOhwmIh3hT1z1Vx/t8tkqqMg6XjgQJgSXj1ekTp
    pAOabJTCCzjI+OlD4scBiaaTjemW9i2L7r9Gg3E5ZKZrCwMZap/aD+vfI9CW6YJIpTkd
    XcwjI/226tNiv5SrBqzfo8Em9VtHKHyxa08E5Q/YHwOwCOK841tG1svUMuyEbL5ShqhN
    YjjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788519124;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kAhvbBh0y8XmQwwqp6+NOqBPmhrCPGrOA+dkTWjQAHU=;
    b=OiHQdapQY2fbSngMsdkwLACy0ftWtGnaqbUU+vsbtd8S4TI3Z4JEe7FjDkPmw2ivzW
    CviqS1Fm/Z8XB6F68XjkWQX//5lo2trLxyRbqLslopCxjHyl6yNl9kQUX3NIwKbz3U7S
    lyuX6QbloWjqjUSbtBPQ8JZM7Abhy9DfJx/wZjdcvNW46aVyKf800xIfscFw5jrDDfXa
    GMKgKEJXl+uTXddQcHtSwucbuLC9zjiv99avMmaT65Ld+/FdU89cyB+BjXyjcEOYOqhe
    FKoWBmV0jYKZN5I0AuN8JR2pDh30Ns8wzpFjOMar4KO1U0KrNQQbY6OqPDuIyiV0zGlZ
    KNKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788519124;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kAhvbBh0y8XmQwwqp6+NOqBPmhrCPGrOA+dkTWjQAHU=;
    b=VfhI3yceMOxBtz+bJyaLuadhh9n3CmADVT+8zXNL+ludZ3GCMp+ayx+hLBpGehZKIV
    y1WyvTDwGDhqB8+L67Dw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e1284Aq32Dw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 4 Sep 2026 12:52:03 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de
Cc: axboe@kernel.dk,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	bob.beckett@collabora.com,
	Bean Huo <beanhuo@micron.com>,
	Gaurav Sinha <gsinha@micron.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT
Date: Fri,  4 Sep 2026 12:51:55 +0200
Message-Id: <20260904105155.1402065-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_035353_745909_69081ECA 
X-CRM114-Status: GOOD (  12.32  )
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

From: Bean Huo <beanhuo@micron.com>

The Micron 4100AT fetches PRP Lists in 512 byte strides, but the driver
allocates small PRP List descriptors in 256 byte strides.  A descriptor
in the last 256 bytes of a dmapool page makes the controller read past
the page: the access lands on an adjacent IOVA, the IOMMU faults the
command. That last block only became reachable with commit da9619a30e73
("dmapool: link blocks across pages"), so this affects v6.4 and later.

Align the small descriptor pool to 512 bytes, as commit ebefac564796
("nvme-pci: 512 byte aligned dma pool segment quirk") already does for
another controller with the same erratum.  The last block then starts
at offset 0xE00 and the fetch stays inside the page.

Cc: <stable@vger.kernel.org> # 6.4.x: ebefac564796: nvme-pci: 512 byte aligned dma pool segment quirk
Cc: <stable@vger.kernel.org> # 6.4.x
Signed-off-by: Gaurav Sinha <gsinha@micron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
Notes for reviewers (not part of the commit message):

* Why the two Cc: stable lines: this device needs the quirk from v6.4
  on, but the quirk itself only exists from v6.13.  Older trees, such
  as the 6.12 LTS where we found this, need ebefac564796 first.  The
  first line asks stable to pick that commit before this one, and the
  second gives 6.4 as the starting version.

* Why no Fixes: tag: the only candidate is da9619a30e73, and that
  commit is not wrong.  It fixed an off-by-one that had been hiding this
  device erratum.  Blaming it did not seem fair, so we left the tag out.
  Happy to add one if the maintainers prefer.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf6627..d6dec3ba41f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4141,6 +4141,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
 	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
 		 .driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1344, 0x6004),	/* Micron 4100AT */
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-- 
2.43.0

