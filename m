Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C0EEC1421
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XdJMjIozpnIK6dGZ+k8EO8jYRXpqF7Xi3LcDBjzeJJY=; b=lfDyZA3KCB1HUPe5lh5qYYZe48
	bIGnGmPoVnxeRHQ6+erjw/d9kDDQR2GwoniE6LinvCAWzprbkNrRrW7pGvbeWw2qtEBEvyxtCXNGd
	rlw2wU/iAmPT/AOIyocH0dMmWKqIeWdQMhHhEfBa7eFF8CEeU4LIcA4XNpjnUHWi8tWGWwudLXGIf
	R+melK+Vg5UerTA96nITvGPFCtY9aqI1GKC3z+9RA6elr/6zOFx+l0tb6KQckT8G1gSr/4ljpAoXd
	E7lI4OBJeC+nLSLIOXY3dPK2gSg5FlQ4eFhLealbV3+js7UqmmgAtHsMwe7g1hkx7cDTIEVJ2NHMi
	oNLpR4gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxOgi-0000000F8da-415u;
	Tue, 03 Mar 2026 12:17:20 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxOgg-0000000F8cD-1Hpi
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 12:17:19 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9e168229 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:17:16 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 13:17:16 +0100
Message-Id: <DGT52MZM4MVD.1NEXLSLRA3871@arkamax.eu>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <gregkh@linuxfoundation.org>, "Christoph Hellwig" <hch@lst.de>,
 <security@kernel.org>, <sagi@grimberg.me>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>, <joonkyoj@yonsei.ac.kr>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in
 nvmet_tcp_build_pdu_iovec
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Guenter Roeck"
 <linux@roeck-us.net>, "YunJe Shin" <yjshin0438@gmail.com>
X-Mailer: aerc 0.21.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr>
 <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
 <DGT3F4OEHJB9.218JVJM25CWAV@arkamax.eu>
In-Reply-To: <DGT3F4OEHJB9.218JVJM25CWAV@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_041718_711757_5D72372E 
X-CRM114-Status: GOOD (  11.93  )
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

On Tue Mar 3, 2026 at 11:59 AM CET, Maurizio Lombardi wrote:
>
> In my opinion this is a valid concern.
> I suspect that it's really possible to create a malicious sequence
> that would make the target crash.
>
> I would change nvmet_tcp_build_pdu_iovec() to return an error
> code and its caller so they propagate it up to nvmet_tcp_done_recv_pdu()

Additionally, the current design leaves it somewhat ambiguous as to
which function should be responsible for calling nvmet_tcp_fatal_error().
In my opinion, this should be handled by the upper-layer function
nvmet_tcp_try_recv(), allowing the lower-level functions to simply
return an error code.

I submitted a patch to clean this up exactly one year ago,
but it has been forgotten and I only just remembered it.

https://lore.kernel.org/linux-nvme/20250305132642.1271523-1-mlombard@redhat=
.com/

I could prepare a patchset to fix all this stuff

Maurizio

