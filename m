Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0CFCCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2TzMdzrlb+Yo5TEaNY3GKRfdzyFqT8Uhv1y1w1MPdWk=; b=LKHKghUguKU8H+Bm7KVZdJPNmL
	N8dCNo2wnZfrFczRyOL+MD6TdrrK7USc4f0yvmRlNnwohYcd8mu223Q7AbYk07raEYZ/zGGxYt3b3
	EoK8m1+WiI3JubMhcgtBCEpiJWnwqkMun9fN1webIV9iScOuY2y6LSATRuAlDNZxPRhJ92F9efIyu
	X/73MgdIqbL3YSkfLUTywRizHgdW8PBUg0XojnI3RwAR+EP89s87tFQqrV7fYyMtkYUng746FB7bF
	gvV/RkTmDz96uwlqTLz4L8/oRjokbAnucYiEj0e5VGSGYVPoXWMWcdvYCkiRyuvcVlLpZpAgTDW/H
	ZAfab/Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGC3a-0000000BNaU-0W7D;
	Tue, 04 Nov 2025 08:06:22 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGC3W-0000000BNZk-2jRt
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:06:20 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so548489b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 00:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762243577; x=1762848377; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2TzMdzrlb+Yo5TEaNY3GKRfdzyFqT8Uhv1y1w1MPdWk=;
        b=jlseAXwRYFct2UFMBc8Rkv+EKCRlsSVNTvt600lXha9ZMY6b5+JDTmNMLQlDpi1Ye+
         oQlZt9T1nmQvLL/655AhniCbDqCUmb/H0AtKCFZh0DPTglzP+9mIk2tkOqzONbNrARJV
         xDLEXocRfh5UVMZccOyRRvPuVVAmzGn81fSEduk9LPCGPGN9jcnDU0Xhb2pFe1G5CDBI
         h8d8XYmMUOIauQDdVfNPuLopLtRvBQUrH9hekbeii4F55nv0RtU/CFfJu5b1W+g+RLI6
         aQMG7HuXd6HWBDaESBx4LcwnkJdv60BQTIoTUxHlEzJaZLnmbM5KffohetkyAJNIZBIN
         rjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243577; x=1762848377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TzMdzrlb+Yo5TEaNY3GKRfdzyFqT8Uhv1y1w1MPdWk=;
        b=LZGRkqt0ruB8TIfgF5CkceegRWNvIpVL6jS7hy1eCpHa6ut3pLskhLzhDG8xe8RiLv
         uIeGT8x37Dp476fbB6qgtDrqEdZvhiYT+a8EfV0PS+GdPF3cxbLXlkWkUIyWgWa+OltZ
         TKEahEMKLH+U0GIh3NavG+lfHaN6X+9LQ0wvSzk1o5YBzrWgKBB9YTOufa4RFR8nuKNx
         FSQIxrY/a1l1SdSLaUA+oTvIA/ab4+xqMALAWcHJ4N1/UidI6eIVSif4eRPO/ZHgRAk4
         CBf+Ir8KXgzcIq60Z2LzlWVkwT9FAzDGc0kCmI6Y/GqDBp32zbDtLKRR+FvdVlo/miZ1
         GYEA==
X-Gm-Message-State: AOJu0Yx7zwio/CiTgBCQ28ObsL7leLgNXitqqVLAe1A9QtbH87l7/25+
	eEsx1eve7LN7dhhp0Dqh3PJlQrD8mo2h6iG66hXrniOXalnZoMMWemIZmwmeNw==
X-Gm-Gg: ASbGncurA6gZIWPpH86+y6jQKeXXW4Azx46e3gF2/rDPDm5/AU5LKts6Oq0k0jNB+u2
	RdUnonDJh1YXTaOpib9yn2kMCdoru3MDMaZSQMjZmByvzLFFQpFK8xY5qUPxF9z51tXCQvqP7jR
	TOK0K0K/hHm317e4e4RULfG+v2dLDGzbQew+4oKCFXiJY/7xtOyuMxOI9AeD/2SBE71/qd9TIWv
	1GfomB6vXJiJGV89kX28sR1bcnkQtWDja2SjnWqPPcqYqKFiBz8KRkek4v949EU5FTEeAAfmcgY
	qaAU29fhJ5fj/AIhM4RyAR8d0JN7L8lRhaEpZgZizJM86eOURP2uqvzIfIDrIow3NdJAMex1Jpn
	mZ2l0jPloKUkVPaScWAN9eHm9/ksplQPok4AsWB4Ni25jMvm/fa0X1GMMy/Nd6Viq2aybAlnkoe
	eiJGfZKORYuWnrgaOq6R1hpED+uTKFLWrsjpQV
X-Google-Smtp-Source: AGHT+IH16y9mztVwgNIFNRWGuhbTXuSr31YAIp4tVykn5/KqQCQrkdQEXQp+ioT3HJxC0hC+XvXyUA==
X-Received: by 2002:a05:6a21:9986:b0:341:8609:3bb4 with SMTP id adf61e73a8af0-348caf8d496mr19698634637.21.1762243576840;
        Tue, 04 Nov 2025 00:06:16 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f862sm1933221b3a.34.2025.11.04.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:06:16 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 0/1] nvmet: add basic in-memory backend support 
