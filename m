Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C75C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34D56008E
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 14:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34D56008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F2ePU7nPmYG/P6NhFbThTQhP/sIpz4p7yHJY7Sgb5Zs=; b=TlUxiDO3eAFsdDZknv/zCjrlo
	4Kj2Xyd7qP0BX0bHJaWhNnChXgRiJb2ApsK1KGVnpwOpItoVvTQv3ahEHtxLiHxUx5Ep8ug8PbDb2
	27yiHOGD57mzZ0dhdpbyanLmg5Tv237AAmB0sFQ7wGs7H7b6QRliu1XxmnZ5rAkX38gq5vsCnor8x
	YrFzXdBsgijED1yh0IVt8q7SLZH45QputdyqibdtFd484qnVSU1LhJaFKw2Ha2gy42K4rb1a4Ktsb
	E9kIT0pB+D3pO8TvjidHRnCOPhxfEKGnkXFdskFp+z4ox4SvbAOfVk6+sjMAwY/9NszEwx8beFM3h
	wR01HAW2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRcEm-006q8Y-AO; Wed, 31 Mar 2021 14:54:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRcEX-006q4t-U3
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 14:54:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEFCE6101C;
 Wed, 31 Mar 2021 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617202452;
 bh=KRtcv92ugaL4q/o3FGKlhrCxuRDdgQnoUR6q8WbXG1Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HUgIfUgid2Srl+d+/pqn6LBFcBBYkAAeja9GZmTcowrT1WNdIyO+0iKZr2Ls4HeZG
 lT4VBP3yzlAv97YjU1ShxR8ROhmMGb+5NmG9h1J/wSEci20YcD80+IDZ34qaMRR+8w
 nQw7sCX5iK7lK0iVlb/Ku7sL8t3ES4mnmB/SBMlfeYSHy+2WJn125j5NQn9whNgLxs
 B6GOMq8kcInoDNmU4CjR8hxYAWugRyG0/54YQUtOVWCcUWXAqUL8zfZe4hGUoWt866
 LTS4g+xGgyww7BAPJLdZycmWsPwVKf2mc9B8EtukKMQ8ogQF+AUt7691wiwikwRHaq
 UdGGGdtiDFP5Q==
Date: Wed, 31 Mar 2021 23:54:06 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Tomas Bzatek <tbzatek@redhat.com>,
 Tony Asleson <tasleson@redhat.com>
Subject: Re: libnvme questions
Message-ID: <20210331145406.GB23886@redsun51.ssa.fujisawa.hgst.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
 <15fdfa03-3adf-6877-e369-47429a5462a5@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15fdfa03-3adf-6877-e369-47429a5462a5@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_155414_268204_F5BF1E36 
X-CRM114-Status: GOOD (  21.10  )
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

On Wed, Mar 31, 2021 at 04:15:24PM +0200, Hannes Reinecke wrote:
> Hi Keith,
> 
> On 3/10/21 9:48 PM, Keith Busch wrote:
> > On Wed, Mar 03, 2021 at 03:14:02PM -0600, Tony Asleson wrote:
> >> 1. There is interest in utilizing the libnvme library for some other
> >> projects, when is an official release of the library planned?
> >>
> >> 2. Is it planned for nvme-cli to utilize libnvme?
> > 
> > This is my bad, I fell behind the task due to mutliple conflicts of
> > time, but I am back on this right now. The plan is to tag nvme-cli v1.14
> > within the next few weeks, then make the shift to libnvme integration
> > on a "2.0" version for future work on the master branch. This would
> > coincide with an official libnvme stable release.
> > 
> > I honestly do not have enough devices to regression test all the
> > features, so I will continue to maintain nvme-cli 1.x branches as long
> > as necessary while ironing out any integration issues.
> >  
> Any updates here?
> We've got some changes/reworks pending (the nvme monitor stuff, and also
> a new configuration file mechanism with using a json config file), and
> it would be good to know what would be the appropriate base for all of this.
> 
> We could give you a helping hand in moving nvme-cli over to nvmelib if
> that's an issue ...

Thank you, yes, that would be appreciated. I've ported it a couple
times, but I keep having to rebase. It's not terribly difficult, but it
takes a lot of time..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
