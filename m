Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD0C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4t43n3EpTzLAVxJMoQgZuBWxWUt+boAV0S+iIpz3fX4=; b=BmlXGp2E+bBi9yiaGVuFQof6wp
	9LCp97xJnzKJCk7VfQnkbvyT7gzbPBjOjprpXBwKN96hpge5DxlR7englLDhqmJ2syhsDKQJEzU6L
	/kkOyZ0RpoHO5liIoQIAWfU4qdw5puVuowL/GJcGVbcZFpncJLEVpjpouSpS9jq1EffGvAYcTWfKK
	nmwRdy2XorqQtvyfIJFObDLHxTQkKzx78le7xqvsctzPcFupV95KlyhdtIv2ed/TestqxA+x6QS+m
	lqAkcesudh4nhci/yzN3sOZLRgHGaM5PPX/i23ZpuXXs9WGVfNrSEASb7LTp40C5Goq4+ee5RpNJv
	/GgduRAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYJs-00Gj3V-Nr; Wed, 28 Sep 2022 14:45:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odYJq-00Gj1J-E0
	for Linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:45:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F30D161197;
	Wed, 28 Sep 2022 14:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86855C433C1;
	Wed, 28 Sep 2022 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664376344;
	bh=WRhoCN19v4sjX3goSWOakLnbQqjLIB38ynqXUwRxCO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxyRr+3WMxqg8megnjVD4Sz5rNekxlpEOvVTvcGvXU3ms7mfKCRi/kfpTQDYi+Ktg
	 KE8ViM1Br8VBSQ3ZvKV8fTYy1ZehYo5Hzg6TdEKBNrC3gTCk3J6j4rWPblRAgHbUdW
	 dZ4KsgN2WRSvfsZcmIQWJuoEU5bWxhaRlqdZyktBu0aBDvPk6Jxv/TSmigyO2lgqvR
	 X7TQdrdZE6NGXyt9qkznepFK99Ni2Dx4g5OCRWbd+asG/OSwIpSyJFltkurKUpZHhi
	 WRJqh50L4ZGKXEW/SsNTkSnf23YON4ZtItY7I2BjzUg9ijLdr8OJp3cRleZMoFthgo
	 TNCfDjdgCPebw==
Date: Wed, 28 Sep 2022 08:45:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Richard =?iso-8859-1?Q?Clau=DF?= <richardclauss@ricl.de>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: Kingston KC3000 PCIe 4.0 SSD - Abort status: 0x371
Message-ID: <YzReFdGN+5L+bfEv@kbusch-mbp.dhcp.thefacebook.com>
References: <1edaa043-8e8c-a576-7ff8-8abe7f30b5dc@ricl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1edaa043-8e8c-a576-7ff8-8abe7f30b5dc@ricl.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_074550_550294_A232DB5D 
X-CRM114-Status: GOOD (  11.33  )
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

On Wed, Sep 28, 2022 at 03:03:38PM +0200, Richard Clauß wrote:
> 
> [  267.670245] nvme nvme0: request 0x0 genctr mismatch (got 0x0 expected 0x1)

Looks like your device is not in compliance. Try the following quirk and see if
that resolves the observation.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 59fa2490b646..acb1f73c83b0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3502,6 +3502,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* KINGSTON NVMe SSD  */
+		.driver_data = NVME_QUIRK_SKIP_CID_GEN, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
--

