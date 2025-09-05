Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C1CA1010
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLJ9NOhG6RkLmhJWJ488Dd/186kC5dy0tb/zcUScb8E=; b=b1i2NPXkVBbuNkAPZ+c128zyb1
	OGhJlvUbNAk6U9GMIPT6Lj/G6sD2E3MZIUMssDOCfk0HGBjHwdxqY+hED0IfnUNMNKvfsn5BBDOH8
	BWfqI5cLkc7guhiyu7WQbQV4xNLnjxqbQJswyHNNIbRqOEamvKZOfdy/JCiKbhKC3zRjpn045gNVg
	1EiVB5i2KANBQhfrphTE2JuPKvqPBBpGLeBZ9IY2H0SvV+4yv4Gck/KEJLIe/hGFQ4j8oPwblk/Gd
	UmhjriVcfA4Z/1nX1JQkf7A6T4C6HD/S+b65Vu+bBfe6MfOHwtNytVapraxYKblSgHxj5ECtuZ/m9
	McHHyTHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuayk-00000003j2y-3QqG;
	Fri, 05 Sep 2025 18:16:06 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuX1G-00000002AEa-3yud
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 14:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757080947; x=1788616947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7SNkxBMDceyrMBtDVw3FbEQeKmi497N1GJZiGp7K9k=;
  b=PilpM7Y8RYL1Wq1Grt/Axvr4qbtPMm/n20oMAGZyFZfpz0vNbuLB6c+o
   aB67hD5WF7SJ5p6okltdjjqzpln8MP+9eMh66ymR6pnLSPkueDYC+Q0nF
   zIt5A0EKhvdo2zWahjEog5pPmKayJ9aPzVJK7PTU4QsHy04GKcfshWBtH
   eq6I5I9HToCevU2G8JHYfWnZAfEqvuZk7V89QyUCnpV4KJnjgco80Cz86
   BrePrH9SyNrG4YjzSqIg9oW/32/tNE8Me+y5vD1FYaYxN/ObwJ4d79IyI
   V60/fv2X9cz45vv6Lb6UNoPslpsViVFT8dY0L6x2l3I67j7bhhoXpac1A
   Q==;
X-CSE-ConnectionGUID: W/L1MsDFQymhG/ZFIgeMFQ==
X-CSE-MsgGUID: v7TbkgA/TiCLhHgVrkiK6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70046427"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70046427"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:02:25 -0700
X-CSE-ConnectionGUID: 7tJWMnQ6TUWYlbJDxGoMTg==
X-CSE-MsgGUID: FiViECbySquhBvzeXiGqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="195826206"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2025 07:02:21 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuX19-0000Tv-05;
	Fri, 05 Sep 2025 14:02:19 +0000
Date: Fri, 5 Sep 2025 22:01:45 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
Message-ID: <202509052153.luapQMZm-lkp@intel.com>
References: <20250905024659.811386-8-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-8-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_070227_029015_47C98A64 
X-CRM114-Status: GOOD (  13.33  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on net/main net-next/main linus/master v6.17-rc4 next-20250905]
[cannot apply to linux-nvme/for-next horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250905-105201
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250905024659.811386-8-alistair.francis%40wdc.com
patch subject: [PATCH v2 7/7] nvmet-tcp: Support KeyUpdate
config: s390-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052153.luapQMZm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052153.luapQMZm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052153.luapQMZm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/tcp.c: In function 'nvmet_tcp_tls_record_ok':
>> drivers/nvme/target/tcp.c:1173:12: warning: unused variable 'htype' [-Wunused-variable]
    1173 |  u8 ctype, htype, level, description;
         |            ^~~~~
   drivers/nvme/target/tcp.c: In function 'nvmet_tcp_io_work':
   drivers/nvme/target/tcp.c:1479:5: error: implicit declaration of function 'update_tls_keys'; did you mean 'update_cr_regs'? [-Werror=implicit-function-declaration]
    1479 |     update_tls_keys(queue);
         |     ^~~~~~~~~~~~~~~
         |     update_cr_regs
   cc1: some warnings being treated as errors


vim +/htype +1173 drivers/nvme/target/tcp.c

  1168	
  1169	static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
  1170			struct msghdr *msg, char *cbuf)
  1171	{
  1172		struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
> 1173		u8 ctype, htype, level, description;
  1174		int ret = 0;
  1175	
  1176		ctype = tls_get_record_type(queue->sock->sk, cmsg);
  1177		switch (ctype) {
  1178		case 0:
  1179			break;
  1180		case TLS_RECORD_TYPE_DATA:
  1181			break;
  1182		case TLS_RECORD_TYPE_ALERT:
  1183			tls_alert_recv(queue->sock->sk, msg, &level, &description);
  1184			if (level == TLS_ALERT_LEVEL_FATAL) {
  1185				pr_err("queue %d: TLS Alert desc %u\n",
  1186				       queue->idx, description);
  1187				ret = -ENOTCONN;
  1188			} else {
  1189				pr_warn("queue %d: TLS Alert desc %u\n",
  1190				       queue->idx, description);
  1191				ret = -EAGAIN;
  1192			}
  1193			break;
  1194		case TLS_RECORD_TYPE_HANDSHAKE:
  1195			ret = -EAGAIN;
  1196			break;
  1197		default:
  1198			/* discard this record type */
  1199			pr_err("queue %d: TLS record %d unhandled\n",
  1200			       queue->idx, ctype);
  1201			ret = -EAGAIN;
  1202			break;
  1203		}
  1204		return ret;
  1205	}
  1206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

