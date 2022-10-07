Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67224C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uQ9JE1lC0wstbqqSWXdxLOp1541Taoolquv7Jsjf3LU=; b=TRcqgh4fRN37i1tbaiyUSe37/8
	nDYo23V6g+xnO8W0t0xYRW+BK8busHZxCTu83ybUfce/5rn8vHw5Su4Jn5RqeZk6KOHWqUFGdGAoq
	2c+9B3adZH4tdsLUunfuj83Y/FmAr1VTYzry/2f4+grRE8A2GueUInkx4h9SWhevug+9IfkzW2taP
	qb42xbZPMXsOGSuLigD+8+akFaEdEnc427jerxCZsYcQhshFqJNGmx7G09iAmV83jwbFiRi9YEAE7
	BTROEVP5jH+8Y4PTncbo3cyoegVhZT4vvKskE28Ept5BVT/zMCgtZ01TcRN2WCnDvEGLvLoIGaHSJ
	Amx5XKjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogmbN-008rbG-Sg; Fri, 07 Oct 2022 12:37:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogmbL-008ra8-8H
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 12:37:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76AE51F88D
	for <linux-nvme@lists.infradead.org>; Fri,  7 Oct 2022 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665146231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uQ9JE1lC0wstbqqSWXdxLOp1541Taoolquv7Jsjf3LU=;
	b=HrwZyZ48EMtHBokHcehgaBIloaHTXe7Lq6XYDpX5Qd4mhdvAjU6+NbQ91OLRziFLSRqtt/
	nOMsBoDLrETxmOm+TfXfeJgF/n3UjCMjfj8dYfyI/ld8WhImMxWIaqOmSaUVox3Pxv0L3e
	EOHHmkyRIl4xm7QMFwhdHm3YQumpdmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665146231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=uQ9JE1lC0wstbqqSWXdxLOp1541Taoolquv7Jsjf3LU=;
	b=GV6I6CQgzfceloFdOgH6ppPI2Wsynh3xTiMb0hJLVaVgpcluibZuVVBdaCCX8Iajn4hUr7
	yPIxx1zDAxigOeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62AD713A9A
	for <linux-nvme@lists.infradead.org>; Fri,  7 Oct 2022 12:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mBv5F3cdQGNgYgAAMHmgww
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 12:37:11 +0000
Date: Fri, 7 Oct 2022 14:37:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: Leaking minor device numbers
Message-ID: <20221007123710.iu5m7f52owoiwzfv@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_053715_455926_78B017AE 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
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

I've noticed the nvme subsystem is leaking minor device numbers:

# nvme connect-all

brw-rw---- 1 root disk 259,   3 Oct  6 18:58 /dev/nvme2n1
brw-rw---- 1 root disk 259,   5 Oct  6 18:58 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct  6 18:58 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct  6 18:58 /dev/nvme2n4

# while true; do nvme connect-all; nvme disconnect-all; done

brw-rw---- 1 root disk 259, 7913 Oct  6 19:13 /dev/nvme2n1
brw-rw---- 1 root disk 259, 7929 Oct  6 19:13 /dev/nvme2n2
brw-rw---- 1 root disk 259, 7943 Oct  6 19:13 /dev/nvme2n3
brw-rw---- 1 root disk 259, 7945 Oct  6 19:13 /dev/nvme2n4

After a bit printk debugging I found the source of the
leak. nvme_alloc_ns() and nvme_alloc_ns_head() (nvme_mpath_set_live)
will allocate for each disk via blk_alloc_ext_minor() a minor device
number, though using two different interfaces.

nvme_mpath_set_live() will uses device_add_disk() which is also setting
the major number to 259/BLOCK_EXT_MAJOR. This allocation will be freed.

Though the other allocation happens via blk_mq_alloc_disk() which
doesn't set the major number to 259/BOCK_EXT_MAJOR and eventually when
the disk is freed, we end up in bdev_free_inode() and do not call
blk_free_ext_minor():

static void bdev_free_inode(struct inode *inode)
{
	[...]

	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
		blk_free_ext_minor(MINOR(bdev->bd_dev));

	[...]
}

I am a bit lost what is supposed to happen or how those things are
connected together. Any ideas?

