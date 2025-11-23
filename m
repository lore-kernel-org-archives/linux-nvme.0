Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C8DCFA46B
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WSGdlk2npRpR+WxnypEnvk96mB0eVW6HgkGdusX5wE4=; b=RpBmVKKusZDL5trk/sRWXsKRgy
	QEd7byoLnCzB8Fv1x2CDli5r9djvJAPfh36KtPRXe40RyA7JzAesPxwHVrHQSKtAEwDHLu6YaRcoE
	dmVWr55Is76NJO2SHuXP8FlXtJhFU7NI3hHvoUqWeNL5A9hevlrs0a17RG8UN/31BenZbvWwVYZ6X
	i8gxoNS0ALQAQEwzncDubWMBSGjPmNxkiKANSRF6RRCwA00KKVYIKkawWAN/nngqEWjdBh5Fb3o2U
	zSBcDT6+W84c5u3lnbN1jTVp+NhXjKkN4TkO6x/ZqGNTmrwlIY17kf2Z2k7O6gh5pftXwdXrMdAyL
	hfEsHvQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNFc1-0000000Adwn-0yII;
	Sun, 23 Nov 2025 19:19:05 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNFby-0000000Adw8-0Rh8
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 19:19:03 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so2458662a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763925541; x=1764530341; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGdlk2npRpR+WxnypEnvk96mB0eVW6HgkGdusX5wE4=;
        b=Ac6drBgH4zbd1gl58Q8uSIMCo12pEzn3HUw/7EV1OM0STZSFfTmZ1R7pv4nlrEDIzC
         fVLCi3dOAVT5H/J9LiMN3i1MfRaVVKix4VYyRXLtFLKSwWJgVD1pU0pgD/trX+0dDdra
         LC59Q8DpvEukgfj0RyVaFnBU1npDk03QYW5IGoyDtNvXnmWpreFN0CI5nTZBOp/dPrxq
         PJcUEHczBKOmtdTLW4eyrrMbIRBJALiGTryLEaSl8UNqEJGQgaqHLtqw8C/QZ+dktl6N
         vklJM7X7ExWrhzHVS3DnXyPWfY1TyyMPF5EaBylBMgBrZVQzGlVRgtPVqa1y4uD7Q6kA
         X6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763925541; x=1764530341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSGdlk2npRpR+WxnypEnvk96mB0eVW6HgkGdusX5wE4=;
        b=ms7273ZLRpZXdrkactzW78LU8bqO1Y0XQa8QIYsb0ybyxf03j35wNSpaly+ZaEydUK
         3eko1w5E/GPul4qpaPReVMrlI60wTp4kKhD4BDv7YBexQeN8P7E+e79uvYgQla53jH3l
         getInCswDrPtUnnno30kDJCYh43V2fGr227IbFFW3ly0NMUsf/kTXdq7oZbBzLEeGDYl
         hKQ/gm2a79IRLrxbliKieTV1RG5oN6ReGduSos/tcr5Hd3TFNuZq8bxOBgsAVPX4YK2Q
         IMXI38MJ5Tta+WuFib33D/bPrilzayvDtYOsnxxEzTnHfX0aMOJHkA2q+nVMeqN+W0Ws
         wlVQ==
X-Gm-Message-State: AOJu0YzJPd2u8c5qCoE6KVpUvCWVwPPRV0q5gCcWfDjwzuLLBnu4g/I8
	RxlwytH+LIYfLrGZjHOYa3JwtqdIcMpjvy+msU1ZfG8hhBryiV4QujM1A2GXQw==
X-Gm-Gg: ASbGncuVZMCdw8PI1la0n5TFGL6Gg7Xd7n2HtU4aTz7Eul9cGaMX2M2S/hoEShoBAjc
	L/vJCuerObVEUP51ngBe7IPZXuOFqXv5SPBqIoYn8LFA5dS0RL8vKPn6sIK6uWoce1uk4BVmEl/
	ExzpHmUnwI8Fk7+wqCYT2H4k5oVbO/8WfVWURBUnOh+fu9XhIpHcGAgpYPfbGB7cwct1Nu0u2VZ
	AafLP5uUeL82yAjkI1+whNh5ZeCu9mJwizZHKPqCIaf0jJjPPfSO/wpyIONuzE25vt4Dqr4xgDW
	hxG/aKzHdB6xz/ve/Kl00Xvw6wTmQE+JaX/oEGx5WI8zETKvfR2YmdC5D2ZrTstaQ43ZdEry1rd
	xTJgcsv3SXivVP/oXOgiXogKbhB/JxBw6GAhtYvEnbWeNylkMJDeFFhbxW3ZKCQkPJvRAC5g4kN
	LFsVdpJXWKLQTac8zQ8u06rYZ+q8zsfj/B+/LtGjGK+VIpMWk=
