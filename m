Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F0C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=gIAo8v1gV/rF1NjYATC3qvnGY4lE294XgC6eferUcU4=; b=PPMQBwGDue90QxpMUTupZhsWQl
	qhK1LEyzTMayjq3pqyvNh+2fjG2MX3SeoR63RRIUkPixpRq1+NfB7TRyHdRQ7fnvzjNDiYVJfpd8L
	9n2mJh5edcPHb1FJtpeA58WZGR6mDp+ZUUPeRodD2GOQqdXk8tbdz7GjBPhO/JTUFTI23WQWMTRnW
	dpMjSkxOQANM13MACdOP0UTIsG+1QYfI5Gind3Ae7SZvGod9G69kd8RUjdaw2tGPY0RRwZJCetNdo
	sTdFUcvuSJ9mbaUfQkLJxnRLplZPK+GWJQqZwU6kTI6+r1j8j2s9W/xhEQxH8GSFE32G7CctUfEK1
	T0BRS3AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPl7-00BYUb-JD; Thu, 20 Oct 2022 07:14:29 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPkm-00BY6P-C7
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 07:14:18 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221020071345epoutp0217dbf51ee54349a458bd2164334d8ffe~ftZHX01JG0972609726epoutp02d
	for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 07:13:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221020071345epoutp0217dbf51ee54349a458bd2164334d8ffe~ftZHX01JG0972609726epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666250025;
	bh=gIAo8v1gV/rF1NjYATC3qvnGY4lE294XgC6eferUcU4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Oiwgtm69jtxzhKIBr0xlH6J1X1LxU5mEG+ySboLzCG4G0+NlieuZN+ZcMw6y0c5rc
	 3oyj3w74pPG7CO7k05cCGPN7bCRHVI0mrbjngj4r1M8ptcQYQdSHGdoJ/gnAChHCCl
	 fZy+8BvBXdEjxfvweRh0QZkfXYS9/dhvKh01Rs6o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221020071344epcas5p29de698ff88495caf1c91d932fd12c7f0~ftZGzVxuw2564725647epcas5p2o;
	Thu, 20 Oct 2022 07:13:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MtJjf0hLbz4x9Pp; Thu, 20 Oct
	2022 07:13:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.FA.39477.225F0536; Thu, 20 Oct 2022 16:13:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98~ftZAuoizW2107221072epcas5p1b;
	Thu, 20 Oct 2022 07:13:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221020071338epsmtrp191563d7f8aac972f00529e4b8b619c74~ftZAt8KaT1842918429epsmtrp1C;
	Thu, 20 Oct 2022 07:13:38 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-38-6350f522632b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.27.18644.125F0536; Thu, 20 Oct 2022 16:13:37 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221020071336epsmtip2d784f1883a00bc82e9bf88fb8fc23092~ftY-kHCjE2670526705epsmtip2I;
	Thu, 20 Oct 2022 07:13:36 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 0/2] Granular CAP_SYS_ADMIN
