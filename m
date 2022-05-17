Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7535C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1JSWBmF6HMyPNCFvDVNzCLM/k7mgBtNuUI93sLEX5g=; b=nlWDg5CCTmD2YB5rlV8W9Ww3TR
	SiCmRc68gjH3T5bih18se5pchdaO1QFwbN4Kkj8Sim30793Y4z+QewO4H/QZ4LBhkwzQR5u6OBxNr
	1OX1CpNwMjnaH8kkzk8BRXrkgV8CXjgfQxl11/mhU13HxK3K9LjYbZG9hMe9p7NoprM8nmKH8U2sa
	0TEaziBKquwUS09/I6Kb4meDfBLfJ9AeTzD53j/AMo4c1nLLW3/HLYjwZd3svIb725uwIALsZMv5K
	setJ9Uf8UoqZb5/JR58gDN+W08DOLCULMkS8Z1OX4n5PbH4DoDXxDnymd8g+nRrrOYqjrotfIDhlS
	yk8Xrghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqsIF-00CMR7-Ky; Tue, 17 May 2022 08:10:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqsIC-00CMO2-KZ
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 08:10:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1EFE67373; Tue, 17 May 2022 10:10:48 +0200 (CEST)
Date: Tue, 17 May 2022 10:10:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
 dsterba@suse.com, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 jiangbo.365@bytedance.com, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220517081048.GA13947@lst.de>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_011056_869256_ED1C2E84 
X-CRM114-Status: UNSURE (   8.77  )
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

I'm a little surprised about all this activity.

I though the conclusion at LSF/MM was that for Linux itself there
is very little benefit in supporting this scheme.  It will massively
fragment the supported based of devices and applications, while only
having the benefit of supporting some Samsung legacy devices.

So my impression was that this work, while technically feasible, is
rather useless.  So unless I missed something important I have no
interest in supporting this in NVMe.

