Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35C0CA5FA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 23:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IS6TByWFgsxOTPGaMQkR8btgGIqLwW1a4rgcn4lxTW4=; b=aFgNKsrcKZuaHvakdOIXOsTMA5
	BKmCk5E8BbpfZdn18yFuvon4nfJzgQXXtsdjOq3UMkWrvp7rt4qB2u2Xf8Rvs1x6VFX7GS1dTQGyS
	S1WAH0/VP1dzcEp8rBsOPm7fEZ2pcTn8c8cY0hcbneVczcZ5AO5dZyU96p6dz71Xo6uB8GcuyLNHB
	49Gn+LeEcTeQ8/2taLXPQiDchEfZrBR09fYGTquaISY95YMZ8LIXvCWNa85e6xmb9gWpM1FHl15XV
	L7Dw++b7knO4k0WaE3c1Dfl6ptLzricxnIXz6Ad0qGcfqd9ZnoGifVYJuDk0IXmJUfzFWCTCDOiQQ
	QIPk5vdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhBM-00000004kiZ-2uVA;
	Tue, 29 Sep 2026 23:24:20 +0000
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhBJ-00000004kiD-1ZUm
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 23:24:19 +0000
Received: by mail-pz2-x0c.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso2926494a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724256; x=1791329056; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IS6TByWFgsxOTPGaMQkR8btgGIqLwW1a4rgcn4lxTW4=;
        b=X/GFjLCviScgvqC0SEYzHFXtPXuapV0CGnOZgAidovDjWcAPXR5MSUkj7fXPaEyqql
         c1N2YKTobYErs9ZZmltgZd6IxhocTKy0Taq6BqRsXtzutTYQgfsNGTK8Xgd0mbXwNrTL
         MighVWCXVr5fUksHq+njbv6wvbKFXEQRAuDT7RdUIVx2yDzbsbiV7EPZWrE/d43gh+ql
         VGFPJ/rbPwuTAp8xXjuW7fiLBJwh3tnHQogxUKtJOuSGcCVIamzPyDNNrNh7ZAGL+ZGz
         YWHB211qW55++Lhx19tk9C1IoNpEkkVtzH9ol/R/H0OS1qnWJP5Rc4fR+V9DyekiqIqV
         stNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724256; x=1791329056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IS6TByWFgsxOTPGaMQkR8btgGIqLwW1a4rgcn4lxTW4=;
        b=ThmVoOhXpqK18prTe/TOJB3kqLWA82tBnqgtLnLnkELDYJvNGoBhBLHBwIBj/HMSxo
         QCQEPdN8UZRjeKt7wWVL/WGAs6LEvIQ69SnmEk2Bp/mI4ZnkorugCrh/sJ7776UH6PX4
         IFIEKK3xGQIH8zzoIcJ9a+l8q586v6tYhZ33kdTpmU2sMFxQOZ5CPBPJ9itvXso1naON
         29AhtjDfFTjrNihSLfBl8ZqhC+XHOl/XnjKJCH3qzvmUwVjAN49URS9EvIv57vBMMcHZ
         zK0nqmxbease0feSK708IPm6SmvqngpGnTtUhkQFz1mKm7zGejMX91qyMcpqIuoij9Go
         lLFg==
X-Forwarded-Encrypted: i=1; AKwUvBxDPhAlrw5/fCJMywuemNrvotuSZxRoxGfSIjzuWHBhupuKjMtT1oEVC8+Tv82K7kJIIv+tFJHV+swy@lists.infradead.org
X-Gm-Message-State: AFq9FYKc8jk/H0PrRyW9JbjI0Fkpmjwg5aHiYleomVa2r9HCIP8M4UVe
	y2JLNSluJc0xfApma5BoBBWKDndmtrqjX1I8eWeA+M993W4YHFRBsAq7
