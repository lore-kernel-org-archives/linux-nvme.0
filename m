Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9E9CC6B1D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDYHMGj+PaSnSyhBuqn5AX0+H5oOf9EczweODc02XDQ=; b=lVJN36/DeBGi37cBS4zbm2piru
	J8EbmzuBvjwd5Z6IS+xkr+QIFVAbJK4BLl7gD9b0c0OOqbPBhW2pkkQ+4MmpudDCQa5iqDc67JMp6
	tGKfFiWKF4KnEyAtNzrXaqzKXbBZCm6ePY1mTB54zLCt0kgIppwl+u6xRT+dsv+Wr6/bt7faOIeCE
	gwdWLcvDBVcey9/hjrSjbl/5DbJCnnl3bwRBqVEcAu2ilM2cpEcdKGUTtyXQDtOu6o7Xq7XbEaRiA
	XUHwaI//FpLVcoQ7VCnQfsGouXyPHF2a818HSt3b7ARzGfjUHGyMAd8gS5UrR1Q97PRGl5hFTjiQy
	iVRzUwmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyNk-0000000FUDT-24aK;
	Wed, 14 Oct 2026 12:46:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyNg-0000000FUBN-2vlI
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 12:46:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C50D860218;
	Wed, 14 Oct 2026 12:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C06D1F000FF;
	Wed, 14 Oct 2026 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982011;
	bh=bDYHMGj+PaSnSyhBuqn5AX0+H5oOf9EczweODc02XDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uj5vA4CVAZCFVjhPvai73fMsJBgr1g35Tc2TWmhmOYfF7nGBrx9UWZkPMEl/RHhdm
	 /7yH9eTxrd9c/Nm3ZIWEkBDN4Nkr9BcErMahu2kx0K7e/dHc/7YOtBAG24HfikriRn
	 sTogNN3bcn76jqLpYBRbZzldTald+6A4U0BufbH8BBN7pwMUj3IEtbQ9VPt02yehMX
	 DeEwkne3tHClVYMYJ49Ox5KzF0acBP9u7q2LW5RrcaXkJaykF4y6I3uKyPSahTiWNU
	 +/5BfxJVLPgN8/Pv2/6Renqeb3r3B3i4JmTMg+BvOrCv+UJ+f2Md4IvkzfXwyIx/Ma
	 pEstE7fSBthOA==
Date: Wed, 14 Oct 2026 14:46:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrea Parri <parri.andrea@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command
 completions
Message-ID: <as95tp8CF2lX4Gs0@ryzen>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-5-parri.andrea@gmail.com>
 <20261013142736.GE14759@lst.de>
 <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
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

On Tue, Oct 13, 2026 at 05:12:16PM +0200, Damien Le Moal wrote:
> On 2026/10/13 16:27, Christoph Hellwig wrote:
> > I think this looks good.  Damien/Niklas, can you test this on hardware?
> 
> I do not have the hardware available right now. Niklas ? Can you test this?

I understand that these changes are not supposed to affect performance,
but posting it for completeness:


Before patches:

# ./fio-test.sh /dev/nvme0n1
Running on /dev/nvme0n1...
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=3088, BW=12.1MiB/s (12.7MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=45.4k, BW=177MiB/s (186MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=47.8k, BW=187MiB/s (196MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1803, BW=225MiB/s (236MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=9078, BW=1135MiB/s (1190MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=10.0k, BW=1253MiB/s (1314MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1447, BW=724MiB/s (759MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=2415, BW=1208MiB/s (1267MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=2686, BW=1343MiB/s (1409MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=3046, BW=11.9MiB/s (12.5MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=22.9k, BW=89.3MiB/s (93.6MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=22.9k, BW=89.6MiB/s (94.0MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1555, BW=194MiB/s (204MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=6183, BW=773MiB/s (810MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=6903, BW=863MiB/s (905MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1672, BW=209MiB/s (219MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=9033, BW=1129MiB/s (1184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=1580, BW=790MiB/s (829MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=2536, BW=1268MiB/s (1330MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=1297, BW=1297MiB/s (1360MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=1547, BW=193MiB/s (203MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=6563, BW=820MiB/s (860MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=893, BW=447MiB/s (469MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=1667, BW=834MiB/s (874MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=762, BW=763MiB/s (800MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=788, BW=396MiB/s (415MB/s)
 IOPS=811, BW=408MiB/s (427MB/s)


After patches:

# ./fio-test.sh /dev/nvme0n1
Running on /dev/nvme0n1...
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=2958, BW=11.6MiB/s (12.1MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=44.5k, BW=174MiB/s (182MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=47.4k, BW=185MiB/s (194MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1741, BW=218MiB/s (228MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=9327, BW=1166MiB/s (1223MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=10.2k, BW=1280MiB/s (1342MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1444, BW=722MiB/s (758MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=2505, BW=1253MiB/s (1313MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=2516, BW=1258MiB/s (1319MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=3322, BW=13.0MiB/s (13.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=22.8k, BW=89.1MiB/s (93.5MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=22.9k, BW=89.4MiB/s (93.7MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1529, BW=191MiB/s (201MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=6369, BW=796MiB/s (835MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=6449, BW=806MiB/s (845MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1690, BW=211MiB/s (222MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=9262, BW=1158MiB/s (1214MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=1428, BW=714MiB/s (749MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=2652, BW=1326MiB/s (1391MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=1301, BW=1302MiB/s (1365MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=1531, BW=191MiB/s (201MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=6144, BW=768MiB/s (805MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=924, BW=462MiB/s (485MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=1468, BW=734MiB/s (770MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=749, BW=749MiB/s (786MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=786, BW=394MiB/s (414MB/s)
 IOPS=809, BW=407MiB/s (426MB/s)



Also used ftrace on the EP side to see that SGLs were actually being used:
   kworker/u32:2-75      [005] .....   300.152187: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.152560: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.153126: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.153702: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.154273: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.154807: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.155445: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.156263: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.156676: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.157340: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work
   kworker/u32:2-75      [005] .....   300.158096: nvmet_pci_epf_iod_parse_sgls <-nvmet_pci_epf_exec_iod_work


I can not see anything wrong, thus:

Tested-by: Niklas Cassel <cassel@kernel.org>

