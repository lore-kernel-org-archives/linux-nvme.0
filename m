Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D88C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhhpFCSKViNKZANYHjspLNKZvbDFhd3sog0YaQtISf8=; b=FCvIs6FGpT8djFM500Lre+1j+r
	Bfd+FAtbBAeLCmOh03nRGWrwLWypp/DMubmKhpd9M1mTsjEUFHN5vukt69kAo6nYir6zjwnn0byE8
	Ruc0ap0/uhQDgXshtgm7LtwYsaYoHMS478PMDjaV0HH4X7x49/lKFF/aNQORIgl4bN4XOET5Xr1ra
	SPXzBnZliiohtw3lFLIQr26MLhHOII9mF+RdpS6EfyxmriwXjaXu3gteo5Lo2X5IWT1V2DhXcqAOg
	pO0BI68Khf0lgkQZQ4b3geSElInoAl7F/yROdE96FIQponzTdowRv2kMy9qiguCHH1kf1ZXRnJzj4
	czS3MTkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viTX1-000000055YI-17yc;
	Wed, 21 Jan 2026 08:25:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viTWy-000000055XV-0SYz
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 08:25:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 967AF227AAC; Wed, 21 Jan 2026 09:25:27 +0100 (CET)
Date: Wed, 21 Jan 2026 09:25:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <20260121082527.GA15293@lst.de>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_002536_292097_0E4838A9 
X-CRM114-Status: UNSURE (   7.99  )
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

Any chance you could bisect it to the offending commit?


