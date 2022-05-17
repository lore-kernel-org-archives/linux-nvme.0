Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0FDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OOcjDSgK8cJWTacTHHEeY2ZV1fsyiqwKHKqJNuxa1c0=; b=OyNAKOQ/n94RTah7bB1te7M9Vs
	pi6z30eJTR/OHWUy81FH3VhSc7CesbdNMVkYDTuiQ4jWE/U9Laz0ENMO2eKTNXOZCCp5NyGHSUHAd
	9Erqx2v0w+8sEcugH+9nDR3dYieTQYwh8MYT0rhb7bPdVWumR3fdGJSIPwEH6qo1CcBIUoSp6Jj6k
	vUyh0CTgGvofBMxMGDBpbtlRX6XM/ZpypNguidAM+pGS3YHoGjGOyzFf5E/SSW2Wff39kGAu+Ngog
	Vusr3fSjOjwSkCAYaindkmZ+cudu5CB8ZX3Y/93xmXXE6b4WcErYWUESTyProfQO1yJoCo8FHjVb/
	/1pSoyuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr31-00Bthb-31; Tue, 17 May 2022 06:51:11 +0000
Received: from [2001:4bb8:19a:7bdf:afb1:9e:37ad:b912] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr0x-00Bsbu-1h; Tue, 17 May 2022 06:49:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
Subject: cleanup blk_execute_rq*
Date: Tue, 17 May 2022 08:48:58 +0200
Message-Id: <20220517064901.3059255-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jens,

this series cleans up the blk_execute_rq* helpers.  It simplifies the
plugging mess a bit, fixes the sparse __bitwise warnings and simplifies
the blk_execute_rq_nowait API a bit.

