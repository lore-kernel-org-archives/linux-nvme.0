Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9F1C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JV6zvHc7DgjYjuSRPUTOq/76cABMWlfRuPIwbT9BFxQ=; b=HtzaWTavgcAQ6vTXPAA0mTrhHp
	Hc4ZAocyCSlHwGfXEQ4ovK0iFY9A3IP12KNOsngWy5j10M5/VL4jgSmNCTKbDNtspfqsVcmx5O4ZM
	0NID+mzMft5+7J5db0Jo9ICg3OSrQNr+xj7sZbk9kvA/2L71eGCyT+3M+Jt696NclfgT1SRCvj8Jk
	xcAb2yflAXXZAJeVbu2a0tg10XbnQ1ifpCopZzbjy5OiJLpG7CwoJW7xg8T6YJX1CYkh85RovXRv8
	mov96ox/ZbSnwDwhezBhcrzIENdgj1Ch4foVHvDQQ9m3BZ3eAsJbsHTu7L8MGkrppk4y1mdq05gyE
	7XswkkZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r83MP-0067vG-2w;
	Tue, 28 Nov 2023 19:03:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r83MN-0067uX-15
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 19:03:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1308BB83B87;
	Tue, 28 Nov 2023 19:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF7C433C8;
	Tue, 28 Nov 2023 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701198181;
	bh=2SQ8nvZfspwKy1et1VHxsaVcIH7exyr+AqAnPoaC4q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIqofS+xJmG1Hdyo9mOGQ7WWhrSLt7JnhNRiAWWhDW2eqrXLV0YqBF8x+IAXTCBAY
	 7SrHq5chBNn6+yG3xBeuSrOzyGVYcEB2MOLhc+OJ6mszIcKIjAU3cD7YSGSZNHvExx
	 iYqofMI4dh+xkcF3HxISDhGdR35hcd14Lnhulw9kOXo0S9mSOVFlhtqbtXjSLHpy9K
	 aKYswY96frh8VpfXZaUrbK9KqE3eOtZffK5w2EIBqGQpwhV1YcGJFW44LTBc9wTKsF
	 cYf0Hnp6I6V7NSC/Lx3cziaEoI3BJc7dUG/e1U+YupqvYDFQzK8tpsFpJJWR96lSdv
	 FOFUi6jQo9ODg==
Date: Tue, 28 Nov 2023 12:02:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWY5YkYJ4Pf0meiD@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
 <20231128130508.GA8221@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130508.GA8221@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_110303_510200_5E777C15 
X-CRM114-Status: GOOD (  21.49  )
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

On Tue, Nov 28, 2023 at 02:05:08PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> > > 
> > > Yes.  But does it care about the tuple size, or the actual size of the
> > > metadata field even if is bigger than the PI tuple?
> > 
> > tuple_size is the same value as metadata size regardless of PI usage.
> > See nvme_init_integrity() for how this driver sets it:
> > 
> > 	integrity.tuple_size = ns->ms;
> 
> Yes, for the case where we actually support integrity in the kernel
> for a given device.  But if the device has a metadata size larger than
> the PI size we still support it, and just let the device strip/insert
> the PI.

I'm pretty sure that isn't right. We already support PI regardless of
the metadata size as long as the PI field is in the first 8 bytes.
Strip/insert doesn't even work if metadata is larger than a PI field.
For any metadata case where PI isn't used, the driver requests
allocating an empty buffer for the purpose.

> And if nvme-cli wants to report detailed information about
> the namespace it probably needs to report the actual metadata size
> as the tuple size won't be reported given that we're never initializing
> the kernel PI support.

I don't understand. For any namespace with a metadata size, even if the
namespace format doesn't have PI support, we still register an
"integrity" profile with no-ops to get that unused buffer just so the
block layer can access the format. We alyways set the tuple_size to the
namespace metadata-size so the kernel buffer is correctly sized.

This all works as long as the metadata is separate (not extended) and
kernel has CONFIG_BLK_DEV_INTEGRITY.

