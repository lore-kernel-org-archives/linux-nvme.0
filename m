Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F376C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zBdsVpfrA/IboWH5itbXV/QJbTzznodEuxkg3PZmegg=; b=4+e2Yn0gDfZXoZyJuGQxlT4WXN
	ExVKpITywWg15paDgYfY62FgZdlahnNCVNs40ZbLX3/QR6jiMq1gH32nJCns7XdGCMigPm8oIBxrT
	PW/58u0m1spdqEss5U5IkmoRLFaOmWkSF6Q4TlcjBK7XxgXST9vQqZjY0Gz6OF0c1xLLPbUhobJ0y
	Z5HYAOkwL6vWtVodAZPwEGUgamCeNjVXfMXe5QB2EUzAfgRj0Vhsa/YCDv9vIy7CnrAZQUjhdAamw
	klYlvxUwU6x9C0oF6xRjQqt2pap7iDRd4WdV+KX+3F/DWE4Su1qZSpcPLTjhUF1ObC1HgCU38jFJh
	I04AR5cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHnCw-000C0R-6p; Wed, 09 Feb 2022 13:40:30 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHnAN-000B7L-6I
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 13:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644413871; x=1675949871;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=AyBhoS/GZN6YjyJ1wWGufiFSgoiXmzT//o/MMzrJhFU=;
 b=VDIATSHmv2eJgHLZTmKznjezKrqhAP9tdZ6IKt7AquVgX9kuxMFkAA36
 lYKLj3Cv00WsKPw6VBm6xTogkJHR4po/cOWPn6Kegiz6OvYAL7xOrSLoT
 Gq/LOHPH8nfcqRMSOjFaJaVSPwnyopuw1LFskmWhUNPlBNl+fboyZnhgH
 CRn8MHA30wusOIrmWuKwHpqMrdCRZ9HqOFFeOeaOWPCEKNd1rYHvSxArq
 P18n1TMe1gaMNwTxFOquetojuwFcBymwQJeE5WNaaF+Mg3Irw/k2q86yv
 S0zIZBESmvDPVdn7hgXHAmRZEs5SoCHi9fWete53nEUoOp59ZKh1t4ypa g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229173821"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="229173821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 05:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="485240997"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 09 Feb 2022 05:37:48 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nHnAK-0001s1-2U; Wed, 09 Feb 2022 13:37:48 +0000
Date: Wed, 9 Feb 2022 21:37:01 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: [linux-nvme:nvme-5.17 1/2] drivers/nvme/host/tcp.c:920:25: sparse:
 sparse: incorrect type in argument 2 (different base types)
Message-ID: <202202092122.25VLa0rQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_053751_291008_FC408CF2 
X-CRM114-Status: GOOD (  11.34  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.17
head:   5c66f610f0be01358a3bb037fce6ae5744e225d2
commit: 52100021775a35eef08e493acabe3deb31847cb8 [1/2] nvme-tcp: fix bogus request completion when failing to send AER
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220209/202202092122.25VLa0rQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.17
        git checkout 52100021775a35eef08e493acabe3deb31847cb8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/tcp.c:920:25: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __le16 [usertype] status @@     got int @@
   drivers/nvme/host/tcp.c:920:25: sparse:     expected restricted __le16 [usertype] status
   drivers/nvme/host/tcp.c:920:25: sparse:     got int

vim +920 drivers/nvme/host/tcp.c

   913	
   914	static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
   915	{
   916		if (nvme_tcp_async_req(req)) {
   917			union nvme_result res = {};
   918	
   919			nvme_complete_async_event(&req->queue->ctrl->ctrl,
 > 920				NVME_SC_HOST_PATH_ERROR, &res);
   921		} else {
   922			nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
   923					NVME_SC_HOST_PATH_ERROR);
   924		}
   925	}
   926	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

