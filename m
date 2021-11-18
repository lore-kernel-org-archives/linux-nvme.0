Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 16:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8089B61A6C
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 16:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8089B61A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8EAdpivs4s0Wk4mXPm7EqohUmpgfCcdoAnrE3GuRpM=; b=GxlCr/lhtIqqW4A3k+ZXDlMyXA
	N0Wpy/QXAB2A8wKhDgVzbsES17GFght1y5r9TJLCRoLsFhgWyQxYqh2TgGlQv9CHNRNFUb2+20Uz7
	GGDAHQ75U//RuO1ZZZuT2byOPM7SvlSxxqC2wJfpd0WWjim4ql518cMTbxp0VgqHXVuvHh5du0tfD
	aE0DV5xeZf/mih17HkRitQHoNxeSgdTlMOea+yT+fiVjOWSzS01qvI6LvdIR0DuXF3eVq3JzP9psQ
	qRsFLp5vtj/StvlxyY3sLRxwrWBDHL2cm5qqV/B/CN1sjAvmntKxygu1nDltCGv6P6/fzMg/LeURM
	NTRE48LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnkK5-008M2v-LZ; Thu, 18 Nov 2021 16:31:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnkK2-008M1s-Km
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 16:31:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C4BD218CE;
 Thu, 18 Nov 2021 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1637253095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8EAdpivs4s0Wk4mXPm7EqohUmpgfCcdoAnrE3GuRpM=;
 b=hvGqFbDDsA+KMIg0j6CjdYYCA0pt2YwIy0Pao4AAsZ3jKJSRd9wPQWlLNywP780FQZHXQV
 IwnYHppye2Xe+9a/Lf9o4qh2mPSUfd9+5Z7D68E+ir89KIEK9EGIvjcTviV110doUSbrxs
 M69QzxiXqjEEHnu/pD7a70VO0wCF00E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B56AE13D21;
 Thu, 18 Nov 2021 16:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tllFKuZ/lmERPgAAMHmgww
 (envelope-from <mwilck@suse.com>); Thu, 18 Nov 2021 16:31:34 +0000
Message-ID: <b98f6062f59c1c1cfc4a200de83e4e244efbffbf.camel@suse.com>
Subject: Re: Sysfs paths to NVME devices
From: Martin Wilck <mwilck@suse.com>
To: Keith Busch <kbusch@kernel.org>, Jean Delvare <jdelvare@suse.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date: Thu, 18 Nov 2021 17:31:33 +0100
In-Reply-To: <20211118153016.GA3296638@dhcp-10-100-145-180.wdc.com>
References: <3c725e5deaabaaf145f48f2f6fcfdae9f6d41e2e.camel@suse.de>
 <20211118153016.GA3296638@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_083138_874151_6A52C27F 
X-CRM114-Status: GOOD (  39.37  )
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

On Thu, 2021-11-18 at 07:30 -0800, Keith Busch wrote:
> On Thu, Nov 18, 2021 at 03:28:26PM +0100, Jean Delvare wrote:
> > Hi all,
> > 
> > I have a few questions related to the sysfs paths to NVME devices. We
> > have a dracut module using udevadm on block devices (under
> > /sys/dev/block) to figure out which drivers should be included in the
> > initrd, and noticed that it does not always work for NVME devices.
> > Upon
> > investigation, it was discovered that the link in /sys/dev/block
> > leads
> > to either a physical NVME device (e.g.
> > /sys/devices/pci0000:00/0000:00:06.0/nvme/nvme0/nvme0n1) or a virtual
> > NVME device (e.g. /sys/devices/virtual/nvme-subsystem/nvme-
> > subsys0/nvme0n1). The latter case is problematic because virtual NVME
> > devices do not have a driver attached to them.
> > 
> > First of all I would like to understand what is the deciding factor
> > inside the kernel to go for virtual devices or physical devices. At
> > first I thought it was related to CONFIG_NVME_MULTIPATH, but in fact
> > all our systems have that option enabled, still some have virtual
> > devices and others have physical devices.
> 
> If you're using nvme native multipathing, and your namespace reports
> that it is multipath capable (ID_NS.NMIC), then the driver will set up
> the virtual device for the visible block device.
> 
> If your namespace isn't multipath capable, you will only get the
> physical device. That's just for pci, though; fabrics targets always
> link to a virtual nvme subsystem device.
> 
> In the case you have a multipath namespace, the driver will also create
> "hidden" block devices for each controller path that it found. As an
> exampe, if you have multipath nvme /sys/block/nvme0n1, there should be
> a
> /sys/block/nvme0c0n1, which should link to a physical device in sysfs
> for pci.
>  

For the multipath case, you obtain the hidden path devices for a given
name space like this:

NSID=1

ls -d /sys/block/nvme0n${NSID}/device/nvme*/nvme*c*n${NSID}
/sys/block/nvme0n1/device/nvme0/nvme0c0n1 
/sys/block/nvme0n1/device/nvme1/nvme0c1n1 
...
(/sys/block/nvme0n1/device is a symlink to the nvme-subsystem device,
and /sys/block/nvme0n1/device/nvme* are symlinks to the
respective fabrics controllers).

Because there are multiple symlinks involved, you can't use these
relationships in udev rules easily, as udev can only match attributes
of the device itself and its parents.

> > Secondly, I would like to know if there's a chance to have a
> > consistent
> > behavior where the paths would be the same on all systems, so that
> > user-space only has to deal with one naming scheme instead of two.
> > It
> > would be nice not to have to deal with exceptions in dracut and
> > udev.

I don't think there's much hope.

> > 
> > Lastly, in the case of virtual NVME device paths (which I suspect
> > can't
> > be avoided in multipath scenarios), could you suggest a reliable
> > way to
> > figure out which drivers are being used? Multipath existed before
> > NVME
> > so I suppose there's a way to do it already, maybe the NVME
> > subsystem
> > needs to be adjusted to do it the same way other subsystems (SCSI)
> > do
> > it?

For the fabrics case, deriving the necessary drivers for the initramfs
is non-trivial. You would need to look at the "transport" and "address"
sysfs attributes in the sysfs directory of the controller, e.g.
/sys/block/nvme0n1/device/nvme0, map these to FC ports or NICs, and
figure out the drivers for those.

The situation is roughly similar to iscsi, where there's also no easy
mapping from SCSI devices to drivers. For iSCSI, the by-path devices
are There won't be any by-path device links for NVMe multipath like for
SCSI though, because the path devices are hidden by the kernel and thus
no symlink targets would exist. It should be possible to create a
utility similar to udev's "path_id" builtin with support for NVMe
though.

Regards
Martin


