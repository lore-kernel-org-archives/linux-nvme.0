Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6BFC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmRbr5c/qjtqkL35G9uCBX04kRMJjF6JQZDy44M7dHE=; b=AIawD54xmsXeRlHar4GpHT111f
	iPDqERCVxGyzkRfUABDmZoBslsFfsKnGcxIRh+i4dtxfUqPZasQN6HxCzUF4cL4eg2w9HHK/mv6GH
	T34hP2m4PZTM4Nts1iwqWf5auRZI2BqHjP+a2/KQBKvYLkKtuiiOqSjGE3QYmVBkCb0WvgZT1aXFg
	/Q1DWQbpPkcfJJ95tXj72CZfOYuGxfooawxQDkIl2fX8KmAdffo6Hmw3DcgunyS4tEJA0uWKNefSP
	zVhUfsNa7373g5GZw/T1F2uQ7lfOOqkORoi72iyRz1SMxpTgGnhpKYZ3sh1DrY0161oa/3PXRENEV
	oVnp44nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncshP-000lwq-CB; Fri, 08 Apr 2022 17:47:07 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1ncshH-000lvg-CH; Fri, 08 Apr 2022 17:46:59 +0000
Date: Fri, 8 Apr 2022 10:46:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 mcgrof@kernel.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408161052.GA28661@lst.de>
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

On Fri, Apr 08, 2022 at 06:10:52PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 09:19:04AM +0200, Klaus Jensen wrote:
> > Odd indeed. With “legacy/single namespace” setup (drive parameter directly on the nvme device), the uuid, eui64 and nguid should be zeroed.
> > 
> > Using the new -device nvme-ns, QEMU will randomize the uuid. However the eui64 will be more static and only differ with the namespace id so it will not be unique across subsystems (this needs fixing in QEMU).
> 
> Well, if that is the case we'll need to quirk the affeced qemu versions
> as duplicate global ids must not happen.  Can you help to come up
> with a heuristic to catch to affected versions?

The above note from Klaus seems to indicate this is not yet fixed on
qemu for eu64. Please correct me if I'm wring Klaus.

However, what I'm seeing seems to show that the uuid is same uuid as
well when not using -device nvme-ns but just -device nvme (this is
called legacy now it seems?) without the uuid set you end up in the
situation I described. I just destroyed my guests and started from
scratch a set up using qemu-system-x86_64 v6.2.0 on debian-testing,
and end up in a different situation but it is still a bit perplexing.

What I did is I just got debian-testing guests on a host, use kdevops [0]
as follows:

make menuconfig # enable the linux workflow and use linux-next

grep ^CONFIG_BOOTLINUX .config
CONFIG_BOOTLINUX=y
CONFIG_BOOTLINUX_DEV=y
CONFIG_BOOTLINUX_TREE_NEXT=y
CONFIG_BOOTLINUX_TREE_NAME="linux-next"
CONFIG_BOOTLINUX_TREE="https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"
CONFIG_BOOTLINUX_TREE_TAG="next-20220301"

grep CONFIG_KDEVOPS_HOSTS_PREFIX .config
CONFIG_KDEVOPS_HOSTS_PREFIX="kdevops"

make # generate ansible hosts file and vagrant nodes file
make bringup # bring up guests

ssh kdevops sudo lsblk -a -O -a| awk '{print $3"\t"$6"\t"$15"\t"$32}'
PATH    FSSIZE  UUID    GROUP
/dev/vda        dos     0       none
/dev/vda1       19.5G   52e64545        512
/dev/nvme1n1    0       root nvme.1b36-73657269616c31-51454d55204e564d65204374726c-00000001
/dev/nvme0n1    100G    128     512
/dev/nvme2n1    0       root nvme.1b36-73657269616c32-51454d55204e564d65204374726c-00000001
/dev/nvme3n1    0       root nvme.1b36-73657269616c33-51454d55204e564d65204374726c-00000001

So although not the same as before, I see something random but the same
but I can' tell what that nvme.1b36-... is really. Is that the UUID ?
GUID?

root@kdevops ~ # apt-get install nvme-cli
root@kdevops ~ # nvme ns-descs /dev/nvme0n1
NVME Namespace Identification Descriptors NS 1:
uuid    : 00000000-0000-0000-0000-000000000000
csi     : 0
root@kdevops ~ # nvme ns-descs /dev/nvme1n1
NVME Namespace Identification Descriptors NS 1:
uuid    : 00000000-0000-0000-0000-000000000000
csi     : 0
root@kdevops ~ # nvme ns-descs /dev/nvme2n1
NVME Namespace Identification Descriptors NS 1:
uuid    : 00000000-0000-0000-0000-000000000000
csi     : 0
root@kdevops ~ # nvme ns-descs /dev/nvme3n1
NVME Namespace Identification Descriptors NS 1:
uuid    : 00000000-0000-0000-0000-000000000000
csi     : 0

Huh, the UUID seem to be all zeroes now....

But for whatever reason this boots fine now on linux next:

# On the host:
make linux # build and install linux-next next-20220301

ssh kdevops uname -r # Verify everything went fine
5.17.0-rc6-next-20220301

Now ssh to kdevops and git fetch to the latest linux-next, make
and, install and reboot, and monitor on the console how it goes.

ssh kdevops
cd /data/linux-next
git fetch origin
git branch -D master
git checkout -b master origin/master
make oldconfig
make -j 8
sudo make modules_install install
sudo reboot

This

On the host monitor progress on reboot in case of
failure:

sudo virsh list
sudo virsh console domain_name_or_id

However I see things moving fine now. It is booting fine with
next-20220408. The only thing I changed was probably the version of
qemu-system-x86_64 for the *initial* bringup. I gather that an older
version of qemu was generating a uuid of 00000001-0000-0000-0000-000000000000
and now it's not clear what it is given the above. The other change was
that now /data/ is using btrfs by default in kdevops but even if I
create an XFS partition on /dev/nvme1n1 and mount it always using a
label on /etc/fstab things are good.

So... it may be that the old version of qemu which generated a
that 00000001-0000-0000-0000-000000000000 may create a conflict
with "nvme: check that EUI/GUID/UUID are globally unique" but
its not clear why not with the above newer qemu-system-x86_64 v6.2.0
given what is observed as well.

So a few question remain:

1) Shouldn't this kernel commit still be not allowing these nvme drives to be
used given the above even for qemu-system-x86_64 v6.2.0 ?

2) What version of qemu was issuing UUID which seem to be
something like 00000001-0000-0000-0000-000000000000 which *does*
cause an issue with this new kernel commit?

[0] https://github.com/mcgrof/kdevops

  Luis

