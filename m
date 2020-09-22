Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A7C2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:17:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C09920888
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJ0f4OM4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bmGfn2bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C09920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SCCsXnRMVEnxC0MNK/qrhccjpAl4R/QRu9mcxEP1Kew=; b=EJ0f4OM4sVFkpzGSv19rQElDdD
	qqLp0WEG0Zrh7oSW6ZfitznrF3FGdjLG726WHrdO7NakPuWPY9ZYPe70AIiBBVIHh2sGRIPnXyeNq
	LrKDtY8HR6CMg8fLWn1fXXZ1YWSDoAhvs1Fy+BetuGRu6qLzMwRrNzenFdSVUataN0zEFwGp0vj4k
	DUzPJuiclZ4bT5aVDMiaKrcnAjPTzDq0qT70ZVj46fvGZXNTiA0oZwOt/BaKe4at7ylglmXseVqHT
	K686Lkv777Sm4AJw1P75fY6RmMKgkoKG0GGQYmNri1UeLBjVgrr+sQaGL+A/qiNkDNcom/FKBNzR+
	gIa1nNiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKpfK-0002Sv-LV; Tue, 22 Sep 2020 21:17:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKpfG-0002SK-Gf
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600809450; x=1632345450;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=opv5O1yUkJIaEW+i+u3esLzxe1pibG+IkSMPop+YPWE=;
 b=bmGfn2bXFFYZoymSUjsYQwNoErZsWcoDFw+9XOI8X9yxcPJZn6LuzaZh
 CRIVMbuBpSAhl8+5RahG21zWTXpTXS9L643NGQ9wS1EA6fHnndWGAeZGP
 asPlETiiE7TEmm/3Rw5oyqrZzZC53jWC5na7DMzzhOu4puKCCreeHobAK
 dcBgfVvzczKGPECLTbRNkM0Rr9wL8hunl+WAsH/mG5U6vBOnpjgHVOLr0
 uX4cEnpzAi5u4SdwnXUn7Iu+wsZAI9goW2Ax75njT6GdSiQ6pdLLAxDIX
 pGUNq99sfK2ueYp90RIMykYJ/uDAQoQxlu/Jk7Qwil8RJg76GiJhg2DO0 w==;
IronPort-SDR: 9M2pH1vYu9E+VJKjRreI4JyZEI4//0zmhBjYsnqZhEE7QdMqc5whO2smPUEb1d73RsZfhs+IpN
 w0NXJLvqPxeBfD/mP6nqtQzI2QME33JsEF65qmpPAHeJ4hd4nfxp2cZI1yGRZ42AT/O/Xl9SMW
 tUNbXfRNM8b2Sp2/NX3TC84UBq6fu58y/OV0/ZW284tPkvujSaH6Gj47eIDiXfB0Af0t3LnSLV
 nICx9WlbV5ioNIWgX91KjbeSPMG0qMYgMm/nrsw2RTd5cg1X+xQW8fl0vi5HefwGmWVDzB17FD
 GWk=
X-IronPort-AV: E=Sophos;i="5.77,292,1596470400"; d="scan'208";a="149254317"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 05:17:29 +0800
IronPort-SDR: XmWiRTtPV7xEnEYmOUgufZB2SXx8a/uLvhQgw+cljB8vhsFTD8Az7w7iGnwzCMA/7Susccg1a3
 nEdSfFyad2LA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 14:03:36 -0700
IronPort-SDR: D6nmBlICHnzJEgocTx6qxRADlmbGdUhegORTaJow4mbkPA6d/ml6RzMD+e3EKxSxOM32u/PyF5
 cppe2+hjpHzQ==
