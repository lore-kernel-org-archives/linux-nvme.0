Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279BC388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 19:19:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582F2206B6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CZ7XmxID";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEWN4QHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582F2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qqxzu61pdAOsMjUYa7E2qKpGtaS9UhDvVmr3juYLc1A=; b=CZ7XmxIDrDLUHsv3IBXbwe3Gw
	9zRTv4sJ7b/JLG9Sem3Qcnkp4sASkXOep8aViLw0AADw8SZ1NNBEJmudpf4CuW1C2SUW7Qgs+VhnH
	/8omt1rXuB0z4sN17lOzSvg7ipjbNAwAmCQ8CdaiE3SNXkV+IgBD5mKKxFdmn3sxLBdaxz66PEcBi
	4TvH7rNkuef/DW7V0N3jFF1ls4siD37ga1Bre4QA4XrPDGuxQ731iJNxeO0tPlXauZjAqf9gQn1I8
	nQfxi1iC8e4fJe7QJ/I52X0fRllNnoqcd/xMXmRtU3hFOgnMN9DNWzjQbXxu4eyJCmbRRAdw3wvO9
	F13auXvXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcveS-000679-6p; Wed, 11 Nov 2020 19:19:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcveP-000666-JH
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 19:19:26 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1544C206B6;
 Wed, 11 Nov 2020 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605122363;
 bh=gFPQwslG1rILTc9UqMk7UbcmIKPcnEqZ9d1qKSA/hvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GEWN4QHz+PeEXeqM5ToTXtiTv4l/SPBeUkRKT47e+adtXY8dA3Y+YvmXtsCa5j12w
 decKtbniaVQUvplzW9d4gQ7Rf1tG7ew4jTupb34OWmiFdE8VfNYClZ+ruSfPBiIbLO
 KXRr44Amn+v6aggKOh6M7Gqq0k6NLOgsZ5hkd7tk=
Date: Wed, 11 Nov 2020 11:19:20 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201108040903.8185-1-bvanassche@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_141925_746388_D6801388 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Greg KH <gregkh@linuxfoundation.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
> The following two issues have been introduced by commit 1811977568e0
> ("nvme/pci: Use async_schedule for initial reset work"):
> - The boot process waits until all NVMe controllers have been probed
>   instead of only waiting until the boot controller has been probed.
>   This slows down the boot process.
> - Some of the controller probing work happens asynchronously without
>   the device core being aware of this.
> 
> Hence this patch that makes all probing work happen from nvme_probe()
> and that tells the device core to probe multiple NVMe controllers
> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.

I am finding that this setting probes devices in parallel on boot up,
but serially for devices added after boot. That's making this a rather
unappealing patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
