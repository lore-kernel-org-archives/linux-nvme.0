Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8780EC021A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVjnLn9E3sfJKDIcyN7wAZ/FXjiM8y8O7MiQKQj5kCw=; b=NiHJU7nm5J7I07m7LiXC1HbDPC
	lFir97uGApdSlO/zdUFd+so+DM0oLbzTifSeiHc7PpF9MWUoBt+u300fscJCWpFZ/52g/SnNh9uc7
	TfksJKzoc4DVtxIDfrGu0us03bW99EEooop9QMrF9YEhA21Ij3+6BoUwVhkA5BIZjlTM9so3hOH8f
	Fm9ZrD1OwVEUCBpsvauibzsHIPkIT5pSLLSFWHUqMIpCQ+PXM4l+9W7ZRhWkc9/UUku03Q5+mzW1s
	mW8TAT8r816qlZ8Ie4oYV0Pjis8XX6A188IafwBF54DsYY7b0rWLrPEq+iYRUZQWSHmkfV+6NWSi4
	YCjL55yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiAFI-000000072DH-3ODR;
	Wed, 12 Feb 2025 10:45:32 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9yw-00000006z6U-1q4w
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 10:28:39 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id e97734e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 11:28:36 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 11:28:34 +0100
Message-Id: <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
 <D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
 <202502121747455267343@cestc.cn>
In-Reply-To: <202502121747455267343@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_022838_828923_9EFECA4B 
X-CRM114-Status: UNSURE (   6.17  )
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

On Wed Feb 12, 2025 at 10:47 AM CET, zhang.guanghui@cestc.cn wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0Hi, Thanks.
> =C2=A0=C2=A0=C2=A0=C2=A0I will test this patch, but I am worried whether =
it will affect the performance.
> Should we also consider null pointer protection?

Yes, it will likely affect the performance, just check if it works.

Probably it could be optimized by just protecting
nvme_tcp_fail_request(), which AFAICT is the only function in the
nvme_tcp_try_send() code that calls nvme_complete_rq().

Maurizio


