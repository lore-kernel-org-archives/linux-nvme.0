Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58ADCD37BE
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zoh82QG96RTJM0Nffi3MkHTZXf6XWPEUAh48DjvCrpY=; b=FDUqTJveUVYESueUIrFqx5OpDG
	1BqBRn1s6cbu5PeQbc6Pi6yCbNgNQpZ+/3sMZL9sqqI8TO1vX/VW2DvQakfLjPxoBZS0H7hmJQAfx
	7De9kk4Rtt4MHp89BcHP/eM1D7v6Q0NL11HpMiaFAk8JFC6u59zZjzdjhzRZ2MUQbr+P329iaM0f3
	v2AFvK77Fd4ju5b2/9Rxjmx3NVfGS8sFxKT3pe1Rts0KSNWNQsgXIU8Y+NL1CxWHW1RDAhw0eEeTV
	+oUFfYF6MGiUfUNBTR86B24z2KjcKuGa4YDEH3rj0LELqTazIMPoUmHupEc6CWg1gQ+kjA26qW8wk
	cQAq6bHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMbKW-0000000F7NE-0Tw2;
	Tue, 12 May 2026 00:50:36 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMbKQ-0000000F7MY-3wrO
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 00:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778547031; x=1810083031;
  h=date:from:to:cc:subject:message-id;
  bh=JwqU7Ee39TWRwtwE6qQ2aJ/YD2wFDlDj7uj8bGIqBvg=;
  b=PSjBOC/Oovwi0AtSZtK7e4mKTtVrwnQfBk0wF+zbAFgrn6ro+whN0fZp
   3Zg/H3p23s++q13e6Dw4V5wNltsqOGJOJPBaxM6PN5ib9wPRiFlb7nNgZ
   9VUYATT/kXEu9L4kBEk7wDbwht+k9ja2qiX1A8HptQMZDgufqziTDOfu3
   2Nx1VJhc7CqxlU6XsQusBOnY/TwLYxTrumzYsp8Len40/KpYMJPsFQ2FX
   qFzBBqJJoq1xN1tc137m0KFtH7nJtza0I7DZOWznKfh+8PjarPA/7+Mk3
   /felvJtOUneX9hnFnFodcdsMAn99bCe2K27xirqBYizajVT5c3YU1wat8
   A==;
X-CSE-ConnectionGUID: GfKsxsEnSdy+e/yTmF30aA==
X-CSE-MsgGUID: RH69eCzvTWGcE1kQLkqFeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79343976"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79343976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 17:50:28 -0700
X-CSE-ConnectionGUID: mHeXVDrrQ2S5ClTKNOxNjQ==
X-CSE-MsgGUID: Xqz5gP93SEuGcXT//38T5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242585229"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 May 2026 17:50:26 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMbKJ-000000001NF-1PZ0;
	Tue, 12 May 2026 00:50:23 +0000
Date: Tue, 12 May 2026 08:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-7.1 5/7] drivers/nvme/target/tcp.c:1325:46:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202605120806.84Oz8bWJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_175031_062365_9BA9BC0D 
X-CRM114-Status: GOOD (  10.60  )
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

tree:   git://git.infradead.org/nvme.git nvme-7.1
head:   37953cec775ed34e59cf9a7d7bb9b0610daa3f3e
commit: dbbd07d0a7020b80f6a7028e561908f7b83b3d5a [5/7] nvmet-tcp: Fix potential UAF when ddgst mismatch
config: sparc64-randconfig-r123-20260512 (https://download.01.org/0day-ci/archive/20260512/202605120806.84Oz8bWJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605120806.84Oz8bWJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605120806.84Oz8bWJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/tcp.c:1325:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] status @@     got int @@
   drivers/nvme/target/tcp.c:1325:46: sparse:     expected restricted __le16 [usertype] status
   drivers/nvme/target/tcp.c:1325:46: sparse:     got int

vim +1325 drivers/nvme/target/tcp.c

  1288	
  1289	static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
  1290	{
  1291		struct nvmet_tcp_cmd *cmd = queue->cmd;
  1292		int ret, len;
  1293		char cbuf[CMSG_LEN(sizeof(char))] = {};
  1294		struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
  1295		struct kvec iov = {
  1296			.iov_base = (void *)&cmd->recv_ddgst + queue->offset,
  1297			.iov_len = queue->left
  1298		};
  1299	
  1300		if (queue->tls_pskid) {
  1301			msg.msg_control = cbuf;
  1302			msg.msg_controllen = sizeof(cbuf);
  1303		}
  1304		len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
  1305				iov.iov_len, msg.msg_flags);
  1306		if (unlikely(len < 0))
  1307			return len;
  1308		if (queue->tls_pskid) {
  1309			ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
  1310			if (ret < 0)
  1311				return ret;
  1312		}
  1313	
  1314		queue->offset += len;
  1315		queue->left -= len;
  1316		if (queue->left)
  1317			return -EAGAIN;
  1318	
  1319		if (queue->data_digest && cmd->exp_ddgst != cmd->recv_ddgst) {
  1320			pr_err("queue %d: cmd %d pdu (%d) data digest error: recv %#x expected %#x\n",
  1321				queue->idx, cmd->req.cmd->common.command_id,
  1322				queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
  1323				le32_to_cpu(cmd->exp_ddgst));
  1324			if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED)) {
> 1325				cmd->req.cqe->status = NVME_SC_CMD_SEQ_ERROR;
  1326				nvmet_req_uninit(&cmd->req);
  1327			}
  1328			nvmet_tcp_free_cmd_buffers(cmd);
  1329			ret = -EPROTO;
  1330			goto out;
  1331		}
  1332	
  1333		if (cmd->rbytes_done == cmd->req.transfer_len)
  1334			nvmet_tcp_execute_request(cmd);
  1335	
  1336		ret = 0;
  1337	out:
  1338		nvmet_prepare_receive_pdu(queue);
  1339		return ret;
  1340	}
  1341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