X-Google-Smtp-Source: AGHT+IGcMUGhvAP5A4p75aokEZM9midBlQEMdYMMYQC1xlybmF+FUtA5vgnBB+p65Z1YNX7BzteOyQ==
X-Received: by 2002:a05:7301:fc0e:b0:2a4:7599:29fb with SMTP id 5a478bee46e88-2a719c2944dmr4527140eec.36.1763925540763;
        Sun, 23 Nov 2025 11:19:00 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc204881sm50717584eec.0.2025.11.23.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:19:00 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 0/2] nvme: blktests bug fix for 6.19
Date: Sun, 23 Nov 2025 11:18:56 -0800
Message-Id: <20251123191858.69957-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_111902_177858_803D40F4 
X-CRM114-Status: GOOD (  12.01  )
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

While testing my discard return value series I discovered two blktests
failures, here are two fixes, below blktest testing after these patches.

-ck

Chaitanya Kulkarni (2):
  nvme-tcp: use __fput_sync() to avoid use-after-free on reset
  nvme-multipath: clear BIO_QOS flags on requeue

 drivers/nvme/host/multipath.c | 10 ++++++++++
 drivers/nvme/host/tcp.c       |  9 +++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

nvme (nvme-6.19) # gitlog -3
0e53aeec7e61 (HEAD -> nvme-6.19) nvme-multipath: clear BIO_QOS flags on requeue
d0147be50d71 nvme-tcp: use __fput_sync() to avoid use-after-free on reset
1c2ad96dbb33 (origin/nvme-6.19) nvme: Fix typo error in nvme target
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # ./compile_nvme.sh
+ unload
+ sh ./unload-vfio-nvme.sh
rmmod: ERROR: Module drivers/vfio/pci/nvme/nvme_vfio_pci is not currently loaded
rmmod: ERROR: Module vfio_pci is not currently loaded
rmmod: ERROR: Module vfio_pci_core is not currently loaded
rmmod: ERROR: Module vfio_iommu_type1 is not currently loaded
rmmod: ERROR: Module vfio is not currently loaded
############################## UNLOAD #############################
nvme_loop              20480  0
nvmet                 221184  1 nvme_loop
nvme_tcp               90112  0
nvme_fabrics           40960  2 nvme_tcp,nvme_loop
nvme_keyring           20480  3 nvmet,nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  5 nvmet,nvme_tcp,nvme,nvme_loop,nvme_fabrics
umount: /mnt/nvme0n1: no mount point specified.
NQN:testnqn disconnected 0 controller(s)

