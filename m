Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E8C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NVe9cNfJ9ZrWuwVX/Qlh5NlcwU9a+Yet8RYQbgrTXk=; b=hYUThNTJcez0uoF1XNGlEmZhEY
	VBlzYEDVL98V9Pd2yB+4J7L4jt3A+MCNkXyGwbhMytucD8+1YLSN5ZAi3DsYwvyuA+bsRYaKNUHIC
	orcdSU4Gd+SQkfnftxfpLgWCVDIgyp8zD7T328hJcJUmTdpRqnLQII8fnZrTSV1Hs+LYXT4TBHG4k
	3xFo6noSFiZ4n86wnhawd4WWN7xqUhPvrkfmM53tApWyZawF6De/FivSSDauR0QPkt5DhdXV0PV0z
	Y/0jaK8OwXM3bBA2FIwFNPH6PcnJj5fEl+RQ7tEQO7vMlLJ85v+0G9ppzAFXEOvzUPnWTRqrX9zVk
	iDOfrFSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXpl-000oHj-36;
	Wed, 29 Mar 2023 15:35:33 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXpj-000oGT-00
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680104130; x=1711640130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNS1M2RM9Rk4Uy0VwUr2zlDcBxvRJk8YLS721HVn1hw=;
  b=D2F5j2RmUeBrzGevsBHD5PfPWN18ypj1YoqBRSb2n6jWf08b4DqoCZIz
   2aiYKflKfQNiJCRAzmgLDl7Cl+mIqW9tATrXKpNwDpaHXoUngWgXqv+sW
   r0wd3evrn0NZOcLuu05VNuEgrzmrktdWrBOSizkA11X6lxvljwIH4tmb9
   XChmCNgMyoBCRCc1hi8Tma6Mga65petJ0dZQYiolqSTEU9gc8uE5yMh05
   iS/E9pQCt5doEUskMmUheV4AdLHcDBo/LHWvxh8fgyjuric0SJQxGefXI
   80IdLVreDshUCjxkDgZYqxfLClQgGTB9vrj5MOCVGvFJn4SQeYj89xHHJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="340935258"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="340935258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677812139"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="677812139"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 08:30:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1phXlK-000JfU-0G;
	Wed, 29 Mar 2023 15:30:58 +0000
Date: Wed, 29 Mar 2023 23:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bvanassche@acm.org, hare@suse.de,
	ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <202303292349.ED70Fxdw-lkp@intel.com>
References: <20230327084103.21601-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327084103.21601-5-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083531_051072_3A5B26E4 
X-CRM114-Status: GOOD (  20.22  )
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

Hi Anuj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on device-mapper-dm/for-next linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230327084103.21601-5-anuj20.g%40samsung.com
patch subject: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for direct block device.
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20230329/202303292349.ED70Fxdw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/61819d260936954ddd6688548f074e7063dcf39e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anuj-Gupta/block-Add-copy-offload-support-infrastructure/20230329-162018
        git checkout 61819d260936954ddd6688548f074e7063dcf39e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292349.ED70Fxdw-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `generic_copy_file_checks':
>> fs/read_write.c:1453: undefined reference to `I_BDEV'


vim +1453 fs/read_write.c

  1398	
  1399	/*
  1400	 * Performs necessary checks before doing a file copy
  1401	 *
  1402	 * Can adjust amount of bytes to copy via @req_count argument.
  1403	 * Returns appropriate error code that caller should return or
  1404	 * zero in case the copy should be allowed.
  1405	 */
  1406	static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
  1407					    struct file *file_out, loff_t pos_out,
  1408					    size_t *req_count, unsigned int flags)
  1409	{
  1410		struct inode *inode_in = file_inode(file_in);
  1411		struct inode *inode_out = file_inode(file_out);
  1412		uint64_t count = *req_count;
  1413		loff_t size_in;
  1414		int ret;
  1415	
  1416		ret = generic_file_rw_checks(file_in, file_out);
  1417		if (ret)
  1418			return ret;
  1419	
  1420		/*
  1421		 * We allow some filesystems to handle cross sb copy, but passing
  1422		 * a file of the wrong filesystem type to filesystem driver can result
  1423		 * in an attempt to dereference the wrong type of ->private_data, so
  1424		 * avoid doing that until we really have a good reason.
  1425		 *
  1426		 * nfs and cifs define several different file_system_type structures
  1427		 * and several different sets of file_operations, but they all end up
  1428		 * using the same ->copy_file_range() function pointer.
  1429		 */
  1430		if (flags & COPY_FILE_SPLICE) {
  1431			/* cross sb splice is allowed */
  1432		} else if (file_out->f_op->copy_file_range) {
  1433			if (file_in->f_op->copy_file_range !=
  1434			    file_out->f_op->copy_file_range)
  1435				return -EXDEV;
  1436		} else if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb) {
  1437			return -EXDEV;
  1438		}
  1439	
  1440		/* Don't touch certain kinds of inodes */
  1441		if (IS_IMMUTABLE(inode_out))
  1442			return -EPERM;
  1443	
  1444		if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
  1445			return -ETXTBSY;
  1446	
  1447		/* Ensure offsets don't wrap. */
  1448		if (pos_in + count < pos_in || pos_out + count < pos_out)
  1449			return -EOVERFLOW;
  1450	
  1451		/* Shorten the copy to EOF */
  1452		if (S_ISBLK(inode_in->i_mode))
> 1453			size_in = bdev_nr_bytes(I_BDEV(file_in->f_mapping->host));
  1454		else
  1455			size_in = i_size_read(inode_in);
  1456	
  1457		if (pos_in >= size_in)
  1458			count = 0;
  1459		else
  1460			count = min(count, size_in - (uint64_t)pos_in);
  1461	
  1462		ret = generic_write_check_limits(file_out, pos_out, &count);
  1463		if (ret)
  1464			return ret;
  1465	
  1466		/* Don't allow overlapped copying within the same file. */
  1467		if (inode_in == inode_out &&
  1468		    pos_out + count > pos_in &&
  1469		    pos_out < pos_in + count)
  1470			return -EINVAL;
  1471	
  1472		*req_count = count;
  1473		return 0;
  1474	}
  1475	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

