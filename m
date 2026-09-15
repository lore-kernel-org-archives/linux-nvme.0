Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D57C88E75
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0b1PfaVl/cTIM8WRTkqllVRbOqKhbw/4gbvoksKE5s=; b=b5/NphDBwLCo0/EvexcS6G7TEE
	FIL8BMyVG3dNBu64uBDMDj1QqMPgXfi1pHo+UGJMpUs3eWxdEtVYTg2OvVjo4f7d36C2u1LUts6a4
	BEjA3kMtD+XOVtyOryXS7+dYSw0qfK8kCJdoSzamycZmTBMpdaEImZDfr1YYF+keSZ0B5WlcfK4B5
	B4GJFphYbNGpW3K3QrdV9yZPosjeeClGzTc3yriRM7XHazVHT5xQE1akvOC1rpfgIe8xbdGn9AHqt
	WdXfwKqieYOKBnqugwGpDx8A923LWmKekE53ccAcgZ9MNDt8lZ8w8nteb9lvxZce+QzkDdg0dtVx8
	dn3fs8BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TXb-00000006nNk-2OOb;
	Tue, 15 Sep 2026 13:49:43 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TXZ-00000006nMj-01Hu
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 13:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=M0b1PfaVl/cTIM
	8WRTkqllVRbOqKhbw/4gbvoksKE5s=; h=in-reply-to:references:subject:cc:
	to:from:date; d=arkamax.eu; b=e0mOGTxV54lW30l+zSTVbGY/dwLwmgN8AL8kAcDA
	pQLeX+5Hwng+x3/YWdo7J0ai3/E4mQk/hCwLvC5uf26LM3KTol7Uqk1/Iobuutb1szGL6O
	Zls4PbQSbO6iekKhRMG9IcXp92dmzrsSgjc3bg5Izf3P05x6xnsJZHni5G7rjA86cqNO2I
	ssGWcmV6jSoN9wsfNAcenz26bYUUiaeMm+vbZoisPxAHASzSmx6+8VcGGJjQglZxGt8em6
	+F87r8zYiIKh1/atZTYVnk3ozGfGas4RqVIVeA8wOEdSr+yJK14yAQFAZNmcHhajpzirX1
	7MQOKBDLLTjQaTGY3cAyig==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 6ff795c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Sep 2026 15:49:36 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 15:49:36 +0200
Message-Id: <DLFXS43UXYEC.MEIQ5NBK049N@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <hch@lst.de>, <hare@suse.de>
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
X-Mailer: aerc 0.22.0
References: <20260915095827.698928-1-mlombard@redhat.com>
 <e6146839-0a52-45d0-8b95-9ae0f7807493@flourine.local>
In-Reply-To: <e6146839-0a52-45d0-8b95-9ae0f7807493@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_064941_722320_62F80402 
X-CRM114-Status: GOOD (  17.04  )
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

On Tue Sep 15, 2026 at 3:11 PM CEST, Daniel Wagner wrote:
> On Tue, Sep 15, 2026 at 11:58:27AM +0200, Maurizio Lombardi wrote:
>> During NVMe controller creation, the controller is exposed to sysfs via
>> nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
>> This creates a narrow race window where a userspace process can write to
>> the reset_controller sysfs node before the initialization thread
>> transitions the state to NVME_CTRL_CONNECTING.
>>=20
>> If a reset is triggered during this window, the state machine allows the
>> transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
>> is queued. However, the original creation thread continues its execution=
,
>> subsequently moving the state to NVME_CTRL_CONNECTING and finally to
>> NVME_CTRL_LIVE.
>>=20
>> When the delayed reset work finally executes, it attempts to tear down
>> the controller and transition the state to NVME_CTRL_CONNECTING. Because
>> the state is now NVME_CTRL_LIVE, this transition fails, triggering a
>> WARN_ON in the reset work.
>>=20
>> Fix this by removing NVME_CTRL_NEW from the allowed prior states for
>> the NVME_CTRL_RESETTING transition.
>>=20
>> Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecting =
when resetting")
>> Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com or why it was
>> there it there in the first place
>
> Looks reasonable. It might be worth explaining why we don't need to
> handle the NEW -> RESETTING state transition or why it was there in the
> first place.

Maybe the last paragraph could be expanded in the following way:

"
 Fix this by removing NVME_CTRL_NEW from the allowed prior states for
 the NVME_CTRL_RESETTING transition. It is safe to drop this transition
 entirely because a controller in the NVME_CTRL_NEW state is merely
 allocated and not yet initialized, a reset operation at this stage is
 meaningless.
"

For what concernes the "why it was there in the first place" question,
I think that the reason is that in ancient times a CONNECTING state
didn't exist. The controller initialization was done via a reset;
so the transition was NEW -> RESETTING -> LIVE.

Maurizio



