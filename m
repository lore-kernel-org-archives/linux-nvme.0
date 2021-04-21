Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CEC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 07:57:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D4F61434
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 07:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D4F61434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BaFEArIXv1HnSX2jRLrG//DV0y5Wd1KqP5FjYdeFj6s=; b=Hz79rlAMyhXR0j+/6hcGNWONX
	0+oRbNz23VhibAsTV4FeMACjxmGjgHZ+GZH+Yz042XtugsTA9JusV6t+S/Jt3u3N6ryngUWBrPJsT
	B5ACPKKPqHF0wrIsWU+LF+adgSqEV7IY8XUZvdaU3Eh6hqqCR2up6UwKcAhSA8x+kUhrp4rX4uR+z
	9JkolJLx/7tsxJ9cfWyG6D0Mr2owwE3UaXT/pcpIBuj2wCbRzrApBJw5BEmvJ0ua0FJ0PbIlzKqFr
	osv6Fda9nCCbaQtiJNyke2W7hUU7NQmK4hM7eIhFvosBZ3vz5dn8DLgCh3+Uszg7i9dTFEouAcfGb
	Dm7+A9DFQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZ7jd-00DwA6-7b; Wed, 21 Apr 2021 07:57:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ7jR-00Dw8M-U0
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 07:57:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=i2iOk/0pIpUHkWQn0m5z026EF9q+aqrVtkg96hg7LgM=; b=f6c4TVsIwj78JZqDVKU4UgqxQy
 IgGGw/b81LF6rfDbShVsn5eQg5VGyUH9P6Y3wArRHGFy+fPhQ/UIQdDyHCqFSINq0DUcr/gFH8qG+
 CuAwkX7BpBJCzUQq/lpjSqV0SUoEgCsDOUrZZ1yfqKKnMBo1AWzLAE/pD3YW8KsaXwuAUXqtdb0wJ
 Hin0Elkpj8XK8+9QCKE3+kjCc+v5XiDlAc4O98xzzmEvLTuahbFg+Hx1D1DemgJrEIy5UNRK+9KBG
 OHoahHaQuGgZ50lH3avKS/BcVWN5p85dZgR3U8ZOJZSfPdzKRLghKR6EkSpEJN0xYHpTUkQBv/rwC
 RiCwfcSA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZ7jI-00Cgm4-Ux
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 07:57:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 88C5CAFE6;
 Wed, 21 Apr 2021 07:56:59 +0000 (UTC)
Date: Wed, 21 Apr 2021 09:56:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Arun Easi <aeasi@marvell.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Nilesh Javali <njavali@marvell.com>, James Smart <james.smart@broadcom.com>
Subject: Re: [EXT] Re: [RFC] qla2xxx: Add dev_loss_tmo kernel module options
Message-ID: <20210421075659.dwaz7gt6hyqlzpo4@beryllium.lan>
References: <20210419100014.47144-1-dwagner@suse.de>
 <YH8QzgWiec8vka20@SPB-NB-133.local>
 <20210420182830.fbipix3l7hwlyfx3@beryllium.lan>
 <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.9999.2104201642290.24132@irv1user01.caveonetworks.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_005701_174476_FD21E954 
X-CRM114-Status: GOOD (  28.88  )
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

Hi Arun,

On Tue, Apr 20, 2021 at 05:25:52PM -0700, Arun Easi wrote:
> On Tue, 20 Apr 2021, 11:28am, Daniel Wagner wrote:
> > As explained the debugfs interface is not working (okay, that's
> > something which could be fixed) and it has the big problem that it is
> > not under control by udevd. Not sure if we with some new udev rules the
> > debugfs could automatically discovered or not.
>
> Curious, which udev script does this today for FC SCSI?

I am currently figuring out the 'correct' settings for passing the
various tests our partner does in their labs. That is no upstream udev
rules for this (yet).

Anyway, the settings are

  ACTION!="add|change", GOTO="tmo_end"
  # SCSI fc_remote_ports
  KERNELS=="rport-?*", SUBSYSTEM=="fc_remote_ports", ATTR{fast_io_fail_tmo}="5", ATTR{dev_loss_tmo}="4294967295"
  # nvme fabrics
  KERNELS=="ctl", SUBSYSTEMS=="nvme-fabrics", ATTR{transport}=="fc", ATTR{fast_io_fail_tmo}="-1", ATTR{ctrl_loss_tmo}="-1"
  LABEL="tmo_end"

and this works for lpfc but only half for qla2xxx.

> In theory, the exsting fc nvmediscovery udev event has enough information
> to find out the right qla2xxx debugfs node and set dev_loss_tmo.

Ah, didn't know about nvmediscovery until very recentetly. I try to get
it working with this approach (as this patch is not really a proper
solution).

> > > What exists for FCP/SCSI is quite clear and reasonable. I don't know why
> > > FC-NVMe rports should be way too different.
> >
> > The lpfc driver does expose the FCP/SCSI and the FC-NVMe rports nicely
> > via the fc_remote_ports and this is what I would like to have from the
> > qla2xxx driver as well. qla2xxx exposes the FCP/SCSI rports but not the
> > FC-NVMe rports.
> >
>
> Given that FC NVME does not have sysfs hierarchy like FC SCSI, I see
> utility in making FC-NVME ports available via fc_remote_ports. If, though,
> a FC target port is dual protocol aware this would leave with only one
> knob to control both.

So far I haven't had the need to distinguish between the two protocols
for the dev_loss_tmo setting. I think this is what Hannes was also
trying to tell, it might make sense to introduce sysfs APIs per
protocol.

> I think, going with fc_remote_ports is better than introducing one more
> way (like this patch) to set this.

As I said this patch was really a RFC. I will experiment with
nvmediscovery. Though, I think this is just a stopgap solution. Having
two completely different ways to configure the same thing is sub optimal
and it is asking for a lot of troubles with end customers. I am really
hoping we could streamline the current APIs, so we have only one
recommended way to configure the system independent of the driver
involved.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