X-Gm-Gg: AYBFou0M2wCVOdMqBdnLWU5D65sSCr3omM8mshaB/9kiFdoXp6WQfNIY06Uyp6LfGwE
	G346uNV+ftCoMeLtUA/FKIo7GMJC+PkszCGCxWw9G1NQGy1+vg5GPeRe/Fq6rdcq0j6adJ3Thh6
	rjiQTYbLBhvdrRdTrNzkh7OUE3JikZEtplGA4ltFbnr/V9wWqBW704V2UaqLedxRhqnM7J5Se0Q
	4946QaFVOClfKSlidWIFwJ9bX/1+Eo2dV90EOcEfF3DNdnFB+L7rMYbhPabZ9Cx79flkMD5cMWY
	X9RwcUeQQ8bXlbKKPnvJrLBoEyhj8Vw/t/P0pB+7HZ3aTxzIKM09i0MA9MGLV9J6KIFFJslYyK7
	mv/SkECbGomXrFdh270Ata2MoupQFfdyHVCkpyAQ70juClUP5C0znB+H3bf87nZC88Iqk4SFT1P
	7+/nDJy15NvRKi7uGngtgzf4baih3DDjmf5A7EO20Hi/owXTFDOBxnUuNSA0mBdqRd9/HhUUhWE
	+3iC705pnrpGxm8bPPN5tb/6QQhhslLjZxqUeiNkmBrYsvZ43ImctL8enzOCm2FZeLlJFMyQ6dK
	Ofo=
X-Received: by 2002:a17:90b:4f89:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a4bfe73db9mr752355a91.29.1790724256010;
        Tue, 29 Sep 2026 16:24:16 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca78102csm138700a91.4.2026.09.29.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:24:15 -0700 (PDT)
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
Subject: [PATCH v7 0/2] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Tue, 29 Sep 2026 16:24:09 -0700
Message-ID: <20260929232411.101087-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_162417_426193_7F37608F 
X-CRM114-Status: GOOD (  14.98  )
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

Change since v6:
* 1/2: Explain in the commit message why the effective css is tracked,
  and add comments on e_css[] and in init_cgroup_root() (Tejun).
* 2/2: Use cgroup_get_e_css() and css_put() in nvmet_blkcg_set_bio()
  instead of cgroup_e_css() under rcu_read_lock() (Tejun).
* Drop "cgroup: export cgroup_e_css()", which is no longer needed (Tejun).

Change since v5:
* Add "cgroup: track the effective css in each cgroup", so looking up
  the effective css for each I/O is O(1) (Tejun).

Change since v4:
* Hold the cgroup and look up its effective io css for each I/O,
  instead of pinning one io css when the namespace is enabled (Tejun).
* Allow a cgroup that doesn't have the io controller enabled (Tejun).
* Add "cgroup: export cgroup_e_css()".

The two patches don't depend on each other: 2/2 only uses symbols that
are already exported and works without 1/2, with the slower lookup.
1/2 can go through the cgroup tree and 2/2 through the nvme tree.

v6: https://lore.kernel.org/all/20260928061417.1574676-1-yupeng0921@gmail.com/
v5: https://lore.kernel.org/all/20260926063328.257023-1-yupeng0921@gmail.com/
v4: https://lore.kernel.org/all/20260924053121.17703-1-yupeng0921@gmail.com/
v3: https://lore.kernel.org/all/20260923152653.40953-1-yupeng0921@gmail.com/
v2: https://lore.kernel.org/all/20260922065115.22508-1-yupeng0921@gmail.com/
v1: https://lore.kernel.org/all/20260908011214.11344-1-yupeng0921@gmail.com/

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
  cgroup: track the effective css in each cgroup
  nvmet: add cgroup_id to charge namespace I/O to a cgroup

 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 58 ++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 include/linux/cgroup-defs.h       |  8 +++++
 kernel/cgroup/cgroup.c            | 60 ++++++++++++++++++++-----------
 8 files changed, 247 insertions(+), 24 deletions(-)


base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
-- 
2.53.0


