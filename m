Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A60EC47080
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:15:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04517613AE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04517613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sh8TPaSh4MfF0DLxAtIP0AYGEX1Niq6vP5wj7MqsEcw=; b=xtZUHe09RSji9j
	1niJ5fblyOllRBgL2JggmsUDGuRBWofuGJudvZZYNbe828m0CodrhdDhGb3jgFzalLV41BRZjj3xH
	s1USbwZhLKhMZwJ3xeYTJFwjSLXQXESYEwiR5WFiUzJqj7RuJis259As9+zJCxqy4P56seqm21nfA
	PSfg/+1nUgTw4LaVdx0MrG7wCmTvjVdB7Jt8mV8Dz7U6BN3H1z8zMU9BT5XbUXX0QAbOz657H74UQ
	QJABrr/k7IVDEHgh2ZzaJ+p7AorrDJ09OVRf3YZQFgxbmgt82q9xGW9Ge2DaDo5+QH0IGjzoy5GDO
	CsWREH7gWloFID9FaTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo7zC-0003HS-G5; Tue, 01 Jun 2021 17:15:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo7z2-0003Fr-7q
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:15:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CD02613EB;
 Tue,  1 Jun 2021 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622567715;
 bh=QHoBPf/2sxu+iAXot83ejJn5wlHgzQYisQqDciR9tso=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XrP28+CSswVnxfIxNB/+WumEq+7/vf39Rsln/w1FS7biRawMHPeecyjPT61vcGuS8
 YRr5G2djQZjBuzN7taojVJc3HndfqHJdWK+1LJ4aN0rfa9hQGYciFa1cJ1nHLRJoo+
 xEEHWSZ1Xy1bgYVOzHbjbw853Glgbju9ANVXB3oFc21a1zl4+t2I913ZUA3PA+MVs+
 xlZU+Jk2kgygeLtxIBhrVase6m2SAUaQfFdZl+mu2Z0w9dywOKl+gVsu6Df25J9kVS
 Ie5a23PqyaUTGBDQSvFcGhDXZ5zI29Vq2Z0U1nI0VDkFEWySEbCprDziVPIHSzPLyi
 wPfTIHDfhUgSg==
Date: Tue, 1 Jun 2021 10:15:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVME_IOCTL_SUBMIT_IO access control
Message-ID: <20210601171513.GA4506@dhcp-10-100-145-180.wdc.com>
References: <YLTD7gcSIiNRJvGX@x1-carbon>
 <20210601135310.GA4197@dhcp-10-100-145-180.wdc.com>
 <YLZPAV4Cu8ZuYe/Y@x1-carbon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLZPAV4Cu8ZuYe/Y@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_101516_326615_83E845E0 
X-CRM114-Status: GOOD (  23.51  )
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

On Tue, Jun 01, 2021 at 03:15:14PM +0000, Niklas Cassel wrote:
> On Tue, Jun 01, 2021 at 06:53:10AM -0700, Keith Busch wrote:
> > On Mon, May 31, 2021 at 11:09:35AM +0000, Niklas Cassel wrote:
> > > Hello there,
> > > 
> > > How is the NVME_IOCTL_SUBMIT_IO access control supposed to work?
> > > 
> > > $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> > > /dev/nvme0n1: Permission denied
> > > 
> > > $ sudo chmod o+r /dev/nvme0n1
> > > 
> > > $ echo "hello" | nvme write /dev/nvme0n1 -s 0 -c 1 -z 512
> > > Rounding data size to fit block count (8192 bytes)
> > > write: Success
> > > 
> > > 
> > > Am I supposed to be able to do a write if I only have read permission?
> > > 
> > > $ ls -al /dev/nvme0n1
> > > brw-rw-r-- 1 root disk 259, 0 May 31 10:59 /dev/nvme0n1
> > 
> > I'm not sure, we've always allowed any user passthrough command if
> > CAP_SYS_ADMIN capable. It should be pretty easy to check permissions for
> > any data-out opcode against FMODE_WRITE. We'll probably break something
> > if we do, though.
> 
> Hello Keith,
> 
> Indeed,
> NVME_IOCTL_IO_CMD and NVME_IOCTL_IO64_CMD does require CAP_SYS_ADMIN,
> however, the same is not true for NVME_IOCTL_SUBMIT_IO.
> 
> Which is why as a regular user, with only o+r, I could do a write using
> NVME_IOCTL_SUBMIT_IO.
> 
> In one way it makes sense that NVME_IOCTL_IO_CMD requires CAP_SYS_ADMIN,
> since you can send any command to the drive using that ioctl.
> 
> With NVME_IOCTL_SUBMIT_IO, you can only submit write/read/compare.
> So it makes sense to not need CAP_SYS_ADMIN.
> 
> But I probably would expect data-out to be checked against FMODE_WRITE.
> 
> I just wanted to raise the issue, in case this was accidentally overlooked.

You're right, and SUBMIT_IO has always behaved that way. I believe this
was an oversight and should have been checking fmode_t against the
opcode.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
