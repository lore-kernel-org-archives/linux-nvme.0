Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8A5C02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96GvQM+rLNhGqu2cqM9zlmUkzr9OQptMOdGtCwz9Q4s=; b=xWEXPTQ8zlG/4aJvfTIMcC3gy2
	UgVueFZpauyUUJfrd3GMoza/yBaNgi08azg/dUh5nVtgtZql+Ocuh21rQByL4Ra2MwMGbacy8Xrjv
	dbLZNr+G2G7h/TZqoaUH5IwZ4GTKn0fR9TzQCmrD1AH2P71JrXG5Xlx+kLJhDEgIL51mrY8hgPlt5
	YJ3Vo6jOtMmurch0jW8Yo3wXN0iGjHwBx3sk+e9adPHUFda0ns9e/BhOHzhI+U98sya/W4o+jem2U
	wPN8owVj6UKSa/qwmqC1Vguglbev5UPgKevIM0BnV6u/kb0K0DQOhJuHExlaNoUSpi07YxNf5RXX6
	nT5rN1Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thQbp-0000000GuXu-0gts;
	Mon, 10 Feb 2025 10:01:45 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thQbn-0000000GuXR-19zL
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 10:01:44 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 95258b83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 11:01:39 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 11:01:39 +0100
Message-Id: <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
In-Reply-To: <2025021015413817916143@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_020143_651982_1B4D125B 
X-CRM114-Status: GOOD (  10.13  )
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

On Mon Feb 10, 2025 at 8:41 AM CET, zhang.guanghui@cestc.cn wrote:
> Hello=20
>
>

I guess you have to fix your mail client.

>
> =C2=A0 =C2=A0=C2=A0When using the nvme-tcp driver in a storage cluster, t=
he driver may trigger a null pointer causing the host to crash several time=
s.
> By analyzing the vmcore, we know the direct cause is that=C2=A0 the reque=
st->mq_hctx was used after free.=20
>
>
> CPU1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CPU2
>
> nvme_tcp_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nvme_=
tcp_try_send=C2=A0 --failed to send reqrest 13

This simply looks like a race condition between nvme_tcp_poll() and nvme_tc=
p_try_send()
Personally, I would try to fix it inside the nvme-tcp driver without
touching the core functions.

Maybe nvme_tcp_poll should just ensure that io_work completes before
calling nvme_tcp_try_recv(), the POLLING flag should then prevent io_work
from getting rescheduled by the nvme_tcp_data_ready() callback.


Maurizio


