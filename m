Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D61E6F062
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4v/EPByujJ+RssKKj5/vyuu/qgup3TSLSNFTfF3urPc=; b=lLor9aW2eEgAy0C3VDZeCCrjjw
	k6n6YvwNE3eK/qVl8/7cag5Sy9OyCq5bBjtKLI9HzAkq0+m0WHF41Q5Qhb0vRkryDM48m1SJcen6r
	T616EGiarIqRLSGEaZ7GKzbT+S3w3xqMiQLd3DyTEYF3TGPUDSkNf6clO62B08s9mRG2rcD7NqXys
	06iYVlH2hF0P8Gci6WAJwkW/6Q5DlN22XFjb1oEH7N1qWN0T8STHSX5/+GZwpAgevPMp/o8nLfC2d
	uDMet8ud4ak1vbMsM35XNN+82qw0dhDlIa2dbs4B/5aEW6AhL9g+lIEUAUzDaoIsd+uA2hDisPsPN
	byxHGWfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sbk-00000007KjG-1SGH;
	Fri, 01 Nov 2024 14:26:36 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sEe-00000007GOs-3FgG
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 14:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730469765; x=1762005765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsQ9V3sf5ngVZOnd60/14YeNO9J7P5KfgVF/8fNfJW0=;
  b=e3yl7GYzZDTrshHQsLu+eX05qlDTqNZB1/MWLnPvyCmyFIeOnf11olOh
   h3Qs/hs+4AGuL/IJRH9QovpuEfabxQLpF8gzo7hjTYID1a20bB5Ka7pXR
   qcXosoeASWeyuVXViAHBoEeYzdDQIr/M0H+V3lEFSGim9GjPZqcnEUnuT
   KG7nPnr9Htw5Z23OREMx4yKDJmfXjNcs6vmOaSk5FfqgYu+LIGQw6aI8w
   FwAGm0XyrLh/rWoIm8IsQwWs/h532meApljnlP7pjqDkHj/ghrJ9zirhL
   KtpVfJqpzDoepxQ5GbCtqBzXAt+nGSx49cL9z/a/T0zlH2hlMiQQB5aZ/
   g==;
X-CSE-ConnectionGUID: M2ryWzf5R/ugvowwyB0v2w==
X-CSE-MsgGUID: k+N042gIQ2uTEucwVwEVQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29654128"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="29654128"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 07:02:44 -0700
X-CSE-ConnectionGUID: rFT8x/NOQPa4sxUhjtTxQg==
X-CSE-MsgGUID: UjNqDcWDTKClZxEyenorSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87767855"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 07:02:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6sEX-000hcH-2j;
	Fri, 01 Nov 2024 14:02:37 +0000
Date: Fri, 1 Nov 2024 22:02:09 +0800
From: kernel test robot <lkp@intel.com>
To: George Rurikov <grurikov@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, MrRurikov <grurikov@gmal.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, George Rurikov <g.ryurikov@securitycode.ru>
Subject: Re: [PATCH] nvme: rdma: Add check for queue in
 nvmet_rdma_cm_handler()
Message-ID: <202411012136.hoMlvrTF-lkp@intel.com>
References: <20241031173327.663-1-grurikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173327.663-1-grurikov@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_070244_907045_5C246CA6 
X-CRM114-Status: GOOD (  14.12  )
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

Hi George,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Rurikov/nvme-rdma-Add-check-for-queue-in-nvmet_rdma_cm_handler/20241101-013611
base:   linus/master
patch link:    https://lore.kernel.org/r/20241031173327.663-1-grurikov%40gmail.com
patch subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20241101/202411012136.hoMlvrTF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012136.hoMlvrTF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012136.hoMlvrTF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/rdma.c: In function 'nvmet_rdma_cm_handler':
>> drivers/nvme/target/rdma.c:1771:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1771 |                 if (!queue) {
         |                    ^
   drivers/nvme/target/rdma.c:1775:9: note: here
    1775 |         case RDMA_CM_EVENT_ADDR_CHANGE:
         |         ^~~~
   drivers/nvme/target/rdma.c:1785:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1785 |                 if (!queue) {
         |                    ^
   drivers/nvme/target/rdma.c:1789:9: note: here
    1789 |         case RDMA_CM_EVENT_DEVICE_REMOVAL:
         |         ^~~~
   drivers/nvme/target/rdma.c:1798:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1798 |                 if (!queue) {
         |                    ^
   drivers/nvme/target/rdma.c:1802:9: note: here
    1802 |         default:
         |         ^~~~~~~


vim +1771 drivers/nvme/target/rdma.c

  1752	
  1753	static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
  1754			struct rdma_cm_event *event)
  1755	{
  1756		struct nvmet_rdma_queue *queue = NULL;
  1757		int ret = 0;
  1758	
  1759		if (cm_id->qp)
  1760			queue = cm_id->qp->qp_context;
  1761	
  1762		pr_debug("%s (%d): status %d id %p\n",
  1763			rdma_event_msg(event->event), event->event,
  1764			event->status, cm_id);
  1765	
  1766		switch (event->event) {
  1767		case RDMA_CM_EVENT_CONNECT_REQUEST:
  1768			ret = nvmet_rdma_queue_connect(cm_id, event);
  1769			break;
  1770		case RDMA_CM_EVENT_ESTABLISHED:
> 1771			if (!queue) {
  1772				nvmet_rdma_queue_established(queue);
  1773				break;
  1774			}
  1775		case RDMA_CM_EVENT_ADDR_CHANGE:
  1776			if (!queue) {
  1777				struct nvmet_rdma_port *port = cm_id->context;
  1778	
  1779				queue_delayed_work(nvmet_wq, &port->repair_work, 0);
  1780				break;
  1781			}
  1782			fallthrough;
  1783		case RDMA_CM_EVENT_DISCONNECTED:
  1784		case RDMA_CM_EVENT_TIMEWAIT_EXIT:
  1785			if (!queue) {
  1786				nvmet_rdma_queue_disconnect(queue);
  1787				break;
  1788			}
  1789		case RDMA_CM_EVENT_DEVICE_REMOVAL:
  1790			ret = nvmet_rdma_device_removal(cm_id, queue);
  1791			break;
  1792		case RDMA_CM_EVENT_REJECTED:
  1793			pr_debug("Connection rejected: %s\n",
  1794				 rdma_reject_msg(cm_id, event->status));
  1795			fallthrough;
  1796		case RDMA_CM_EVENT_UNREACHABLE:
  1797		case RDMA_CM_EVENT_CONNECT_ERROR:
  1798			if (!queue) {
  1799				nvmet_rdma_queue_connect_fail(cm_id, queue);
  1800				break;
  1801			}
  1802		default:
  1803			pr_err("received unrecognized RDMA CM event %d\n",
  1804				event->event);
  1805			break;
  1806		}
  1807	
  1808		return ret;
  1809	}
  1810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