WDCIronportException: Internal
Received: from zns.labspan.wdc.com (HELO zns.sc.wdc.com) ([10.6.137.48])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2020 14:17:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/1] nvmet: add ZNS passthru support
Date: Tue, 22 Sep 2020 14:17:17 -0700
Message-Id: <20200922211718.6206-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_171730_990474_66C4F305 
X-CRM114-Status: GOOD (  13.89  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch adds a support for NVMeOF ZNS passthru.

I've tested this with zonefs tests [1] and fio verify test, all the
basic tests seems to pass at this point.

Regards,
Chaitanya

* Changes from RFC :-

1. Rebase and test the code on nvme-5.10 branch.

ZoneFS Test log :-

Passthru Setup :-

cat /sys/kernel/config/nvmet/subsystems/pt/passthru/device_path
/dev/nvme0

# nvme list | tr -s ' ' ' ' 
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme0n1 deadbeef QEMU NVMe Ctrl 1 1.07 GB / 1.07 GB 512 B + 0 B 1.0 
/dev/nvme1n1 deadbeef QEMU NVMe Ctrl 1 1.07 GB / 1.07 GB 512 B + 0 B 1.0 

1. ZoneFS Tests on local ZNS controller :-

 # ./zonefs-tests.sh /dev/nvme0n1  
zonefs-tests on /dev/nvme0n1:
  8 zones (0 conventional zones, 8 sequential zones)
  262144 512B sectors per zone (128 MiB)
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS

43 / 43 tests passed

2. ZoneFS Tests on NVMeOF passthru ZNS controller :-

# ./zonefs-tests.sh /dev/nvme1n1  
zonefs-tests on /dev/nvme1n1:
  8 zones (0 conventional zones, 8 sequential zones)
  262144 512B sectors per zone (128 MiB)
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS

43 / 43 tests passed

3. Fio Verify est on local ZNS controller :-

# blkzone reset /dev/nvme0n1
# fio --name=zbc --filename=/dev/nvme0n1 --direct=1 \
--zonemode=zbd --offset=0 --size=1G --verify=crc32c \
--norandommap --randrepeat=0 --ioengine=libaio --iodepth=2 \
--rw=write --bs=4k
zbc: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
fio-3.23
Starting 1 process
Jobs: 1 (f=1): [V(1)][100.0%][r=78.5MiB/s][r=20.1k IOPS][eta 00m:00s]                 
zbc: (groupid=0, jobs=1): err= 0: pid=5891: Tue Sep 22 14:12:49 2020
  read: IOPS=22.5k, BW=87.7MiB/s (91.0MB/s)(1024MiB/11672msec)
    slat (usec): min=6, max=8227, avg=28.80, stdev=31.86
    clat (usec): min=11, max=8232, avg=58.35, stdev=34.31
     lat (usec): min=40, max=16233, avg=87.33, stdev=49.29
    clat percentiles (usec):
     |  1.00th=[   14],  5.00th=[   27], 10.00th=[   42], 20.00th=[   47],
     | 30.00th=[   51], 40.00th=[   55], 50.00th=[   58], 60.00th=[   62],
     | 70.00th=[   68], 80.00th=[   72], 90.00th=[   78], 95.00th=[   84],
     | 99.00th=[   94], 99.50th=[  100], 99.90th=[  147], 99.95th=[  229],
     | 99.99th=[ 1369]
  write: IOPS=12.5k, BW=48.9MiB/s (51.3MB/s)(1024MiB/20927msec); 0 zone resets
    slat (usec): min=2, max=5430, avg=23.51, stdev=17.70
    clat (usec): min=20, max=57609, avg=134.48, stdev=347.06
     lat (usec): min=66, max=57640, avg=158.20, stdev=350.30
    clat percentiles (usec):
     |  1.00th=[   70],  5.00th=[   92], 10.00th=[   97], 20.00th=[  101],
     | 30.00th=[  103], 40.00th=[  105], 50.00th=[  108], 60.00th=[  110],
     | 70.00th=[  113], 80.00th=[  116], 90.00th=[  123], 95.00th=[  131],
     | 99.00th=[  225], 99.50th=[ 3687], 99.90th=[ 4146], 99.95th=[ 4228],
     | 99.99th=[ 4621]
   bw (  KiB/s): min=39496, max=59097, per=99.57%, avg=49889.90, stdev=4282.32, samples=42
   iops        : min= 9874, max=14774, avg=12472.33, stdev=1070.61, samples=42
  lat (usec)   : 20=1.45%, 50=12.34%, 100=45.22%, 250=40.51%, 500=0.13%
  lat (usec)   : 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.19%, 10=0.14%, 100=0.01%
  cpu          : usr=8.97%, sys=32.57%, ctx=598567, majf=0, minf=6263
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=87.7MiB/s (91.0MB/s), 87.7MiB/s-87.7MiB/s (91.0MB/s-91.0MB/s), io=1024MiB (1074MB), run=11672-11672msec
  WRITE: bw=48.9MiB/s (51.3MB/s), 48.9MiB/s-48.9MiB/s (51.3MB/s-51.3MB/s), io=1024MiB (1074MB), run=20927-20927msec

Disk stats (read/write):
  nvme0n1: ios=262238/261055, merge=0/1089, ticks=16283/29978, in_queue=46261, util=99.58%

4. Fio Verify Test on NVMeOF passthru ZNS controller :-

# blkzone reset /dev/nvme1n1
# fio --name=zbc --filename=/dev/nvme1n1 --direct=1 \
--zonemode=zbd --offset=0 --size=1G --verify=crc32c \
--norandommap --randrepeat=0 --ioengine=libaio --iodepth=2 \
--rw=write --bs=4k
zbc: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
fio-3.23
Starting 1 process
Jobs: 1 (f=1): [f(1)][100.0%][r=79.9MiB/s][r=20.4k IOPS][eta 00m:00s]                  
zbc: (groupid=0, jobs=1): err= 0: pid=5920: Tue Sep 22 14:13:37 2020
  read: IOPS=20.5k, BW=80.0MiB/s (83.9MB/s)(1024MiB/12796msec)
    slat (nsec): min=1092, max=7885.8k, avg=21165.61, stdev=26763.49
    clat (usec): min=8, max=12153, avg=74.35, stdev=71.02
     lat (usec): min=57, max=12297, avg=95.73, stdev=76.20
    clat percentiles (usec):
     |  1.00th=[   34],  5.00th=[   58], 10.00th=[   62], 20.00th=[   67],
     | 30.00th=[   69], 40.00th=[   71], 50.00th=[   73], 60.00th=[   76],
     | 70.00th=[   78], 80.00th=[   80], 90.00th=[   85], 95.00th=[   91],
     | 99.00th=[  115], 99.50th=[  135], 99.90th=[  247], 99.95th=[  351],
     | 99.99th=[ 3163]
  write: IOPS=11.4k, BW=44.5MiB/s (46.6MB/s)(1024MiB/23037msec); 8 zone resets
    slat (usec): min=2, max=4465, avg=23.01, stdev=15.57
    clat (usec): min=29, max=9558, avg=150.97, stdev=291.69
     lat (usec): min=70, max=9579, avg=174.21, stdev=295.29
    clat percentiles (usec):
     |  1.00th=[   84],  5.00th=[  102], 10.00th=[  106], 20.00th=[  111],
     | 30.00th=[  114], 40.00th=[  117], 50.00th=[  120], 60.00th=[  123],
     | 70.00th=[  129], 80.00th=[  149], 90.00th=[  169], 95.00th=[  182],
     | 99.00th=[  255], 99.50th=[ 3425], 99.90th=[ 4178], 99.95th=[ 4228],
     | 99.99th=[ 4424]
   bw (  KiB/s): min=22848, max=53112, per=100.00%, avg=45573.72, stdev=5809.92, samples=46
   iops        : min= 5712, max=13278, avg=11393.35, stdev=1452.45, samples=46
  lat (usec)   : 10=0.01%, 20=0.19%, 50=0.54%, 100=49.83%, 250=48.87%
  lat (usec)   : 500=0.21%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.20%, 10=0.12%, 20=0.01%
  cpu          : usr=11.76%, sys=11.13%, ctx=907150, majf=0, minf=6260
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=80.0MiB/s (83.9MB/s), 80.0MiB/s-80.0MiB/s (83.9MB/s-83.9MB/s), io=1024MiB (1074MB), run=12796-12796msec
  WRITE: bw=44.5MiB/s (46.6MB/s), 44.5MiB/s-44.5MiB/s (46.6MB/s-46.6MB/s), io=1024MiB (1074MB), run=23037-23037msec

Disk stats (read/write):
  nvme1n1: ios=261998/261085, merge=201/1067, ticks=17605/34341, in_queue=51947, util=98.20%

Chaitanya Kulkarni (1):
  nvmet: add passthru ZNS support

 drivers/nvme/target/passthru.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
