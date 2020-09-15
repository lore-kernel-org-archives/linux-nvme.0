Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7AC433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BC520731
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HIjQKqYy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h9WZ88FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BC520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S1dHS4iisTCE8qLdxeLIpfmVc79Lq1GIdXoLSIZtp/s=; b=HIjQKqYyecDcFEScHVCEdHtV80
	T+DVvqdfhLGhffOZAs78DpXFW5UzTFltIpxqRbH9b796soJIshfKIjJa3gocZ2Bs2IIvV7peeebw+
	BjUstTpOVFZQkWUHyDBhg0b186w/CBuq63wrmXsWqw7JKfdAMZwD+iHZCYCirRmSbQnYsQeZLW8tj
	ddkv12kzBM5k6gK9tvRjmMKbiulIUYPBS4/MUdqOQnOehuJHVTOxDGoEVgmQMJxh9LKlYzlfYXjZ+
	Z2Yp+GaYeqs1f3RHN3onXvpAAhZpWXXg8w+60vbOUo9+us7vVx7RseSXOWD+XQh11gNdsc5vMZo1m
	OvZZ2lYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIiW-0000Vb-56; Tue, 15 Sep 2020 21:42:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIiT-0000UT-0U
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206141; x=1631742141;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZxYeJlcV4HEepMM9yBZmdDvAGaiByG6S0Ljrbqkh8MQ=;
 b=h9WZ88FIbVNtwzJHBY4xrZHI7yeS0cmd4pBtrI0JTX4fejRmfP95+q/H
 iSV/bK6CNaTMboBLhtTp4X9c0+R1BvZ2KxkaLyM4FYKcRWk010Old5nMG
 tBlbl8V9cyGu02IWlwNhW24prmSt24eSWo+VTgWHuATijuGe8Dejmr8VR
 HC5+mwOBv9bU5rTg5n4Jm7CT4yWJwpddk0WS5+ed93ybc0tk3lcthb2Y1
 84Uovan8pW/MiETBXzTJrzDC7yeUaX6cpsBhGZplalBoJDAzISuw1Qnvg
 GsybKJHx50vfQWccBWgWZOFlJIP+bK3ypSQGr9hoPz/rF0m1oC8bnkbjf Q==;
IronPort-SDR: wBdpekUctpF03CzUSYfNBPHg5TOO6O5gn9gfQcK4PMdH2BpI5rUTYdVSIMnXWdjo8GyUpZLNu/
 +IcVlyMhJ0iWOeg/oNhHJqJzfoeOUKCM4QvF3GWZggodt7JjVzlvsYhlRtySrxkly4Ee6jI3Ba
 +t3CAg2Cc64fOQM29ccpP78ySZRl5rMD5SmlJcDw8INYiewqKqv9Pz2S6f25M52tzyN5lq3gVZ
 qsLUkG1ImdqQAnz4b/dI603MryfWmfFePAeI5xBPTco4z7pUlCEtTups8+aBbxpwRMYWWyHdZJ
 xDU=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147384687"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:42:18 +0800
IronPort-SDR: e32TVZeLULI3fLdenIC9WNabzTwJNCUNgoS/xoly71ONi+Y8lqCWimqzhx3kFoYowjLn2G46RS
 f8DGlxw3d63A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:29:28 -0700
IronPort-SDR: 2/ibOv+PYDAIylxUdsfAJVsTIl3Pz6tPDePVU8AMBBcFjUeoeZScmGl+JIlrPSpoxZZYrlPeWA
 IwqHsm5RkU9w==
WDCIronportException: Internal
Received: from zns.labspan.wdc.com (HELO zns.sc.wdc.com) ([10.6.137.48])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:42:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 0/1] nvmet: add ZNS passthru support
Date: Tue, 15 Sep 2020 14:42:11 -0700
Message-Id: <20200915214212.14868-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_174221_289495_B1B0C1B8 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 matias.bjorling@wdc.com, sagi@grimberg.me
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

3. Fio Verify Test on local ZNS controller :-

