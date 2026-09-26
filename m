Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE35CC98328
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 06:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v8XYO5YM5s3vZvbrjVcN9xgfREmdqmZ1B6r1XIDErl8=; b=xK+ekx0e+Z57/ENya8smXK36RF
	TUnGFwqxbZN23FAJuJEIx1qypdtmf3DNH39Cw6tczJHv3ja29WhKEPn7hQVTW3CNkLb36qPyJZAvW
	1yivKzE+6x8MIZ0/9JNXsR1/+leiXXdXUGq3wl3allNBWhKJa5Jf70DjMq6r7ToqULydpD75cc3up
	DQAf2V16HCTzS4Yon4aZ7qIVTCN1ZHMZvEdEcB2rZ2SPR+sPZb/l6TrFsY6xnq3na9RPuT+KkCfpX
	AQPif1PtjjPsNiqQOkpTxhEBgx1p3lv4jOAXem/QkMKFEMPfuRk8kENG5TY59ophgSckOZuSumNBb
	ASdo/+KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xALyY-0000000F4rM-3IOu;
	Sat, 26 Sep 2026 06:33:34 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xALyW-0000000F4r0-3C82
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 06:33:33 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747eb79f7so7228855ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2026 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404412; x=1791009212; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v8XYO5YM5s3vZvbrjVcN9xgfREmdqmZ1B6r1XIDErl8=;
        b=mp/LMYofV1thQR37MaTSfwoFI17kZpnIFz+AH2i0fY21lKoXz2ZRBaMUr2bhd5Kd4y
         +n/EOEd0yEzSAreqpYYYQlyrpsxqEO2lPBj5QzIDpX5r1d7luWe6T09ipyf7cdeTzR5y
         8nO9V1kr3QsRwH5qKxuDn1TWnBC/9IsxcE8mrQINFnQnLPqQNZeW8cFE1l/letKSrDrZ
         pFoc6IJchteSVa6JBc85ku7dnSVL2sq3o7wS3IIrvhvB7Vggnrjt3xMiHO9Bwg8ZGeLZ
         9hyUAjOBNlPsgM2FIicWRFibl0+YQu68AQUING7Rr7qrfr2CldzIhMYhryV7dHsk61Pd
         klpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404412; x=1791009212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8XYO5YM5s3vZvbrjVcN9xgfREmdqmZ1B6r1XIDErl8=;
        b=fDmSMIh8RxT9QRgcjiSUnv9w4rgII7g1bP+ncSDBLaIdnnVfD42TQF1XFLf4gtswgj
         nkWDaMa36xULQiGfN8yZA4cerDlzctB5z/tWvOYALMEx0wxFgXDMVWYSCeAwJVD9hDVI
         3TWad+arv5fJxdKty361yBAZ+V6U3oCx2fh8jBM68QpOYLfFj6JPBq1zxcM5xagLCXZ3
         JNNOMcfz6CK9r6E/EMp2Ae6iFp5Xx9BSeeKK00HdWRwUn6GsLcXdRuy9jK75J47uKCAG
         RrdN5VdWYKsa211sOv69Zdk0sTAWVrU9Id1WQyokxMRqSh+8mVOzxrvGBgKrVHqyqLs9
         t0jQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFNFM2UFx//RSqUaMuc2Y9VjuraS8hUibpWUk2GPXE35xi7OAa2ZJZuhv6n99+ge/LJ+AJR3LEPDkx@lists.infradead.org
X-Gm-Message-State: AFq9FYK4xgzFrC034zEIWplsORrGH0NU0xXulnxsBiO2gIKd9SyKRGIF
	6tUfKNXmye2kFg/EIQVikevcK/S7mkn0NaCtN8r0oZfHCJUY5sUM179oqtLNPff5gCE=
X-Gm-Gg: AYBFou1tLnTSzCWtu/YvBHfcSmcm4qif0rr5BsxLrdldBP7NPXxcx9iGBynfXuPoQSc
	8l5KG9uQ/BWn/qQAywdMYPmIUgq/mElrP698qHSVxHxa423PK7W9F7lpf8qub41j8ddTZSCSzzZ
	GEXAV3abgI6mewEqUHNed7fgnSpY5xhnuM3MtA+FkSY1qKYZV9R56ZIMCnPLhy6WS+KVltGFlg5
	OdBLVGR7ZX/wI+C27ZHuvsK9AwRh9vaz+W8bPRPhkePM4VgHf1YBpktHeFWemKjPttz8wuEoEmS
	nACJ6NVR2j98roJkgJ1gn+Sj0bTbKC1v2HddV+Y3b+gfnwYXQ3IroJ1eQu7I/ahHMBe4NKeDNUY
	R1NmPDdd1wIIIeTGEsSFQPSDi5/d9+X2djtbqd5Zgroh4pmkinvmAehqRzhDgvuUoOcnhKUwb3c
	JNn4xBQHcyvincrDKSbIsg8mwDDjO8zKmvINTbI9Yf+knBm/nbmhE11LbyFYgY19EkTSA3uhT5P
	R8RcFVbSSP/FUv9ZFRxDElFoV0tAwV7kpgMEpstmyOig+m78fR40PxZby1GTyc9JIJ1dUMPoKRf
	R30=
X-Received: by 2002:a17:902:c404:b0:2dd:c0ff:e728 with SMTP id d9443c01a7336-2df7dfdda93mr62813445ad.58.1790404411724;
        Fri, 25 Sep 2026 23:33:31 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91460aaasm19196895ad.73.2026.09.25.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:33:31 -0700 (PDT)
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
Subject: [PATCH v5 0/2] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Fri, 25 Sep 2026 23:33:26 -0700
Message-ID: <20260926063328.257023-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_233332_812697_B807D37E 
X-CRM114-Status: GOOD (  11.27  )
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

Peng Yu (2):
  cgroup: export cgroup_e_css()
  nvmet: add cgroup_id to charge namespace I/O to a cgroup

 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 59 +++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 kernel/cgroup/cgroup.c            |  1 +
 7 files changed, 202 insertions(+), 3 deletions(-)


base-commit: d9cc476535d29a44df3f2aa3b14af9a833fddf90
-- 
2.53.0


