Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A527F30930
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OaS2/jkjid/b0x/a0yZPbkd3JCfocIR1szET4NLkcto=; b=wOFWOsgpFsjCYpdqt580pUxuHJ
	9A6aCJYXFLaFW4aZy7Efn9jdgFT1ccHdY4bKawmC+Bq3zW5IOlOkK81C0BSYil8qIZ0j4hs0/2CZG
	huUyHiL4Zqa2NbhFibuc9hSuzkon+azpwp5zgVIlCX6WP5jR9R+yZdb7Hx5JrAxUf0Fm/CjvGlgPo
	Q0OJmylTWKtHefj2j/ehNMl8DLre5+alIBt4cygzEUC8rdkAMr8wYWqE/KOj/364mSvV/HGbEN4t+
	XgovzFixdDMvEmq4PfmrGPWPNgbtiRT3wHQGI7avtBG5MTFEtgma//x4qaRKUuQOPLQFf7bJi5I3V
	z1TT6Gtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy6HJ-00000001cWK-0NB6;
	Thu, 05 Mar 2026 10:50:01 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy6HF-00000001cUe-35io
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 10:49:59 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 5201fe64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 11:49:52 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 11:49:52 +0100
Message-Id: <DGUSGT9WLRH8.GBZ0CM62IV9T@arkamax.eu>
To: "yunje shin" <yjshin0438@gmail.com>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>, "Guenter Roeck" <linux@roeck-us.net>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <gregkh@linuxfoundation.org>, "Christoph Hellwig" <hch@lst.de>,
 <security@kernel.org>, <sagi@grimberg.me>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>, <joonkyoj@yonsei.ac.kr>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in
 nvmet_tcp_build_pdu_iovec
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr>
 <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
 <DGT3F4OEHJB9.218JVJM25CWAV@arkamax.eu>
 <DGT52MZM4MVD.1NEXLSLRA3871@arkamax.eu>
 <CAMX6_QFn1-Pe7gen7JkbpzXeq41gA9z=U8d6=NE4-o_vg43hBw@mail.gmail.com>
In-Reply-To: <CAMX6_QFn1-Pe7gen7JkbpzXeq41gA9z=U8d6=NE4-o_vg43hBw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_024958_117171_8B4448F7 
X-CRM114-Status: GOOD (  14.24  )
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

On Thu Mar 5, 2026 at 4:01 AM CET, yunje shin wrote:
> Hi,
>
> When I wrote the patch, I followed the existing convention of calling
> nvmet_tcp_fatal_error() directly. But since the function returns void,
> having reviewed the AI agent's analysis, the concern seems to have
> some merit - the caller could overwrite rcv_state with
> NVMET_TCP_RECV_DATA after the failure, causing the state machine to
> proceed with an uninitialized cmd->recv_msg.msg_iter.
>
> Maurizio's approach of changing the return type to int and letting
> callers propagate the error makes sense. This also aligns with his
> earlier patch [1] to remove redundant nvmet_tcp_fatal_error() calls
> from lower-level functions.
>
> To confirm this, would the following sequence trigger the issue?
>
> 1. Send a crafted H2C Data PDU with an invalid data_offset or length
>    that causes sg_idx >=3D sg_cnt in nvmet_tcp_build_pdu_iovec()
> 2. The bounds check triggers -> nvmet_tcp_fatal_error() sets
>    rcv_state =3D NVMET_TCP_RECV_ERR -> early return (void)
> 3. Back in nvmet_tcp_handle_h2c_data_pdu(), the caller overwrites
>    rcv_state with NVMET_TCP_RECV_DATA (ignoring the failure)
> 4. The state machine proceeds to nvmet_tcp_try_recv_data(),
>    which calls recvmsg() using the uninitialized cmd->recv_msg.msg_iter


Yes, this is the sequence that should make the kernel crash.
I say "should" because right now I don't have a reproducer to confirm it 10=
0%.

In any case, the code looks a bit fragile and I am going to submit a
patchset to clean it up.

It should be ready very soon.

Maurizio

