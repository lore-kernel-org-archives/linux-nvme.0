Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D169C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 14:28:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF44261406
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 14:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF44261406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j9h4Bw/If4ZuNT+GOg/Fzw0fm2KV8+gOyLinAXVS1EU=; b=FZhzxd4RKJZIEmuysj1jZKEtQ2
	PHPPRkQUdn3U+XIpZz83mZpau9ab847E5xC8nZOCTouTpcLTgzprtXPqG7Vv48lyQQN8JkaUGRI/X
	rzbRSyMa2KOegaAg+s70/aYg7Rg9DYFjIvT+gBBlaSDMh/84xf8/s0RDAKwbYdDaDHPfEd+0al6aw
	YDlzU87F0dPp/kRm+Uaq1QQ2+5xRk6P6bEdRO/fczRikNr+XuIafKeqTEi3XXvAPkbjgIv7e0Rlj7
	Itc3OL4wnnbwM8AHnFIoCnQM7eFfmX97/SOiQRbKFJJbwxU72t20xCsLiJa3arGE8QDbIcQbIe55O
	BWhI2kCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mniOy-00875E-Ho; Thu, 18 Nov 2021 14:28:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mniOs-00874M-9x
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 14:28:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 495E01FD35;
 Thu, 18 Nov 2021 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637245707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9h4Bw/If4ZuNT+GOg/Fzw0fm2KV8+gOyLinAXVS1EU=;
 b=Y/nLI+1UYHzfX+aHo4HGDW7FsAYR6mwk+W27Rgos8msJyjAkgELKZ6rONZzHuNMl/R6CV7
 JthVhAyrgyV4eQGv3a3RXu9gfOwF1nZOp9IGzIBcTXrRCvnHGTVnHCzwM1QskYdYCaKlXT
 wdZxpRV+gPQvv2RAfmTEwaqix2Lb3fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637245707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9h4Bw/If4ZuNT+GOg/Fzw0fm2KV8+gOyLinAXVS1EU=;
 b=300W8EfwsD+v6knbJ9OgLvCWzdoE4Tj2s6jX4G4ztA1qK4IVAX2l28hqtWDch7dhLvPtlI
 afMIAgBKmWO4eeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF21213D21;
 Thu, 18 Nov 2021 14:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GZYLOApjlmHHAwAAMHmgww
 (envelope-from <jdelvare@suse.de>); Thu, 18 Nov 2021 14:28:26 +0000
Message-ID: <3c725e5deaabaaf145f48f2f6fcfdae9f6d41e2e.camel@suse.de>
Subject: Sysfs paths to NVME devices
From: Jean Delvare <jdelvare@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date: Thu, 18 Nov 2021 15:28:26 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_062830_543372_AE584854 
X-CRM114-Status: GOOD (  16.14  )
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

Hi all,

I have a few questions related to the sysfs paths to NVME devices. We
have a dracut module using udevadm on block devices (under
/sys/dev/block) to figure out which drivers should be included in the
initrd, and noticed that it does not always work for NVME devices. Upon
investigation, it was discovered that the link in /sys/dev/block leads
to either a physical NVME device (e.g.
/sys/devices/pci0000:00/0000:00:06.0/nvme/nvme0/nvme0n1) or a virtual
NVME device (e.g. /sys/devices/virtual/nvme-subsystem/nvme-
subsys0/nvme0n1). The latter case is problematic because virtual NVME
devices do not have a driver attached to them.

First of all I would like to understand what is the deciding factor
inside the kernel to go for virtual devices or physical devices. At
first I thought it was related to CONFIG_NVME_MULTIPATH, but in fact
all our systems have that option enabled, still some have virtual
devices and others have physical devices.

Secondly, I would like to know if there's a chance to have a consistent
behavior where the paths would be the same on all systems, so that
user-space only has to deal with one naming scheme instead of two. It
would be nice not to have to deal with exceptions in dracut and udev.

Lastly, in the case of virtual NVME device paths (which I suspect can't
be avoided in multipath scenarios), could you suggest a reliable way to
figure out which drivers are being used? Multipath existed before NVME
so I suppose there's a way to do it already, maybe the NVME subsystem
needs to be adjusted to do it the same way other subsystems (SCSI) do
it?

Thanks for any insight on this topic,
-- 
Jean Delvare
SUSE L3 Support


