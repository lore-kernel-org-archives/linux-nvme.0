Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D8BC02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWwGc5ybGnNaoCOK3eBfF57y7YFYHkmmjUuPazTbw3E=; b=S0+p8gZhGO2qAdEmgzqH56HOqk
	8Ok4bLXjhxt+EDb+9glzJRsLBL6Th0a1CELpYmCNAuMhSglBiWkeFbj0bNQI2Q2o52Gu0zzd2GfwK
	tMVISx12M0Y3Km2tUfwhJeiiQzt6lkgNYono5dEBH2y7CvI9IUxKJ7BNs2WNQf0+vhgXSrSHtTrO2
	Gv9I9Bo+5roXP+zUA4EqiwjPt/8hTsmvG//yyLX6yNVEFeyVAxTKUVtBsxCpS2sDib2/u5FVS0w5d
	28GuHttIVzwU0Us2csyXbnR2Ir8XZWftxxTO60iQomiiZOgN3WCLY+ngZuIi+JmbLF74hAfSytYgV
	xOEm9rwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ti87G-00000006cuD-3vm7;
	Wed, 12 Feb 2025 08:29:06 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ti81q-00000006bcC-1MpF
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 08:23:31 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 7d8026c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:23:28 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:23:26 +0100
Message-Id: <D7QBMEU5WL4L.2FI34UVHXCDC5@bsdbackstore.eu>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
In-Reply-To: <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_002330_696929_6BA3A3B1 
X-CRM114-Status: UNSURE (   6.12  )
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

On Wed Feb 12, 2025 at 9:11 AM CET, Maurizio Lombardi wrote:
> Hello, could you try this patch?
>
> Concurrent calls to try_recv() should already be protected by
> sock_lock.
>
> +	mutex_lock(&queue->send_mutex);
>  	nvme_tcp_try_recv(queue);
> +	r =3D queue->nr_cqe;
> +	mutex_unlock(&queue->send_mutex);

Well, reading nr_cqe like this is still racy, but should be a minor
issue and not hard to fix.

Maurizio


