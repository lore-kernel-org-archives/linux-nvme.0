Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E091C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJhAkTfREiFzNuYrKWh2MMsWD602rKyOpoU19n+u96o=; b=hqxzFxHcumDXo2esIvSgA/CYXe
	IAzmz7PTxvVNKV4L3H4Zk2ngRfxSFUKUADjyOv4wPsvzw8lGKg6yxePGVIRaJUmjIudaHdJ/ACF3q
	L1HLd+AR0bUdzSChhL3OBdSrXaW6TOoovOWJ20C/RsR8kaklX6ouzp7N5ScqYawQgpRPCQinnq8vr
	C13f/cnNeWNuUwOg+vIThXGRCMPU6xF9oKxqMe3EsWDVTneaJ/qmwkuNfmId2ZXAba4Ukv78sGBb9
	MWGaI3nMKy6Sb2ZOKCSZvGU58MFSyrks8KG1xK8eP0WTWCXhUlWU4PAmY1mY9PVWnXdIJEp9OsRUD
	TSxTzzzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh3c0-007VSZ-PS; Wed, 20 Apr 2022 06:14:48 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh3bx-007VRF-35
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 06:14:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B7DE9B81D1D;
 Wed, 20 Apr 2022 06:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA24C385A0;
 Wed, 20 Apr 2022 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650435281;
 bh=AzW2KIqt1TOZ3fJCJ2Qqg0c7UdQiexQ4mM1Brh5WZcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MM518wF3K2I2N8/3dzm2b92zKZ/1gWeSPX21dePC//u82/sP5v74676cvktRn+MiV
 SSH5GtpRrRpuy4aSkBdw+JVzysGOhiG178kTI2ZbnRJWFBlylI7tl+zJGN+RoEX+N8
 Jum+KwTHyja8CnguAQKWlBhR8MdJtCJKjalICUIw=
Date: Wed, 20 Apr 2022 08:14:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <Yl+kzdPG2EvAGCFG@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_231445_333199_3A2D9AEA 
X-CRM114-Status: GOOD (  10.95  )
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

On Tue, Apr 19, 2022 at 03:35:47PM -0700, Tanjore Suresh wrote:
> Hey,
> 
> I did not hear any comments on this v2 version. Please help me with your
> comments and approval so that this can be prepared for checkin.

Wait, there was comments, that you seem to have ignored.  Why?


