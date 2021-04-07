Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C91C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 21:34:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84F6610D0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 21:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F6610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2cUvfaNM6YTqBu+THQ05svDbkl6LJSY7MfwrLGn5Tic=; b=oBsMbBunq6hALAOa5h+Dp0x34
	EiErXjUEQhvUF8HP2meHY2zE4AazUka9uNn07GyXrpxKODhI4Ok04rFDRX1lyVMYplqzo8NN6ArZ2
	T6dfFdSIBMxQiEsZz6xVMQrWui33NjgB46J2DW6l35C5U0S+fr9+f0VWKZWpOszgZ4+gKQ8YmAW1D
	DgqVGCcygu4/VHqHMrihd3j1x2pp9GBkCHCw3xK5ux04p7gN4Zm6blyPuA4WOETItOp6xOGYLlqfJ
	m4etnZZCkcpL/hf3p3Pp8hGqf7A8sPLdTIBoILDSdkL2GKc3cl9ANedrmb+PW+gt0GZ4GtGjXiItH
	vwJZ606JA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUFp2-0064jo-OQ; Wed, 07 Apr 2021 21:34:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUFoy-0064jS-AO
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 21:34:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FE94611CC;
 Wed,  7 Apr 2021 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617831282;
 bh=J71KapKeoT7frCZM+DXa4xBWl+YWwokcBAgBASUbSqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZUbic7XDEWaGpo3yLTi2LaBC5SC7vKv60YYAqe5Ij8OMzcd9jUEf9jyfDq9LPRWUu
 yaWcxVm6Ar3DwcQQXdDVNV7YcSSpDSnIKKDmU3IcY5vglmnzWaK7DjgdMIgVOVWprq
 lIlJoSL+cjwyIZNVxtoJUTm7g5MSzMt0dB9GTKMHz8SOQjkgK6gOG4vgn91kvQu9e4
 aYeY27zdW+KGNJoInlpUGCazR7BfLGeuLXuUq1Xi2PVE6kR+XNafT8mUpvaYnLC9gT
 2lzadci4QVZW6nXFiZaLIFZKy15Ldc/z3HJ3KaHwhFWMR37+YQFRyyX83r683e7i76
 s/z4NTi9mQ84Q==
Date: Thu, 8 Apr 2021 06:34:36 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: libnvme questions
Message-ID: <20210407213436.GB30623@redsun51.ssa.fujisawa.hgst.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
 <15fdfa03-3adf-6877-e369-47429a5462a5@suse.de>
 <20210331145406.GB23886@redsun51.ssa.fujisawa.hgst.com>
 <44c4f2ea-dd3e-5a9c-f93e-d6de6ca7dd13@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44c4f2ea-dd3e-5a9c-f93e-d6de6ca7dd13@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_223444_574155_1B231715 
X-CRM114-Status: GOOD (  31.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 31, 2021 at 05:29:46PM +0200, Hannes Reinecke wrote:
> On 3/31/21 4:54 PM, Keith Busch wrote:
> > On Wed, Mar 31, 2021 at 04:15:24PM +0200, Hannes Reinecke wrote:
> > > Hi Keith,
> > > 
> > > On 3/10/21 9:48 PM, Keith Busch wrote:
> > > > On Wed, Mar 03, 2021 at 03:14:02PM -0600, Tony Asleson wrote:
> > > > > 1. There is interest in utilizing the libnvme library for some other
> > > > > projects, when is an official release of the library planned?
> > > > > 
> > > > > 2. Is it planned for nvme-cli to utilize libnvme?
> > > > 
> > > > This is my bad, I fell behind the task due to mutliple conflicts of
> > > > time, but I am back on this right now. The plan is to tag nvme-cli v1.14
> > > > within the next few weeks, then make the shift to libnvme integration
> > > > on a "2.0" version for future work on the master branch. This would
> > > > coincide with an official libnvme stable release.
> > > > 
> > > > I honestly do not have enough devices to regression test all the
> > > > features, so I will continue to maintain nvme-cli 1.x branches as long
> > > > as necessary while ironing out any integration issues.
> > > Any updates here?
> > > We've got some changes/reworks pending (the nvme monitor stuff, and also
> > > a new configuration file mechanism with using a json config file), and
> > > it would be good to know what would be the appropriate base for all of this.
> > > 
> > > We could give you a helping hand in moving nvme-cli over to nvmelib if
> > > that's an issue ...
> > 
> > Thank you, yes, that would be appreciated. I've ported it a couple
> > times, but I keep having to rebase. It's not terribly difficult, but it
> > takes a lot of time..
> > 
> Can you send me your latest attempts?
> That should be a good starting point, and probably avoids some work on our
> side ...

Sorry for the long delay. I thought it was going to be a quick effort to
make that available, but it wasn't so simple. I just popped all the git
stashes I had around and integrated them into a branch I started last
month. The result is here:

  https://github.com/linux-nvme/nvme-cli/tree/libnvme-int-3.4.2021

It's reasonably complete and tests fine for the commands that I can
execute.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
