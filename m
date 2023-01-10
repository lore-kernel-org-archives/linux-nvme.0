Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43100C54EBE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDP70CNfk9jq9Lo9Nio0Ps1DncJkb1lXlprG53qdTX0=; b=J1nYwJMZQsLjsss74i8KH94IMf
	6+CI2xl/nRGwyvZuVlg4lih65CbFeq4nITQEamtU8MBpElbwbzazcNIkH/eDs5AS6iyHAaKG4+INg
	Nv50NDYxj/4ZLY4y53XUToZbQd1YhhZg59tiKc4xT6NqvFQMaaTWJcs5TjKAoxh2Jim+9LtZyasMk
	SzvgPcVUblgqvYk8Pn/FB+ucQVJHu+DDcdm6MPr5cAyJbt8FBPP+Dzx/fdEYvnHoRGOJkdRoooZ0E
	QEgwFFS+/MoW1ri/N2WlN/d0jePXOfqSX0DmTrh0hHcJMJ5lBRoYYlfuAiqcF+7ExzRK5+qtLexTQ
	jxWI2QGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Xt-005XKg-QB; Tue, 10 Jan 2023 06:55:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8Xr-005XJT-HR
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 06:55:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6AFF68AFE; Tue, 10 Jan 2023 07:55:36 +0100 (CET)
Date: Tue, 10 Jan 2023 07:55:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
	hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
	dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
	linux-nvme@lists.infradead.org, hch@lst.de,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Message-ID: <20230110065536.GC10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com> <20230106083317.93938-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_225539_738421_379C6E5A 
X-CRM114-Status: UNSURE (   7.95  )
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

s/nvmet/block/ in the Subject.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

