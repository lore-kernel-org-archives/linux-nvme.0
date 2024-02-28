Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75D4C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXS80hvWDXpsMqofoMG6r1QJDyzVHQQ6NsQ4NXgxP50=; b=UTYkhJRHVPYLulkUlD9rSWAvot
	3bx7Ym5LZK9b+YUHXAniCvlViF2p8iCovD0VaZWDYMn5/0ktrKsea/XprEiQ5mP6t8oyXU9HrX/2N
	TIKdKUnVHrTUtPS2fh5A6qm89FmDFvrGwPc7SUhb+nFvuiBQX0GkvTXij3CRnKZ9MO/wHagS03FwZ
	n3Mx1hyQyytiSFPFb6IrixWPvw1TVZBLT8xKTIw8mRO1mtef7OcP104IEQ3arTKlt8dnUU2RTA5GZ
	Fpau4uZoDNueSOUEAKFEFP/in8osJjM8k43EHRH6buw1iWM2+vZtTX080RnfIBPRA2ChLCNGE8ui9
	shPPYDkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGeO-00000008kTz-05ee;
	Wed, 28 Feb 2024 09:54:56 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGeK-00000008kTY-35PZ
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 09:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709114087; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yXS80hvWDXpsMqofoMG6r1QJDyzVHQQ6NsQ4NXgxP50=;
	b=FsSWGu0omIl4MDqDcTdMLPhyd12vFQpvjl8mZZILmZU0KKLlqBIHFckiF2F115KdkODhMbz0tc+6fuF814Gwo+2b24c9dFNGrI02Wltr/Z1VZUguaUNQgoc+WNOODWZ1TdtasgtQU2yiRRZwA5Gr74GPfGeEkjsSXjoyfPogVrI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1PWkwI_1709114082;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1PWkwI_1709114082)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 17:54:43 +0800
Message-ID: <bc414f6c-55f7-4fda-b095-8d4a15028eac@linux.alibaba.com>
Date: Wed, 28 Feb 2024 17:54:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: check max outstanding commands
Content-Language: en-GB
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
 <Zd4f4PaoOM6WSF4u@kbusch-mbp>
 <89bcff20-e07c-4f62-9ef8-36cbbc3d6def@linux.alibaba.com>
 <73uh4vwpacq22ttzlbrouvtpwysbcy246d2ejgpobsrtb2chaw@rlbdjiqzbdsa>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <73uh4vwpacq22ttzlbrouvtpwysbcy246d2ejgpobsrtb2chaw@rlbdjiqzbdsa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_015453_309759_B2C4CE0D 
X-CRM114-Status: UNSURE (   6.45  )
X-CRM114-Notice: Please train this message.
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


> And please run blktests with it. Last time, we had some fallouts when a
> new check was added. Thanks.

I am sorry for the last time's mistake, I've already run the blktests 
this time,

the maxcmd is mandatory for all controllers.

Best Regards,

Guixin Liu


Blktests log:

nvme/002 (create many subsystems and test discovery)         [passed]
     runtime  16.481s  ...  16.716s
nvme/003 (test if we're sending keep-alives to a discovery controller) 
[passed]
     runtime  11.130s  ...  11.160s
nvme/004 (test nvme and nvmet UUID NS descriptors) [passed]
     runtime  0.535s  ...  0.615s
nvme/005 (reset local loopback target) [passed]
     runtime  0.969s  ...  0.973s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
     runtime  0.046s  ...  0.046s
nvme/007 (create an NVMeOF target with a file-backed ns) [passed]
     runtime  0.029s  ...  0.028s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
     runtime  0.540s  ...  0.519s
nvme/009 (create an NVMeOF host with a file-backed ns) [passed]
     runtime  0.539s  ...  0.536s
nvme/010 (run data verification fio job on NVMeOF block device-backed 
ns) [passed]
     runtime  3.388s  ...  3.356s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
     runtime  259.255s  ...  265.053s
nvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns) [passed]
     runtime  11.734s  ...  11.623s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed 
ns) [passed]
     runtime  228.180s  ...  231.981s
nvme/014 (flush a NVMeOF block device-backed ns) [passed]
     runtime  12.468s  ...  14.417s
nvme/015 (unit test for NVMe flush for file backed ns) [passed]
     runtime  11.854s  ...  11.849s
nvme/016 (create/delete many NVMeOF block device-backed ns and test 
discovery) [passed]
     runtime  8.017s  ...  8.201s
nvme/017 (create/delete many file-ns and test discovery) [passed]
     runtime  8.419s  ...  8.596s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
     runtime  0.511s  ...  0.529s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
     runtime  0.535s  ...  0.547s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
     runtime  0.529s  ...  0.526s
nvme/021 (test NVMe list command on NVMeOF file-backed ns) [passed]
     runtime  0.529s  ...  0.525s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns) [passed]
     runtime  0.949s  ...  0.951s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
     runtime  0.527s  ...  0.557s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
     runtime  0.526s  ...  0.523s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
     runtime  0.539s  ...  0.526s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
     runtime  0.531s  ...  0.544s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
     runtime  0.529s  ...  0.512s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
     runtime  0.520s  ...  0.523s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
     runtime  0.600s  ...  0.595s
nvme/030 (ensure the discovery generation counter is updated 
appropriately) [passed]
     runtime  0.183s  ...  0.160s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) 
[passed]
     runtime  5.149s  ...  4.988s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
     runtime  0.006s  ...  0.006s
nvme/040 (test nvme fabrics controller reset/disconnect operation during 
I/O) [passed]
     runtime  7.054s  ...  7.077s
nvme/041 (Create authenticated connections)                  [not run]
     kernel 6.8.0-rc5+ config not found
     kernel 6.8.0-rc5+ config not found
nvme/042 (Test dhchap key types for authenticated connections) [not run]
     kernel 6.8.0-rc5+ config not found
     kernel 6.8.0-rc5+ config not found
nvme/043 (Test hash and DH group variations for authenticated 
connections) [not run]
     kernel 6.8.0-rc5+ config not found
     kernel 6.8.0-rc5+ config not found
nvme/044 (Test bi-directional authentication)                [not run]
     kernel 6.8.0-rc5+ config not found
     kernel 6.8.0-rc5+ config not found
nvme/045 (Test re-authentication)                            [not run]
     kernel 6.8.0-rc5+ config not found
     kernel 6.8.0-rc5+ config not found
nvme/047 (test different queue types for fabric transports)  [not run]
     runtime  2.730s  ...
     nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
     runtime  7.073s  ...
     nvme_trtype=loop is not supported in this test



