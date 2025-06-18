Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11C4C7115B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 05:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nW2ZyY5TvKKPIx4Y8fh4DF/g4+g8boHzAHN66loiaog=; b=aFFYNVOzuytddXCdMPvP/2B/2l
	XTuOyDG8NyGSV9cTCgLFGse83uzXZvROnGWf+ML0crZ+NmAJKz6Qv+mLwx5luyDBd2jqoce+URLun
	+YR4KNMBuTLb2aG0owdOopioN3cxMEOUMqaOKMUJlBLRnDf2WvovemK9Jy/qZeG6vvvTy5+rz8UXQ
	HbFLyiDB/ZQEdPnMktXRt3TzkdfRY0lyNbRCBEVSpL9xAzPBMEaSxVKWZZiDpnbrGlUa+YKBE+S2e
	tcGjLGjLQ/opu1U5jN90yquMr0aUqBlhb9XFsOsY1Xk8n9yy6AR3T3hd0L41kk9QOFBkCvXf4dQ+m
	QjH0nSig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlPU-000000095rh-1cn0;
	Wed, 18 Jun 2025 05:32:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlPN-000000095rJ-3lse
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 05:32:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 091A468D0E; Wed, 18 Jun 2025 07:32:13 +0200 (CEST)
Date: Wed, 18 Jun 2025 07:32:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250618053213.GA28614@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com> <20250616053627.GF1148@lst.de> <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_223226_084679_BA9E071C 
X-CRM114-Status: GOOD (  13.08  )
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

On Tue, Jun 17, 2025 at 10:40:35AM -0700, alan.adamson@oracle.com wrote:
> I changed the config a bit:
>
> CTRL 0 - AWUN=31 AWUPF=15
> CTRL 1 - AWUN=31 AWUPF=31
> CTRL 2 - AWUN=15 AWUPF=7
> CTRL 3 - AWUN=15 AWUPF=15
>     NS - NAWUN=31 NAWUPF=15
>     NS - NAWUN=127 NAWUPF=63

I'm a bit confused what this config means.  The NS lines here are
multiple namespaces?

> [root@localhost ~]# sh testxx.sh nvme0n3

But this is all about the controller 0 above, which now has multiple
namespaces?

> + cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
> 8192
> [root@localhost ~]# dmesg | grep -i awupf
> [root@localhost ~]#
>
> AWUPF of 7 isn't consistent with an atomic_write_max_bytes of 8192.

It is consistent with an (N)AWUPF=15, and it is namespace number 3.  Are
you testing controller 3 above or is the namespace shared between
controller 0 and controller 3?