Date: Tue,  4 Nov 2025 00:06:09 -0800
Message-Id: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_000618_750028_FED7C555 
X-CRM114-Status: GOOD (  15.40  )
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

Hi,

Add a new memory backend (io-cmd-mem.c) that provides RAM-backed storage
for NVMe target namespaces, enabling high-performance volatile storage
without requiring physical block devices or filesystem backing.

* Implementation Overview:
==========================
The memory backend introduces a new namespace configuration option via
configfs that allows users to create memory-backed namespaces by
setting the 'mem_size' attribute instead of 'device_path'.
1. Lazy Page Allocation
   - Uses xarray for sparse page storage
   - Pages are allocated on first write (copy-on-write semantics)
2. Configfs Interface
   New attribute: ${NVMET_CFGFS}/subsystems/<subsys>/namespaces/<ns>/mem_size
   - Accepts size in bytes (e.g., "1073741824" for 1GB)
   - Can only be set when namespace is disabled
   - Mutually exclusive with device_path attribute
   - Limited to 80% of total system memory for safety
3. I/O Command Support
   - Read 
   - Write
   - Flush
   - Discard
   - Write Zeroes
4. Backend Detection Logic
   Namespace backend is selected based on configuration:
   - If mem_size is set (no device_path): Use memory backend
   - If device_path points to block device: Use bdev backend
   - If device_path points to regular file: Use file backend
5. The implementation follows existing nvmet backend pattern with three
   main entry points:
   - nvmet_mem_ns_enable(): Initialize namespace with xarray storage
   - nvmet_mem_ns_disable(): Release all pages and cleanup
   - nvmet_mem_parse_io_cmd(): Dispatch I/O commands to handlers

I/O processing uses scatter-gather iteration similar to existing backends,
with per-page operations that handle alignment and boundary cases.

* Usecase Ephemeral Scratch Space for High-Performance Workloads:
=================================================================
  Training job starts, creates scratch namespace
   # echo 10737418240 > /sys/kernel/config/nvmet/.../mem_size  # 10GB
   # echo 1 > /sys/kernel/config/nvmet/.../enable
  Pod connects via NVMe-oF, downloads dataset to scratch space
  Training job processes data with sub-millisecond latency
  Intermediate results stored temporarily in memory-backed namespace
  Job completes, namespace destroyed
   # echo 0 > /sys/kernel/config/nvmet/.../enable
  Memory automatically reclaimed, zero cleanup required

* Testing with blktests support enabled for mem backend for nvme-loop and tcp:
==============================================================================

