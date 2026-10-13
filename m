Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B7CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KGntCJveSKgTB5Os53pE5ueO2Ap7EeMI1AvE0Iy3Ck=; b=xywuIXtUaOJaaRWZuTLK0PzA8Q
	KwBEL1QVX/F2Umj9g3sxupuQ1t5OFR2ySvOJobfdlwmXfx8UbXvVviXgq1v5aszdFd2Ckn4YJwsS3
	G4kO4jq0wxOIxWCfC5BMIl+sDMmkdVXB0bvrDF+joNMQgn7P/aAgSC7PzdIUK89hxpA3iYXywKa5e
	CZ+338oY2VB9HZarT0e+4jrH6OWogl1BTvmLeJ0wMW/HuFFUtSBcKVxVUW5fjUWQdE8BSxnoBwkQG
	rcT6+sJs8hWkl9yRNp5Mw7Ps6IzB7iqFrER89aPVDA/TFU6Z3vE3YLRgwjqVQkHjtj9Hr32/Bb7qA
	apPW5AcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeZR-0000000DNEI-0LDQ;
	Tue, 13 Oct 2026 15:37:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeZP-0000000DNDV-1KHE
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:37:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 021CC436AA;
	Tue, 13 Oct 2026 15:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D66B1F000FF;
	Tue, 13 Oct 2026 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905858;
	bh=6KGntCJveSKgTB5Os53pE5ueO2Ap7EeMI1AvE0Iy3Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HUW1CULqV0z82N6MB40nIhnlWwes1QqSsgOyJi7hx4z2T3w0JeeSi7TkYME2Zbv5A
	 kKA4C38aPuJS8/aGtVOvJNJOOsYU2pQBf2x02MepwVIXLGfua7tAo1o5FLJ3ESea1o
	 FdZrIx/7OAMEpU+lpGKcLT2o9UwN/m2jFNCsXmB7WgYDA436c4Ws8pjKjkTan8JQ6e
	 Oy7H6g3cLL8/vsJXxxjfbL6zQ/BcFqe1W613iADPuVDtXyqUDK7+xOEJLJGKTd2H6M
	 0ufphI0hmu7o7/eThMgC57kTRNNOIgfTBXX4Asaqr5T4LXjPFkh8SauNsW4zrpFV+M
	 vDytBgEdb5wAQ==
Date: Tue, 13 Oct 2026 09:37:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] nvmet: fix Reservation Acquire preempt sent by the
 holder
Message-ID: <as5QQbY2qa8Qq5N1@kbusch-mbp>
References: <CGME20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
 <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
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

On Fri, Oct 02, 2026 at 03:59:31PM +0900, Daejun Park wrote:
> nvmet_pr_preempt() does not follow NVMe Base Specification 2.1, section
> 8.1.22.7 when a Reservation Acquire command with the Preempt or Preempt
> and Abort action is sent by the reservation holder and the reservation
> is not of an All Registrants type.
> 
> Patch 1 fixes a use-after-free read in the path that handles a preempt
> sent by the holder.  It does not depend on patch 2 and comes first so
> that it can be backported alone.
> 
> Patch 2: a holder that preempts with the key of another registrant gets
> a successful completion, but that registrant stays registered and the
> reservation type is changed to RTYPE.  The pNFS SCSI layout server
> fences clients with this command (RFC 9561 section 2.2.3), so on an
> nvmet namespace nfsd logs a client as fenced while the client can still
> write to the device.  The patch lists what changes for a host that
> holds the reservation.

Thanks, applied to nvme-7.4.

