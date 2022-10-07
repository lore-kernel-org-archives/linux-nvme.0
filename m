Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C59C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ot0Aje25H1Hud9Bn6NL4BrUjOyybeDIEZpH/0Cgt5no=; b=OgdianHpnInUQ/P4KcfgBR6AW3
	uSawcQ8ZKI0NfJLZ65SGMkQN+p7UXzmvAfzN8MzWDwg53Gznm5qMpW0hC3MSCFVA7iTXne2llAYKh
	77RS0tlSGAUVJedDZIjgYDu+N602ZnflB1aXhRqH+GlO7y0WFcNixNgnyy+5l7++Xkbd5VMvaAc4r
	ZDME0/klSWDlGEqw6xIUMM1lVsDXcoK600sqzRjIchUpRa4+BcioeHJZNh0T2o43+8YvCunDqGH2y
	KMpUt7mkzk1+0Y9v3fjmklJ3coMIgUZgw46j5xTAloEPLtCczUY79f3+3SMW+QucXzWXXcafGJHxL
	dpaqjlDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogsp3-00ACGP-RC; Fri, 07 Oct 2022 19:15:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogsp1-00ACFw-Ol
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 19:15:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E3A0E61D4E;
	Fri,  7 Oct 2022 19:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C84C433D6;
	Fri,  7 Oct 2022 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665170146;
	bh=QYhepy+nqw6Nj50sKG5xE18A5kuq1oQq/wFNy7jrvaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rh/inY7r1JTrwzb07fR60oy/uTpX7TY99c4q8t3nSmvbBXCT9M0FLQ2nyJxAs9N2V
	 KtfQcd1vfHxXEuUvLaWRJMFxZBb9iRN559CL1FXBOxuRtxofVgK8BL346kPELl6d/y
	 iPJmhqiSgvlWg0v1PqXU1OFUO9NB9xWAxN5f+eYk5PFMMU1EIfwWjtW3GQ5FFmcS0o
	 XDoOlMwKzoV5VHt3dIYaGPFVSn75T95PbdLUyyH8hyfFNea/b2uDjoRYTb2fVIf0ir
	 vfLRG7SOjaIaKjU/XwyJsSUiRdp3LZH5PFqM7aRzEIyvXDK6pcI6gHmSjPj7feSiZR
	 RKlreivJx+dJQ==
Date: Fri, 7 Oct 2022 13:15:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Leaking minor device numbers
Message-ID: <Y0B639Zz4CvH7lQ9@kbusch-mbp.dhcp.thefacebook.com>
References: <20221007123710.iu5m7f52owoiwzfv@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007123710.iu5m7f52owoiwzfv@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_121547_900596_98C22955 
X-CRM114-Status: GOOD (  24.61  )
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

On Fri, Oct 07, 2022 at 02:37:10PM +0200, Daniel Wagner wrote:
> I've noticed the nvme subsystem is leaking minor device numbers:
> 
> # nvme connect-all
> 
> brw-rw---- 1 root disk 259,   3 Oct  6 18:58 /dev/nvme2n1
> brw-rw---- 1 root disk 259,   5 Oct  6 18:58 /dev/nvme2n2
> brw-rw---- 1 root disk 259,   7 Oct  6 18:58 /dev/nvme2n3
> brw-rw---- 1 root disk 259,   9 Oct  6 18:58 /dev/nvme2n4
> 
> # while true; do nvme connect-all; nvme disconnect-all; done
> 
> brw-rw---- 1 root disk 259, 7913 Oct  6 19:13 /dev/nvme2n1
> brw-rw---- 1 root disk 259, 7929 Oct  6 19:13 /dev/nvme2n2
> brw-rw---- 1 root disk 259, 7943 Oct  6 19:13 /dev/nvme2n3
> brw-rw---- 1 root disk 259, 7945 Oct  6 19:13 /dev/nvme2n4
> 
> After a bit printk debugging I found the source of the
> leak. nvme_alloc_ns() and nvme_alloc_ns_head() (nvme_mpath_set_live)
> will allocate for each disk via blk_alloc_ext_minor() a minor device
> number, though using two different interfaces.
> 
> nvme_mpath_set_live() will uses device_add_disk() which is also setting
> the major number to 259/BLOCK_EXT_MAJOR. This allocation will be freed.
> 
> Though the other allocation happens via blk_mq_alloc_disk() which
> doesn't set the major number to 259/BOCK_EXT_MAJOR and eventually when
> the disk is freed, we end up in bdev_free_inode() and do not call
> blk_free_ext_minor():
> 
> static void bdev_free_inode(struct inode *inode)
> {
> 	[...]
> 
> 	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
> 		blk_free_ext_minor(MINOR(bdev->bd_dev));
> 
> 	[...]
> }
> 
> I am a bit lost what is supposed to happen or how those things are
> connected together. Any ideas?

Thanks for the detailed report.

I see we are leaking the minors of the HIDDEN block devices as we never
set the dev_t for them in device_add_disk():

	if (!(disk->flags & GENHD_FL_HIDDEN))
		ddev->devt = MKDEV(disk->major, disk->first_minor);

We could remove that HIDDEN check in order to set it unconditionally,
but then the device nodes would appear under /dev/, which is what we
don't want to happen.

It sounds like the del_gendisk needs to take on this responsibility
directly for HIDDEN disks. The below appears to work, but I'm not sure
this is respecting the necessary dev_t lifetime if user space is holding
a reference on the namespace.

---
diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..b40b66ed30ec 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -611,6 +611,8 @@ void del_gendisk(struct gendisk *disk)
 		 * get reused and we'd get clashes in sysfs).
 		 */
 		bdi_unregister(disk->bdi);
+	} else if (disk->major == BLOCK_EXT_MAJOR) {
+		blk_free_ext_minor(disk->first_minor);
 	}

 	blk_unregister_queue(disk);
--