nvme/006 (tr=loop bd=device) (create an NVMeOF target)       [passed]
nvme/006 (tr=loop bd=file) (create an NVMeOF target)         [passed]
nvme/006 (tr=loop bd=mem) (create an NVMeOF target)          [passed]
--
nvme/008 (tr=loop bd=device) (create an NVMeOF host)         [passed]
nvme/008 (tr=loop bd=file) (create an NVMeOF host)           [passed]
nvme/008 (tr=loop bd=mem) (create an NVMeOF host)            [passed]
--
nvme/010 (tr=loop bd=device) (run data verification fio job) [passed]
nvme/010 (tr=loop bd=file) (run data verification fio job)   [passed]
nvme/010 (tr=loop bd=mem) (run data verification fio job)    [passed]
--
nvme/012 (tr=loop bd=device) (run mkfs and data verification fio) [passed]
nvme/012 (tr=loop bd=file) (run mkfs and data verification fio) [passed]
nvme/012 (tr=loop bd=mem) (run mkfs and data verification fio) [passed]
--
nvme/014 (tr=loop bd=device) (flush a command from host)     [passed]
nvme/014 (tr=loop bd=file) (flush a command from host)       [passed]
nvme/014 (tr=loop bd=mem) (flush a command from host)        [passed]
--
nvme/019 (tr=loop bd=device) (test NVMe DSM Discard command) [passed]
nvme/019 (tr=loop bd=file) (test NVMe DSM Discard command)   [passed]
nvme/019 (tr=loop bd=mem) (test NVMe DSM Discard command)    [passed]
--
nvme/021 (tr=loop bd=device) (test NVMe list command)        [passed]
nvme/021 (tr=loop bd=file) (test NVMe list command)          [passed]
nvme/021 (tr=loop bd=mem) (test NVMe list command)           [passed]
--
nvme/022 (tr=loop bd=device) (test NVMe reset command)       [passed]
nvme/022 (tr=loop bd=file) (test NVMe reset command)         [passed]
nvme/022 (tr=loop bd=mem) (test NVMe reset command)          [passed]
--
nvme/023 (tr=loop bd=device) (test NVMe smart-log command)   [passed]
nvme/023 (tr=loop bd=file) (test NVMe smart-log command)     [passed]
nvme/023 (tr=loop bd=mem) (test NVMe smart-log command)      [passed]
--
nvme/025 (tr=loop bd=device) (test NVMe effects-log)         [passed]
nvme/025 (tr=loop bd=file) (test NVMe effects-log)           [passed]
nvme/025 (tr=loop bd=mem) (test NVMe effects-log)            [passed]
--
nvme/026 (tr=loop bd=device) (test NVMe ns-descs)            [passed]
nvme/026 (tr=loop bd=file) (test NVMe ns-descs)              [passed]
nvme/026 (tr=loop bd=mem) (test NVMe ns-descs)               [passed]
--
nvme/027 (tr=loop bd=device) (test NVMe ns-rescan command)   [passed]
nvme/027 (tr=loop bd=file) (test NVMe ns-rescan command)     [passed]
nvme/027 (tr=loop bd=mem) (test NVMe ns-rescan command)      [passed]
--
nvme/028 (tr=loop bd=device) (test NVMe list-subsys)         [passed]
nvme/028 (tr=loop bd=file) (test NVMe list-subsys)           [passed]
nvme/028 (tr=loop bd=mem) (test NVMe list-subsys)            [passed]
--
nvme/006 (tr=tcp bd=device) (create an NVMeOF target)        [passed]
nvme/006 (tr=tcp bd=file) (create an NVMeOF target)          [passed]
nvme/006 (tr=tcp bd=mem) (create an NVMeOF target)           [passed]
--
nvme/008 (tr=tcp bd=device) (create an NVMeOF host)          [passed]
nvme/008 (tr=tcp bd=file) (create an NVMeOF host)            [passed]
nvme/008 (tr=tcp bd=mem) (create an NVMeOF host)             [passed]
--
nvme/010 (tr=tcp bd=device) (run data verification fio job)  [passed]
nvme/010 (tr=tcp bd=file) (run data verification fio job)    [passed]
nvme/010 (tr=tcp bd=mem) (run data verification fio job)     [passed]
--
nvme/012 (tr=tcp bd=device) (run mkfs and data verification fio) [passed]
nvme/012 (tr=tcp bd=file) (run mkfs and data verification fio) [passed]
nvme/012 (tr=tcp bd=mem) (run mkfs and data verification fio) [passed]
--
nvme/014 (tr=tcp bd=device) (flush a command from host)      [passed]
nvme/014 (tr=tcp bd=file) (flush a command from host)        [passed]
nvme/014 (tr=tcp bd=mem) (flush a command from host)         [passed]
--
nvme/019 (tr=tcp bd=device) (test NVMe DSM Discard command)  [passed]
nvme/019 (tr=tcp bd=file) (test NVMe DSM Discard command)    [passed]
nvme/019 (tr=tcp bd=mem) (test NVMe DSM Discard command)     [passed]
--
nvme/021 (tr=tcp bd=device) (test NVMe list command)         [passed]
nvme/021 (tr=tcp bd=file) (test NVMe list command)           [passed]
nvme/021 (tr=tcp bd=mem) (test NVMe list command)            [passed]
--
nvme/022 (tr=tcp bd=device) (test NVMe reset command)        [passed]
nvme/022 (tr=tcp bd=file) (test NVMe reset command)          [passed]
nvme/022 (tr=tcp bd=mem) (test NVMe reset command)           [passed]
--
nvme/023 (tr=tcp bd=device) (test NVMe smart-log command)    [passed]
nvme/023 (tr=tcp bd=file) (test NVMe smart-log command)      [passed]
nvme/023 (tr=tcp bd=mem) (test NVMe smart-log command)       [passed]
--
nvme/025 (tr=tcp bd=device) (test NVMe effects-log)          [passed]
nvme/025 (tr=tcp bd=file) (test NVMe effects-log)            [passed]
nvme/025 (tr=tcp bd=mem) (test NVMe effects-log)             [passed]
--
nvme/026 (tr=tcp bd=device) (test NVMe ns-descs)             [passed]
nvme/026 (tr=tcp bd=file) (test NVMe ns-descs)               [passed]
nvme/026 (tr=tcp bd=mem) (test NVMe ns-descs)                [passed]
--
nvme/027 (tr=tcp bd=device) (test NVMe ns-rescan command)    [passed]
nvme/027 (tr=tcp bd=file) (test NVMe ns-rescan command)      [passed]
nvme/027 (tr=tcp bd=mem) (test NVMe ns-rescan command)       [passed]
--
nvme/028 (tr=tcp bd=device) (test NVMe list-subsys)          [passed]
nvme/028 (tr=tcp bd=file) (test NVMe list-subsys)            [passed]
nvme/028 (tr=tcp bd=mem) (test NVMe list-subsys)             [passed]

-ck

Chaitanya Kulkarni (1):
  nvmet: add basic in-memory backend support

 drivers/nvme/target/Makefile     |   2 +-
 drivers/nvme/target/configfs.c   |  61 +++++
 drivers/nvme/target/core.c       |  20 +-
 drivers/nvme/target/io-cmd-mem.c | 426 +++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h      |   8 +
 5 files changed, 511 insertions(+), 6 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-mem.c

