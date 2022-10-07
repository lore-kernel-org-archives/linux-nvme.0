Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EC0C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=feOHLXEtnqH40fnolc8rU20/TRyPn4BdRsurB4VCRjc=; b=pbCrBahO+gGHEVTAMtDkJCSNGO
	UERCpqyBAR2/dNYCOzICZp7380HbcrfxMvCMq+UTOsJye3gstD50hodDhB/IZ2wbmRZPRDxUzTgQB
	VPZzwkZV+/hmqpZI05sU/C0D7YvVB5/uoDYTLE4D67el7os0fHKzMotXHYmJ5vNrFpB/UUHu980eM
	+DzkGoRc9daVkW/ZidbedFc5ySKRgS+gcIu2ttjaYajKwrLAPp87Moj6Tgn+a50PCWB082YLpXBt4
	v+0Otj2dfsyYoycYilpFHJjwLmsftckLAVBPgVwM2EcgwmiTVG3BW6Mjt+4qZVe1sjrhoAAUNRIut
	gScE//lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogsyO-00ADUB-K7; Fri, 07 Oct 2022 19:25:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogsyL-00ADTp-2M
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 19:25:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7843D61747;
	Fri,  7 Oct 2022 19:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A76C433C1;
	Fri,  7 Oct 2022 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665170723;
	bh=AZ/9vIkQ5cgd08j9BgaUP8wr4ZY7Ig33P1JztLgjf9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOrhZjgKZ3TZp0xRA1N1wGiokaDZ2KcDCFF1Frve8xcSZOStO/Y1JtQUjIQe/beR/
	 JuNzNpGtyZ8d6c2weqLEnPrdWBsSQzN/ie6osG4Z70suws/MARMPZGBJgr/Em/qZe9
	 D71y91Fo/HNigqgnhDLFhgXr+vedxv1CjUwPudTuthV+NmRDuSy7/JI/8hCvS9WAPr
	 BsGVNgohj/UV8bRF1k0b0NC8mLdByt35ZqMcKqfg6WGIagIBIODCglRN9hGGh9c/Gh
	 x0YyScKolqRe9C07ntae5wTuPzHvnLSRkmYubZWLDfMPz5diyqGnN9s/kcfedFryX6
	 JKqNB3kDHcqOQ==
Date: Fri, 7 Oct 2022 13:25:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Leaking minor device numbers
Message-ID: <Y0B9IZpO94EvisoR@kbusch-mbp.dhcp.thefacebook.com>
References: <20221007123710.iu5m7f52owoiwzfv@carbon.lan>
 <Y0B639Zz4CvH7lQ9@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0B639Zz4CvH7lQ9@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_122526_261243_1312CF64 
X-CRM114-Status: GOOD (  13.91  )
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

On Fri, Oct 07, 2022 at 01:15:43PM -0600, Keith Busch wrote:
> 
> It sounds like the del_gendisk needs to take on this responsibility
> directly for HIDDEN disks. The below appears to work, but I'm not sure
> this is respecting the necessary dev_t lifetime if user space is holding
> a reference on the namespace.

The previous patch was indeed wrong with dev_t lifetimes. This is better:

---
diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..d46edf26320a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1166,6 +1166,8 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
+	if (disk->major == BLOCK_EXT_MAJOR)
+		blk_free_ext_minor(disk->first_minor);
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
--

