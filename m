Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4EEC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Apr 2022 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9owOnrSL4v8PrTima/6oWFY10o2x0HcvuzHdRM9+1jo=; b=BDB9poCTE1WolBq3ZQSUf89oVY
	S2Ku7bt98jgs3xYhK2NoxaokYaH0g/dq568xwfSPz27uidCRMgc43zrbjqrjX0TlWpmqcfhxclXGE
	leUV4JV1RF/WOLIwv3DJrwMjKEzMeMwj+bIhfJ7HY8WEpTCCzSuZEBvHsLo8mUpfxw52ZSvoRChqG
	ZgDl4f68Dmy84NEWrJWfnK/FAV8en3Bj9fCgDJcd+It6644KLI9AU8kqrxhhe2mFCOAR5fZXNwoYr
	SexxBEs2Ni3tHZ9dWtgi0MlFYmDk9E04auxSxdknBybXZIpsDcDLNUN3i3WHtB4SJ8ZUeLALGaOr+
	VR8z2Rfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nf4pp-006zto-CJ; Thu, 14 Apr 2022 19:08:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nf4pi-006zs3-1H
 for linux-nvme@lists.infradead.org; Thu, 14 Apr 2022 19:08:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7A5F9CE2BB3
 for <linux-nvme@lists.infradead.org>; Thu, 14 Apr 2022 19:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE527C385A1;
 Thu, 14 Apr 2022 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649963321;
 bh=bYIXZqNRYHNTC7uwbHLUzgVpvy3h1GV2XQ7TOWXxejc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qL8PUBIsY07Yy6QYe3SjYneE2rJdXI73XcsqyUpC+fw2O9Y1DPRukDA3mVIHkUKvW
 wuO7W6gcuL1mt0t6Xmj2qAm4ToyUPs+TJAzlW3twxmYHEx9UUE3YYDFFMZMIkQyAEl
 FEdKA2Vh6Yr9EFWg9fNBYTRs7du01xLLY441Hdk3sk88J9fdCc3R4+hju/9Kr+Dbyy
 Chuw8uwwjCv/F6mEiKR2PJz3BAIWJyo+ckNHHR8LTXt+ZbG+rGbneXolJS3BXRoBX6
 rknOFApCy0XoncVpghZJMR2W8CHUfxr0h3U/ri1xGV0ONwB+Pes4h55RfNzuk0/UDC
 UTcTq01ElgUEQ==
Date: Thu, 14 Apr 2022 13:08:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: Re: [Bug 215679] New: NVMe/writeback wb_workfn/blocked for more than
 30 seconds
Message-ID: <YlhxNn5JZcsqpOlf@kbusch-mbp.dhcp.thefacebook.com>
References: <bug-215679-95461@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215679-95461@https.bugzilla.kernel.org/>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_120846_314498_EB0619B6 
X-CRM114-Status: GOOD (  12.79  )
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

On Sun, Mar 13, 2022 at 08:13:53PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215679
> 
>             Bug ID: 215679
>            Summary: NVMe/writeback wb_workfn/blocked for more than 30
>                     seconds
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 5.17.0-rc7
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: NVMe
>           Assignee: io_nvme@kernel-bugs.kernel.org
>           Reporter: imre.deak@intel.com
>         Regression: No
> 
> Created attachment 300564
>   --> https://bugzilla.kernel.org/attachment.cgi?id=300564&action=edit
> dmesg log after suspend resume, io stuck
> 
> After system suspend/resume filesystem IO will stall, producing a 'kworker
> blocked for more than x sec" in dmesg, recovering after a long delay. See the
> attached dmesg-suspend-resume-nvme-stuck.txt. I also noticed the same issue
> happening right after booting or after runtime suspend transitions.
> 
> The same issue also happens on multiple SKL systems in the i915 team's CI farm,
> see:
> 
> https://gitlab.freedesktop.org/drm/intel/-/issues/4547
> 
> I bisected the problem to
> commit 4f5022453acd0f7b28012e20b7d048470f129894
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Oct 18 08:45:39 2021 -0600
> 
>     nvme: wire up completion batching for the IRQ path
> 
> By reverting it on top of 5.17.0-rc7, I can't reproduce the problem. Attached  
> dmesg-suspend-resume-nvme-ok.txt with the revert, captured after a few
> suspend/resume.

Forwarding to linux-nvme for higher visibility.