Date: Thu, 20 Oct 2022 12:32:03 +0530
Message-Id: <20221020070205.57366-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmlq7S14Bkg/uPLC1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
	5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQw
	MDIFKkzIzlh0ag57wSSNiqUfl7M1MD6S62Lk5JAQMJFY+mgpaxcjF4eQwG5GicMPFrNBOJ8Y
	JTZunsAM4XxmlJg6u5mpi5EDrOXEVEGI+C5GibOrt7GAjAIruvaBE6SGTUBT4sLkUpCwiICL
	xOeeC6wgNrNAvMTNv5vZQGxhAW2Jje/Og8VZBFQlvn3/yARi8wpYSGzphaiREJCXmHnpOztE
	XFDi5MwnLBBz5CWat84Gu01C4Bq7RMv1ecwQDS4Si7ccY4KwhSVeHd/CDmFLSbzsb4OykyUu
	zTwHVVMi8XjPQSjbXqL1VD8zyP3MQPev36UPsYtPovf3E6jXeSU62oQgqhUl7k16ygphi0s8
	nLEEyvaQuNy9nQ0SIrESs7fvZ5/AKDcLyQezkHwwC2HZAkbmVYySqQXFuempxaYFRnmp5fCY
	TM7P3cQIToJaXjsYHz74oHeIkYmD8RCjBAezkghvwbuAZCHelMTKqtSi/Pii0pzU4kOMpsBg
	ncgsJZqcD0zDeSXxhiaWBiZmZmYmlsZmhkrivItnaCULCaQnlqRmp6YWpBbB9DFxcEo1MG1v
	1ZzzcH6Ri/kTMbvGSe/+H3S099EzFdSpXP3vhJrBnHSHO96+6y8JZh5dkbz7tnShkGHf0dXP
	fubma/Hb/UuQ6OnxOXUlY175c537snNOGrq/2pcXqlHLFqxwcYU+m9m1wgv2XctiTNsaHaTv
	btWzd3vEZloQKx3VFNwc5T69sMH0aSz7jz8KnvY7+DyEqtc9uvm3V7Tb81di5Py16ZZuHxfF
	i+6dtv/YTr7ARz4NhusuXp/Ls2db9dbstL7b1RxbpqQsytiyvsUy36+k8OuLuzmKD6My+CLe
	HXk2cfHk1E0rZYPS2E4b7zntl7Z9MdMBPenukqi5Vhbp8m07FLt7qyoXTqnoduHheJqrxFKc
	kWioxVxUnAgAZkxcvgsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvK7i14Bkgz0nLS1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBlLDo1h71gkkbF0o/L2RoYH8l1MXJwSAiYSJyYKtjFyMUh
	JLCDUeLL9Z3sXYycQHFxieZrP6BsYYmV/56zQxR9ZJT48HoSE0gzm4CmxIXJpSA1IgJeErdf
	PmcGsZkFEiXeH33MCmILC2hLbHx3HsxmEVCV+Pb9IxOIzStgIbGldzMbxHx5iZmXvrNDxAUl
	Ts58wgIxR16ieets5gmMfLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7
	iREcqlpaOxj3rPqgd4iRiYPxEKMEB7OSCG/Bu4BkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwX
	uk7GCwmkJ5akZqemFqQWwWSZODilGphmZ1ezJITNWhy9VNRNVv7pddWzduv2Ly5Vi1xQfaSR
	oSf/ZY3g2Y6spRKv1yy9nWpvnKnAfKsjdv6/7kNVPNYWBybZh21IMrrFslMtUM9lWt8jbo2n
	a+Yd3C6ovOe93CTR1uvyH75GWPuyv3rG4nuIrdNufeh8rSP/NLbtn1BY+XXRJtmomx4f57wv
	KpztuK/PbvFblvZ7J1iU17XKLbql/3LStQuCJY1M9UwWX/adZ3ipObN4p1T8FtFMXX8OaS3J
	BVI677ZE7+449WOd9b8Plb89HipEtOwVFzAxs/GacWT9ry/yRamnNuy+w7P295wtG+YfOhwd
	w7C4XWDt1/gVxq37X2lkTbGqa9vDOkdIiaU4I9FQi7moOBEAs8Xtr8QCAAA=
X-CMS-MailID: 20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98
References: <CGME20221020071338epcas5p16d72f5d4d868b889e3a98688bc454a98@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_001413_078839_DD0CD7E9 
X-CRM114-Status: GOOD (  14.31  )
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

Patch 1 is for io-commands. It implements the shift to file-mode based
policy.
Patch 2 is to allow identify-namespace command. This is based on the feedback
received during ALPSS.

@Sagi: Since patch 1 is changed a bit (changelog below), I did not
apply the reviewed-by tag. Please take a look again.

Changes since v2:
- Add patch 2 that allows identify-ns
- Patch 1: Move nvme_cmd_allowed check further down, so that we can use CNS
  values for decision making in patch 2
- Patch 1: invert if condition (Sagi)

Changes since v1:
- Move nvme_cmd_allowed check at a place that allows using nvme_is_write
  helper (hch)
- Keep everything into single patch (chaitanya, hch)
- Comments cleanup (hch, chaitanya)
- Part of cover-letter moved to commit-description

Examples (after patches):
***************************

#1: Two NS, one with 666 another with 600
$: ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Oct 20 12:04 /dev/ng0n1
crw------- 1 root root 242, 1 Oct 20 12:04 /dev/ng0n2

#2: this should fail
$: nvme id-ns /dev/ng0n2
/dev/ng0n2: Permission denied
Usage: nvme id-ns <device> [OPTIONS]

Send an Identify Namespace command to the given device, returns properties of
the specified namespace in either human-readable or binary format. Can also
return binary vendor-specific namespace attributes.

