Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B722CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XAbToR/Hh8jCVDtc+1tUSl75X4
	NuecPK7YN4lOztyGcQCFQ6PR2h6zjqUTYTCSDE4hibwyVSJ07kWg+NkjXpHicWM6DtIEbb5l5k3Fk
	I/kv+MIMysT+9DXOUwteB+ssU642P3rRKU2UpllMUqR6+u/r1IBwRkxf17MV94dlby90T+ixBlFvY
	R1YGlQKd0BGXEwK0dWtFkzRu+GuvHh/G/bbaSrDw8rE4F1LB2jBQor2jc0jsEw9lMY51+umtANpHM
	kUexVWywMLIYuTFyuGxlhSdny3C3F+pz+xqxWiGCa6JG7greTfVRDnjIimXH5lWKgsjSDcdKQLG3H
	7wd8TRJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW7l-00000005O7e-3NP8;
	Thu, 28 May 2026 08:29:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSW7i-00000005O70-2OXE
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 08:29:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAE0B68B05; Thu, 28 May 2026 10:29:47 +0200 (CEST)
Date: Thu, 28 May 2026 10:29:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v4] nvme: refresh multipath head zoned limits from path
 limits
Message-ID: <20260528082947.GA7073@lst.de>
References: <20260528073601.4139342-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528073601.4139342-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_012950_743274_1B380D50 
X-CRM114-Status: UNSURE (   8.33  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


