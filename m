Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC18C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF05320809
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DwHHw5dX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eky31ZE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF05320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N2XQw3Ju17n/yEutQwcyHnmyv5EfVQ/KY3gtkWavSNg=; b=DwHHw5dXOkCzHWDetouuQSM7R
	msvrjob/na96O4/SZIZ41y7WM0n+6irXspB5uwHf3MPGE7VGYFIaulF3jMLDXrEnvIacnL2g1TAek
	aiJdl6HEFPddthtKxkmfSpZk6gd3d5yVERut69SN4+zW/M0982BvxfmdAA7Dxz3cJ9JP9oCQILhdR
	bCePt5/+Cc5BjTrv57b+gS3KotBSDwatQYbA3XcIm7H7xcw9uYOGzgU9OzGUWgiKpBYNiifPXB2P8
	xyTSf4NL3hqZC4bPzQQDBhy/iu+3rwAvIG/0H9H/5NE0QfvdZkBo4wtl8P9eGymrIvx8ujrSeWjeu
	R3hx/0RyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0s51-00005W-Bg; Wed, 29 Jul 2020 19:49:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0s4y-0008W4-HE
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 19:49:33 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10F9420809;
 Wed, 29 Jul 2020 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596052171;
 bh=QNiv9n7PuSdxKRrJ6qT8RBFA2b9ZvLFMIst1Fg0eciU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eky31ZE76gTUM2zR/ESSrpF2nD3tgUZJliHVJu1smF8kR6j5Capm3eHz3741QcX++
 dF3b3MfvmfVDVh5Ii0LK1KcfjFNa94ESjWOdJ4DrLwS9O/tGsxa5IuHJEVUXNVm6aD
 857fCb7f1J1wc/8q7ClbScXY20N9+au/q0l7QD2U=
Date: Wed, 29 Jul 2020 12:49:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lach <iam@lach.pw>
Subject: Re: Regression in nvme driver
Message-ID: <20200729194929.GA3499289@dhcp-10-100-145-180.wdl.wdc.com>
References: <8aeb9192-df1b-979d-514d-025366f658e2@lach.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8aeb9192-df1b-979d-514d-025366f658e2@lach.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_154932_648994_60CF2A98 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 29, 2020 at 07:29:08PM +0000, Lach wrote:
> Hello
> 
> I caught a regression in the nvme driver, which shows itself on some
> controllers (In my case, at 126h:2263)

Fix is staged for the next 5.8 pull;

  https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.8&id=5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
