Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B6FCA5FC1
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZ5y3ZSOkJKyNCJ6Hso8ZTRbuxj1ex4T5I/X5Y45tiM=; b=viAdcktEDPI81chQIW/Dn1v8Mu
	o/ItfpFthjeXj5r1EwHLn84FdnVMDl2VPZRs1TcZe2ENvemTRVSrZL1ljlIfYEJK8Rp1EDkgcvSZP
	McFcJnOMdU4kPR3H7OROvDJDdr03jP9Y+dmjTQ1MtEY9voIxglL9mYraNOy+htSFw1KUmJKgJ68Wo
	4PDJoR3cMz/fkd7JuwfkQY0rDOQ8bV1zGWUmJQEuoi9iKGloaZVbnFqY6kS3X8fSZVxWc/LNFlzFS
	prxhHBS45UT0hwLSxXGWsJPclpobb+4Qz4/QCgdZ+NEdwfdfuy2CD0KNivX5v0trRh+k5XRRg0lp5
	Z2+6a0SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyvO-0000000DUuO-0cP4;
	Sat, 03 Oct 2026 12:33:10 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyvK-0000000DUtv-0gEA
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 12:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=AHWwi2RygPrOnN
	pVFuECy+vvC6Lk/DVmV3VXA83YzMI=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=n/Ryms9sTkAj9ApaVaOFDy+3tF9z+X2gqHHDx
	+Ki0LO2BDN24XVKuDm4B+bPrSTwjsJE5uzKOpN74WdvEMFgDUNd7d1qn9cikha1sthrmJR
	fJnaA3qiKs1uCIjJjygxj2jjKnRj1o9E3eN/C3DTmI8tAUj2F8USgOSjFcZSGHP2shGBzq
	g/plOiZT9cAQhAEHtBaS5byL00nBue3swqyXUtWLHKLryAxsCTwyN8oQrmCXdkWMZs7PU7
	ZoGycJqgPKzaPw8GChVycUCf0qgqbbkMLWwYREqR382lmRRqbL2Vf3vftsrrGYBZkTaEaj
	pay8dN9bIBK1BJ3epVy2YTmVQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 2092ede2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 3 Oct 2026 14:33:00 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 14:33:00 +0200
Message-Id: <DLV7F9W5HSFS.1D5WQW59ZEHEL@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <hare@suse.de>,
 <dwagner@suse.de>, <asahi@lists.linux.dev>, "Sven Peter" <sven@kernel.org>
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Yureka Lilian" <yureka@cyberchaos.dev>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260915095827.698928-1-mlombard@redhat.com>
 <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
In-Reply-To: <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_053306_839171_B6701E5E 
X-CRM114-Status: GOOD (  23.60  )
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

On Sat Oct 3, 2026 at 1:55 PM CEST, Yureka Lilian wrote:
> On 9/15/26 11:58, Maurizio Lombardi wrote:
>> During NVMe controller creation, the controller is exposed to sysfs via
>> nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
>> This creates a narrow race window where a userspace process can write to
>> the reset_controller sysfs node before the initialization thread
>> transitions the state to NVME_CTRL_CONNECTING.
>>
>> If a reset is triggered during this window, the state machine allows the
>> transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
>> is queued. However, the original creation thread continues its execution=
,
>> subsequently moving the state to NVME_CTRL_CONNECTING and finally to
>> NVME_CTRL_LIVE.
>>
>> When the delayed reset work finally executes, it attempts to tear down
>> the controller and transition the state to NVME_CTRL_CONNECTING. Because
>> the state is now NVME_CTRL_LIVE, this transition fails, triggering a
>> WARN_ON in the reset work.
>>
>> Fix this by removing NVME_CTRL_NEW from the allowed prior states for
>> the NVME_CTRL_RESETTING transition.
>>
>> Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecting =
when resetting")
>> Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/core.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index beea23d04a70..7ea8dd27d08d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -598,7 +598,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>>   		break;
>>   	case NVME_CTRL_RESETTING:
>>   		switch (old_state) {
>> -		case NVME_CTRL_NEW:
>>   		case NVME_CTRL_LIVE:
>>   			changed =3D true;
>>   			atomic_long_inc(&ctrl->nr_reset);
>
> Hi!
>
> I was testing something with linux-next 2026-10-02 and ran into an issue=
=20
> with the
> nvme-apple driver where /dev/nvme0 exists but none of the namespaces appe=
ar,
> and the dmesg is awfully quiet about the nvme device. I bisected it down =
to
> this patch, which as far as I can tell leads to the nvme-apple being=20
> stuck in
> NVME_CTRL_NEW state. Without being familiar with the matter, this looks l=
ike
> the nvme-apple driver was using this transition as part of its=20
> initialization
> procedure.=C2=A0 If one of the NVMe people who know how these transitions=
 are
> supposed to work could have a look, that would be much appreciated, as
> otherwise this will break nvme-apple in 7.3-rc6.
>
> Thanks,

Thanks for reporting this,
it seems that nvme-apple is the only driver that still initializes the
controller by performing a reset directly from a NEW state.

This should be easy to fix by moving the state to CONNECTING in
apple_nvme_probe, just before nvme_reset_ctrl() is called.

Would you be able to test the patch if I prepare it?

Maurizio


