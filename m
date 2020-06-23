Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED55C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 18:01:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1989C20781
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 18:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7MyEgXV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbrtIjQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1989C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EpdlVAtFPerAdnbvHF8AIcKuAD+0gM2dmPAsi9PiQsE=; b=c7MyEgXVeTL7Naj7pe/c1uB+c
	PagP8rANRdYIAjrsg4/N0XrucSfbeEFa1VyqqNnzOjAVv86JJag2O59VP2DUt9EvXVC2Fr7fH7sGg
	C8iauI6ch3VK1hiFIq2QmTQ35XRcD5qST6uUH9gyTCZqALx5BHrOMz1YX0AkzDur7NHgOsL40FUgF
	l+21kcTUczXUx8D3+q9EjqKaGRQxsTlEkPLLq3VbcJYOhx/vBhTLtYxqE1I9cpe4bCJVG503v8uki
	zBG6q6JHH4ylQ+JV3Tdad+BxEvTcxCi/8dPkTLe7z1K6fbwKCykfINrNREOXTJpnt6L3N1bzJv0v/
	hHc0MVhUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnnEQ-00032S-Fd; Tue, 23 Jun 2020 18:01:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnnEN-000310-Ku
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 18:01:12 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD85020781;
 Tue, 23 Jun 2020 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592935270;
 bh=+jfly5Ngdrj48jWGMhf0AWiq7rzl82cAMECyjRrpm7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GbrtIjQNnqzJ0vx63NM4QAOL+qYwxJVWynHFyEuShC/rZ+ieqmI4ZTS75fDGdb522
 TSBwCa5HDHkz//wbdzXSovuFgwf3Og/v++jtLNIqgzJ87H5HU4joqKN9gOFIZUpgAv
 +Lw3pblMKbDwl3D/v6iJM9ScJ5O1x+ccF+ch82Qg=
Date: Tue, 23 Jun 2020 11:01:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 Baolin Wang <baolin.wang@linux.alibaba.com>, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 10:39:01AM -0700, Sagi Grimberg wrote:
> 
> > >  From the NVMe spec, "In order to make efficient use of the non-volatile
> > > memory, it is often advantageous to execute multiple commands from a
> > > Submission Queue in parallel. For Submission Queues that are using
> > > weighted round robin with urgent priority class or round robin
> > > arbitration, host software may configure an Arbitration Burst setting".
> > > Thus add Arbitration Burst setting support.
> > 
> > But if the user changed it to something else that better matches how
> > they want to use queues, the driver is just going to undo that setting
> > on the next reset.
> 
> Where do we do priority class arbitration? no one sets it

Not the priority class, we don't use WRR in this driver. The RR
arbitration can be set from user space and saved across controller
resets, like:

  # nvme set-feature -f 1 -v 3 --save

This patch would undo the saved feature value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
