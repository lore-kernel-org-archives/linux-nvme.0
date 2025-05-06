Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A23EC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bOPiUlyrhnx8kdBc4QcgN2Kg8jvl0sf6Xkm8mhk+a6s=; b=PIXarfth6cLy7zOQTyRVpQejfR
	UoReINLgGdPi0YtJriGbRrP06iBdoLcCtSbvprdscsDyXfxqQlbkSI+1/SeSoKAhDzt0obl94PR+E
	mTj3D2E/idKkYsOn2FvA61qVjUZT0zBBe09UGg5NlouDvbw/dpdm03dNqLjUvBWzXSEv2uOcs7edL
	CCgshx+/Y5n+yDsCbNy9QJjygjGaHX4SXsS1GghrOP32jkJyPC3RvSo9hYOg/9uHog8LaIzOnO8TY
	6V+ZDhhUVRE/EsJV8ZJRpv4eeUablb3W42mWRNHWibpwpyP3/a98xX1gaXGdcGWK6jOjLCowlsvb3
	KhYKbUQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKlG-0000000Cbiq-3NUV;
	Tue, 06 May 2025 16:03:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHWC-0000000BwJu-1g9F;
	Tue, 06 May 2025 12:35:28 +0000
Date: Tue, 6 May 2025 05:35:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBoCELZ_x-C4talt@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
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

Hi Chuck,

let me use this as a vehicle to rant^H^H^H^Hprovide constructive
feedback about configuration of the tls upcalls now that I finally
got around playing with both NVMe and TCP over TLS.

For modular systems configuations the amount of monolithic state
in tlshd.conf is a bit unfortunate.

For NVMe it isn't all that bad, but having to hardcode the .nvme
keyring still means that:

 - we need userspace configuration past just enabling tlshd to enable
   any kernel subsystem using TLS upcalls.
 - hard code the keyring used in the userspace configuration

Can't we ensure the upcall passes the keyring to use and avoid
this issue entirely?

For NFS hardcoding the keys and certs in tlshd.conf is even more anoying,
because it limits to a single client key and cert for the entire system.

I have a hacky little patch for the NFS client to pass keyids for the
client key and the certificate as mount options, which seems to work
nicely, but it still requires adding another keyring (see above) or
giving the user read permissions for the keys while it would prefer
that it would just work and we would not need to give any root login
session a way to read the keys.


