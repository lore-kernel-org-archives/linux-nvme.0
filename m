Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A03AC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbdHnxN5kXBuETo7v8xkTpVetDw3V/0gRCWPk2MjzZ8=; b=OLDj7GjNg3UsNX9eyJDFEUfkOI
	fD2VLO0Yt0VVDK8t66dr+M+JGcK8sG0jQUL5NORT7qaZ6YuC5GF19nz91dW4UkFHL7fl2oUN+LCFY
	1SVwgFQj53wjWSvO2OmKoAKZzwuLaVSlJLaghZrOvOm0u14JQ5JSu4kbvYlXP1jEXu3YIl1fKCV7k
	5uk0UYUZprcjMgW7BSwhch3obzDAbCu3p3ZMmlVAr9aTF8kIc5xseBghNEIn1oNNrK21/EGqroNU5
	yEpbwwPJ1Qg4hMFxLgXZ3q2J4aJQnatAR0dWQzfgEV+X/w4mRcKXF+fR6dCz1W/72k4oHTcqluvvU
	51TUY/rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph3Uv-00DP6s-1M;
	Tue, 28 Mar 2023 07:12:01 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph3Us-00DP6A-1b
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 07:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679987518; x=1711523518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EMwksUcgneeDJrIel2ml+6289XzTvwVeWFaCidCXvM=;
  b=M2Dn91QvSPXvtZD8daBUQGAa6+jA0la1S2oOYZ/ywtTlt0l5mopJrLrT
   b0QfsCbgzpEWuCvZ02NnjfMUzGi+9OpwoQwQ1YgsnA4hO2dmq8gQ32AAq
   U9WugtfOcNK8i0DBYA3Qwv1EmQ1Nx5/tQWbSYtWXlvEmEuS6xh7s5Z3z2
   RUtde2KQJowdNLop7kBJ6eZaMLBx7lBsoILyh+SL5Q2OP7QpEkoZaVQYJ
   DfVEFZlKnmvVn8A1VoCyBaSCi9ZJ2JZ7WOjK8+d+FQnEeuXYESdBmE8tu
   rXLiUBWcCrCbcccaKkdzDmbv9wF70Yz7oas2Wlb7RgMSKP4iUhtUjX+1P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426754944"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="426754944"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773033858"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773033858"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2023 00:11:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ph3Un-000IMh-1x;
	Tue, 28 Mar 2023 07:11:53 +0000
Date: Tue, 28 Mar 2023 15:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
	hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v5 11/18] nvme: Add pr_ops read_keys support
Message-ID: <202303281502.U47uzous-lkp@intel.com>
References: <20230324181741.13908-12-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324181741.13908-12-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_001158_561280_8E819EDE 
X-CRM114-Status: GOOD (  13.00  )
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

Hi Mike,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next axboe-block/for-next linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Christie/block-Add-PR-callouts-for-read-keys-and-reservation/20230325-022314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230324181741.13908-12-michael.christie%40oracle.com
patch subject: [PATCH v5 11/18] nvme: Add pr_ops read_keys support
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20230328/202303281502.U47uzous-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/fcd2233cf643c550ab3cea2b6102077b1d05b389
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Christie/block-Add-PR-callouts-for-read-keys-and-reservation/20230325-022314
        git checkout fcd2233cf643c550ab3cea2b6102077b1d05b389
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303281502.U47uzous-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/pr.c:165:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [assigned] [usertype] cdw11 @@     got int @@
   drivers/nvme/host/pr.c:165:24: sparse:     expected restricted __le32 [assigned] [usertype] cdw11
   drivers/nvme/host/pr.c:165:24: sparse:     got int
>> drivers/nvme/host/pr.c:171:21: sparse: sparse: restricted __le32 degrades to integer

vim +165 drivers/nvme/host/pr.c

   156	
   157	static int nvme_pr_resv_report(struct block_device *bdev, void *data,
   158			u32 data_len, bool *eds)
   159	{
   160		struct nvme_command c = { };
   161		int ret;
   162	
   163		c.common.opcode = nvme_cmd_resv_report;
   164		c.common.cdw10 = cpu_to_le32(nvme_bytes_to_numd(data_len));
 > 165		c.common.cdw11 = NVME_EXTENDED_DATA_STRUCT;
   166		*eds = true;
   167	
   168	retry:
   169		ret = nvme_send_pr_command(bdev, &c, data, data_len);
   170		if (ret == NVME_SC_HOST_ID_INCONSIST &&
 > 171		    c.common.cdw11 == NVME_EXTENDED_DATA_STRUCT) {
   172			c.common.cdw11 = 0;
   173			*eds = false;
   174			goto retry;
   175		}
   176	
   177		if (ret < 0)
   178			return ret;
   179	
   180		return nvme_sc_to_pr_err(ret);
   181	}
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

