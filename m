Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F06C02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pInBy8YX1VZfoKLrPNtGqsHJ8GKtyDoFXM54Z975PS0=; b=1iPNqXz18djUuS/WkmIufjt0AZ
	KsI7STBF/LzuN8uEmN0aWWQpQggGMjnqlD2syY+oyOmXM2N1zc4g7W0ugbggav0odIxXy+q9AH+Go
	k9W4K3Jx2WLheq6wogqmF6XYgAoDyo0z8pImmmKG4aQtDzPCmLUSZuegZ3+V1nWzYUypUA8FPFhOm
	hdeB1VKCNQThiv16uDYRDhI9de+PU9LcsZa5UmbkYXyhO4RRPQTyP2C/gmgAh+Gdkfk6bhBp/B96N
	3yqxMchoBPz62M8tN7ZSEDoERfluUR98RuUFQp3cRFAa2025MLqE6ZVBQpyDbXZXZH/V7VLfXuBky
	cCSG+2Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thWrw-00000000Yoh-2V3P;
	Mon, 10 Feb 2025 16:42:48 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thWpV-00000000YIh-0b3X
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 16:40:18 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id dc734ee4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 17:40:13 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 17:40:13 +0100
Message-Id: <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Max Gurtovoy" <mgurtovoy@nvidia.com>, "zhang.guanghui@cestc.cn"
 <zhang.guanghui@cestc.cn>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
In-Reply-To: <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_084017_525065_C93FF312 
X-CRM114-Status: UNSURE (   9.03  )
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

On Mon Feb 10, 2025 at 11:24 AM CET, Max Gurtovoy wrote:
>
> It seems to me that the HOST_PATH_ERROR handling can be improved in=20
> nvme-tcp.
>
> In nvme-rdma we use nvme_host_path_error(rq) and nvme_cleanup_cmd(rq) in=
=20
> case we fail to submit a command..
>
> can you try to replacing nvme_tcp_end_request(blk_mq_rq_from_pdu(req),=20
> NVME_SC_HOST_PATH_ERROR); call with the similar logic we use in=20
> nvme-rdma for host path error handling ?

Yes, I could try to prepare a patch.

In any case, I think the main issue here is that nvme_tcp_poll()
should be prevented from racing against io_work... and I also think
there is a possible race condition if nvme_tcp_poll() races against
the controller resetting code.

Maurizio

