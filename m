Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D76CD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIVTbLCqZrwb65YQcfZhp1zfE3Xa+WmG01AjipTUy2s=; b=b1966RC/jcwR3IZY4iMt4fRCt+
	gof9gZI2U7RIyoYYTkwA+3b0NMJd2yMi4Omi33XgVSu29Ly8UHsm16UVSceMew9NAUgJUz1KVZN7M
	M0j1JTLW+LrfCKgAeWNQW75Mlgas++hnL0o9f+0006helP0mXvhC/pYRt98iA6NYuFaC7b4r6Rj/H
	jwiy+eSrTEPdyq3iuAT1DeWuRvvS3GoxHin+SMJFagw95e70THMWvq8AZpEN5bqXjT756D0/HsrAf
	GQccxdyQg0GC35EbGQ7RjQDLqlvrm2dT2MM52zoF9//CnOqwRaOjK/zdz17ECE8e8b15Aiq8hwodK
	Do5QsOUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdht-00000006cUB-11ta;
	Thu, 14 May 2026 21:35:01 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNdhp-00000006cTV-3Fv7
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 21:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778794498; x=1810330498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLsAASEYhbMuO0V6Xfd51IvN0Jpo4lEx4H6j7JHYlWE=;
  b=UfBw6z1fMT2E/Neb9dw/W9wGjPPct6yMD2l6ZnepBC00INKKXGeCI7m+
   EQVTgumr5Uxt0UwVhgQWYc4VknlKZBtabcto16FEhYEyj09bAaZkB0NLE
   Bjlp2uUthd3IGZFIS622gRqdTfbBG8FuHJl9D0W8Mc5Gtn+9jomnjYayf
   S4JI8olg/WlvVU+AHoRTowWvH5VRGFDSc7eIB3ih+dFyY4AxBxDtsuYt3
   BuVcsT05jWRx2d+nuNKPxFueKX4qxLG9MjS3BRfm8hdLUKu1AfLztW7Cr
   GLzDPGnRjbekF6rUGtsaQaT5DzlnBScXBZ+rU760q+pXzhjg5Wjc4M8NQ
   A==;
X-CSE-ConnectionGUID: ZfqQdJEkQEm8rQFpx94yXw==
X-CSE-MsgGUID: x9UVKG80RRGKu4o02bn25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79919105"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79919105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 14:34:56 -0700
X-CSE-ConnectionGUID: XQIqMsPHSMy5dkJQkIqGOg==
X-CSE-MsgGUID: Hrnu7xwUT7aJezi66WFw/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="235857758"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 14:34:53 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNdgQ-000000000A5-0BXv;
	Thu, 14 May 2026 21:33:42 +0000
Date: Fri, 15 May 2026 05:25:18 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch
 messages
Message-ID: <202605150537.AqXMjMVu-lkp@intel.com>
References: <20260504123555.1741525-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123555.1741525-1-roheetchavan@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_143457_895679_BCB895E3 
X-CRM114-Status: GOOD (  12.58  )
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

