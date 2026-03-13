Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00311105F78C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itphv8sQ2DwvIAl0h3cu3s7Tt4w31FNRFSGHdhZYKTA=; b=pySxjCV42VHMuTGZDqor0INOG4
	c1RvgNu/Q+/GbEyf2rfMxMbp3JNpRkSVu1ZsTvOlAz1rP0iBvdE8nQ8PzPWAazrYo+Jt4C29vhxXO
	ioEPU05olcIhSyb+FA9qbrPqoBzUAN5OnsHbLMxrP9XTiT2axL3OQ61UjeCCbYmc3k2js/O4BeoBi
	4+qCBTCWEc71eFcPqDhCpZNNii2tPPSdGvhhxtp0waWMnBFsskjR9Ki/ckAB9ukiCQaqRZioeFjX3
	ZEiI2RnQ1QpzVCR4zifUDfDPt19KhdR4jYck0mNf4QmpOz+nQxjVdo2nmFXImgHrX78f6VA88Dv1r
	7VeDgUvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10WE-000000000kp-0YNi;
	Fri, 13 Mar 2026 11:17:26 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10WA-000000000kQ-3g2x
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 11:17:24 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 57b367da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 12:17:18 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 12:17:17 +0100
Message-Id: <DH1M262WZRUE.2FR90L883CA9F@arkamax.eu>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <dwagner@suse.de>, <hare@suse.de>, <sagi@grimberg.me>,
 <chaitanyak@nvidia.com>, <mlombard@arkamax.eu>
Subject: Re: [PATCH 0/2] nvmet-tcp: fix receive path error handling and
 state machine
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "yunje shin" <yjshin0438@gmail.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260311160920.465209-1-mlombard@redhat.com>
 <CAMX6_QHFZE35qNXZyn8-SDkoQ6dUAuSLXSH__65CWxLtSTx5rg@mail.gmail.com>
In-Reply-To: <CAMX6_QHFZE35qNXZyn8-SDkoQ6dUAuSLXSH__65CWxLtSTx5rg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_041723_254186_C34C64E9 
X-CRM114-Status: GOOD (  12.42  )
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

On Fri Mar 13, 2026 at 6:58 AM CET, yunje shin wrote:
> On Thu, Mar 12, 2026 at 1:09=E2=80=AFAM Maurizio Lombardi <mlombard@redha=
t.com> wrote:
>>
>> Patch 1 fixes a potential issue where network data could be read into an
>> uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns v=
oid,
>> meaning callers are unaware if an out-of-bounds PDU length or offset tri=
ggers
>> an early return. Consequently, callers blindly overwrite the queue state=
 to
>> NVMET_TCP_RECV_DATA. This patch modifies the function to return an error=
 code,
>> shifting the handling responsibility to the callers to ensure proper soc=
ket
>> teardown.
>
> Thank you for the patchset =E2=80=94 the error propagation cleanup looks
> really clean and makes the receive path error handling much clearer.
>
> I've been trying to reproduce this crash scenario on my end [1],
> but I haven't been able to trigger it reliably in my test
> environment so far.

I guess that the msg_data_left(&cmd->recv_msg) check in
nvmet_tcp_try_recv_data() prevents the derefence of the uninitialized
iterator, so this is why it doesn't crash.

I see however that it tries to parse junk, so the patchset is useful
anyway, I will correct the commit message.


[  114.122436] nvmet_tcp: unexpected pdu type 75
[  114.122487] nvmet: ctrl 1 fatal error occurred!
[  124.660886] nvmet: Created nvm controller 1 for subsystem test-nqn for N=
QN nqn.2014-08.org.nvmexpress:uuid:eb574a60-a657-4daa-8a7d-c3c1d25033f6.
[  132.872857] nvmet_tcp: unexpected pdu type 129
[  132.872871] nvmet_tcp: unexpected pdu type 236
[  132.872880] nvmet: ctrl 1 fatal error occurred!


Maurizio