# blkzone reset /dev/nvme0n1
# fio --name=zbc --filename=/dev/nvme0n1 --direct=1 \
--zonemode=zbd --offset=0 --size=1G --verify=crc32c \
--norandommap --randrepeat=0 --ioengine=libaio --iodepth=2 \
--rw=write --bs=4k
zbc: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
fio-3.23
Starting 1 process
Jobs: 1 (f=1): [V(1)][97.1%][r=99.8MiB/s][r=25.5k IOPS][eta 00m:01s]                   
zbc: (groupid=0, jobs=1): err= 0: pid=14858: Sat Sep 12 17:40:31 2020
  read: IOPS=24.6k, BW=96.2MiB/s (101MB/s)(1024MiB/10639msec)
    slat (usec): min=7, max=9980, avg=27.65, stdev=29.23
    clat (usec): min=2, max=9991, avg=51.56, stdev=30.21
     lat (usec): min=38, max=18028, avg=79.42, stdev=45.43
    clat percentiles (usec):
     |  1.00th=[   14],  5.00th=[   15], 10.00th=[   23], 20.00th=[   43],
     | 30.00th=[   46], 40.00th=[   49], 50.00th=[   53], 60.00th=[   59],
     | 70.00th=[   62], 80.00th=[   65], 90.00th=[   70], 95.00th=[   74],
     | 99.00th=[   85], 99.50th=[   89], 99.90th=[   98], 99.95th=[  105],
     | 99.99th=[  143]
  write: IOPS=11.4k, BW=44.3MiB/s (46.5MB/s)(1024MiB/23091msec); 0 zone resets
    slat (usec): min=2, max=4117, avg=24.25, stdev=18.49
    clat (usec): min=26, max=55699, avg=150.33, stdev=436.82
     lat (usec): min=63, max=55710, avg=174.79, stdev=441.42
    clat percentiles (usec):
     |  1.00th=[   64],  5.00th=[   89], 10.00th=[   94], 20.00th=[   98],
     | 30.00th=[  100], 40.00th=[  103], 50.00th=[  105], 60.00th=[  108],
     | 70.00th=[  111], 80.00th=[  114], 90.00th=[  121], 95.00th=[  133],
     | 99.00th=[ 3458], 99.50th=[ 3916], 99.90th=[ 4228], 99.95th=[ 4293],
     | 99.99th=[ 4555]
   bw (  KiB/s): min= 5293, max=58674, per=98.18%, avg=44585.06, stdev=9426.03, samples=47
   iops        : min= 1323, max=14668, avg=11146.09, stdev=2356.51, samples=47
  lat (usec)   : 4=0.01%, 20=3.51%, 50=18.45%, 100=42.31%, 250=34.99%
  lat (usec)   : 500=0.15%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.36%, 10=0.22%, 50=0.01%, 100=0.01%
  cpu          : usr=8.67%, sys=29.47%, ctx=588863, majf=0, minf=6261
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=96.2MiB/s (101MB/s), 96.2MiB/s-96.2MiB/s (101MB/s-101MB/s), io=1024MiB (1074MB), run=10639-10639msec
  WRITE: bw=44.3MiB/s (46.5MB/s), 44.3MiB/s-44.3MiB/s (46.5MB/s-46.5MB/s), io=1024MiB (1074MB), run=23091-23091msec

Disk stats (read/write):
  nvme0n1: ios=259821/260414, merge=0/1730, ticks=14438/31508, in_queue=45947, util=99.77%

4. Fio Verify Test on NVMeOF passthru ZNS controller :-

# blkzone reset /dev/nvme1n1
# fio --name=zbc --filename=/dev/nvme1n1 --direct=1 \
--zonemode=zbd --offset=0 --size=1G --verify=crc32c \
--norandommap --randrepeat=0 --ioengine=libaio --iodepth=2 \
--rw=write --bs=4k
zbc: (g=0): rw=write, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=2
fio-3.23
Starting 1 process
Jobs: 1 (f=1): [V(1)][100.0%][r=96.2MiB/s][r=24.6k IOPS][eta 00m:00s]                  
zbc: (groupid=0, jobs=1): err= 0: pid=14908: Sat Sep 12 17:41:15 2020
  read: IOPS=23.5k, BW=91.8MiB/s (96.2MB/s)(1024MiB/11159msec)
    slat (nsec): min=1293, max=8542.8k, avg=18820.11, stdev=25993.79
    clat (usec): min=5, max=8552, avg=64.17, stdev=28.61
     lat (usec): min=46, max=16418, avg=83.17, stdev=42.52
    clat percentiles (usec):
     |  1.00th=[   21],  5.00th=[   39], 10.00th=[   51], 20.00th=[   57],
     | 30.00th=[   61], 40.00th=[   64], 50.00th=[   65], 60.00th=[   67],
     | 70.00th=[   69], 80.00th=[   72], 90.00th=[   80], 95.00th=[   86],
     | 99.00th=[   97], 99.50th=[  106], 99.90th=[  135], 99.95th=[  147],
     | 99.99th=[  310]
  write: IOPS=9287, BW=36.3MiB/s (38.0MB/s)(1024MiB/28225msec); 0 zone resets
    slat (usec): min=2, max=2259, avg=24.83, stdev=17.55
    clat (usec): min=28, max=59521, avg=188.80, stdev=498.49
     lat (usec): min=68, max=59552, avg=213.87, stdev=503.54
    clat percentiles (usec):
     |  1.00th=[   67],  5.00th=[   96], 10.00th=[  101], 20.00th=[  106],
     | 30.00th=[  110], 40.00th=[  114], 50.00th=[  119], 60.00th=[  139],
     | 70.00th=[  155], 80.00th=[  161], 90.00th=[  172], 95.00th=[  186],
     | 99.00th=[ 3720], 99.50th=[ 4047], 99.90th=[ 4228], 99.95th=[ 4228],
     | 99.99th=[ 4424]
   bw (  KiB/s): min=12920, max=48720, per=98.97%, avg=36769.86, stdev=7442.52, samples=57
   iops        : min= 3230, max=12180, avg=9192.35, stdev=1860.64, samples=57
  lat (usec)   : 10=0.02%, 20=0.33%, 50=4.52%, 100=49.03%, 250=45.09%
  lat (usec)   : 500=0.21%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.52%, 10=0.27%, 50=0.01%, 100=0.01%
  cpu          : usr=9.38%, sys=10.35%, ctx=890723, majf=0, minf=6261
  IO depths    : 1=0.1%, 2=100.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,262144,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=2

Run status group 0 (all jobs):
   READ: bw=91.8MiB/s (96.2MB/s), 91.8MiB/s-91.8MiB/s (96.2MB/s-96.2MB/s), io=1024MiB (1074MB), run=11159-11159msec
  WRITE: bw=36.3MiB/s (38.0MB/s), 36.3MiB/s-36.3MiB/s (38.0MB/s-38.0MB/s), io=1024MiB (1074MB), run=28225-28225msec

Disk stats (read/write):
  nvme1n1: ios=261868/259745, merge=9/2399, ticks=14912/40112, in_queue=55025, util=99.85%


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
