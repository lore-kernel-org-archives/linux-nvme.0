Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3759C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fsqgEMkVKj5+x3wNqlwld8MUDlYrZOo/G5PEMTGrjg=; b=lPLDKExhqTmFD6zJNcMaIzEWYU
	gt0DAQvhS77jSUpz7TE9Kq0un8DW1B4F7fP+brjpfVDIhuEnYGaPUvsZrEDZy8LTbsicRCrp9MPKd
	L23ah5YWpLNL8ZI28qvJiFJXvjsyF+76rSo/A2a1fSF/QSn6cJtaj2p//CJoFbuZoarbalui3AYfg
	2bu001dqDUNldligT1hZqx7XF2Nml6RaTGJ1BLQ3BKd4DHENiHY+Q2abcpIOzLB0QtptGSNoQ63W5
	b3DBWD/usUsMAExltHKZz8XrZQljtBCT6GSqb1WOWkEUyQsA0SM5q0orVgnr01OnQ79o3RzsgLF70
	qeaG3ebw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcDc-00000004jck-0gES;
	Tue, 15 Jul 2025 09:45:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubba2-00000004cFy-0qGT
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 09:04:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F22368AFE; Tue, 15 Jul 2025 11:03:58 +0200 (CEST)
Date: Tue, 15 Jul 2025 11:03:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715090357.GA21818@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_020406_387948_216EE6BD 
X-CRM114-Status: GOOD (  14.76  )
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

On Tue, Jul 15, 2025 at 09:42:33AM +0100, John Garry wrote:
>> I'm not sure a XFLAG is all that useful.  It's not really a per-file
>> persistent thing.  It's more of a mount option, or better persistent
>> mount-option attr like we did for autofsck.
>
> For all these options, the admin must know that the atomic behaviour of 
> their disk is as advertised - I am not sure how realistic it is.

Well, who else would know it, or rather who else can do the risk
calculation?

I'm not worried about Oracle cloud running data bases on drives written
to their purchase spec and validated by them.

I'm worried about $RANDOMUSER running $APPLICATION here that thing
atomic write APIs are nice (they finally are) and while that works
fine with the software implemenetation and even reasonably high end
consumer devices, they now get the $CHEAPO SSD off Alibab and while
things work fine their entire browinshistory / ledger / movie data
base or whatever is toast and the file system gets blamed.


