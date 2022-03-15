Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA1CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6G4Lb1SK1GZajHQWiLsHbjqmgwMrs4kWC7RlM8q5qiI=; b=WG6GvBSvKCJQe0xruvkANXRhp5
	MbD5wDTM28yMsdnHnifzK76r90nxwERwp223OCztCJOSPUmf5jxGfsiHDtVNzrLH8QW6vV1G0aiZ8
	XMF993QblVIGbTh3bVxL69A0+ZAIwzHYuGaCIsuX80ppC8wcivFQnQ6Z45hhW7tWZkVwokiKdVr7z
	6BHiqCrXn1HI58munvEF8btFr3226wImOJ51J+VYtpi43DL35AcmJKNOLmR3eHcGrveIB9UMWuXY5
	8+5K5iE2MLew8N54+BjbTUhwJM3zI94yqqKyB1zi/ZlMRBbvNAjbnKcmfx7hHHUmLkcvnmVGRNcK1
	CHT24Aqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU457-008gkB-2A; Tue, 15 Mar 2022 10:07:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU454-008gjF-0b
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:07:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8E45668AA6; Tue, 15 Mar 2022 11:07:01 +0100 (CET)
Date: Tue, 15 Mar 2022 11:07:01 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sungup Moon <sungup.moon@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (2) [PATCH v2] driver/nvme/host: Support duplicated nsid for
 the private ns
Message-ID: <20220315100701.GA5639@lst.de>
References: <20220315071230.GA2069@lst.de>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p3>
 <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315095612epcms2p304482f5160ae91a120d719c88dbe368d@epcms2p3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_030706_236609_108AB722 
X-CRM114-Status: GOOD (  19.22  )
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

On Tue, Mar 15, 2022 at 06:56:12PM +0900, Sungup Moon wrote:
> I'll answer your opinion.
> 
> 1. ns_head leak issue
> 
> I don't think that is leaked ns_head. Because although all ids and nsid are same
> through all namespaces, each namespaces are indenpendent namespace and each of that
> should have independent data structure.
> Duplicated nsid private namespace is different from the shared namespace even though
> same information.

In your patch if nvme_find_ns_head returns a head for a private namespace
with a non-uniqueue ID, that returned head already has an additional
reference, which we'll never drop as the head variable is overriden just
below.

> 2. nvme_mpath_set_disk_name issue
> 
> Yes, I also agree that subsystem-wide IDA is very important data. However, I
> implemented without nvme_mpath_set_disk_name modification at the first time, it is
> hard to decide which namespace are connected to private controller.

It is not just very important, it can't work without that.  The two
separate IDAs can will have conflicts, so you can up with two namespaces
with the same name without that change.

> As you know, each nvme controller start initiating at a time. So, each controller
> structures are sequentially initiated, but each namespaces structures are initiated
> independently because of multi-processing on cpu. So, all namespace can have different
> instance number every boot-up time, and it makes hard to track and control the private
> namespace on the controller or device failure.

Yes, but that is true of all Linux device enumeration.  That is why
everyone should use table identifiers like the UUID or GUID to identify
the namespaces.

> Anyway, the private namespace is same condition with no-multipath situation (because
> private namespace cannot shared between controllers) so I think that the private
> namespace should follow the naming rule with no-multipath situation.

We can't use the non-multipath cabale naming as it will cause conflicts
in the naming.  If anything in the system supports multipathing we have
to use subsystem based instances for the naming.

