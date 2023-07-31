Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206A1C00528
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3TorukNnHMeG5Dl454WzehxY6SuXeHm2IsGSo18GQSw=; b=i9LUmevoLUwRYREwD65MuFtwS4
	XhSckVimQIiDcfrpnGcUQRDv0OinDKZc1zkT5f9ISSu0pWN/nljRd42oOvYQU6IjQqSpzVeYt62Jr
	9x1F51DEz3Cw9HQMyBi0i5p9YlYK9NkBsbCGr0WMa8aayblV/0z6HNBxxixiJUg+6StInmySVPv9Y
	1e+vW+qyLXLAt7la+RI3n4593UIxi5pqvy5xR7sYFm/zx6qF9Qz2/OJnbfkY8lifq/ZJ4s5uWf0RG
	M84hfr1SjJbskcSBlPG4iVDD2MmJczGU32vfh3m/rQbsCBvgx8ZZiKhWsMRoT3nexe1mENE5YdN8t
	w2knGtdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYHa-00H4a5-1x;
	Mon, 31 Jul 2023 19:10:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYHX-00H4ZS-0b
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 19:10:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1566126C;
	Mon, 31 Jul 2023 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53347C433C8;
	Mon, 31 Jul 2023 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690830613;
	bh=7BUP17YZLUCEJIi4rAJBHLTCh+olUP+m+qo5gNNUQQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3rVcA8G0AtmamNt3KZciRNmpZAw/gId0t1RzJbGLJkPD4PbMzKu7fAVivLCU6t8R
	 zRm5RhEinrX2CWq1QAzTEqID4FOPvovwH7Ghb5VPjCAjRBqO81Hk2tzpyPsXxpmHvb
	 Ndss40rzb6kGEP141ddFKfhhxe6l7uwCeA9upxQ7dYDckl4wQRjh5uf1xdv8uZMgHn
	 +0kbgT8Nu6B/SiL1ZmKDOmteoJw4QxDaOSCWuZh1h2yDIwY5G1WgdNVaQ3EeUrtEHH
	 7endB90IpUb3NyJ6jDaNVYzjhM7f/ZIWTaLQZS7OeVeGhz1M4Gd9SQUzwbUKtPMeqg
	 adlYGJ0AG5fFw==
Date: Mon, 31 Jul 2023 13:10:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilskruse97@gmail.com, git@augustwikerfors.se, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
References: <20230731185103.18436-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731185103.18436-1-mario.limonciello@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_121015_272400_9850890D 
X-CRM114-Status: GOOD (  16.32  )
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

On Mon, Jul 31, 2023 at 01:51:03PM -0500, Mario Limonciello wrote:
> Samsung PM9B1 has problems after resume because NSID has changed.
> This has been reported in the past on OEM varities of PM9B1 parts
> and fixed by firmware updates on 'some' of those parts.
> 
> However this same issue also happens on 'retail' PM9B1 parts which
> Samsung has not released firmware updates for.
> 
> As the check has been relaxed at startup for multiple disks with
> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> probe due to duplicate IDs for single-ported PCIe devices") also
> relax the check that runs on resume for NSIDs and mark them bogus
> if this occurs on resume.

How could the driver tell the difference between the device needing a
quirk compared to a rapid delete-create-attach namespace sequence?
Proceeding with the namespace now may get dirty writes intended for the
previous namespace, corrupting the new one.

The commit you mentioned tries to constrain allowing duplication where
we can reasonably assume the quirk is needed. If we need to do similiar
for this condition, one possible constraint might be that the device
doesn't report OACS bit 3 (Namespace Management).

