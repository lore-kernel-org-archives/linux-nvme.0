Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818FCCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqM0kHIE9alfaO+iN5jAAc6b6FGT/OqUh5vpZMam6DM=; b=jjaX7WTbiUjohDD6diw7wFAa8S
	Z5Qzm4aJoYal1IER5aM6YLrFkzOsQkeKb5+fj5KdruVwemNGv04/lahyRNPFSmFY+Q77iZ6Eid3g/
	O9hWmWQVjDWfkKuaHqR5qgM0jh6qXvWCjvCBmSbLNJGIkTHoeK5QJNbdEEHk1YtYAidahIJzV22Sx
	Cq4sQoKrpaouARzqqxQSyXCvxwsNCH7mEmcaOVL+0ODxMAehfM9F97uXWIHZJd/D0VDf4ZMSDlSAy
	DmZ7qj3l9ss/4IiCt2D0w2l5BaYYwI5DXvn5uZneE8aMFR4wj2DTDQhCVn8dkonC6a/1EqE0Cg9Cs
	kanu8APQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6yJr-00000007AaJ-3wiS;
	Thu, 09 Oct 2025 21:37:03 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6yJp-00000007AZw-35hD
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 21:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760045821; x=1791581821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgS44lxvbU6lDjItJfGDfhpBYiflSNB4fwxf9JnAi6Y=;
  b=APr4ziWvRKvfQwVp6SUCwVBLo3L4o6SHv08YviO9K4gopQcFResmWZOm
   i10GeD0sNiUOBm1ygy2Yhcq4qHESNKIu5l33Jt7yMO6N1gaM5rgHgqL7i
   cXvU5nlKGnnHjiRcAC2wxqMyJkJ2LasJiw63qXNwENPti4zvTACnE/UMy
   CTnkqaXK5gbvB3L09AWZGc1dTROGu1MmWo3sivADUIRLxiLEO4taRs3fW
   i5qfcew7hNGSsSyHGnQn5hN66k9ichChnG6iQVLqMYdngpwGqIPVc5Ncx
   Uz5Gyt/OmVseUtlCKlXIlst9ybEquZfLRiTbBW1wSj1BLEwur48tvfjpX
   A==;
X-CSE-ConnectionGUID: 0SBawlvoTqGiXQchOhUB3w==
X-CSE-MsgGUID: GSd1s1x8QGyXgnuyBYU8dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="87726932"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="87726932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 14:36:57 -0700
X-CSE-ConnectionGUID: ue2VzTsYTIu45ra031tL6Q==
X-CSE-MsgGUID: a2v1uV22T0GvaG+Bfk2Zkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="186082522"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Oct 2025 14:36:53 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6yJe-0001VD-2D;
	Thu, 09 Oct 2025 21:36:50 +0000
Date: Fri, 10 Oct 2025 05:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
Message-ID: <202510100505.gzOzGPbI-lkp@intel.com>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007004634.38716-2-wilfred.opensource@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_143701_811971_8AF36FE0 
X-CRM114-Status: GOOD (  14.99  )
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

Hi Wilfred,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master linux-nvme/for-next v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wilfred-Mallawa/nvme-tcp-handle-tls-partially-sent-records-in-write_space/20251009-193029
base:   net/main
patch link:    https://lore.kernel.org/r/20251007004634.38716-2-wilfred.opensource%40gmail.com
patch subject: [PATCH] nvme/tcp: handle tls partially sent records in write_space()
config: s390-randconfig-002-20251010 (https://download.01.org/0day-ci/archive/20251010/202510100505.gzOzGPbI-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100505.gzOzGPbI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100505.gzOzGPbI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1316:22: warning: unused variable 'ctx' [-Wunused-variable]
    1316 |         struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
         |                             ^~~
   1 warning generated.


vim +/ctx +1316 drivers/nvme/host/tcp.c

  1312	
  1313	static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
  1314	{
  1315		struct nvme_tcp_request *req;
> 1316		struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
  1317		unsigned int noreclaim_flag;
  1318		int ret = 1;
  1319	
  1320		if (!queue->request) {
  1321			queue->request = nvme_tcp_fetch_request(queue);
  1322			if (!queue->request)
  1323				return 0;
  1324		}
  1325		req = queue->request;
  1326	
  1327		noreclaim_flag = memalloc_noreclaim_save();
  1328		if (req->state == NVME_TCP_SEND_CMD_PDU) {
  1329			ret = nvme_tcp_try_send_cmd_pdu(req);
  1330			if (ret <= 0)
  1331				goto done;
  1332			if (!nvme_tcp_has_inline_data(req))
  1333				goto out;
  1334		}
  1335	
  1336		if (req->state == NVME_TCP_SEND_H2C_PDU) {
  1337			ret = nvme_tcp_try_send_data_pdu(req);
  1338			if (ret <= 0)
  1339				goto done;
  1340		}
  1341	
  1342		if (req->state == NVME_TCP_SEND_DATA) {
  1343			ret = nvme_tcp_try_send_data(req);
  1344			if (ret <= 0)
  1345				goto done;
  1346		}
  1347	
  1348		if (req->state == NVME_TCP_SEND_DDGST)
  1349			ret = nvme_tcp_try_send_ddgst(req);
  1350	done:
  1351		if (ret == -EAGAIN) {
  1352			ret = 0;
  1353		} else if (ret < 0) {
  1354			dev_err(queue->ctrl->ctrl.device,
  1355				"failed to send request %d\n", ret);
  1356			nvme_tcp_fail_request(queue->request);
  1357			nvme_tcp_done_send_req(queue);
  1358		}
  1359	out:
  1360		memalloc_noreclaim_restore(noreclaim_flag);
  1361		return ret;
  1362	}
  1363	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

