Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B65C9833E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oOOwgR3Na06hDrMsbkRMKNZF35be9FXivq+8tVzj7v0=; b=ycTr57RSH8wh6x1n47chplfTNO
	VAQhRLhGF7EtgwKSG1sy/uA2fINOYZ88ojYrBSPKj120GeOsFKWFmNYxPiRA9frloZbx/hX7W712u
	/q4kerv0Hxuh24uXt4Bv8f+a7AXY9xUHzib+0nAUEfvsPOTjmZrgUw8Sq3Ap08ekSgxp9solDJtgz
	rBGq74n5Dxhm3/SrA+aNn2OxLvRP09yf/lkgds5MZMixPulw/pe5UFogWc+/zEu9GcFXk626xwA71
	p7kYwibCXbKhYDI7K4K1eLUVF9Srp7qyV+Nwf1eCXnWdkDRQ7NsY0OJxW6g+Y6YxsOkyRszfLHLZ7
	jF0Nvfvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4d7-0000000HR3i-20Je;
	Mon, 28 Sep 2026 06:14:25 +0000
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4d4-0000000HR2p-15yl
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 06:14:23 +0000
Received: by mail-pz2-x2b.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso853254a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 23:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576061; x=1791180861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOOwgR3Na06hDrMsbkRMKNZF35be9FXivq+8tVzj7v0=;
        b=h5n7QzSpTZ70VhwMZSvGyiSGf6TqLXbS9hn9xsMDG7Zi6Lm07qIiyRKWMvglSQHpb4
         fTeM8IfbGKM1zr3TJV0nNdjPprXIeplVZ1/Jd5iljuDBPvxDl12H9XW9nMaU6JE2Rsey
         4ljZngkWyD9nIbagsIlFwIh+v4+SNTbkLV8QrecjKGsGAgSFP7hymaZTd2U58SpuTyPb
         hwLRHydqdi0GizbIWX0PdS+OzGFQxln1RcbDLQg4Pe31z5d1lNplbOsdZS1Ro8MEMZ4H
         k7UkaJGe4HDDL3Os/nZ3ib59Y/pCZB/nqrbKbriOz1qGgn3xoylYEc4tQTM2OttjLpBA
         bV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576061; x=1791180861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOOwgR3Na06hDrMsbkRMKNZF35be9FXivq+8tVzj7v0=;
        b=l7yCRum7u8FO7Wi8YPpFbDwcH6QRMQdMRgs2FJqotHnJ+784JuepwWxV3NCL9774jN
         hXO5puxEHrlM3E0Ii0SX6IylhZfngPUUH6FzGRkxBixzh4xkWccQLKwFALY3v8MbSVOh
         75u0xErXKAygvq1dVNFpxsgu0juRhavQqPjENLGFg1kzRAZJgpGK7sng8l2rlQNO84Rd
         eeu0+gme+1eSqZ3b22F7gDhHCFlt0Jkh8ibUeOQevqgDOk8L6uhIvPzXypZobuOc3pBx
         3nF8TGwKBl82Kh2VX3u1ViseHRT/g8ERYMcGwPmyDiqG9MIlEYCVUFeX0ss6M6U5iY9P
         UHeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzy7FU+YLZI6UO3yUf2zbsYS51CyeO+o60Nu5wJSbv2y4RICcHPXcKslyaI06IKMUi2v/dkfj+UkpYt@lists.infradead.org
X-Gm-Message-State: AFq9FYKH6OpLHlbCN1VMfxH+DzUxZlhWOu917OjU2Nx/6r3jyCJlUFXT
	GqlUykT93qQyj7DpXEmSiIjnklFJBGeSckFL8hlgv/o+PK9REcoUrAb7
X-Gm-Gg: AYBFou0XutBWHkEcOJ4buJB/kowz+y27++w2NyRzqbXAIGxSZIQ7hmOyVpSWOh4E8eY
	Id48Z5nn5xYxSgVjljhnn1qFkqOQDvCykLapsmTfalHRLG79rDbhb+MRKne1pCBfZ4cL6n2emsQ
	HSDahCIZEvDr9HIY33KhVGvtM9qmvVXcDYQisgQwwEUNLOQ6qHcQM19A5+WRC8XnmMlzpaxPi1W
	zgswP1fO4ONXRoB8mlCGFoYJui5+WtrY5ZNAaZR3sOvVCxqMolr7fPSsFbySJjqei+6tdZu9tdA
	f4Qxx8DHURViscFJvWZ8YuBJEnx2POd9P761KbWbDVF3prZX7q+G2Bzxu9+if67P6AU9aIc61nx
	g43uo+DCUTeKHBm/mPOOcdZhwctQQj0gCz1UryDo+CKtSjCZuf1BP9VQ8RUKw6F47wzRVzu4PLB
	16D2io/HskmCfx/7yvkImqQehOeqqn/TmY9E2fJSMDrybXKMmt/mU1PX/X7/pWKR0Hy2qpZSiOI
	8sm5soMIlHeCamNgko9kiBhhEsDN6pJ5kN0B3QoCfyNXsUDs9KCfAhaaxEk5ilxdGZVcvtxFca4
	F6AoOF3igTWAVQ==
X-Received: by 2002:a17:90b:2c86:b0:3a2:bb45:d37b with SMTP id 98e67ed59e1d1-3a2bb45da47mr1186529a91.25.1790576060904;
        Sun, 27 Sep 2026 23:14:20 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm18864088a91.11.2026.09.27.23.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:20 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v6 0/3] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Sun, 27 Sep 2026 23:14:14 -0700
