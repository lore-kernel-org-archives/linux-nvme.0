Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42EDE7718B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AnGKX9Fkp44jBKpNitfL+p2iry
	ZxemYD0LMdfKSX7/Uvs2qTFmQsOz2nLjKzGgKnrqjksW+v8i14QrDyjNpQYCOoNrUo1gOl7IFarNG
	l38jMFV4Vr4WWijfCzW6DHGVvtFwc3dxD/GB9omec1/Io6mHwc3Cg0eUk56xCy4JtMEygYJ3AjyIb
	5/dRp5R0qNSvusZPimZ73VxI7xYTe7tpLE7FalB9YuqUkkG2bJmabR29BpmliQSnhZp5QkkSIZoMt
	keXJidgcuVrqrWI8hsLZ0fHETX8/awApPg0AwOC8zDTRg/0oTaMd9uZF/+v93ghQcoSDCUbr5VXGX
	V8PfnhQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPeCS-00000009c6T-1Xqc;
	Mon, 23 Dec 2024 08:54:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPeCQ-00000009c5f-0eUt
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 08:54:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E3BF68BEB; Mon, 23 Dec 2024 09:53:51 +0100 (CET)
Date: Mon, 23 Dec 2024 09:53:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: change return type of nvme_poll_cq() to bool
Message-ID: <20241223085351.GB20943@lst.de>
References: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223010516.241581-1-ysjoo@kookmin.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_005402_363761_B403AC2E 
X-CRM114-Status: UNSURE (   9.26  )
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

