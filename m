Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ECBCA1017
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMWIYIk7rar3uysfQHpfaNcKdRgk+QYxyMbF/YUjpWw=; b=ItAGl5VPuQLYSZECconQBGmpyT
	T4U+ozvIF82pepZ05OCjHVgToVPE2RkKN9sJXsH80PFzw0QL/9mlzmz8hZsCXNcYtteDDta3YrPlv
	sfEN28kxMy/RF/aFkr0LtNYdpsBTKBlOtV457qWbUHnsNyE+ohV7A5QJEoXcvE0z6TGSfywNo8CW/
	ZIw4SYZfZxnF/6jCJ88x1wjUXU5bd5BJsEgLmfIiwe3jO4Ah88XmhP50WzBQSR7xYirmlRAH1fi3N
	s3JnXduVqE3dva4beQPsaf3NuJ+W2cSpCTcqxRaIl6bEqM62a06YzL1HRoQXBgoPfG7R8phQWdqhJ
	5bqQ2nvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugYv-00000005Xis-2KKl;
	Sat, 06 Sep 2025 00:13:49 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuehx-00000004x5T-0KKZ
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 22:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757110500; x=1788646500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+r/RsHPqce6DBiDyKNnvYHMFIwMBLx4/IBCtIvmAI4=;
  b=hlXpLbnll162VEtLsP3d3lCcQGHo729qBzSfAznaaMLhXr/eMW9DdTQ3
   UtVn+VEE/BHYdA0oHR9OpmMrYyaEcV/sVwND0Dtl9dRJHu4Y2e5YF+lxX
   RDOCTXfd7x9u+yZ2C9jMyJGtYXm0dBy9y9rNgRhlzeZp3aQAGZLDSRe+q
   P6IdPuuRpAVMb7AaoVg+P7dlIA7CVa4HiH7TilhenonQFzr9OxLBwLr7Z
   1Ex0k5teIbwmypKZDZgc+YhGj0QLg5h7Zb9YW77iuOeLTFhhrahqTDL31
   rOyg5hZP1Qjxz3x8d/lKh6stHS/OjchNpShAR0yXuEd0Hp5c0/cvcifrk
   g==;
X-CSE-ConnectionGUID: hIvxy/qjQSu2c+m1+YC28w==
X-CSE-MsgGUID: 0mohTgzfRFecMur5IyR40Q==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109005751"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 06:14:58 +0800
IronPort-SDR: 68bb60e2_6XuSJM7VzWoMx/N/q/2QQjwItBXtb83OBmONtBrPitKpYEM
 6IKkVpmZlsKb+hhRMcghfMmR39gIgwS3oTdGl+Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 15:14:59 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 15:14:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJVyV3YxVz1SHvh
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 15:14:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1757110498; x=1759702499; bh=F+r/RsHPqce6DBiDyK
	NnvYHMFIwMBLx4/IBCtIvmAI4=; b=L1iFYr1+8PumSZuu3VaL5vFQuK+jPuoI6C
	2z30zKqKDGIsXEka/e6B3isBLqIay7SDxTvKGN4FaN3eoDUbp5qCPO1Om4RPZnPQ
	JTssLD+zMDCScevaVl1q6pqqqvsMOhL9VG1yG8khQwgOEP35uMihEeoKY8bhDbrH
	ELRFMwCyj3Pr8eW2RkCmjJZIHOhTyK2yn4roOtVOIxAc4ayVn4MzoVSdIzpg5243
	dWZgWCS03wTdoijjEwuFqeFFwaw1v2lMgJiHNU8Ceenj6djM3gcJPZzOfpuxBRSB
	8r3MwrTi00Eu2/tXVjpkFoxTcdPU0Z8JxtdBnPtjJWddxe/HLusg==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vou3UhnE9GV4 for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 15:14:58 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJVyT4r5gz1SHkR;
	Fri,  5 Sep 2025 15:14:57 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:14:56 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin
 ctrlr
Message-ID: <aLtg4PIb1Xd6WTP0@ros-3.wdc.com>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
 <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
 <aLta40FO1Ud6TZ4T@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLta40FO1Ud6TZ4T@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_151501_157880_7B055F86 
X-CRM114-Status: GOOD (  15.03  )
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

On Fri, Sep 05, 2025 at 03:49:23PM -0600, Keith Busch wrote:
> On Fri, Sep 05, 2025 at 02:10:01PM -0700, Kamaljit Singh wrote:
> > An administrative controller does not support I/O queues, hence it
> > should exclude existing checks for IOCCSZ/IORCSZ.
> > 
> > -	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
> > +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcsz < 1) {
> 
> Excessive line length over 80 chars.
> 
> Perhaps, though, we should have a helper to indicate IO controllers
> rather than chaining conditions for everything that isn't one.
Sure, I'll add a new function nvme_is_io_controller() and make it dependent 
on nvmf_discovery_ctrl() and nvme_admin_ctrl(). How does that sound?

Thanks,
Kamaljit

