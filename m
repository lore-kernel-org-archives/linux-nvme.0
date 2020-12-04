Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AB2C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAAC22B2D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAAC22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sNbXVUDtLl8x+vJTEkvysuZn+cubCHnh7mi5qFaWb84=; b=KCny9AmnVzSZKQY0mDUsRgrxZ
	kF1A9rbUzPzP0kxQcpVjLPOxKV3rxQWv1cprs2DN3pQyFmAzi72JkJoaNk0WKzyLjcm6j6UmDaBxv
	1+9phA1O3RWZJfkpGLP6KzpAR9HFQixMQyILdeRRdfW5Aq2POaCnW3/M3kqj8DFOw6ci+onnmjkac
	2557kA+jqRXp/O9HQoOAkG/2pzDU+KtF162cRmWZKCvKVaxt/dVDt4y8fJnCetYTt8F+1iMagLdgp
	nE6QqhzJMB+gHn/ORJQD0NMIyUsQMzRlv9DFW3A1Ikzc5DEWfiBI6asM3KJVTYHYtoPi1fw9cbfMC
	+Bi2T4Rfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klCFr-0006eg-IQ; Fri, 04 Dec 2020 14:40:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klCFo-0006dc-1x
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 14:40:13 +0000
Date: Fri, 4 Dec 2020 23:40:03 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607092810;
 bh=uvtPoUqekE4ysrPkcwN2m2pvmLXmJsPsKTH0pCoQOwU=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=I7lh3BQP018ZryVSybF2HF+vDP9xIgie2+3oUbLevvAPt1bI5uCSFT3O857/mw6tH
 2dAaMkiSlJXFlsnh7E0zL6i1ElPKE7r97FFgtt6lG/FG7sgDmFmSvksH0gtqds8JXZ
 euyKyTB+IFz5FZVtcc5dVttsZdsYwdKPCl9uNPPLPWjGb6fLqdwH+pLhxMwvIbUEUU
 z1BaIEGceWAPgxjSoh8MfssdXWvYRWhotdB6/h+0AkWnbw/4Qhf4XxNZ+6czkvqrIK
 4tpPwkUiWg/9BcaCRZXxvJjLDifRCK+bJJWSL3x6AuAEW5DzAaRTdAjKcR6ixo9jAi
 klEnMtskQGb3w==
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_094012_224284_918A8D24 
X-CRM114-Status: GOOD (  21.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
> On 2020/12/04 20:02, SelvaKumar S wrote:
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > This is an RFC. Looking forward for any feedbacks or other alternate
> > designs for plumbing simple copy to IO stack.
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> > 
> > This implementation accepts destination, no of sources and arrays of
> > source ranges from application and attach it as payload to the bio and
> > submits to the device.
> > 
> > Following limits are added to queue limits and are exposed in sysfs
> > to userspace
> > 	- *max_copy_sectors* limits the sum of all source_range length
> > 	- *max_copy_nr_ranges* limits the number of source ranges
> > 	- *max_copy_range_sectors* limit the maximum number of sectors
> > 		that can constitute a single source range.
> 
> Same comment as before. I think this is a good start, but for this to be really
> useful to users and kernel components alike, this really needs copy emulation
> for drives that do not have a native copy feature, similarly to what write zeros
> handling for instance: if the drive does not have a copy command (simple copy
> for NVMe or XCOPY for scsi), then the block layer should issue read/write
> commands to seamlessly execute the copy. Otherwise, this will only serve a small
> niche for users and will not be optimal for FS and DM drivers that could be
> simplified with a generic block layer copy functionality.
> 
> This is my 10 cents though, others may differ about this.

Yes, I agree that copy emulation support should be included with the
hardware enabled solution.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