nvme (nvme-6.19) # git log -1 
commit ca6e4a009dfb06010f590fd80d9899a41cbbe01a (HEAD -> nvme-6.19)
Author: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date:   Tue Oct 14 00:05:33 2025 -0700

    nvmet: add basic in-memory backend support
    
    Add a new memory backend (io-cmd-mem.c) that enables dynamic, on-demand
    RAM-backed storage for NVMe target namespaces. This provides instant,
    zero-configuration volatile storage without requiring physical block
    devices, filesystem backing, or pre-provisioned storage infrastructure.
    
    Modern cloud-native workloads increasingly require dynamic allocation
    of high-performance temporary storage for intermediate data processing,
    such as AI/ML training scratch space, data analytics shuffle storage,
    and in-memory database overflow. The memory backend addresses this need
    by providing instant namespace creation with sub-millisecond latency
    via NVMe-oF, eliminating traditional storage provisioning workflows
    entirely.
    
    Dynamic Configuration:
    The memory backend introduces dynamic namespace configuration via
    configfs, enabling instant namespace creation without storage
    provisioning. Create memory-backed namespaces on-demand by setting
    'mem_size' instead of 'device_path':
      # Dynamic namespace creation - instant, no device setup required
      echo 1073741824 > /sys/kernel/config/nvmet/.../mem_size
      echo 1 > /sys/kernel/config/nvmet/.../enable
    
    This eliminates the need for:
    - Block device creation and management (no dd, losetup,
      device provisioning)
    - Filesystem mounting and configuration
    - Storage capacity pre-allocation
    - Device cleanup workflows after namespace deletion
    
    Implementation detail :-
    - Dynamic page allocation using xarray for sparse storage
    - Pages allocated lazily on first write, efficient for partially filled
      namespaces
    - Full I/O command support: read, write, flush, discard, write-zeroes
    - Mutually exclusive with device_path (memory XOR block/file backend)
    - Size configurable per-namespace, limited to 80% of total system RAM
    - Automatic memory reclamation on namespace deletion
    - Page reference counting and cleanup
    
    Backend selection logic:
    - If mem_size is set (no device_path): Use memory backend
                                          (dynamic allocation)
    - If device_path points to block device: Use bdev backend
    - If device_path points to regular file: Use file backend
    
    The implementation follows the existing nvmet backend pattern with three
    main entry points:
      nvmet_mem_ns_enable()    - Initialize namespace with xarray storage
      nvmet_mem_ns_disable()   - Release all pages and cleanup
      nvmet_mem_parse_io_cmd() - Dispatch I/O commands to handlers
    
    Tested with blktests memory backend test suite covering basic I/O
    operations, discard/write-zeroes, all transport types (loop/TCP/RDMA),
    dynamic namespace creation/deletion cycles, and proper resource cleanup.
    
    Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
