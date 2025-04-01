Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159D6C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v8dvnzU26UOXIc5ecmhYh4ffDC3+I7cVZfniOLlIENA=; b=jxxYdbbv7+856UdZlevUfb6xlm
	R1LrOw6Oumyc1B55yPb5VFRcXyTHwAzrX0qJshqDoWCNq2N65cU+O69S6K58qvl7ecQ1o0maRiSTj
	vTt0+hzjcjFiRMz/XIx/FDQVLq6Yyu1UY69nMSJPCl8101WOwMq6J9O741KW4I5CiBFIv5da3F1Zq
	zRRJDdrQ9QUZQCY3zVdR9nbUJepFEWMTCLsz0Uzu1PANYEsiUvxYABgoSCp2Ns7cDjKGQkJ52qHFy
	A2O38gpnnDL2JaDSB/s0KHwgli+5Eo9Hra4KiCKU3KR+fetiEpYK+x3E6eTlkEZdk5TWRbYRpDHYY
	mNInx0PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzdxB-00000003muy-0YDf;
	Tue, 01 Apr 2025 15:55:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzdoJ-00000003kwr-2bia
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 15:45:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A87E5436AC;
	Tue,  1 Apr 2025 15:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D55C4CEE8;
	Tue,  1 Apr 2025 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743522354;
	bh=vc1XN8jBaqlXSRiGFM8X5RyY+ob7nK3JHer0BnIJXKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k00C1VnA0ajYfAVG9rgY9wRDQ1YhWBthb9iB75QVA3kPmFQOEzZKkfzvwAli4dzEf
	 KauflDNyG1JnQus1cMxyJdiEUahiE5BHqu0xqSupO+OIrFNgmBI8vvnD4VbMPyfI8o
	 Tpi9D53XPaop1PKs9AM/XtwoR+Kv+LwZw1mAa6nYdh5MyJVN40CYWGk/msXmmax1HR
	 TXQNQ5ithyXdvPmOb4VHx2IB6dHFO0FdcwEZrk3TlJ+Awe3j4PX4Ev1BVL75pC/C7W
	 AFdKIx2xMLHeF8iSOi8tpMDYuIuez7ACwp2xJsquadOSUABaayuctodUYcQGV8LHz1
	 T3WX4vHCmMKEg==
Date: Tue, 1 Apr 2025 09:45:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: nvme-cli connect regression
Message-ID: <Z-wKL4g32sABS_Ta@kbusch-mbp.dhcp.thefacebook.com>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_084555_683622_2592A53F 
X-CRM114-Status: GOOD (  15.42  )
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

On Tue, Apr 01, 2025 at 05:25:51PM +0200, Daniel Wagner wrote:
> Hi,
> 
> Luca reported that "occasional failures in the systemd integration test
> that uses nvme-cli:" [1]
> 
> [   10.378713] TEST-84-STORAGETM.sh[316]: + nvme connect-all -t tcp -a 127.0.0.1 -s 16858 --hostid=95fe8041-3f53-415b-bc40-1bbd8932e7e8
> [   10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
> [   10.397326] TEST-84-STORAGETM.sh[340]: failed to add controller, error failed to write to nvme-fabrics device
> 
> I was not able to identify any changes in nvme-cli v2.12 which could
> explain this problem. The kernel in question is a stable kernel (6.13.7)
> which got following commit back ported:
> 
> 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp
> PDU").
> 
> The change itself looks okay but I think introduces a behavior change
> for the initial connect attempt.

Does reverting the commit fix the regression? It looks like the only
kernel change in this area, but still would be nice to confirm.