Hi Rohit,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[cannot apply to linux-nvme/for-next hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/nvme-use-str_enabled_disabled-for-digest-mismatch-messages/20260514-220734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260504123555.1741525-1-roheetchavan%40gmail.com
patch subject: [PATCH] nvme: use str_enabled_disabled() for digest mismatch messages
config: powerpc64-randconfig-002-20260515 (https://download.01.org/0day-ci/archive/20260515/202605150537.AqXMjMVu-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150537.AqXMjMVu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150537.AqXMjMVu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1576:3: error: unterminated function-like macro invocation
    1576 |                 pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
         |                 ^
   include/linux/printk.h:553:9: note: macro 'pr_err' defined here
     553 | #define pr_err(fmt, ...) \
         |         ^
>> drivers/nvme/host/tcp.c:3089:26: error: expected '}'
    3089 | MODULE_ALIAS("nvme-tcp");
         |                          ^
   drivers/nvme/host/tcp.c:1575:42: note: to match this '{'
    1575 |             (!queue->hdr_digest && ctrl_hdgst)) {
         |                                                 ^
>> drivers/nvme/host/tcp.c:3089:26: error: expected '}'
    3089 | MODULE_ALIAS("nvme-tcp");
         |                          ^
   drivers/nvme/host/tcp.c:1475:1: note: to match this '{'
    1475 | {
         | ^
>> drivers/nvme/host/tcp.c:1493:8: error: use of undeclared label 'free_icreq'
    1493 |                 goto free_icreq;
         |                      ^
>> drivers/nvme/host/tcp.c:1514:8: error: use of undeclared label 'free_icresp'
    1514 |                 goto free_icresp;
         |                      ^
   5 errors generated.


vim +1576 drivers/nvme/host/tcp.c

3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1473  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1474  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1475  {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1476  	struct nvme_tcp_icreq_pdu *icreq;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1477  	struct nvme_tcp_icresp_pdu *icresp;
2837966ab2a8117 Hannes Reinecke     2023-08-24  1478  	char cbuf[CMSG_LEN(sizeof(char))] = {};
2837966ab2a8117 Hannes Reinecke     2023-08-24  1479  	u8 ctype;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1480  	struct msghdr msg = {};
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1481  	struct kvec iov;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1482  	bool ctrl_hdgst, ctrl_ddgst;
c2700d2886a87f8 Varun Prakash       2022-01-22  1483  	u32 maxh2cdata;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1484  	int ret;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1485  
bf4afc53b77aeaa Linus Torvalds      2026-02-21  1486  	icreq = kzalloc_obj(*icreq);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1487  	if (!icreq)
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1488  		return -ENOMEM;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1489  
bf4afc53b77aeaa Linus Torvalds      2026-02-21  1490  	icresp = kzalloc_obj(*icresp);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1491  	if (!icresp) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1492  		ret = -ENOMEM;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03 @1493  		goto free_icreq;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1494  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1495  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1496  	icreq->hdr.type = nvme_tcp_icreq;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1497  	icreq->hdr.hlen = sizeof(*icreq);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1498  	icreq->hdr.pdo = 0;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1499  	icreq->hdr.plen = cpu_to_le32(icreq->hdr.hlen);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1500  	icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1501  	icreq->maxr2t = 0; /* single inflight r2t supported */
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1502  	icreq->hpda = 0; /* no alignment constraint */
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1503  	if (queue->hdr_digest)
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1504  		icreq->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1505  	if (queue->data_digest)
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1506  		icreq->digest |= NVME_TCP_DATA_DIGEST_ENABLE;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1507  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1508  	iov.iov_base = icreq;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1509  	iov.iov_len = sizeof(*icreq);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1510  	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1511  	if (ret < 0) {
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1512  		pr_warn("queue %d: failed to send icreq, error %d\n",
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1513  			nvme_tcp_queue_id(queue), ret);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03 @1514  		goto free_icresp;
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1515  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1516  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1517  	memset(&msg, 0, sizeof(msg));
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1518  	iov.iov_base = icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1519  	iov.iov_len = sizeof(*icresp);
363895767fbfa05 Hannes Reinecke     2024-07-22  1520  	if (nvme_tcp_queue_tls(queue)) {
2837966ab2a8117 Hannes Reinecke     2023-08-24  1521  		msg.msg_control = cbuf;
2837966ab2a8117 Hannes Reinecke     2023-08-24  1522  		msg.msg_controllen = sizeof(cbuf);
2837966ab2a8117 Hannes Reinecke     2023-08-24  1523  	}
578539e0969028f Caleb Sander Mateos 2025-01-24  1524  	msg.msg_flags = MSG_WAITALL;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1525  	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1526  			iov.iov_len, msg.msg_flags);
528361c49962708 Dan Carpenter       2025-03-05  1527  	if (ret >= 0 && ret < sizeof(*icresp))
528361c49962708 Dan Carpenter       2025-03-05  1528  		ret = -ECONNRESET;
528361c49962708 Dan Carpenter       2025-03-05  1529  	if (ret < 0) {
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1530  		pr_warn("queue %d: failed to receive icresp, error %d\n",
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1531  			nvme_tcp_queue_id(queue), ret);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1532  		goto free_icresp;
e4f4aabb6f66177 Hannes Reinecke     2023-08-24  1533  	}
0e32fdd7968eb9a Christophe JAILLET  2023-10-30  1534  	ret = -ENOTCONN;
363895767fbfa05 Hannes Reinecke     2024-07-22  1535  	if (nvme_tcp_queue_tls(queue)) {
2837966ab2a8117 Hannes Reinecke     2023-08-24  1536  		ctype = tls_get_record_type(queue->sock->sk,
2837966ab2a8117 Hannes Reinecke     2023-08-24  1537  					    (struct cmsghdr *)cbuf);
2837966ab2a8117 Hannes Reinecke     2023-08-24  1538  		if (ctype != TLS_RECORD_TYPE_DATA) {
2837966ab2a8117 Hannes Reinecke     2023-08-24  1539  			pr_err("queue %d: unhandled TLS record %d\n",
2837966ab2a8117 Hannes Reinecke     2023-08-24  1540  			       nvme_tcp_queue_id(queue), ctype);
0e32fdd7968eb9a Christophe JAILLET  2023-10-30  1541  			goto free_icresp;
2837966ab2a8117 Hannes Reinecke     2023-08-24  1542  		}
2837966ab2a8117 Hannes Reinecke     2023-08-24  1543  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1544  	ret = -EINVAL;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1545  	if (icresp->hdr.type != nvme_tcp_icresp) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1546  		pr_err("queue %d: bad type returned %d\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1547  			nvme_tcp_queue_id(queue), icresp->hdr.type);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1548  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1549  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1550  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1551  	if (le32_to_cpu(icresp->hdr.plen) != sizeof(*icresp)) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1552  		pr_err("queue %d: bad pdu length returned %d\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1553  			nvme_tcp_queue_id(queue), icresp->hdr.plen);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1554  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1555  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1556  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1557  	if (icresp->pfv != NVME_TCP_PFV_1_0) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1558  		pr_err("queue %d: bad pfv returned %d\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1559  			nvme_tcp_queue_id(queue), icresp->pfv);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1560  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1561  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1562  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1563  	ctrl_ddgst = !!(icresp->digest & NVME_TCP_DATA_DIGEST_ENABLE);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1564  	if ((queue->data_digest && !ctrl_ddgst) ||
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1565  	    (!queue->data_digest && ctrl_ddgst)) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1566  		pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1567  			nvme_tcp_queue_id(queue),
7a36402bd09e72c Rohit Chavan        2026-05-04  1568  			str_enabled_disabled(queue->data_digest),
7a36402bd09e72c Rohit Chavan        2026-05-04  1569  			str_enabled_disabled(ctrl_ddgst));
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1570  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1571  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1572  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1573  	ctrl_hdgst = !!(icresp->digest & NVME_TCP_HDR_DIGEST_ENABLE);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1574  	if ((queue->hdr_digest && !ctrl_hdgst) ||
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03 @1575  	    (!queue->hdr_digest && ctrl_hdgst)) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03 @1576  		pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1577  			nvme_tcp_queue_id(queue),
7a36402bd09e72c Rohit Chavan        2026-05-04  1578  			str_enabled_disabled(queue->hdr_digest),
7a36402bd09e72c Rohit Chavan        2026-05-04  1579  			str_enabled_disabled(ctrl_hdgst);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1580  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1581  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1582  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1583  	if (icresp->cpda != 0) {
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1584  		pr_err("queue %d: unsupported cpda returned %d\n",
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1585  			nvme_tcp_queue_id(queue), icresp->cpda);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1586  		goto free_icresp;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1587  	}
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1588  
c2700d2886a87f8 Varun Prakash       2022-01-22  1589  	maxh2cdata = le32_to_cpu(icresp->maxdata);
c2700d2886a87f8 Varun Prakash       2022-01-22  1590  	if ((maxh2cdata % 4) || (maxh2cdata < NVME_TCP_MIN_MAXH2CDATA)) {
c2700d2886a87f8 Varun Prakash       2022-01-22  1591  		pr_err("queue %d: invalid maxh2cdata returned %u\n",
c2700d2886a87f8 Varun Prakash       2022-01-22  1592  		       nvme_tcp_queue_id(queue), maxh2cdata);
c2700d2886a87f8 Varun Prakash       2022-01-22  1593  		goto free_icresp;
c2700d2886a87f8 Varun Prakash       2022-01-22  1594  	}
c2700d2886a87f8 Varun Prakash       2022-01-22  1595  	queue->maxh2cdata = maxh2cdata;
c2700d2886a87f8 Varun Prakash       2022-01-22  1596  
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1597  	ret = 0;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1598  free_icresp:
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1599  	kfree(icresp);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1600  free_icreq:
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1601  	kfree(icreq);
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1602  	return ret;
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1603  }
3f2304f8c6d6ed9 Sagi Grimberg       2018-12-03  1604  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