real	0m0.011s
user	0m0.001s
sys	0m0.010s
rmdir: failed to remove '/sys/kernel/config/nvmet/ports/1': No such file or directory
./delete.sh: line 14: /sys/kernel/config/nvmet/subsystems/*/namespaces/*/enable: No such file or directory
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*/namespaces/*': No such file or directory
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*': No such file or directory
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
umount: /mnt/nvme0n1: no mount point specified.
umount: /mnt/backend: not mounted.
############################## DELETE #############################
nvme_tcp               90112  0
nvme_fabrics           40960  1 nvme_tcp
nvme_keyring           20480  2 nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  3 nvme_tcp,nvme,nvme_fabrics
nvme_tcp               90112  0
nvme_fabrics           40960  1 nvme_tcp
nvme_keyring           20480  2 nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  3 nvme_tcp,nvme,nvme_fabrics
nvme                   69632  0
nvme_core             233472  1 nvme
nvme                   69632  0
nvme_core             233472  1 nvme
modprobe: FATAL: Module nvme_keryring not found.
modprobe: FATAL: Module nvme_auth not found.

3 directories, 0 files
############################## UNLOAD #############################
### nvme_loop unload 
### nvmet unload 
### nvme_tcp unload 
### nvme_fabrics unload 
### nvme unload 
### nvme_core unload 
### nvme_keryring unload 
### nvme_auth unload 
modprobe: FATAL: Module nvme_auth not found.

make[1]: Entering directory '/mnt/data100G/nvme/drivers/nvme'
make[1]: Leaving directory '/mnt/data100G/nvme/drivers/nvme'
+ ls -lrth /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host/ /lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target//
/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/host/:
total 7.9M
-rw-r--r--. 1 root root 4.2M Nov 23 10:21 nvme-core.ko
-rw-r--r--. 1 root root 592K Nov 23 10:21 nvme-fabrics.ko
-rw-r--r--. 1 root root 1.2M Nov 23 10:21 nvme-fc.ko
-rw-r--r--. 1 root root 929K Nov 23 10:21 nvme.ko
-rw-r--r--. 1 root root 1.2M Nov 23 10:21 nvme-tcp.ko

/lib/modules/6.17.0-rc3nvme+/kernel/drivers/nvme/target//:
total 9.5M
-rw-r--r--. 1 root root  660K Nov 23 10:21 nvme-fcloop.ko
-rw-r--r--. 1 root root  562K Nov 23 10:21 nvme-loop.ko
-rw-r--r--. 1 root root 1009K Nov 23 10:21 nvmet-fc.ko
-rw-r--r--. 1 root root  4.6M Nov 23 10:21 nvmet.ko
-rw-r--r--. 1 root root  765K Nov 23 10:21 nvmet-pci-epf.ko
-rw-r--r--. 1 root root  1.1M Nov 23 10:21 nvmet-rdma.ko
-rw-r--r--. 1 root root  992K Nov 23 10:21 nvmet-tcp.ko
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
nvmet                 221184  1 nvme_loop
nvme_tcp               90112  0
nvme_fabrics           40960  2 nvme_tcp,nvme_loop
nvme_keyring           20480  3 nvmet,nvme_tcp,nvme_fabrics
nvme                   69632  0
nvme_core             233472  5 nvmet,nvme_tcp,nvme,nvme_loop,nvme_fabrics
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # 
nvme (nvme-6.19) # cdblktests 
blktests (master) # 
blktests (master) # 
blktests (master) # 
blktests (master) # 
blktests (master) # 

blktests (master) # ./test-nvme.sh
++ for t in loop tcp
++ echo '################nvme_trtype=loop############'
################nvme_trtype=loop############
++ nvme_img_size=900M
++ nvme_num_iter=1
++ nvme_trtype=loop
++ ./check nvme
nvme/002 (tr=loop) (create many subsystems and test discovery) [passed]
    runtime  40.593s  ...  41.344s
nvme/003 (tr=loop) (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.256s  ...  10.266s
nvme/004 (tr=loop) (test nvme and nvmet UUID NS descriptors) [passed]
    runtime  0.893s  ...  0.911s
nvme/005 (tr=loop) (reset local loopback target)             [passed]
    runtime  1.449s  ...  1.482s
nvme/006 (tr=loop bd=device) (create an NVMeOF target)       [passed]
    runtime  0.119s  ...  0.112s
nvme/006 (tr=loop bd=file) (create an NVMeOF target)         [passed]
    runtime  0.082s  ...  0.078s
nvme/008 (tr=loop bd=device) (create an NVMeOF host)         [passed]
    runtime  0.907s  ...  0.909s
nvme/008 (tr=loop bd=file) (create an NVMeOF host)           [passed]
    runtime  0.879s  ...  0.867s
nvme/010 (tr=loop bd=device) (run data verification fio job) [passed]
    runtime  38.757s  ...  71.268s
nvme/010 (tr=loop bd=file) (run data verification fio job)   [passed]
    runtime  101.443s  ...  175.439s
nvme/012 (tr=loop bd=device) (run mkfs and data verification fio) [passed]
    runtime  37.683s  ...  82.689s
nvme/012 (tr=loop bd=file) (run mkfs and data verification fio) [passed]
    runtime  81.227s  ...  156.973s
nvme/014 (tr=loop bd=device) (flush a command from host)     [passed]
    runtime  6.871s  ...  15.076s
nvme/014 (tr=loop bd=file) (flush a command from host)       [passed]
    runtime  6.281s  ...  10.713s
nvme/016 (tr=loop) (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  0.165s  ...  0.162s
nvme/017 (tr=loop) (create/delete many file-ns and test discovery) [passed]
    runtime  0.164s  ...  0.162s
nvme/018 (tr=loop) (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.849s  ...  0.852s
nvme/019 (tr=loop bd=device) (test NVMe DSM Discard command) [passed]
    runtime  0.892s  ...  0.871s
nvme/019 (tr=loop bd=file) (test NVMe DSM Discard command)   [passed]
    runtime  0.865s  ...  0.849s
nvme/021 (tr=loop bd=device) (test NVMe list command)        [passed]
    runtime  0.971s  ...  0.887s
nvme/021 (tr=loop bd=file) (test NVMe list command)          [passed]
    runtime  0.903s  ...  0.857s
nvme/022 (tr=loop bd=device) (test NVMe reset command)       [passed]
    runtime  1.506s  ...  1.507s
nvme/022 (tr=loop bd=file) (test NVMe reset command)         [passed]
    runtime  1.441s  ...  1.450s
nvme/023 (tr=loop bd=device) (test NVMe smart-log command)   [passed]
    runtime  0.887s  ...  0.871s
nvme/023 (tr=loop bd=file) (test NVMe smart-log command)     [passed]
    runtime  0.849s  ...  0.872s
nvme/025 (tr=loop bd=device) (test NVMe effects-log)         [passed]
    runtime  0.883s  ...  0.916s
nvme/025 (tr=loop bd=file) (test NVMe effects-log)           [passed]
    runtime  0.855s  ...  0.862s
nvme/026 (tr=loop bd=device) (test NVMe ns-descs)            [passed]
    runtime  0.874s  ...  0.892s
nvme/026 (tr=loop bd=file) (test NVMe ns-descs)              [passed]
    runtime  0.857s  ...  0.895s
nvme/027 (tr=loop bd=device) (test NVMe ns-rescan command)   [passed]
    runtime  0.910s  ...  0.930s
nvme/027 (tr=loop bd=file) (test NVMe ns-rescan command)     [passed]
    runtime  0.887s  ...  0.891s
nvme/028 (tr=loop bd=device) (test NVMe list-subsys)         [passed]
    runtime  0.884s  ...  0.899s
nvme/028 (tr=loop bd=file) (test NVMe list-subsys)           [passed]
    runtime  0.858s  ...  0.851s
nvme/029 (tr=loop) (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.111s  ...  1.108s
nvme/030 (tr=loop) (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.524s  ...  0.551s
nvme/031 (tr=loop) (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  8.303s  ...  8.372s
nvme/038 (tr=loop) (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.029s  ...  0.029s
nvme/040 (tr=loop) (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.817s  ...  7.811s
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
    runtime  2.157s  ...  2.184s
nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [passed]
    runtime  6.443s  ...  6.458s
nvme/054 (tr=loop) (Test the NVMe reservation feature)       [passed]
    runtime  0.937s  ...  0.933s
nvme/055 (tr=loop) (Test nvme write to a loop target ns just after ns is disabled) [passed]
    runtime  0.917s  ...  0.924s
nvme/056 (tr=loop) (enable zero copy offload and run rw traffic) [not run]
    Remote target required but NVME_TARGET_CONTROL is not set
    nvme_trtype=loop is not supported in this test
    kernel option ULP_DDP has not been enabled
    module nvme_tcp does not have parameter ddp_offload
    KERNELSRC not set
    Kernel sources do not have tools/net/ynl/cli.py
    NVME_IFACE not set
nvme/057 (tr=loop) (test nvme fabrics controller ANA failover during I/O) [passed]
    runtime  37.234s  ...  29.876s
nvme/058 (tr=loop) (test rapid namespace remapping)          [passed]
    runtime  8.093s  ...  7.385s
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
nvme/065 (test unmap write zeroes sysfs interface with nvmet devices) [not run]
    driver scsi_debug is not available
++ for t in loop tcp
++ echo '################nvme_trtype=tcp############'
################nvme_trtype=tcp############
++ nvme_img_size=900M
++ nvme_num_iter=1
++ nvme_trtype=tcp
++ ./check nvme
nvme/002 (tr=tcp) (create many subsystems and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/003 (tr=tcp) (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.267s  ...  10.260s
nvme/004 (tr=tcp) (test nvme and nvmet UUID NS descriptors)  [passed]
    runtime  0.405s  ...  0.410s
nvme/005 (tr=tcp) (reset local loopback target)              [passed]
    runtime  0.507s  ...  0.505s
nvme/006 (tr=tcp bd=device) (create an NVMeOF target)        [passed]
    runtime  0.121s  ...  0.131s
nvme/006 (tr=tcp bd=file) (create an NVMeOF target)          [passed]
    runtime  0.096s  ...  0.093s
nvme/008 (tr=tcp bd=device) (create an NVMeOF host)          [passed]
    runtime  0.396s  ...  0.408s
nvme/008 (tr=tcp bd=file) (create an NVMeOF host)            [passed]
    runtime  0.378s  ...  0.384s
nvme/010 (tr=tcp bd=device) (run data verification fio job)  [passed]
    runtime  3.971s  ...  101.482s
nvme/010 (tr=tcp bd=file) (run data verification fio job)    [passed]
    runtime  0.984s  ...  149.695s
nvme/012 (tr=tcp bd=device) (run mkfs and data verification fio) [passed]
    runtime  2.220s  ...  111.416s
nvme/012 (tr=tcp bd=file) (run mkfs and data verification fio) [passed]
    runtime    ...  144.534s
nvme/014 (tr=tcp bd=device) (flush a command from host)      [passed]
    runtime  6.669s  ...  12.069s
nvme/014 (tr=tcp bd=file) (flush a command from host)        [passed]
    runtime  6.066s  ...  10.806s
nvme/016 (tr=tcp) (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/017 (tr=tcp) (create/delete many file-ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/018 (tr=tcp) (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  0.374s  ...  0.382s
nvme/019 (tr=tcp bd=device) (test NVMe DSM Discard command)  [passed]
    runtime  0.410s  ...  0.414s
nvme/019 (tr=tcp bd=file) (test NVMe DSM Discard command)    [passed]
    runtime  0.362s  ...  0.383s
nvme/021 (tr=tcp bd=device) (test NVMe list command)         [passed]
    runtime  0.422s  ...  0.413s
nvme/021 (tr=tcp bd=file) (test NVMe list command)           [passed]
    runtime  0.383s  ...  0.383s
nvme/022 (tr=tcp bd=device) (test NVMe reset command)        [passed]
    runtime  0.522s  ...  0.510s
nvme/022 (tr=tcp bd=file) (test NVMe reset command)          [passed]
    runtime  0.473s  ...  0.488s
nvme/023 (tr=tcp bd=device) (test NVMe smart-log command)    [passed]
    runtime  0.405s  ...  0.390s
nvme/023 (tr=tcp bd=file) (test NVMe smart-log command)      [passed]
    runtime  0.368s  ...  0.350s
nvme/025 (tr=tcp bd=device) (test NVMe effects-log)          [passed]
    runtime  0.421s  ...  0.436s
nvme/025 (tr=tcp bd=file) (test NVMe effects-log)            [passed]
    runtime  0.385s  ...  0.382s
nvme/026 (tr=tcp bd=device) (test NVMe ns-descs)             [passed]
    runtime  0.407s  ...  0.397s
nvme/026 (tr=tcp bd=file) (test NVMe ns-descs)               [passed]
    runtime  0.354s  ...  0.367s
nvme/027 (tr=tcp bd=device) (test NVMe ns-rescan command)    [passed]
    runtime  0.432s  ...  0.446s
nvme/027 (tr=tcp bd=file) (test NVMe ns-rescan command)      [passed]
    runtime  0.411s  ...  0.407s
nvme/028 (tr=tcp bd=device) (test NVMe list-subsys)          [passed]
    runtime  0.395s  ...  0.393s
nvme/028 (tr=tcp bd=file) (test NVMe list-subsys)            [passed]
    runtime  0.367s  ...  0.362s
nvme/029 (tr=tcp) (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  0.626s  ...  0.636s
nvme/030 (tr=tcp) (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.376s  ...  0.384s
nvme/031 (tr=tcp) (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.170s  ...  3.217s
nvme/038 (tr=tcp) (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.035s  ...  0.036s
nvme/040 (tr=tcp) (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  6.481s  ...  6.484s
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
    runtime  1.943s  ...  1.936s
nvme/048 (tr=tcp) (Test queue count changes on reconnect)    [passed]
    runtime  5.548s  ...  5.519s
nvme/051 (tr=tcp) (test nvmet concurrent ns enable/disable)  [passed]
    runtime  2.197s  ...  2.234s
nvme/052 (tr=tcp) (Test file-ns creation/deletion under one subsystem) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/054 (tr=tcp) (Test the NVMe reservation feature)        [passed]
    runtime  0.477s  ...  0.453s
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
    runtime  26.300s  ...  31.214s
nvme/058 (tr=tcp) (test rapid namespace remapping)           [passed]
    runtime  4.343s  ...  7.080s
nvme/060 (tr=tcp) (test nvme fabrics target reset)           [passed]
    runtime  19.562s  ...  19.475s
nvme/061 (tr=tcp) (test fabric target teardown and setup during I/O) [passed]
    runtime  8.648s  ...  8.586s
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
nvme/065 (test unmap write zeroes sysfs interface with nvmet devices) [not run]
    driver scsi_debug is not available
blktests (master) #

-- 
2.40.0