Options:
  [  --namespace-id=<NUM>, -n <NUM> ]   --- identifier of desired namespace
  [  --force ]                          --- Return this namespace, even if
                                            not attaced (1.2 devices only)
  [  --vendor-specific, -v ]            --- dump binary vendor fields
  [  --raw-binary, -b ]                 --- show identify in binary format
  [  --output-format=<FMT>, -o <FMT> ]  --- Output format: normal|json|binary
  [  --human-readable, -H ]             --- show identify in readable format

#3: this should travel
$: nvme id-ns /dev/ng0n1
NVME Identify Namespace 1:
nsze    : 0x300000
ncap    : 0x300000
nuse    : 0x300000
nsfeat  : 0
nlbaf   : 7
flbas   : 0x4
mc      : 0
dpc     : 0
dps     : 0
nmic    : 0
rescap  : 0
fpi     : 0
dlfeat  : 9
nawun   : 0
nawupf  : 0
nacwu   : 0
nabsn   : 0
nabo    : 0
nabspf  : 0
noiob   : 0
nvmcap  : 0
mssrl   : 256
mcl     : 256
msrc    : 127
nulbaf  : 0
anagrpid: 0
nsattr  : 0
nvmsetid: 0
endgid  : 0
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000000
lbaf  0 : ms:0   lbads:9  rp:0
lbaf  1 : ms:8   lbads:9  rp:0
lbaf  2 : ms:16  lbads:9  rp:0
lbaf  3 : ms:64  lbads:9  rp:0
lbaf  4 : ms:0   lbads:12 rp:0 (in use)
lbaf  5 : ms:8   lbads:12 rp:0
lbaf  6 : ms:16  lbads:12 rp:0
lbaf  7 : ms:64  lbads:12 rp:0

#4: this should not travel
$: nvme id-ctrl /dev/ng0n1
identify controller: Permission denied

#5: uring-passthru read on ng0n1 (should work)
$: ./fio -iodepth=1 -rw=randread -ioengine=io_uring_cmd -cmd_type=nvme -bs=4k -numjobs=1 -size=4k -filename=/dev/ng0n1 -name=pt
pt: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring_cmd, iodepth=1
fio-3.32-58-gb19c-dirty
Starting 1 process

pt: (groupid=0, jobs=1): err= 0: pid=56582: Thu Oct 20 12:12:50 2022
  read: IOPS=500, BW=2000KiB/s (2048kB/s)(4096B/2msec)
    slat (nsec): min=461505, max=461505, avg=461505.00, stdev= 0.00
    clat (nsec): min=544742, max=544742, avg=544742.00, stdev= 0.00
     lat (nsec): min=1006.2k, max=1006.2k, avg=1006247.00, stdev= 0.00
    clat percentiles (usec):
     |  1.00th=[  545],  5.00th=[  545], 10.00th=[  545], 20.00th=[  545],
     | 30.00th=[  545], 40.00th=[  545], 50.00th=[  545], 60.00th=[  545],
     | 70.00th=[  545], 80.00th=[  545], 90.00th=[  545], 95.00th=[  545],
     | 99.00th=[  545], 99.50th=[  545], 99.90th=[  545], 99.95th=[  545],
     | 99.99th=[  545]
  lat (usec)   : 750=100.00%
  cpu          : usr=0.00%, sys=200.00%, ctx=1, majf=0, minf=6
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=2000KiB/s (2048kB/s), 2000KiB/s-2000KiB/s (2048kB/s-2048kB/s), io=4096B (4096B), run=2-2msec

#6: uring-passthru read on ng0n2 (should fail)
$: ./fio -iodepth=1 -rw=randread -ioengine=io_uring_cmd -cmd_type=nvme -bs=4k -numjobs=1 -size=4k -filename=/dev/ng0n2 -name=pt
pt: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring_cmd, iodepth=1
fio-3.32-58-gb19c-dirty
Starting 1 process



Run status group 0 (all jobs):


Kanchan Joshi (2):
  nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
  nvme: identify-namespace without CAP_SYS_ADMIN

 drivers/nvme/host/ioctl.c | 107 ++++++++++++++++++++++++++------------
 include/linux/nvme.h      |   1 +
 2 files changed, 75 insertions(+), 33 deletions(-)

-- 
2.25.1


