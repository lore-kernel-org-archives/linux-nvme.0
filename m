Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B19710F994F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YYeTjtCgmmwwXuEg+0P4T4OJABE+qAeKgo4I+n3aUec=; b=M1LLubeXVLlauVI4oqV3LdMDyN
	1Bkcem2Gk8HhPKgU4goRfg64WHvHKcnl5LUzKOFQ+8Q7pmglqW1Ej4Jew3yw9bcdkzut3SmqznFG0
	UZXpUc40hd5r+9bKcl4CC1jqCZnQ4nfnXVmmstL3xiOdgHeKYzgj8S5sIMVkfgiuwHz8RGCf5ZPAD
	qDCL8wVRBsh5XL5gzBIj77mMbwF8V/HPPBZm/cewbXRLbrMueA/yk5nu06F4MK4IKa1vpQWzyOQPV
	hdr31fPwEgUVyMsHzFFIwvk4m7MaBRe/lfSj5J7qscdlcn+IoquToqE3SQ96ULKKQseGDw/PPA9tB
	daqXNSIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUre-000000093hR-2ctF;
	Wed, 08 Apr 2026 15:30:46 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAUrb-000000093gc-19X2
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 15:30:44 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id be4b3b79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 17:30:39 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 17:30:39 +0200
Message-Id: <DHNVQBI845U4.35LOI7WR51V97@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <yjshin0438@gmail.com>, <hare@suse.de>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>, <mlombard@arkamax.eu>
Subject: Re: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and
 state machine
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260316143936.120999-1-mlombard@redhat.com>
In-Reply-To: <20260316143936.120999-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_083043_649204_073CE8FC 
X-CRM114-Status: GOOD (  10.97  )
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

Hello Keith,

this patchset has been reviewed already, could you pick it up?

Thanks,
Maurizio

On Mon Mar 16, 2026 at 3:39 PM CET, Maurizio Lombardi wrote:
> Patch 1 fixes a potential issue where network data could be read into an
> uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns vo=
id,
> meaning callers are unaware if an out-of-bounds PDU length or offset trig=
gers
> an early return. Consequently, callers blindly overwrite the queue state =
to
> NVMET_TCP_RECV_DATA. This patch modifies the function to return an error =
code,
> shifting the handling responsibility to the callers to ensure proper sock=
et
> teardown.
>
> Patch 2 cleans up redundant, localized calls to nvmet_tcp_fatal_error() s=
cattered
> across the receive path. It delegates the responsibility of executing the=
 fatal
> error function to the top-level caller by bubbling up the error codes.
>
> V3: remove nvmet_tcp_fatal_error(), fold it into nvmet_tcp_socket_error()
>
> V2: some cosmetic changes to Patch 1, no functional changes.
>
> Maurizio Lombardi (2):
>   nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
>   nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
>
>  drivers/nvme/target/tcp.c | 88 ++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 52 deletions(-)


