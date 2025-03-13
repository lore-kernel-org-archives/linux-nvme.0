Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92A7C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bYgeVvtX+Cno/WF5MQKKyOgTXymcBBDKd38eLnxoGy0=; b=SEY45YtdK9QFj60kwokEw1/p8Y
	8bA38VFoO+Mkm6UiuxVMyLtveXeMiBaerGj3UoWx/Cf2QELC5SogPF+ub9u+U9WPS26Lx+tOle69B
	cMTqZ1rWA581RVPkemZ9m69KsDIT0E/YabPKpM4pXIxg4ENwFDNbeg5CYKQkwA4sSaJUIXMtwD/6i
	e/dE3OZf2rfSsD7kiyMfM4H0fosFroKQq09vHFhMbzknmhEGGb+lurH8X7SI6PWUjbrUk3E/RdtZl
	aYx+DIZ1kISzR+ZvWZ537ru325+2AbwlXGg/aekAmR7kB+XmHhU8FU4RN7Za73QvYrym6uqknJXfM
	VxE3wMMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tseRJ-0000000AdhH-0DGz;
	Thu, 13 Mar 2025 09:01:17 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tseRG-0000000Adc0-0kEq
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:01:15 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id fd0d5281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 10:01:09 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 10:01:07 +0100
Message-Id: <D8F0L25A8NP6.MR1S5ORJC9XE@bsdbackstore.eu>
Subject: =?utf-8?q?Re:_nvme-tcp:_fix_a_possible_UAF_when_failing_to_send_request?= =?utf-8?q?=E3=80=90=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6?= =?utf-8?q?=E7=94=B1sagigrim@gmail.com=E4=BB=A3=E5=8F=91=E3=80=91?=
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "Hannes Reinecke"
 <hare@suse.de>, "sagi" <sagi@grimberg.me>, "mgurtovoy"
 <mgurtovoy@nvidia.com>, "kbusch" <kbusch@kernel.org>, "sashal"
 <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
 <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025031309485746586710@cestc.cn>
 <deb1584c-67b8-4543-9017-9ca18a9ee7d8@suse.de>
 <2025031316185747646815@cestc.cn> <2025031316313196627826@cestc.cn>
In-Reply-To: <2025031316313196627826@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_020114_556695_665227D2 
X-CRM114-Status: UNSURE (   5.62  )
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

On Thu Mar 13, 2025 at 9:31 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi,
>   in fact, the nvme_tcp_try_send() failure, the target may send C2HTermRe=
q immediately. while the host receives the C2HTermReq and still starting er=
ror recovery. =20
>  so when queue->rd_enabled is false,  can avoid starting error recovery a=
gagin.


Not all targets send C2HTermReq (for example, the Linux target doesn't
at the moment) so you can't rely on that.
In any case, calling nvme_tcp_error_recovery() twice is harmless;
the first call moves the controller to the resetting state, the second
call is ignored.

Maurizio

