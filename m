Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46988C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:41:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068A620714
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YTDovPH+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyYbJpf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068A620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y+qaVXNH3Aqbn49+9jcmEu6dWjq5v6V14aTx2BA2YvM=; b=YTDovPH+JwSb0p
	IO+rb/dLD1r7bcRZGurXMoVxs9/AbCR7k/JOVR1UeQGKDLYhi/DI6jleBMQ85xbblAjciV+08v2FA
	WWK/KrgvBiAkNI1Mst1H63IxLzVSczg8fx59LDAgkxE7bXux4SHYoSo8yZj7zyjowxN3zxnOS8KXM
	MDKIRHYe5VtCaUyJQIOX+PHfxtLbOL1eZ01QDqOFo5L7XPPHdkNcRBe9jb2Sn+/baRtJXy1yOmvyv
	jmqc6rJOlaekIoGPvgvRfxybK7Y4dmX4NcHZPb5oZqkwZYL3gSgKd8QmfgeIGjzYxjrW5R2Z8sPlv
	DLQBD7BTFrjZhi4gWGBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJjEq-0000xT-Hp; Wed, 01 Apr 2020 19:41:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJjEn-0000wy-VG
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 19:41:23 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BF9620714;
 Wed,  1 Apr 2020 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585770081;
 bh=CvAGjUOnQUvbdCFe7tNgyMqy9ugmppsFAfXoQhzmBoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AyYbJpf+nuGe9CICXSUY9hfxYOHsnnB42OllsWcotaBJQb9NhFWOC/YkseWfOKBmh
 6rkjU9+2RhoRiYipwithFYXRX4VWPxrzh6DDuP/89GTSar7iWxJVPAThoi+BApPo9i
 b8KWWbO6SChitTdD2HfyZe1yD5Pym3x495FxbNwo=
Date: Wed, 1 Apr 2020 12:41:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-print: list also hostnqn and hostid for verbose
Message-ID: <20200401194119.GC1144965@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200324085328.23387-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200324085328.23387-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_124122_036416_9A8EF98B 
X-CRM114-Status: UNSURE (   7.02  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks for the patches, applied both to nvme-cli

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
