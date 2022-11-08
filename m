Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A97C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zt1FlwCoyzHqUA6l14DV/vMVVI9Siuvp/YrjRb7u8e8=; b=qSV8A8gojfz1Li56CwnQGcmgIa
	rF0bnEY2Gi85GdbOrzb+M6Zb40D9M/SpOM61Ibovb/2JCALILLkuwxgY0pW3y+fGxp18d4+99X0lo
	05n9ElviORJVD34+sEinhcfDXymppT8S03DvIbGa9l34/Vz421rn9KiwEP8oD/Z68idzqGomPIx3e
	fJcCWZSDAXTwrCnZPQe2vuS+lLE3tTuaAxn1H31T05mASLUM3/MMKwLGdt2Z7KOaIHrGo/oaZWH2i
	4c+AYi5N8XqWILJ+qUQd74M6jWl7TSrORn24PVcrfGTNvsmzBgQ1PDdWrTof2O8EkincitiblQykl
	OpHlbjSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osXp3-0093fQ-4l; Tue, 08 Nov 2022 23:16:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osXov-0093eu-Uk
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 23:15:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E910E617D4;
	Tue,  8 Nov 2022 23:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25220C433D6;
	Tue,  8 Nov 2022 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667949352;
	bh=1RkLi5QAYDoDmVVLkRoTpUsOAxdEDLJmmOLWXGlFifk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxGBynfM+6EVwcndyjxb7pnVthAUo99wudmaKWAz7Kkd9ulw0c/LAU48q2vpXo+Cc
	 2PjG7dktxuqvtxiizWt4yQW3OlBEznycQ+81DhASsnJGngka8qhRWOSQ6d1qaYvdaQ
	 wum1eHoZffaGA22pzFaLvqVaqDYul2C/oEcKkL4dnB3GwOi4rjSNrrkL+xnNtkSngW
	 m3AtJVKqEbsTjJal8xEWvH52Iij31iNOuq1DQbonNK+o9BXabtne8LKAt9YdG0DrPC
	 z8DQvdknyMwZAlmFQu3o4F3GJaV2nGSnC3mjwCGrlGJLG3i2Pb8OgVapF15EF74Xm+
	 Kem7aqUPVnTdQ==
Date: Tue, 8 Nov 2022 16:15:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Message-ID: <Y2rjJZlDzWe3DqkA@kbusch-mbp.dhcp.thefacebook.com>
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
 <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
 <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
 <Y1gVOK8VXhZZbm/C@kbusch-mbp.dhcp.thefacebook.com>
 <5862c074-5546-7d69-f398-e08a42adff65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5862c074-5546-7d69-f398-e08a42adff65@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_151554_089530_144739C7 
X-CRM114-Status: GOOD (  30.63  )
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

On Tue, Nov 08, 2022 at 02:13:25PM -0500, James Puthukattukaran wrote:
> On 10/25/22 12:56, Keith Busch wrote:
> > On Mon, Oct 24, 2022 at 08:26:54PM -0600, Keith Busch wrote:
> >> On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
> >>> On 10/24/22 18:36, Keith Busch wrote:
> >>>
> >>>>
> >>>> Generally, the default timeout is really long. If you have a broken
> >>>> controller, it could take several minutes before the driver unblocks
> >>>> forward progress to unbind.
> >>> One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
> >>> thanks
> >>
> >> In your log snippet, there's this line:
> >>
> >>   kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
> >>
> >> The next action the driver takes after logging that is to drain any
> >> outstanding IO through a forced reset, and all subsequent tasks *should*
> >> be unblocked after that completes to allow the unbinding, so I don't
> >> think adding any new sysfs knobs is going to help if it's not already
> >> succeeding.
> >>
> >> The only other thing that looks odd is that one of your stuck tasks is a
> >> user passthrough command, but that should have also been cleared out by
> >> the reset. Do you know what command that process is sending? I'll need
> >> to double check your kernel version to see if there's anything missing
> >> in that driver to ensure the unbinding succeeds. 
> > 
> > I think there could be a mismatched queue quiesce state happening, but
> > there's some fixes for this in later kernels. Could you possibly try
> > something newer, like 6.0-stable, as an experiment?
> 
> Is this the patch for the mismatch?
> 
> commit d4060d2be1132596154f31f4d57976bd103e969d
> Author: Tao Chiu <taochiu@synology.com>
> Date:   Mon Apr 26 10:53:55 2021 +0800
> 
>     nvme-pci: fix controller reset hang when racing with nvme_timeout

That doesn't look like what's happening here. I was thinking of this
one:

  commit 9e6a6b1212100148c109675e003369e3e219dbd9
  Author: Ming Lei <ming.lei@redhat.com>
  Date:   Thu Oct 14 16:17:08 2021 +0800
  
      nvme: paring quiesce/unquiesce

It's not a clean cherry-pick, though.

