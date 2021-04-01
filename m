Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A5FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:29:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57D261286
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 16:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D261286
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c5BVmqWucnER7UBpldsrWzn8Ba32h5CBiCPkgTN/1yw=; b=pQIU8KVvPlEZ8pvlUNm4faCYf
	47xywRX9AyPEohykXeHzp2AiLBRIdj3QjcDFmUE0AYEZoaGkapMLlGe5XpMFImM9Th8Q5zLedjTeQ
	Phb5oX2wKLYB50yV6AYB5SqO9wiHx0M4BjgS8PjpWO2kOwBrc4n9fns++8M3FAHLvYgPPtXlpZY72
	jYPXeREQCNdE+FO0zkJ5GU6WvRElmjBGD1r83/uzNYQLL1I+7hSoo1B/eCQwZ/teuSG0H4rLYEpsj
	1bDeCJFv2p/tli0avW2PlaLlsi9e9bm0w1ESPtDe8I44nS6zBoS4xMMvUKIIX8khK4fAas76DOed4
	DAhG44mNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS0CG-00AJ4t-QZ; Thu, 01 Apr 2021 16:29:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzwa-00ACAu-W6
 for linux-nvme@desiato.infradead.org; Thu, 01 Apr 2021 16:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=j6TyCBBG2iZ8HfXK41prqhP+GPxiOUGxROd8op02iAI=; b=EKX9OtenHryk1QVcg8muZDkJTW
 HdvO+yPKMhPDgkVbKrnxzjonrf8gZEHi4/eTJFpmTuCP4d7+x7OZVOy2vfV15ywn2B7AE7w8awVXA
 +z+8Nr9oZ5msLCOZFJCA7ydGBbsXC/G3id3wlBHAamyQSgrlhRYnoJ31blUng1TDnzm0pmliBwATv
 awrLKthzpueU9+mZeZGl9MENcCV4X8BR1CjGRmqbPA7slYExsi+W2C4x3g6C33sYyEw7a6JEnu/Tr
 F9CrZHxMm9OBqzOy63SdnlvoWCXL2wEgLZGS6Vr5Mx8L8ML5ssvtD/XDQL70jbV3MIMX7eoEcYB0S
 /BaK4uSA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lRzw8-006Kxy-Gf; Thu, 01 Apr 2021 16:12:54 +0000
Date: Thu, 1 Apr 2021 17:12:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Recursive locking complaint with nvme-5.13 branch
Message-ID: <20210401161248.GA1510273@infradead.org>
References: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
 <20210401153722.GA1501960@infradead.org>
 <2d76014e-1e78-0ea9-e661-e441334f7897@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d76014e-1e78-0ea9-e661-e441334f7897@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 01, 2021 at 09:09:53AM -0700, Bart Van Assche wrote:
> This call trace was reported during boot. The configuration of the VM that
> reported this call trace is as follows:
> - Boot from a virtio disk.
> - One SATA CD-ROM.
> - One SATA disk.
> - One IDE disk.
> - One SCSI disk.
> - No NVMe controller since virt-manager does not support NVMe controllers as
> far as I know.
> 
> I reported this call trace to the linux-nvme mailing list instead of
> linux-block since I haven't seen this call trace yet with Jens' for-next
> branch.
> 
> Please let me know if you need more information.

We've seen a similar trace a while ago, and back then decided not to
fix it given that it is harmless and pktcdvd was considered to be on the
way out.  But it seems like systemd now tries to set up pktcdvd?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
