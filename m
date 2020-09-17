Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E743CC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:52:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4880E206B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LW2Ahqup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4880E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=45DGn22oqlBfeIahUPLTRMdu5dB6XYMNwPND5uM4F7o=; b=LW2Ahqupyp1VmpstyQwNSasY4
	QknwKMZYj6gGel0CkTzgAPX5t+U6KjCGtkayF92m4lIHw1MI7Bhz53Ldy0dSCEPJOjX0SQqID1ZE2
	tiUU1EOhYTuHMZHC43Gjz+GrjktPxiSi3ibrryNA9wr/VJDCz/L44n8FKH2h9Yt4yClUjj2FmQIKt
	j4KKtKeqcVTaH2DWYNy94f0DhsicSAnzQjA19jw9i75eGW50GHjN6S3/XFXx7A7zMUMOM9QxAdAKb
	JPVAgxESgj58pREgbgc0e/xyAt2SbvVLpvvc4HHJHU+n/h6kk3J/5ZKOsrLNgS/sRjf0c7Gc7C0Wy
	0YlBJLgFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIwDD-00072c-5s; Thu, 17 Sep 2020 15:52:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIwDA-00072G-VS
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 15:52:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1FEFB6736F; Thu, 17 Sep 2020 17:52:38 +0200 (CEST)
Date: Thu, 17 Sep 2020 17:52:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: return errors for hwmon init
Message-ID: <20200917155237.GA2441@lst.de>
References: <20200917155025.3795801-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917155025.3795801-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_115241_132042_EBD57BBD 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: Tong Zhang <ztong0001@gmail.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 17, 2020 at 08:50:25AM -0700, Keith Busch wrote:
> Initializing the nvme hwmon retrieves a log from the controller. If the
> controller is broken, we need to return the appropriate error so that
> subsequent initialization doesn't attempt to continue.
> 
> Reported-by: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.  I'm about to send a PR to Jens later today,
but I plan to pick this up for 5.9 after that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
