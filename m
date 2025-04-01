Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B09C36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsHp8wPZOO5NnSrOH0OcLsCriPkpzsfzARmmNqCsmK8=; b=zHsDp7/Vp+Hr+VWRYwYMlxZHOh
	9cLsYuj7YmPf4RnwuYLusqiV3qAejg0dtyDltKZgiHR5Pf5ZNoEe/dZHtS/sYyNdToc8lEcJtSbu/
	EIzAUY1v4olT4HARt6ZnBvZk6fHJQRQ/hEGackXgUc+f3BLqhIJezar2U7UsPefRz85aho5ZsDcJ1
	2Z+CpuYh0k/nWOQzKKk5Nfk0hrYQZgCcpSpkb948zlpo0QmF2Et+yJ53l0oxk2txRTPZ4vcbG9/HM
	aHWov/uFgLBUkHaRwtUKwApgjgK1XHcXtFO0/bE62BLVk+N2TC54xfeGviq2UcTj8R+7u/HkPkZmc
	Ofibympw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzaoC-00000003HZv-355c;
	Tue, 01 Apr 2025 12:33:36 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzaTN-00000002zJ1-3sq1
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 12:12:07 +0000
Received: from localhost (<unknown> [193.207.112.45])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id c7aa2f3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 14:12:01 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 14:11:59 +0200
Message-Id: <D8VAJJYPMVA3.284EXKCVRJVPU@bsdbackstore.eu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc 0.20.1
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn>
 <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025032817241899538928@cestc.cn>
In-Reply-To: <2025032817241899538928@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_051206_306518_45039303 
X-CRM114-Status: UNSURE (   6.64  )
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

On Fri Mar 28, 2025 at 10:24 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi,=20
>
>       So far,  the UAF issue have not been occcurred during testing this =
patch in the same situation.=20
> Additionally, the patch triggers a compilation warning,  nvme_tcp_fail_re=
quest is declared but not defined, please also review. =20
>

Ok, I am going to submit a formal patch.

Thanks for testing it,
Maurizio

