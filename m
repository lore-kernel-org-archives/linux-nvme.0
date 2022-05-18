Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EF7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKOLgW/CM+HTNv7tX1daSLNdTAVJ0tkIsfPBkVDRsc8=; b=BU0TLUwmkNCOjuxl64tHI6pz0D
	ZdV9mx4LY2E6JpREx6DZMEV+xK5snYe4QbKEo6GQGh13MYw1cBgNnL5ReaqevgqrRsKsX5NuCu0xI
	FF5qiaIwSqK7afaYRoXxZNpD8z21jZ3UPAGYOlyoBmRY+2MPoYS/e/F6B5yFJwZslrJdSkxFYu14M
	y1wJ3+ztP80ZRwbp0KwuVuQIMdpIBYEdelAtmbM+MoO61GiX9v8CnNd0ii0vLQ7MSPeytdS1/R4eq
	8liW7fPKMpp/WKjJFmg1walyiybI1runZyDzpp3C2fduJWOX0JGI4lf+0wbVKSzoXCgI4LLwPppfg
	TYCVBApg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrT1P-004GnW-FS; Wed, 18 May 2022 23:24:03 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrT1M-004Glv-Am
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 23:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652916240; x=1684452240;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mRamq6y/FrL9IrxKmzQMYKfzRyhfzGHairLTpmN6JHc=;
 b=Q6p4fpa+2RuNwEh1IIubm3B/gxQ8gcggEUXJCbeyKNy/U574OkvrCqIO
 5+bgl9SYYngiZSOLfZA7gdlSdvhIaaxfOr9p3BmYJFzQhrwt2BHQtCgDh
 n8qYfWBjNBqSNJMNnT9uqMxEdFDW51oW/WHMxCvMtj1Spzi2p4N2LTHpB
 VGWZjVnXejJQr7RLYtUCkCXIuTq+Az+zLvzMVWHNZyN4KdFqli44Crr+x
 q+co5/Pd2/ZcCBZzkIWBeCao3DnKSeyO4baEfmir1aICzEQ4JHm5SQmHj
 dQXuGA9QoQ5CdKWEdM/3LIXAawBgKcTKIsS7f4DbsC8bOlv3SbKhr3ZLO A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259504345"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="259504345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 16:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; d="scan'208";a="627292758"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 18 May 2022 16:23:54 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nrT1F-0002lT-NY;
 Wed, 18 May 2022 23:23:53 +0000
Date: Thu, 19 May 2022 07:23:41 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: kbuild-all@lists.01.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: remove the done argument to
 blk_execute_rq_nowait
Message-ID: <202205190712.zyCIh9kG-lkp@intel.com>
References: <20220517064901.3059255-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064901.3059255-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_162400_493109_FABEB1D9 
X-CRM114-Status: GOOD (  16.29  )
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

Hi Christoph,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on next-20220518]
[cannot apply to mkp-scsi/for-next jejb-scsi/for-next linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/blk-mq-remove-__blk_execute_rq_nowait/20220517-154900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190712.zyCIh9kG-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2dc03b4b4f1f1aa542a1ab6d6ff64be3d9db050c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-Hellwig/blk-mq-remove-__blk_execute_rq_nowait/20220517-154900
        git checkout 2dc03b4b4f1f1aa542a1ab6d6ff64be3d9db050c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/ufs/ufshpb.c: In function 'ufshpb_execute_map_req':
>> drivers/scsi/ufs/ufshpb.c:721:41: error: expected ';' before 'hpb'
     721 |         blk_execute_rq_nowait(req, true)
         |                                         ^
         |                                         ;
     722 | 
     723 |         hpb->stats.map_req_cnt++;
         |         ~~~                              


vim +721 drivers/scsi/ufs/ufshpb.c

   683	
   684	static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
   685					  struct ufshpb_req *map_req, bool last)
   686	{
   687		struct request_queue *q;
   688		struct request *req;
   689		struct scsi_cmnd *scmd;
   690		int mem_size = hpb->srgn_mem_size;
   691		int ret = 0;
   692		int i;
   693	
   694		q = hpb->sdev_ufs_lu->request_queue;
   695		for (i = 0; i < hpb->pages_per_srgn; i++) {
   696			ret = bio_add_pc_page(q, map_req->bio, map_req->rb.mctx->m_page[i],
   697					      PAGE_SIZE, 0);
   698			if (ret != PAGE_SIZE) {
   699				dev_err(&hpb->sdev_ufs_lu->sdev_dev,
   700					   "bio_add_pc_page fail %d - %d\n",
   701					   map_req->rb.rgn_idx, map_req->rb.srgn_idx);
   702				return ret;
   703			}
   704		}
   705	
   706		req = map_req->req;
   707	
   708		blk_rq_append_bio(req, map_req->bio);
   709	
   710		req->end_io_data = map_req;
   711		req->end_io = ufshpb_map_req_compl_fn;
   712	
   713		if (unlikely(last))
   714			mem_size = hpb->last_srgn_entries * HPB_ENTRY_SIZE;
   715	
   716		scmd = blk_mq_rq_to_pdu(req);
   717		ufshpb_set_read_buf_cmd(scmd->cmnd, map_req->rb.rgn_idx,
   718					map_req->rb.srgn_idx, mem_size);
   719		scmd->cmd_len = HPB_READ_BUFFER_CMD_LENGTH;
   720	
 > 721		blk_execute_rq_nowait(req, true)
   722	
   723		hpb->stats.map_req_cnt++;
   724		return 0;
   725	}
   726	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