nvme (nvme-6.19) # ./compile_nvme.sh 
+ unload
+ sh ./unload-vfio-nvme.sh
rmmod: ERROR: Module drivers/vfio/pci/nvme/nvme_vfio_pci is not currently loaded
rmmod: ERROR: Module drivers/vfio/pci/vfio_pci is not currently loaded
rmmod: ERROR: Module drivers/vfio/pci/vfio_pci_core is not currently loaded
rmmod: ERROR: Module drivers/vfio/vfio_iommu_type1 is not currently loaded
rmmod: ERROR: Module drivers/vfio/vfio is not currently loaded
############################## UNLOAD #############################
nvme_loop              20480  0
nvmet                 237568  1 nvme_loop
nvme_tcp               90112  0
nvme_fabrics           40960  2 nvme_tcp,nvme_loop
nvme_keyring           20480  3 nvmet,nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  5 nvmet,nvme_tcp,nvme,nvme_loop,nvme_fabrics
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.002s
user	0m0.001s
sys	0m0.001s
+ rm -fr '/sys/kernel/config/nvmet/ports/1/subsystems/*'
+ rmdir /sys/kernel/config/nvmet/ports/1
rmdir: failed to remove '/sys/kernel/config/nvmet/ports/1': No such file or directory
+ for subsys in /sys/kernel/config/nvmet/subsystems/*
+ for ns in ${subsys}/namespaces/*
+ echo 0
./delete.sh: line 14: /sys/kernel/config/nvmet/subsystems/*/namespaces/*/enable: No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*/namespaces/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*/namespaces/*': No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*': No such file or directory
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ echo '############################## DELETE #############################'
############################## DELETE #############################
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_loop
+ lsmod
+ grep nvme
nvme_tcp               90112  0
nvme_fabrics           40960  1 nvme_tcp
nvme_keyring           20480  2 nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  3 nvme_tcp,nvme,nvme_fabrics
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvmet
+ lsmod
+ grep nvme
nvme_tcp               90112  0
nvme_fabrics           40960  1 nvme_tcp
nvme_keyring           20480  2 nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  3 nvme_tcp,nvme,nvme_fabrics
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_tcp
+ lsmod
+ grep nvme
nvme                   69632  0
nvme_core             233472  1 nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_fabrics
+ lsmod
+ grep nvme
nvme                   69632  0
nvme_core             233472  1 nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme
+ lsmod
+ grep nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_core
+ lsmod
+ grep nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_keryring
modprobe: FATAL: Module nvme_keryring not found.
+ lsmod
+ grep nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r nvme_auth
modprobe: FATAL: Module nvme_auth not found.
+ lsmod
+ grep nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth null_blk
+ modprobe -r null_blk
+ lsmod
+ grep nvme
+ tree /sys/kernel/config
/sys/kernel/config
└── pci_ep
    ├── controllers
    └── functions

3 directories, 0 files
+ echo '############################## UNLOAD #############################'
############################## UNLOAD #############################
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_loop unload '
### nvme_loop unload 
+ modprobe -r nvme_loop
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvmet unload '
### nvmet unload 
+ modprobe -r nvmet
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_tcp unload '
### nvme_tcp unload 
+ modprobe -r nvme_tcp
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_fabrics unload '
### nvme_fabrics unload 
+ modprobe -r nvme_fabrics
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme unload '
### nvme unload 
+ modprobe -r nvme
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_core unload '
### nvme_core unload 
+ modprobe -r nvme_core
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_keryring unload '
### nvme_keryring unload 
+ modprobe -r nvme_keryring
modprobe: FATAL: Module nvme_keryring not found.
+ for mod in nvme_loop nvmet nvme_tcp nvme_fabrics nvme nvme_core nvme_keryring nvme_auth
+ echo '### nvme_auth unload '
### nvme_auth unload 
+ modprobe -r nvme_auth
modprobe: FATAL: Module nvme_auth not found.
+ sleep 1
cdblkt+ lsmod
+ grep nvme
+ git diff
+ getopts :cw option
++ nproc
+ make -j 48 M=drivers/nvme/ modules
make[1]: Entering directory '/mnt/data100G/nvme/drivers/nvme'
e	make[1]: Leaving directory '/mnt/data100G/nvme/drivers/nvme'
+ install
++ uname -r
+ LIB=/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
+ HOST_DEST=/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host/
+ TARGET_DEST=/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-pci-epf.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host/ /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target//
/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host/:
total 9.0M
-rw-r--r--. 1 root root 4.2M Nov  3 23:46 nvme-core.ko
-rw-r--r--. 1 root root 592K Nov  3 23:46 nvme-fabrics.ko
-rw-r--r--. 1 root root 1.2M Nov  3 23:46 nvme-fc.ko
-rw-r--r--. 1 root root 929K Nov  3 23:46 nvme.ko
-rw-r--r--. 1 root root 1.2M Nov  3 23:46 nvme-rdma.ko
-rw-r--r--. 1 root root 1.2M Nov  3 23:46 nvme-tcp.ko

/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target//:
total 9.9M
-rw-r--r--. 1 root root  660K Nov  3 23:46 nvme-fcloop.ko
-rw-r--r--. 1 root root  563K Nov  3 23:46 nvme-loop.ko
-rw-r--r--. 1 root root 1009K Nov  3 23:46 nvmet-fc.ko
-rw-r--r--. 1 root root  4.9M Nov  3 23:46 nvmet.ko
-rw-r--r--. 1 root root  765K Nov  3 23:46 nvmet-pci-epf.ko
-rw-r--r--. 1 root root  1.1M Nov  3 23:46 nvmet-rdma.ko
-rw-r--r--. 1 root root  994K Nov  3 23:46 nvmet-tcp.ko
+ sync
+ modprobe nvme-core
+ modprobe nvme
+ modprobe nvme-fabrics
+ modprobe nvme-tcp
+ modprobe nvme_loop
+ modprobe nvmet
+ lsmod
+ grep nvme
nvme_loop              20480  0
nvmet                 237568  1 nvme_loop
nvme_tcp               90112  0
nvme_fabrics           40960  2 nvme_tcp,nvme_loop
nvme_keyring           20480  3 nvmet,nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  5 nvmet,nvme_tcp,nvme,nvme_loop,nvme_fabrics
nvme (nvme-6.19) # cdblktests 
blktests (master) # sh test-nvme.sh 
+ for t in loop tcp
+ echo '################nvme_trtype=loop############'
################nvme_trtype=loop############
+ nvme_trtype=loop
+ ./check nvme
nvme/002 (tr=loop) (create many subsystems and test discovery) [passed]
    runtime  45.859s  ...  43.717s
nvme/003 (tr=loop) (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.229s  ...  10.226s
nvme/004 (tr=loop) (test nvme and nvmet UUID NS descriptors) [passed]
    runtime  0.796s  ...  0.800s
nvme/005 (tr=loop) (reset local loopback target)             [passed]
    runtime  1.384s  ...  1.396s
nvme/006 (tr=loop bd=device) (create an NVMeOF target)       [passed]
    runtime  0.096s  ...  0.092s
nvme/006 (tr=loop bd=file) (create an NVMeOF target)         [passed]
    runtime  0.069s  ...  0.069s
nvme/006 (tr=loop bd=mem) (create an NVMeOF target)          [passed]
    runtime  0.074s  ...  0.072s
nvme/008 (tr=loop bd=device) (create an NVMeOF host)         [passed]
    runtime  0.814s  ...  0.804s
nvme/008 (tr=loop bd=file) (create an NVMeOF host)           [passed]
    runtime  0.772s  ...  0.790s
nvme/008 (tr=loop bd=mem) (create an NVMeOF host)            [passed]
    runtime  0.781s  ...  0.807s
nvme/010 (tr=loop bd=device) (run data verification fio job) [passed]
    runtime  77.849s  ...  74.891s
nvme/010 (tr=loop bd=file) (run data verification fio job)   [passed]
    runtime  151.337s  ...  152.352s
nvme/010 (tr=loop bd=mem) (run data verification fio job)    [passed]
    runtime  5.068s  ...  4.953s
nvme/012 (tr=loop bd=device) (run mkfs and data verification fio) [passed]
    runtime  70.436s  ...  73.367s
nvme/012 (tr=loop bd=file) (run mkfs and data verification fio) [passed]
    runtime  134.884s  ...  137.229s
nvme/012 (tr=loop bd=mem) (run mkfs and data verification fio) [passed]
    runtime  15.360s  ...  14.633s
nvme/014 (tr=loop bd=device) (flush a command from host)     [passed]
    runtime  8.608s  ...  10.393s
nvme/014 (tr=loop bd=file) (flush a command from host)       [passed]
    runtime  7.614s  ...  7.489s
nvme/014 (tr=loop bd=mem) (flush a command from host)        [passed]
    runtime  5.053s  ...  5.201s
nvme/016 (tr=loop) (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  34.080s  ...  33.866s
nvme/017 (tr=loop) (create/delete many file-ns and test discovery) [passed]
    runtime  35.291s  ...  35.260s
nvme/018 (tr=loop) (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.768s  ...  0.766s
nvme/019 (tr=loop bd=device) (test NVMe DSM Discard command) [passed]
    runtime  0.795s  ...  0.809s
nvme/019 (tr=loop bd=file) (test NVMe DSM Discard command)   [passed]
    runtime  0.766s  ...  0.770s
nvme/019 (tr=loop bd=mem) (test NVMe DSM Discard command)    [passed]
    runtime  0.771s  ...  0.774s
nvme/021 (tr=loop bd=device) (test NVMe list command)        [passed]
    runtime  0.794s  ...  0.800s
nvme/021 (tr=loop bd=file) (test NVMe list command)          [passed]
    runtime  0.771s  ...  0.798s
nvme/021 (tr=loop bd=mem) (test NVMe list command)           [passed]
    runtime  0.779s  ...  0.768s
nvme/022 (tr=loop bd=device) (test NVMe reset command)       [passed]
    runtime  1.376s  ...  1.366s
nvme/022 (tr=loop bd=file) (test NVMe reset command)         [passed]
    runtime  1.361s  ...  1.335s
nvme/022 (tr=loop bd=mem) (test NVMe reset command)          [passed]
    runtime  1.374s  ...  1.245s
nvme/023 (tr=loop bd=device) (test NVMe smart-log command)   [passed]
    runtime  0.783s  ...  0.806s
nvme/023 (tr=loop bd=file) (test NVMe smart-log command)     [passed]
    runtime  0.757s  ...  0.783s
nvme/023 (tr=loop bd=mem) (test NVMe smart-log command)      [passed]
    runtime  0.790s  ...  0.792s
nvme/025 (tr=loop bd=device) (test NVMe effects-log)         [passed]
    runtime  0.796s  ...  0.791s
nvme/025 (tr=loop bd=file) (test NVMe effects-log)           [passed]
    runtime  0.797s  ...  0.771s
nvme/025 (tr=loop bd=mem) (test NVMe effects-log)            [passed]
    runtime  0.784s  ...  0.777s
nvme/026 (tr=loop bd=device) (test NVMe ns-descs)            [passed]
    runtime  0.794s  ...  0.805s
nvme/026 (tr=loop bd=file) (test NVMe ns-descs)              [passed]
    runtime  0.765s  ...  0.775s
nvme/026 (tr=loop bd=mem) (test NVMe ns-descs)               [passed]
    runtime  0.791s  ...  0.789s
nvme/027 (tr=loop bd=device) (test NVMe ns-rescan command)   [passed]
    runtime  0.820s  ...  0.831s
nvme/027 (tr=loop bd=file) (test NVMe ns-rescan command)     [passed]
    runtime  0.786s  ...  0.795s
nvme/027 (tr=loop bd=mem) (test NVMe ns-rescan command)      [passed]
    runtime  0.795s  ...  0.812s
nvme/028 (tr=loop bd=device) (test NVMe list-subsys)         [passed]
    runtime  0.775s  ...  0.786s
nvme/028 (tr=loop bd=file) (test NVMe list-subsys)           [passed]
    runtime  0.765s  ...  0.755s
nvme/028 (tr=loop bd=mem) (test NVMe list-subsys)            [passed]
    runtime  0.762s  ...  0.776s
nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.921s  ...  0.906s
nvme/030 (tr=loop) (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.466s  ...  0.475s
nvme/031 (tr=loop) (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  7.590s  ...  7.470s
nvme/038 (tr=loop) (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.017s  ...  0.016s
nvme/040 (tr=loop) (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.792s  ...  7.836s
nvme/041 (tr=loop) (Create authenticated connections)        [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/042 (tr=loop) (Test dhchap key types for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/043 (tr=loop) (Test hash and DH group variations for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/044 (tr=loop) (Test bi-directional authentication)      [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/045 (tr=loop) (Test re-authentication)                  [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/047 (tr=loop) (test different queue types for fabric transports) [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (tr=loop) (Test queue count changes on reconnect)   [not run]
    nvme_trtype=loop is not supported in this test
nvme/051 (tr=loop) (test nvmet concurrent ns enable/disable) [passed]
    runtime  4.137s  ...  3.832s
nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [passed]
    runtime  6.018s  ...  5.973s
nvme/054 (tr=loop) (Test the NVMe reservation feature)       [passed]
    runtime  0.809s  ...  0.809s
nvme/055 (tr=loop) (Test nvme write to a loop target ns just after ns is disabled) [passed]
    runtime  0.802s  ...  0.792s
nvme/056 (tr=loop) (enable zero copy offload and run rw traffic) [not run]
    Remote target required but NVME_TARGET_CONTROL is not set
    nvme_trtype=loop is not supported in this test
    kernel option ULP_DDP has not been enabled
    module nvme_tcp does not have parameter ddp_offload
    KERNELSRC not set
    Kernel sources do not have tools/net/ynl/cli.py
    NVME_IFACE not set
nvme/057 (tr=loop) (test nvme fabrics controller ANA failover during I/O) [passed]
    runtime  31.640s  ...  31.473s
nvme/058 (tr=loop) (test rapid namespace remapping)          [passed]
    runtime  6.870s  ...  5.595s
nvme/060 (tr=loop) (test nvme fabrics target reset)          [not run]
    nvme_trtype=loop is not supported in this test
nvme/061 (tr=loop) (test fabric target teardown and setup during I/O) [not run]
    nvme_trtype=loop is not supported in this test
nvme/062 (tr=loop) (Create TLS-encrypted connections)        [not run]
    nvme_trtype=loop is not supported in this test
    command tlshd is not available
    systemctl unit 'tlshd' is missing
    Install ktls-utils for tlshd
nvme/063 (tr=loop) (Create authenticated TCP connections with secure concatenation) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
    nvme_trtype=loop is not supported in this test
    command tlshd is not available
    systemctl unit 'tlshd' is missing
    Install ktls-utils for tlshd
nvme/065 (test unmap write zeroes sysfs interface with nvmet devices) [passed]
    runtime  2.754s  ...  2.780s
+ for t in loop tcp
+ echo '################nvme_trtype=tcp############'
################nvme_trtype=tcp############
+ nvme_trtype=tcp
+ ./check nvme
nvme/002 (tr=tcp) (create many subsystems and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/003 (tr=tcp) (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.260s  ...  10.276s
nvme/004 (tr=tcp) (test nvme and nvmet UUID NS descriptors)  [passed]
    runtime  0.291s  ...  0.304s
nvme/005 (tr=tcp) (reset local loopback target)              [passed]
    runtime  0.373s  ...  0.380s
nvme/006 (tr=tcp bd=device) (create an NVMeOF target)        [passed]
    runtime  0.100s  ...  0.095s
nvme/006 (tr=tcp bd=file) (create an NVMeOF target)          [passed]
    runtime  0.076s  ...  0.075s
nvme/006 (tr=tcp bd=mem) (create an NVMeOF target)           [passed]
    runtime  0.078s  ...  0.085s
nvme/008 (tr=tcp bd=device) (create an NVMeOF host)          [passed]
    runtime  0.381s  ...  0.761s
nvme/008 (tr=tcp bd=file) (create an NVMeOF host)            [passed]
    runtime  0.274s  ...  0.280s
nvme/008 (tr=tcp bd=mem) (create an NVMeOF host)             [passed]
    runtime  0.270s  ...  0.282s
nvme/010 (tr=tcp bd=device) (run data verification fio job)  [passed]
    runtime  87.044s  ...  87.870s
nvme/010 (tr=tcp bd=file) (run data verification fio job)    [passed]
    runtime  152.540s  ...  149.576s
nvme/010 (tr=tcp bd=mem) (run data verification fio job)     [passed]
    runtime  17.433s  ...  17.207s
nvme/012 (tr=tcp bd=device) (run mkfs and data verification fio) [passed]
    runtime  80.288s  ...  76.660s
nvme/012 (tr=tcp bd=file) (run mkfs and data verification fio) [passed]
    runtime  142.149s  ...  133.708s
nvme/012 (tr=tcp bd=mem) (run mkfs and data verification fio) [passed]
    runtime  27.757s  ...  27.869s
nvme/014 (tr=tcp bd=device) (flush a command from host)      [passed]
    runtime  7.771s  ...  7.752s
nvme/014 (tr=tcp bd=file) (flush a command from host)        [passed]
    runtime  7.055s  ...  7.014s
nvme/014 (tr=tcp bd=mem) (flush a command from host)         [passed]
    runtime  4.650s  ...  4.561s
nvme/016 (tr=tcp) (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/017 (tr=tcp) (create/delete many file-ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/018 (tr=tcp) (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.263s  ...  0.270s
nvme/019 (tr=tcp bd=device) (test NVMe DSM Discard command)  [passed]
    runtime  0.277s  ...  0.290s
nvme/019 (tr=tcp bd=file) (test NVMe DSM Discard command)    [passed]
    runtime  0.257s  ...  0.276s
nvme/019 (tr=tcp bd=mem) (test NVMe DSM Discard command)     [passed]
    runtime  0.261s  ...  0.283s
nvme/021 (tr=tcp bd=device) (test NVMe list command)         [passed]
    runtime  0.294s  ...  0.289s
nvme/021 (tr=tcp bd=file) (test NVMe list command)           [passed]
    runtime  0.274s  ...  0.272s
nvme/021 (tr=tcp bd=mem) (test NVMe list command)            [passed]
    runtime  0.255s  ...  0.267s
nvme/022 (tr=tcp bd=device) (test NVMe reset command)        [passed]
    runtime  0.380s  ...  0.410s
nvme/022 (tr=tcp bd=file) (test NVMe reset command)          [passed]
    runtime  0.369s  ...  0.358s
nvme/022 (tr=tcp bd=mem) (test NVMe reset command)           [passed]
    runtime  0.354s  ...  0.357s
nvme/023 (tr=tcp bd=device) (test NVMe smart-log command)    [passed]
    runtime  0.288s  ...  0.288s
nvme/023 (tr=tcp bd=file) (test NVMe smart-log command)      [passed]
    runtime  0.267s  ...  0.251s
nvme/023 (tr=tcp bd=mem) (test NVMe smart-log command)       [passed]
    runtime  0.275s  ...  0.276s
nvme/025 (tr=tcp bd=device) (test NVMe effects-log)          [passed]
    runtime  0.290s  ...  0.296s
nvme/025 (tr=tcp bd=file) (test NVMe effects-log)            [passed]
    runtime  0.278s  ...  0.275s
nvme/025 (tr=tcp bd=mem) (test NVMe effects-log)             [passed]
    runtime  0.290s  ...  0.278s
nvme/026 (tr=tcp bd=device) (test NVMe ns-descs)             [passed]
    runtime  0.302s  ...  0.283s
nvme/026 (tr=tcp bd=file) (test NVMe ns-descs)               [passed]
    runtime  0.259s  ...  0.254s
nvme/026 (tr=tcp bd=mem) (test NVMe ns-descs)                [passed]
    runtime  0.265s  ...  0.259s
nvme/027 (tr=tcp bd=device) (test NVMe ns-rescan command)    [passed]
    runtime  0.339s  ...  0.318s
nvme/027 (tr=tcp bd=file) (test NVMe ns-rescan command)      [passed]
    runtime  0.296s  ...  0.304s
nvme/027 (tr=tcp bd=mem) (test NVMe ns-rescan command)       [passed]
    runtime  0.317s  ...  0.318s
nvme/028 (tr=tcp bd=device) (test NVMe list-subsys)          [passed]
    runtime  0.274s  ...  0.284s
nvme/028 (tr=tcp bd=file) (test NVMe list-subsys)            [passed]
    runtime  0.249s  ...  0.271s
nvme/028 (tr=tcp bd=mem) (test NVMe list-subsys)             [passed]
    runtime  0.269s  ...  0.278s
nvme/029 (tr=tcp) (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.425s  ...  0.438s
nvme/030 (tr=tcp) (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.347s  ...  0.352s
nvme/031 (tr=tcp) (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  2.437s  ...  2.544s
nvme/038 (tr=tcp) (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.022s  ...  0.021s
nvme/040 (tr=tcp) (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  6.404s  ...  6.397s
nvme/041 (tr=tcp) (Create authenticated connections)         [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/042 (tr=tcp) (Test dhchap key types for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/043 (tr=tcp) (Test hash and DH group variations for authenticated connections) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/044 (tr=tcp) (Test bi-directional authentication)       [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/045 (tr=tcp) (Test re-authentication)                   [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
nvme/047 (tr=tcp) (test different queue types for fabric transports) [passed]
    runtime  1.195s  ...  1.197s
nvme/048 (tr=tcp) (Test queue count changes on reconnect)    [passed]
    runtime  6.368s  ...  6.361s
nvme/051 (tr=tcp) (test nvmet concurrent ns enable/disable)  [passed]
    runtime  4.473s  ...  3.472s
nvme/052 (tr=tcp) (Test file-ns creation/deletion under one subsystem) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/054 (tr=tcp) (Test the NVMe reservation feature)        [passed]
    runtime  0.311s  ...  0.317s
nvme/055 (tr=tcp) (Test nvme write to a loop target ns just after ns is disabled) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/056 (tr=tcp) (enable zero copy offload and run rw traffic) [not run]
    Remote target required but NVME_TARGET_CONTROL is not set
    kernel option ULP_DDP has not been enabled
    module nvme_tcp does not have parameter ddp_offload
    KERNELSRC not set
    Kernel sources do not have tools/net/ynl/cli.py
    NVME_IFACE not set
nvme/057 (tr=tcp) (test nvme fabrics controller ANA failover during I/O) [passed]
    runtime  28.377s  ...  28.039s
nvme/058 (tr=tcp) (test rapid namespace remapping)           [passed]
    runtime  4.421s  ...  3.264s
nvme/060 (tr=tcp) (test nvme fabrics target reset)           [passed]
    runtime  19.087s  ...  19.643s
nvme/061 (tr=tcp) (test fabric target teardown and setup during I/O) [passed]
    runtime  8.446s  ...  8.344s
nvme/062 (tr=tcp) (Create TLS-encrypted connections)         [not run]
    command tlshd is not available
    systemctl unit 'tlshd' is missing
    Install ktls-utils for tlshd
nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation) [not run]
    kernel option NVME_AUTH has not been enabled
    kernel option NVME_TARGET_AUTH has not been enabled
    nvme-fabrics does not support dhchap_ctrl_secret
    command tlshd is not available
    systemctl unit 'tlshd' is missing
    Install ktls-utils for tlshd
nvme/065 (test unmap write zeroes sysfs interface with nvmet devices) [passed]
    runtime  2.780s  ...  2.779s
blktests (master) # 

-- 
2.40.0


