Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B484AD30CC2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 21:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMpLnXUgXLHVlQzL6pzCW2AMgML7k/j9DSqPtVQMQhY=; b=vR1YywiLD0Sp9oL0KaA5lX6y6y
	7ACSKMtUO/9U/IAVPT3FlpA4DLu4Kua3eIapV15ofqXCvblKW4AF6Yai/3nUU6xzsZB+1XchwiX4z
	K7sEUaR07jAp2GYR8GxdOe565ovPpCjOtrld9zdRZXtqjpH0MRs6k6rdQnxn/+ltGfOvlfV4JwWrL
	hlJ/VdZh3/8Xxqakp+f1PBfFwGiN3cYraLo/IP9taYTb8eSX2GM76WtfYSzqr2c4fo7h4LaiQz1uM
	4rzTu52H3BXJORDTrJ4APSS6dGlwFLo1tuAhyj8Zhst1+eHbyqDzHgRuwoMHHuOjPVzf2Q4R0UlXW
	VzDdyipw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfmKW-00000007mgz-0dat;
	Tue, 13 Jan 2026 21:53:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfmKU-00000007mgr-13Ni
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 21:53:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 598126000A;
	Tue, 13 Jan 2026 21:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE2C116C6;
	Tue, 13 Jan 2026 21:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341213;
	bh=TeNBoWA03tWQIf/AC0DJQTYfI87OLOfbNkTu2M3U6Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMaXqXSFq/w/rncowPebba4OXqxAy+EHpvXxAyp//FhZzDHf8yGwkFbwfJKd+yUUp
	 fq8tjFVvjjlJje408i6p1G2/1cjG2kNwzZzIqeu8soRGcWUbGmaU3ZyiRjBYirkdZh
	 nS5QQBpeG2bcTZSYkKco53iXuMKm6hrDjFDgQqXr/OnJKt3SJub2EzoxDsYNLcs/Cq
	 EJhrhv3sG4opDKkrvOEyu6Zdcq+0Vq1kgG3eulOdkG7R6W+DBrPKkaxnfqVqe9B672
	 R6SftQ+DbIJkjNesqfhP4PRQzfc1JIJNNM/zUczlBzeawvBg/mVALp0e1v7ZloRE86
	 0y5/FaVLX73AQ==
Date: Tue, 13 Jan 2026 14:53:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: mlombard@bsdbackstore.eu, bgurney@redhat.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
Message-ID: <aWa-209BvYmbYWJc@kbusch-mbp>
References: <20251103144406.1148401-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com>
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

On Mon, Nov 03, 2025 at 03:44:06PM +0100, Maurizio Lombardi wrote:
> Currently, there is no straightforward way for a user to inspect
> which quirks are active for a given device from userspace.
> 
> Add a new "quirks" sysfs attribute to the nvme controller device.
> 
> Reading this file will display a human-readable list
> of all active quirks, with each quirk name on a new line.
> If no quirks are active, it will display "none".

Thanks, applied to nvme-7.0.

