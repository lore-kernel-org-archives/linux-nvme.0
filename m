Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C0DE88D81
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=EIa2xY/7ArqmuS4f+LqdW2QQTwVExLr+4F5Vcx6yq0o=; b=E/hJf3vddLJBus
	8vv2LBWfosPk+UnaMNw7jmCkr5m/q7KnW9X678IKgP1NSy9hzH5Z0tji88Kl+LqO/NCW+SgXfTfSV
	HTL03CHUcM2Lacerki/jXN9EEEIbFyMefQCiSuRySaeZqnOtIkOHCMGVtfIJ4vH5LMj9zfu2EXwQ3
	UQFAGaqNOJfk7wOq6tiZBUPuM+Sx6ouU82kgrY4ICmG3OygExJpsvQF1S/PZvhtxXIyDy76pVdaIf
	LKYgL5twZk/ITLbXAJT3AW6Za9m8Hw6kvBSAPvlVSzm9Hn4oF3XOieiPVhyhhghOgCuNFjvTK8B9A
	gAdLobWxGYBknfJeJ/sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ssD-000000037Mv-0RYF;
	Sat, 04 Apr 2026 04:44:41 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8b8J-00000001qLl-0yzd;
	Fri, 03 Apr 2026 09:48:08 +0000
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5DFC6406C750;
	Fri,  3 Apr 2026 09:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5DFC6406C750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775209683;
	bh=EIa2xY/7ArqmuS4f+LqdW2QQTwVExLr+4F5Vcx6yq0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NliT+tOQj2FTWGMCHPwylQmCn894Tz3Kz7z5FcNXNjHKaGRUos2rQciI0uZON65R7
	 I3aEXVr6HLMHg20QNtY1tu6G1APvWaSNKQidCCJAY7nW2XPBmuPueNAhEcMX/CgCWa
	 aQ6tp3KkjE3TzH/+9hmfc//xwkaZk2d3GOvaRbIg=
Date: Fri, 3 Apr 2026 12:48:03 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Heyne, Maximilian" <mheyne@amazon.de>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, 
	Peter Wang <peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Seunghwan Baek <sh8267.baek@samsung.com>, 
	Seunghui Lee <sh043.lee@samsung.com>, Thomas Yen <thomasyen@google.com>, 
	Brian Kao <powenkao@google.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, 
	Wonkon Kim <wkon.kim@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 6.1.y v2 0/6] nvme: correctly fix admin request_queue
 lifetime
Message-ID: <20260403124447-fb4fa96a8af4e7117989073e-pchelkin@ispras>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402-moral-jockey-f072379b@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_024807_465356_79B31A4A 
X-CRM114-Status: GOOD (  16.14  )
X-Mailman-Approved-At: Fri, 03 Apr 2026 21:44:33 -0700
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

"Heyne, Maximilian" <mheyne@amazon.de> wrote:
> The initial attempt to backport upstream commit 03b3bcd319b3 ("nvme: fix
> admin request_queue lifetime") was not correct leading to refcount
> underflows and not even fixing the problem.
> 
> I've tested the reproduction steps from [1] (adding a delay to
> nvme_submit_user_cmd and 'echo 1 | sudo tee
> /sys/class/nvme/nvme0/delete_controller') on the nvme-tcp driver which
> printed the KASAN UAF blurb.
> 
> Fixing the issue in the 6.1 series requires a few dependent patches.
> This is mainly the upstream commit 2b3f056f72e5 ("blk-mq: move the call
> to blk_put_queue out of blk_mq_destroy_queue") which allows to move the
> blk_put_queue to a different location.
> 
> The backport of commit 03b3bcd319b3 ("nvme: fix admin
> request_queue lifetime") needed a tweak to the nvme pci driver.
> 
> Furthermore, in this patch series I've also included a follow-up fixup
> from upstream commit b84bb7bd913d ("nvme: fix admin queue leak on
> controller reset"), again with an adaption to the nvme pci driver. This
> issue could easily be reproduced by resetting the controller (no need to
> run full blktests):
> 
>   echo 1 > /sys/class/nvme/nvme0/reset_controller

For the series

Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>

Thanks for the prompt fix.

