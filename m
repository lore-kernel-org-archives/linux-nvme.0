Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8AC7EE29
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1zi33mYG6E/159otUyBGkZR4XWOgH+qMjpUmfk9u5o=; b=No/JuYRosFL4HR/UistLEfaA/L
	6Ky7G5k7UG77oCRBmm0KmJKPiePZ0Vuv7U52ziU/mJBaRsMO/zRhSuVxS2WaSd6M5kaOqzH6kCaqA
	0g0z0u7uwDv89ugFr8pJFRMB4qcZnz5KOzcF697LGPZVC5PdnEIrFc0i9in0ZAr5a4dPulbyRlLBV
	eC98pcLjAjMRqVidvwxr5ti+thlh6QbLFrKw3utHt8D5j1gUg28kTYfK4oxOY9TshnHFp48EuZ8Wv
	m5bLWCQ+/KEJUQCyOb9yK1EqV9d0/x2w3ztL/6g6uMOFi+2IGLLzxmJsAr5CSTFy/+DW1tcnj4KEl
	mboZvYXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odk-004zsM-01;
	Wed, 07 Jun 2023 08:35:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odf-004zpg-2p;
	Wed, 07 Jun 2023 08:35:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1CB63C51;
	Wed,  7 Jun 2023 08:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78533C433D2;
	Wed,  7 Jun 2023 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126931;
	bh=OMT81Nj+03/UUqXvR/WATI3J1MFOVo+i3KL8UfpdkEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXORTW2prZhLBaGAe7/mLRmhhTZvaBHSnzVd0HFARKJDQ62eKOG4Kzb7xZlfPL9nO
	 97zwfyA/DQztpsvm9grNPGz7haRUOQZrQturaW0SFSa0uosZB40SJST0dXmizK2H91
	 Vrg9ubXMdO+Gt6gYl3oFWyWVhTdUtfr7NIIdvz5ZfTiIhubmxyIDaIzXV3KgUyxjww
	 GcTRPH6U8lSPzfLUWbreqgZvDgNSFImMLsmVidpwIncpJKPPhhlshVQd4J7rrP6eJV
	 7nFr4sqb1S0ehPF5Xwg1baPwzoSZ6HowqC26ZK1aX2UPURtsR/Sx1T5MKoxTEoav5Y
	 AB2Mai1SAj/KQ==
Date: Wed, 7 Jun 2023 10:35:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/31] block: rename blkdev_close to blkdev_release
Message-ID: <20230607-renovieren-getier-8fba2cb1185d@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-12-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_013531_952547_947DBC5D 
X-CRM114-Status: GOOD (  11.82  )
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

On Tue, Jun 06, 2023 at 09:39:30AM +0200, Christoph Hellwig wrote:
> Make the function name match the method name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

