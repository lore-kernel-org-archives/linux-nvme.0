Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7FFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zUY/W+VWYkcxbbF7dgXntp4aJi/sivWacgOv1KLe3uY=; b=SqOSZUT6Ay3txmdb4Gdc4dQNV/
	s11tPDTizUSBE86vbALE7/5P0TChnDbdSTt+4kGj+GQxlkDMpEsG8WHObEXPafDDdZJKI1PiH/I2G
	gA6/E9j8EnqmQCQ68UBBz4kSX/UsZS55T3tbPK/nXkuSsH+ASl0pmqylsW5d8acwG5ixWYFXtfLcs
	5WiR1ChMj83u7vzHFrZLE8RMCrL1D6BJsIlqJgFRdmh7qe1nKEMy7H4JEV1kbAaWOIHbrapgdZped
	b87H6Qx9/gjfQZfacNB5zSkA+EQm6UIqhR153wjweZaCNPBnUGTXHRfuSpx9odjb40g9NVYUeFhHK
	BtIVYx1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX4fR-00EPmG-40; Wed, 23 Mar 2022 17:21:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nX4fP-00EPlb-HW; Wed, 23 Mar 2022 17:21:03 +0000
Date: Wed, 23 Mar 2022 10:21:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
Message-ID: <YjtW/3lQHsZJd4YR@infradead.org>
References: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
 <YjtKYETOnoI6/x4E@infradead.org>
 <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da128051-4d15-1566-2876-5167a0c1d033@suse.de>
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

On Wed, Mar 23, 2022 at 06:16:10PM +0100, Hannes Reinecke wrote:
> I have a patchset ready implementing virtual subsystems based on the NS UUID
> (and thereby putting each namespace into a separate subsystem).
> At this time it's just a PoC to demonstrate the concept; specification is
> not even proposed, and so it's hard to code against.

Virtual subsystems already work, with one or more namespaces per
subsystems. If you need to do any new code you are doing this completely
wrong.

Just looks at the Linux target code - we can create subsystems at will,
and a sensible configuration will have one per tenant (host or set of
closely cooperating hosts).  You can trivially add another controller or
set of controllers on another piece of hardware from the protocol point
of view.  You just need to have some way to synchronize the data access
just like you do for the dispersed namespace proposal.