Message-ID: <20260928061417.1574676-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_231422_309249_2FE2BAE4 
X-CRM114-Status: GOOD (  11.06  )
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

Scenario:
* Create multiple nvmet subsystems/namespaces.
* The namespaces are backed by different LVM logical volumes.
* Some of the logical volumes share the same physical volumes.
* The subsystems are exported to different users.
* We should provide each user a specific iops/bps quota, thus a noisy
  neighbor won't impact the performance of other logical volumes.

Test:
1 Load kernel modules.
sudo modprobe brd rd_nr=2 rd_size=1048576
sudo modprobe nvmet
sudo modprobe nvmet_tcp
sudo modprobe nvme_tcp

2 The two brd devices are used for a bdev backed namespace and a file
backed namespace, remember their major/minor.
lsblk --noheadings --nodeps --output NAME,MAJ:MIN,SIZE /dev/ram0 /dev/ram1
ram0   1:0      1G
ram1   1:1      1G

3 Enable the io controller and create two cgroups, one for the bdev
backed namespace, another for the file backed namespace.
echo "+io" | sudo tee /sys/fs/cgroup/cgroup.subtree_control
sudo mkdir -p /sys/fs/cgroup/nvmet-bdev
sudo mkdir -p /sys/fs/cgroup/nvmet-file

4 Create a file system and a file on ram0.
sudo mkfs.ext4 /dev/ram0
sudo mkdir -p /mnt/nvmet-file
sudo mount -o noatime /dev/ram0 /mnt/nvmet-file
sudo dd if=/dev/zero of=/mnt/nvmet-file/ns.img bs=1M count=512 oflag=direct

5 Create the bdev backed subsystem and namespace.
sudo mkdir -p /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/attr_allow_any_host
echo /dev/ram1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/device_path
stat -c %i /sys/fs/cgroup/nvmet-bdev | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/cgroup_id
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/enable

6 Create the file backed subsystem and namespace.
sudo mkdir -p /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/attr_allow_any_host
echo /mnt/nvmet-file/ns.img | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/device_path
stat -c %i /sys/fs/cgroup/nvmet-file | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/cgroup_id
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/enable

7 Export the two subsystems to 127.0.0.1.
sudo mkdir -p /sys/kernel/config/nvmet/ports/1
echo ipv4 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_adrfam
echo tcp | sudo tee /sys/kernel/config/nvmet/ports/1/addr_trtype
echo 127.0.0.1 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_traddr
echo 4420 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_trsvcid
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:bdev
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:file

8 Connect the two subsystems from 127.0.0.1.
sudo nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.2026-09.io.test01:bdev
sudo nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.2026-09.io.test01:file
sudo udevadm settle

9 Set riops to 20k and run fio.
echo "1:1 riops=20000 wiops=max rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=20000 wiops=max rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=randread --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10001msec)

sudo fio --name=t --filename=/dev/nvme1n1 --rw=randread --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=20.0k, BW=78.2MiB/s (82.0MB/s)(782MiB/10001msec)

10 Set rbps to 100M and run fio.
echo "1:1 riops=max wiops=max rbps=104857600 wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=max rbps=104857600 wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=read --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=97, BW=100MiB/s (105MB/s)(1041MiB/10399msec)

sudo fio --name=t --filename=/dev/nvme1n1 --rw=read --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=97, BW=100MiB/s (105MB/s)(1031MiB/10299msec)

11 Set wiops to 20k and run fio.
echo "1:1 riops=max wiops=20000 rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=20000 rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=randwrite --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10001msec); 0 zone resets

sudo fio --name=t --filename=/dev/nvme1n1 --rw=randwrite --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10002msec); 0 zone resets

12 Set wbps to 100M and run fio.
echo "1:1 riops=max wiops=max rbps=max wbps=104857600" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=max rbps=max wbps=104857600" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=write --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=97, BW=100MiB/s (105MB/s)(1032MiB/10307msec); 0 zone resets

sudo fio --name=t --filename=/dev/nvme1n1 --rw=write --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=97, BW=100MiB/s (105MB/s)(1033MiB/10296msec); 0 zone resets

13 Cleanup the environment.
sudo nvme disconnect -n nqn.2026-09.io.test01:bdev
sudo nvme disconnect -n nqn.2026-09.io.test01:file
sudo udevadm settle

sudo rm -f /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:bdev
sudo rm -f /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:file
sudo rmdir /sys/kernel/config/nvmet/ports/1

echo 0 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/enable
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev

echo 0 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/enable
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file

sudo umount /mnt/nvmet-file
sudo rmdir /mnt/nvmet-file
sudo modprobe -r brd

sudo rmdir /sys/fs/cgroup/nvmet-bdev
sudo rmdir /sys/fs/cgroup/nvmet-file

sudo rmmod nvme_tcp
sudo rmmod nvmet_tcp
sudo rmmod nvmet

Peng Yu (3):
  cgroup: track the effective css in each cgroup
  cgroup: export cgroup_e_css()
  nvmet: add cgroup_id to charge namespace I/O to a cgroup

 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 59 +++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 include/linux/cgroup-defs.h       |  2 ++
 kernel/cgroup/cgroup.c            | 54 +++++++++++++++++-----------
 8 files changed, 236 insertions(+), 24 deletions(-)


base-commit: d9cc476535d29a44df3f2aa3b14af9a833fddf90
-- 
2.53.0


