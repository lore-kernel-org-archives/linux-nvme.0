Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855EC47086
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512D36124C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512D36124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRFo56h9Dk/lYtvA4N51B5a1GbTv39tPdKwUhnigQZU=; b=HnPZe4wfu30luG
	h+EsEYId4v+lvCOyjya+1xKyJFuzCxcJPUojAbuJG9d7Jcm83zgqZIbw5JLXsDm4bWV5vAyHc5giF
	5T+t9dPsAPOd1VGRRPF24oujVrr803/Bi2QJ44wkkG9hdrl+RDMrK8zDQthpObPS2qiG/BkWxVeMs
	pjjjHCWWMaEhMpnwkkLoVT2hHj1zMAbQKCb4NvdDpjULtgq9Tf1Oh6GeUekKoubkoShRCl3cHl/vy
	Yfk1+ykMA1ikb/gGhjdd9hi3KvskHbXcDpKcmGRb1iFJ7SxKrPg4SaAF0ATTVLFjo4dE9/frJq6ML
	sTg40oxeOj7wbsjRuUPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldHs-007yN4-71; Tue, 25 May 2021 20:04:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldCu-007woR-Ev
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 19:59:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1294C6124C;
 Tue, 25 May 2021 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621972755;
 bh=ncJiiN/zA2TC3c0n7FPOs8jXgdzJqxxYalhyCrIShPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ISt7ztLEFAg4LqO7RRqanmrLCqduaDDRnhjqcvNY3vkMlajO2QGCdroLvg6hsXLKd
 L5De4hOyNNVC2dgMCK7DiBXbjCEGj95eCTeWLLSb4LKyPEZpmMRMDJcBqrzD+bMCeH
 UgNA3TwCwG+1Xf7cq3wbBmEZJG7do5O/tUy6c7Fkouu18QICF3VZXUjcAq5rbtZi9H
 g8Ce54DY0JAgQ+0bZh/HKBv6+fAm8pHtYsNEy/lwMG0hGdpa8dj6YjBZBkUmYfLxCY
 hSpwCN8HgG2RNrHjBCCZc31ymZYmkcpEDol+N5lM3nCYV8PxzYK8dpl6WeO5uM5/z3
 UbYAg1IcO7F7Q==
Date: Tue, 25 May 2021 12:59:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>,
 "Liang, Prike" <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Message-ID: <20210525195913.GB3704707@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_125916_619728_79419D97 
X-CRM114-Status: UNSURE (   7.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 25, 2021 at 02:06:09PM +0000, Limonciello, Mario wrote:
> "Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
> and then will lost the NVMe power context during s2idle resume. Finally,
> the NVMe command queue request will be processed abnormally and result
> in access timeout"

The nvme driver explicitly checks pm_set_suspend_via_firmware() in order
to know if firmware may manipulate our device after completing the idle
suspend. That is returning false here, yet firmware will do something
anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
