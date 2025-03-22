Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E408C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 23:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w8BcOo88xyWsRWuAYK8HCKlRNkXjn8rgywJ/9mOiHUk=; b=nbgWovWP1UygCW2HO2AZB3I5HL
	ytQS/hhpaOhgWETuMvUuVtZu6GcOFpVDmMnL/tt99Po6xsTL1ssZYVRyAz3FCDu1uO8deso7z1LIY
	cVFp5mZNUOw4Ab1Z+/qb7+B+xVjePiWXBqVMAO8ysnRw/KVc2rlRHZj6WsSXUWMM8n5b9niWjuT0n
	Ldp3kxkW1gOBwvPFRr9SG513UmGvL5vGdk4lUgOkJQZ63BXvjUL4GgTrClxc2sLNgyCFeqNB//3/G
	T3eJyUVuufreJwZp3SjKfnRUXc+6f4Cd3I14tdOCB2kR/ee5mwjmBZFfd2ncsjZr+QxG4Bh+amV8G
	GOwiF5rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H7-00000000RQu-2oLT;
	Sat, 22 Mar 2025 23:29:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw8H3-00000000RPP-3kQw
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 23:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8BcOo88xyWsRWuAYK8HCKlRNkXjn8rgywJ/9mOiHUk=;
	b=ZB00pHMS52y69dLgqZ77oCARD6rvodserlspQl9nwokI/h9DvreVTyXpXp2pckHpzY257F
	84TGaNB02DtOBexb6afe1NZtgmXP8DuLB7HxKx+pdB2hmdhvOL1AeBcZiOOFB9ZpxgeyQ9
	KpAuDMLmz3Ul+L9L+LL0Aw6zBbamGGA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-zDYPmRy9Nju3GFmKqHDPpQ-1; Sat,
 22 Mar 2025 19:29:01 -0400
X-MC-Unique: zDYPmRy9Nju3GFmKqHDPpQ-1
X-Mimecast-MFC-AGG-ID: zDYPmRy9Nju3GFmKqHDPpQ_1742686139
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D747319560AF;
	Sat, 22 Mar 2025 23:28:58 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62515180B488;
	Sat, 22 Mar 2025 23:28:56 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH v2 0/3] nvme: make core.nvme_multipath configurable   
Date: Sat, 22 Mar 2025 19:28:45 -0400
Message-ID: <20250322232848.225140-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_162906_004254_2C314D83 
X-CRM114-Status: GOOD (  13.27  )
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

These patches propose an alternative to the outright removal of the nvme
core multipath module parameter. Rather than deleting this module
parameter we control its appearance with a new Kconfig option named
NVME_MULTIPATH_PARAM

Note that the default kernel config settings produce a kernel
with no change in functionality. By default both NVME_MULTIPATH
and NVME_MULTIPATH_PARAM are enabled and there are no user visable
changes.

To remove the core.nvme_multipath parameter simply compile with
CONFIG_NVME_MULTIPATH_PARAM=n.

Note: the current behavior of nvme-v6.15

  CONFIG_NVME_MULTIPATH=y and nvme_core.multipath=N

  [  182.863531] nvme nvme4: Found shared namespace 1, but multipathing not supported.
  [  182.871030] nvme nvme4: Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.

Closes: https://lore.kernel.org/linux-nvme/20241121220321.40616-1-bgurney@redhat.com/
Closes: https://lore.kernel.org/linux-nvme/20250204211158.43126-1-bgurney@redhat.com/
Closes: https://lore.kernel.org/linux-nvme/20250228032541.369804-1-jmeneghi@redhat.com/ 

Changes Since v1

Rebased patches to nvme-v6.15

  nvme: add mulitipath warning to nvme_alloc_ns

Dropped this patch because the dmesg it produced was redundant and not
needed. Testing multiport devices with CONFIG_NVME_MULTIPATH disabled
show the following console message at boot.

[167523.157284] nvme nvme5: Found shared namespace 1, but multipathing not supported.
[167523.217083] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.

  nvme-multipath: add the NVME_MULTIPATH_PARAM config option

Fixed up the Kconfig description for NVME_MULTIPATH_PARAM.
Add default y and tested the follow Kconfig options.

Tested the following:

  make mod2noconfig
  make allyesconfig
  make allmodconfig
  make olddefconfig
  make oldconfig - accept all defaults

No change in current behavior.

  nvme: update the multipath warning in nvme_init_ns_head

Tests ran with CONFIG_NVME_MULTIPATH=y and CONFIG_NVME_MULTIPATH_PARM=n

No change in current behavior except:

  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  cat: /sys/module/nvme_core/parameters/multipath: No such file or directory
  
The following does nothing, just like it does when CONFIG_NVME_MULTIPATH=n

  [root@rhel-storage-108 ~]# grubby --update-kernel=ALL --args="nvme_core.multipath=N"
  [root@rhel-storage-108 ~]# reboot now
  .
  .
  .
  [root@rhel-storage-108 ~]# cat /proc/cmdline
  BOOT_IMAGE=(hd1,gpt2)/vmlinuz-6.14.0-rc2_config_ana4a+ ...  nvme_core.multipath=N
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  cat: /sys/module/nvme_core/parameters/multipath: No such file or directory

Tests ran with CONFIG_NVME_MULTIPATH=y and CONFIG_NVME_MULTIPATH_PARM=y

  There is no change in current behavior:

Tests ran with CONFIG_NVME_MULTIPATH=y, CONFIG_NVME_MULTIPATH_PARM=y
and nvme_core.multipath=N

  [  372.040105] nvme nvme4: Found shared namespace 1, but multipathing not supported.
  [  372.047606] nvme nvme4: Shared namespace support requires core_nvme.multipath=Y.
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			                   new message
  [  372.105469] nvme nvme5: creating 2 I/O queues.
  [  372.110383] nvme nvme5: mapped 2/0/0 default/read/poll queues.
  [  372.125480] nvme nvme5: new ctrl: NQN ....
  [  372.166081] nvme nvme5: Found shared namespace 1, but multipathing not supported.
  [  372.235964] nvme nvme6: creating 2 I/O queues.
  [  372.240926] nvme nvme6: mapped 2/0/0 default/read/poll queues.
  [  372.255964] nvme nvme6: new ctrl: NQN ....
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  N
  [root@rhel-storage-108 ~]# grubby --remove-args="nvme_core.multipath=N" --update-kernel=ALL
  [root@rhel-storage-108 ~]# grubby --info=ALL | grep nvme_core 
  [root@rhel-storage-108 ~]# reboot now
  .
  .
  .
  [root@rhel-storage-108 ~]# cat /sys/module/nvme_core/parameters/multipath
  Y



John Meneghini (3):
  nvme-multipath: change the NVME_MULTIPATH config option
  nvme-multipath: add the NVME_MULTIPATH_PARAM config option
  nvme: update the multipath warning in nvme_init_ns_head

 drivers/nvme/host/Kconfig     | 26 ++++++++++++++++++++++----
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  3 ++-
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.48.1


