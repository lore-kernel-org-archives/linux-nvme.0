Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEDC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 15:06:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F81061954
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 15:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F81061954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wIAtWqeNptXe/NdH6bWvOcTCZ9+9Pjtm+5bXV7/WOGM=; b=JCAMhuRlNAAY5xplXi1CNg3E8
	w8lLVYWQQ8OS1lapLQBCwHMsI+zRNyMxJ4zT1UJ3GkgeyyfhJRb7n/KShei4HGv4ZTT7Bl5FLwSO+
	HCn+RwOf5k5VljmQMYWgsjmVoUDFwkNvSwFt12DpVc21wL82rkp3YNh+PP/2eUVJe7Wh3BjHszz+Y
	c9y5IE7oJJz3UFYkwxNuyhbj6YnPWIUiAtBzh7ZKpLq0mCFLI1LJAC1nqugnEzVdL+v1BFtPSjhIR
	JhLRROEu1ElWR0wsUQKar/aayItZxP+fIPK1RAq/3uwBZz7vQL9YZ5JoCxM3vlbJUNf3PJInKJ8aQ
	kcjh8tyew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgqQn-0037Dw-TE; Wed, 12 May 2021 15:05:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgqQj-0037DN-Bd
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 15:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fWqAb6Cw85wQS9aZXSvcFCKiKB4A6lG9v4UAq3FQYu4=; b=eoXpVKx7LbJZWvLGNnrTkb2CyQ
 S6AxqQPh3BRVjBQ+SF9h8u3FomPgjkQTNc97kKKwE5huWh19J/fUFXjfEjbG2HBiJs3PYetQhibgo
 VHEhI4XXU6ZGnBB+2843duPKntE8WY3bTdB/7ZQkRz497XxoDkKLf6Cw2vnZBL+URmRTS7H5hLf9L
 swc7//V2OU76gjYWbkeCMIZT6vRCECIJqQC3+210z6nhGy624KuPynXyxX1bh4lvOOtk3eVXUL4cu
 1mJl0K7OWCdVV5JSlT7B6yKXtBDEMK2cQ7wpYZHsmGdnXCm5rbxDFPCsJkgGMz2Kjkyfh7CWzG73M
 iaSB8l3g==;
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgqQg-00AU2O-3W
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 15:05:44 +0000
IronPort-SDR: k48maeGLg63tIN2K/08hFTPsfEZ8In6veJwblxkFeU+cVmMvqqrZSzIYj94aXPqhtcClYl8R4Z
 TPyHVtKZ0IQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="260978216"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
 d="gz'50?scan'50,208,50";a="260978216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 08:05:40 -0700
IronPort-SDR: GksdELOoVceY0xAA1+0gQUc6dCDa6sBaSOp+yoZAN5f9NyfN6LXLBAlFSyFQKC5tNOvIPA22d6
 yDRKrpmMZN7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
 d="gz'50?scan'50,208,50";a="435243212"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 12 May 2021 08:05:37 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lgqQa-0000L8-Dx; Wed, 12 May 2021 15:05:36 +0000
Date: Wed, 12 May 2021 23:05:01 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH] nvmet: Reset ns->file when open fails
Message-ID: <202105122247.R5Vzvzg7-lkp@intel.com>
References: <20210512101352.23725-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20210512101352.23725-1-dwagner@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_080542_285445_ABAC097A 
X-CRM114-Status: GOOD (  16.63  )
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on hch-configfs/for-next linus/master v5.13-rc1 next-20210512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Wagner/nvmet-Reset-ns-file-when-open-fails/20210512-181435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
config: nios2-randconfig-p002-20210512 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/406c65a33980a0f58f21c897d9283d9fff9a4eb5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Wagner/nvmet-Reset-ns-file-when-open-fails/20210512-181435
        git checkout 406c65a33980a0f58f21c897d9283d9fff9a4eb5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/target/io-cmd-file.c: In function 'nvmet_file_ns_enable':
>> drivers/nvme/target/io-cmd-file.c:54:7: warning: assignment to 'int' from 'struct file *' makes integer from pointer without a cast [-Wint-conversion]
      54 |   ret = ns->file;
         |       ^
>> drivers/nvme/target/io-cmd-file.c:56:18: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
      56 |   return PTR_ERR(ret);
         |                  ^~~
         |                  |
         |                  int
   In file included from include/linux/kernfs.h:10,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/dma-mapping.h:7,
                    from drivers/nvme/target/nvmet.h:9,
                    from drivers/nvme/target/io-cmd-file.c:11:
   include/linux/err.h:29:61: note: expected 'const void *' but argument is of type 'int'
      29 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~


vim +54 drivers/nvme/target/io-cmd-file.c

    41	
    42	int nvmet_file_ns_enable(struct nvmet_ns *ns)
    43	{
    44		int flags = O_RDWR | O_LARGEFILE;
    45		int ret;
    46	
    47		if (!ns->buffered_io)
    48			flags |= O_DIRECT;
    49	
    50		ns->file = filp_open(ns->device_path, flags, 0);
    51		if (IS_ERR(ns->file)) {
    52			pr_err("failed to open file %s: (%ld)\n",
    53					ns->device_path, PTR_ERR(ns->file));
  > 54			ret = ns->file;
    55			ns->file = NULL;
  > 56			return PTR_ERR(ret);
    57		}
    58	
    59		ret = nvmet_file_ns_revalidate(ns);
    60		if (ret)
    61			goto err;
    62	
    63		/*
    64		 * i_blkbits can be greater than the universally accepted upper bound,
    65		 * so make sure we export a sane namespace lba_shift.
    66		 */
    67		ns->blksize_shift = min_t(u8,
    68				file_inode(ns->file)->i_blkbits, 12);
    69	
    70		ns->bvec_cache = kmem_cache_create("nvmet-bvec",
    71				NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
    72				0, SLAB_HWCACHE_ALIGN, NULL);
    73		if (!ns->bvec_cache) {
    74			ret = -ENOMEM;
    75			goto err;
    76		}
    77	
    78		ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
    79				mempool_free_slab, ns->bvec_cache);
    80	
    81		if (!ns->bvec_pool) {
    82			ret = -ENOMEM;
    83			goto err;
    84		}
    85	
    86		return ret;
    87	err:
    88		ns->size = 0;
    89		ns->blksize_shift = 0;
    90		nvmet_file_ns_disable(ns);
    91		return ret;
    92	}
    93	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICErIm2AAAy5jb25maWcAjDzbcts2sO/9Ck46c6Z9SGLJzm3O+AEkQREVSNAAKFt+4agy
k2qqWDmS3DZ/fxbgDQBBJZ1Jbe4ubovF3rDwr7/8GqCX8+Hr5rzbbvb778GX+rk+bs71U/B5
t6//N4hZkDMZ4JjIN0BMd88v/7193h1O8+Ddm9n8zVWwrI/P9T6IDs+fd19eoO3u8PzLr79E
LE/IooqiaoW5ICyvJH6Qt69029d71c/rL9tt8Nsiin4PPr25fnP1ymhERAWI2+8daDF0dPvp
6vrqqqelKF/0qB6MhO4iL4cuANSRza9vhh5orEjDJB5IAeQnNRBXxmxT6BuJrFowyYZeDATJ
KcmxgWK5kLyMJONigBJ+V90zvgQIcPDXYKE3Yx+c6vPLt4GnIWdLnFfAUpEVRuucyArnqwpx
mCnJiLy9nkMv/ZBZQSiGbRAy2J2C58NZddwvjUWIdmt79coHrlBpLi8sCbBDICoN+hgnqKRS
T8YDTpmQOcrw7avfng/P9e89AeJRWuWsEvfIWJJYixUpDDEomCAPVXZX4tLg5j2S0LoDDivm
TIgqwxnj6wpJiaLUs/BSYEpCsx0qQdpNSr0ZsDnB6eXP0/fTuf46bMYC55iTSO9dwVloTMtE
iZTd+zEk/wNHUnHdi45SUtgSErMMkdyGCZL5iKqUYK5YuzZ4WiAusCLyDxjjsFwkQjOkfn4K
Dp+dpbuNIpCRJV7hXIpOcOXua308+diVPlYFtGIxiUyWw84DhsQUm3y30V5MShZpxbGoJMlA
Sm2advqj2fTSxDHOCgnd55bgdPAVo2UuEV97h26pRoISFeVbuTn9HZxh3GADczidN+dTsNlu
Dy/P593zl4EdkkTLChpUKIoYjEXyhSHsglgf/SmKiUAhxbG5Rz8xqp4dj8pAjPcFRl5XgDPZ
AJ8VfoDt8ukL0RCbzR0QEkuh+2gFxYMagcoY++CSowj302tXbK+kF/5l84txHJYpRjE2FS1l
Sn0lcCpJIm9nHwaBILlcgk5LsEtz3bBPbP+qn1729TH4XG/OL8f6pMHtlDxYQx0tOCsL4ZWl
KMXRsmAwuhJmsAr+cyCALtZqWPflp1mLRICogHhGSOLYs3ccU2RohJAugX6ldTaPbYPCUQa9
CVbyCCt9PghHXC0eSeHrPa5CwMyHjgBCHzNkAR4eHTyzRE9BbvydPwppTDJkTFb9lg8MjSpW
gE4gj7hKGFdKB35kKI+wp1eXWsAvxhBFMnw0B8IcKoMjScCKcN8pWWCZgQirXQFDSs12zUa1
CO9WJinKp1RiYwnHWs+SZHM40OoeuhCBLUhKPbNu1BI8NeezKojZFy6YPeVuSWSRI2p6UnqC
SWw1VqYi8cmlSMFYW5aYMA8ZYVXJLU2J4hWBdbS8FNbu4CxEnBPv9iwV9TqzGnSwCnmX2KM1
59RJkmRlWQ8QF9+uDu4G11rc5NIyMh05mDGOY2wxrYhmVzcjU9P63kV9/Hw4ft08b+sA/1M/
g9pHoJAipfjB8pka6idbdFNZZc12Vdo6NTrU8iiRBHd06dtLiiynStAy9OsrysKJ9rB5fIE7
s2f3BtgEDDAlAlQmHBOWTXXSk6WIx2CKLL6KtEwS8IoLBAPBjoG7C9rX19VaSJxVMZJIhQAk
IUBpeW3g/SWENnLZ89t24TvSnDBh6MfekxJlNoam9xicHOkhR+C4ctDxwCFLoYO7RFjBuKwy
7U2bsmKZrcEpm11d+f2rx2r+7srDD0BAFGaysunFT3trRGygYMGYZ+ihegS/i8Ge8NvZbCSi
hgUFXLHfnJXEBodvKsBU09fwrP56OH5XgykX5zQ4NJrF6vTrg3p79d9V+1/TLq7/2YHsn491
bXKiaRXLEOKFqkjXoAXi2CcOA2FjG5UdMnSoi1amU4+TQ/gbEBLsnk/n48u2W4vVTMdCHINK
U/I1c2eX3iuTU4myUFvs95cNwgcfpUsXk1VHZrnlGp+Af/rj0SKigrfwh6N1dDm7bfci2oDb
5NnCqARPKAMxB6+nElgq71iMeNyilcW++u/jIGYWWkXfHc3cISFWD0qEB1kciV0jjMfDtj6d
Dsfg/P1b42wbx6ozPJnhxuZceflivJlwhBd5pjQsuFrFSMGHB/gaRH5QvVmsl6SkbpLTBYLw
t6V02abdJkAsK5YkwFt9QN41B2RY/YV16tmgp3+UCXlyMxRgj5WnFWuviuWjTVtinmOqWARy
vlCpBW1NfWfIT9psdTNdH/lP9mr3uPX2CN7Gj3qzSaCnuuupZ6XDKSu9szlu/9qd661i7Oun
+hs0AYtsbHtngrCsEoOXKVrhRlno+ChlbGm4RAqu0k9xhnTLMtdyHjsk1/OQSCUElWFhFLcX
SKaYK1sC5nVhCBCVrIuYO3IWlxRicPBtKkwT7RUZdnEhVbRaUfAkwDebDzkw7T40E1B+opEe
A40DA+MErCxRhyNJLM9DZRxMx0SMDs4iYqvXf25OwPG/G3vy7Xj4vNtb0bciakXBstmX2rqG
/Qeb18ctYIuVI42N/dPyJDIVFlwZDmvDTJ+vrpZth20iEgTYfVdC0DgO6EKx8AKbfNco+pN4
wYn0BoYtqpIzy+R3BMqQ+xx6he9UlU47cbf1feizFE2/ELFY8q4XrJUKom4/TYK1wnnE11rn
jCSi2BzPO7UpgQRlZmlTmJokUmc4W8XlmRPKyAINpIb0i5gJHwInxAIPetWZirnA7K5aEWjD
Or8NQqA+rWDNGihB++iMQIyRZrJn2gbVch3aG9AhwuTOmzizh+4ZIfKZmSRobGtBclAx+mBa
qcUWz2GGLf4Sztv2HkQPTzU2kW1rzST8X719OW/+3Nf6JiPQ4c7ZYmBI8iSTSmN53ZoWLSJO
Cr/j01JkRET+rA7jOC6zwsvcqQmabm22ed58qb96rUECkWcTLhsA0Jox1l5vZubR2xw4EYw6
QYsoKGjfQmr2aRflxmkUqqjIbNICGv3tZK59MB1acaycQitoh/PEkds8l0rCVBxmRMfCWGWX
A81ggdBFrh3025urT+97m4xBpAusPa5qaTSNKEaNETRgZloKPhq1Y0W5HTCZSN0p+6pSOb68
EuAQiLe47VOMj0XjQPTtH8My9nb8eJ0w6tNEj9pmmBzqIJWQyHLgVUa92QDlIiyB/75cEeaK
VaqtZWUXZTG6LerFd1pCh32Q3WHM6/O/h+PfYEDHcgzyssTWpBsIxCTIN9syJ0Z2Sn3BEbWy
Rhrmth5YAvPyucxYqqs3MDCwadzQM4CA81Goi0YhSLK2MLoJxInafwEGZkUX/w80CaHSzj4N
+S2Z+RULJ/HCn/dbUZRXH6/mszvPImIc5TYvG0jFWSm9GTBKDTGCDyMrgSSiS7uvVYWKgmKF
8E7uYf7OC6eo8OV4ipQ10+22BmOslvbuxgerctr+onOwREVNiHopBXNlKkNRg/NvfZNZ78T1
7qV+qUFY37bWz3IaW+oqCu9sIVHAVIYeYCIiRyY0vOB2enNEoDPLdxdJuNdX6bAi8UxHJJ6J
S3xHfXOUYXKh/ygU465A4r09IXe9DsGCm8FJB43F+DgqOPw0jV9Pzrlv8OzuB4OLZagofG2j
lC0nriVbijvXf3J7AKPsDdNbfHLXkIyXE6ElHkP1Bo5GSdNLW1UQb0d+eEFLV4u1W+uzcj3v
+zytY6vt+Q7QMWN8RDDDiyRigvsdvkhIwqoEecseOqJ2DbevPv9fm6mL9pvTafd5t3UqWhRl
RB25B4AK58xLzg4sI5LH5oVKh0jux7Dy2lDALUDfXY2h7bGw9kjhuFj5buVM9HvPZKiuTxj1
FhZ+59hs5zUsHUGmajMQdWQba7APptwQcPOv5x6UdUtiwPNwLbEX0/DTmnWLycCKTa6spVEV
SxNL62aEchL7+AZO8KUDDxJpHYnIfzcS50LdBzNVgeN3FMCDQDps9TsLjSGcOLQ6/af8JMtQ
FtTv56q558JXQZMKPjD/jkvnq5Jlbm8Of6jCUqwrdYtoxBXaApn+YnCuT229RO93jlAOwvQx
h0RZxlE8hNTFZvt3fQ745ml3ULmd82F72BsuKQI/xvCD4KuKkXLzKVrZcsaZYYM4E7gbAj28
AV/ouZ3sU3Pb8HTc/eMG8Usi/Px+r9xgX26kuMMqM2cGZGuIu8Bz5VUSP3jhqQlfo8zMRlyc
aq91kBmmgchxdG8DQtsJV6DFvT9iAtQfs0/XnyaxEKjKcTIcMN29Tdxz0mi1aiZp9bR6UK08
kRngBB2tClxcGxAhGkGcL1VxgO3ZK2xC8YX+F3zUfzRmpAaBxUVSFSg4uOjDhysPCBiEfGB/
LyQh6qd54azA2XgumTsXa7UNVsL/bh7ePUwx9Q+krlDsflvgeNodwj9xwZI2ZdDvvyjU3dm5
Pn7ebGtn/1NyPZs9OCuKivm7CaBdlmAhKgGKXTp1X12l1XgatgipvCUIEomwVUXnEd/+pJrJ
W3WjjmNuQXgCJznzgCppJWyhbY6LEQAWVjVh6BhVcCaZD5uSuDAZpEB+VQUY6ss9angsnE4y
kUwYVkAiJgpVJ2w3uZR/AbTANHETFc312f6lPh8O57/GGthYVERCKWLb+W/gJfJeZDbIFfxz
l8ZXfndW4eRSDXIBPT1anxHuhWlyZV2re8IxxcLwUztI1fC3g8KXTlQ6IIiGTFWYLFT4PLNc
HR2Oz3SKKANH3qcQ2mbqOGDKVFLuHvHcvsftiSIMq+zqKiqWl3a1SUemrjtgKbrYCMfq5i32
JRcMevjAlJYUgSEkuZzqtimMe9DlEz6X1lhNG1n4VjHUz47Wx2Nk3LK76HtrX9qExWwM0bd6
PPIgeKQyokJyM5Q0sX3y9Geobl991VUK9b7662xU/vWkGbbdwTGFOv2XKTwn2zOM6DKYdgLZ
6gTocqt8tUfnrLkruDwTcLFDcOCazi7Oh2Z4nCbu0RC/jPsYk6XyZ6hYFP4MGQmF+Bm64qeo
ZEw9dL51giSmupKnKZ7oHeFkSUzPvvke2YIWTPKi9N+vtASLYjJ188kJCD8Vpq60EVMrihCx
Elbq+yKx6tBxFAFYCjPXlkTWB4RZC2JlKxUwj8gIoG7SrMm34AnjoNCp241IY53WbWOpzTFI
dvVelfd9/fry3GY0gt+A9PfWfFgxiepC8uTDpw9XaGJI672BAiiul4iOl5TYTkQLqsg8mui6
yN/d3Nh9aJBqMgJfX3tAfsq5ZqENz0jEmbp+nACPexJyPoOfyA9t6a3VCqn3z1mwj0Q7lV6e
5A+FR1gaoGeO18k9z995gd4ZatTH+UjGnEl+epc6yaA+9P4pEeumUwiUFRS7R5Qkfg1N72WZ
5xN5wgQRylbeDBREyZIx2mU6uvMwFUEWUYS4U3ObRcQ6AU32IHq93Ryfgj+Pu6cvdV+JqAtC
dtu244C591xlU6+SYlqYjrYFrgokU6vMHvSMzIoJ1xdUcB4jyiZMW8GbvhPCM3C7cPNia7Se
ZHf8+u/mWAf7w+apPho3zPcVZerlxDDbHqQvFWP1QGJAgv/CUT+a8fpraFXqZETHgmEXfQSw
t5SGThLE00TdOXPsZlFa0XQX1/u4KJf6Qqu7ozfyPZSy+wncFFSHfOAx28vqQ0Huredp0Mp9
btuC/5kxM8NUZNUdE9WyVE/7ZFPjM/TetCmwgfeM0lcLF6URlXYSxCKVijNMNV5YlQPNt61j
WlhjqFxYNgZmGWHjHs1Cj6HHCq3MOFcXr6UgTVrUEoe9gExwHjWuIfbu/8SpbKLDl5Nh/jr/
hj1I5+owJYpH3u7NLnpvgIG2Ui87LV3CgdPNIznfHuVmoKa+VNaOmP6CBmbqcZIPIQhP/Jgy
fBghMtlfdQ6lSN82x5ObnJRxhfgHXcTkddEBb5R3SWENUbHEB4W91MWnF1AxhHeKgeu25O31
bLKDqszbqn3z8nBMpqw5y+najKHHa9eLL+HXIDuoqqfmVYQ8bp5P+8ai0c13y2qokUK6hIPl
rMUp1kuk5ftJ+7IVvivuT5YShZzwjuPKwXWnWiSxcV5FZg+v94YVzoQL/ezMEnwF7erX4ARm
SDhFBM2LQpS95Sx7m+w3p7+C7V+7b+M0i5aUhNgj/oFjHDlvZhUcNJb7lLZtry46xjXFHTJn
7ethawUKE4LtW0usXxf7Y5+WkE4QOmQLzDIs+dodSymxEOXL6p7EMq1mE104ZHN7KQ725geD
fPy5QWbvL45yPR/zk8x8vCTzC4who9lq6MdJpjt5frdhLjG10yKdIGRx8wxwNBg4Rb6opUOX
kjhHgaPM7Yczf12OVoihAC3utQYXTkJT1bf59k3dT7VAVfLXUG22qs7eOS5MOckPaqMKO2Gm
z2W6FtlY2FtwW1s9wYaOiCVTzdWDfwSMmkiZGJQLnJHcF7ZYRBDAN3V67ngUqRem/gKzHzCr
eY5b7z+/3h6ez5vdc/0UQJ+TmV41nnq9lVAkUpuZPbitJtXvu0aHe6ByhNY+nVFazK+X83fv
J5giIFh854igoI0QWrwbgeCfC4PvSjIJgbfOwJhlkC0Wc11lrrCz+ceRhZobvkC8O/39mj2/
jhSXp8IkzQkWLYzAO9QlLjm4sdnt7GYMlbc3w7b+eMearAVENvagCuIkqrUCybHCeIHtRja7
6m5nR9P6x9MaqqW7tOkdzfxBGa6FI9KWrrmv2uk2tnPz71twPjb7fb3Xaw4+N7oDGHQ87Pcj
1uthYhiNOsbUQFSx9OCyB7M6pQers+myRiO6K7mJlTTbAQEY+N+ebhGInXm72CO0Sq/oIutY
kO1OW9fp1JTqf4JcHD8mYsny9k9kjHsY0I0/cam8/1KjWIWXQ3rTRxqG0itlKqTR++p6TTiK
4Eh8gUMQnF6+fTscz56NxpFvywAKDoqqasjsfLifAPy/yMueliyMUq8C9s2wz/io46nXQQv1
QPJ/mp/zoIiy4GtTGuzVwJrMnvIduLisd/j6IX7c8S8un9nIwLRg/TLpRhf3qr+4M3mOO3Jx
X3R/ZGNKi48p1R/kWekCe+oXg5Z8ifGUz1OGzqkGQHVPK5mCBKaMxq6G1wQhDtu/9zO/cnGq
7M1+CtAiFrTEIXHnqbtTdmFigum6wNxKGMTSEFGWmL+rQmwprZdJAFTPFCTH2AJixOnaj1qy
8A8LEK9zlBFr1P6MmjArw8DUqzSIg1cqjjELRxuEqrCyYCqn2LypHkJ4xCcetrbPoEzi7mVU
XlKqPnxXCXFTPdS3eRy5Qk5nFKK2kSKJeQgmdHdSL0megj/r7eblVAc635CIAJwmXfDeNNnX
23P9ZNx+d7MMzb+o0QItX8MANk/ubmfvfbjBDRnuU9Q6q2Ipo3jlfVglkWa3Stia7Gguclzm
Nd7BKsOBcNWmgnYewhBbK6AupFa5VV9+XREkKAQfQIwaJt5bCoWRiC/sPJEB1k9v4dCWl1vr
DZ3qIon+n7IraW4bSdZ/RRHvMhMxfo2FWHjoAwiAJFoAAQMgCerCUMuabsXIlsOWZ3r+/avM
KgC1ZIF+B8tSfonal8yqzCxyVVaqPm2g5jkWU1I6ttSxhaHzy5PjKbpSkgVeMFyzpiZtYo9V
ddE8sdJu7XvdypHuo9nOX9bdEW7i2byarF3GLJqsW8eOl1jMCYuu9NaO4y+AHh2SYKxZz5iC
YJlns3ejaJkFC7p2KHumfZWGfqBYkGadG8YemSAsXqwV2Lba+CIiDZ0xLR4OEDtiuHbZNle2
69TTVx0uP+QNaKmz7DB9wBE2rTzK2WFGAzkXQS7zXZLS4a4ER5UMYRzRbh6CZe2nA6X9TPAw
rEIi8yLrr/F63+Qd1RmCKc9dx1nJgoLWEjwA2fNfj9/vCgyy8BnDm3z/8/EbWx/f4SwP+O5e
QbBh6+bTy1f4VQ6FdRUH7WP8sP9/YuYwg3loueFTWJST9gSMshI40mgkjTFP94rI3pya5KBr
MKMWLS8OXGVOu2JUuQzJE/2Jq1raDdqkyCB4nhw+C7jUv+AsXqNo126YrciPhxP4G2uvf/3j
7v3x6/M/7tLsA+vEv5tbUydbLe5bTiN8nWUb5IlvR9Bks3Ms6LSOyW2KCKqvCX1kjwxlvdtp
ZqFI78AQMOkuh9SYt9gO/ThwlON2/incgUBz2/LcplR3sCUTfo6IliZEodTTNFnKYsP+W+Bp
GyqZUbHXKqY11Bnd/6UdBel4Qo/ek0ahj9tun1LyAivmVlkhkVDbIqZh3DybzQvCXNBY+JzW
j6iJJMk0Uv+AhAORL5X9kccRQpOjvG3JmEPAg9FylMYBalMR5tHzmcHdf17e/2Tolw/ddnv3
5fGdKUyzvaoy5iC1ZJ8WS/o+4ml+kuqEpI91W0hCAiTF8ptmPMv6SS/T04/v72+f79hyQZcH
0thUCOvX7kX94e3L63/1dGVPUmgZwngZAbiNIqqo3N3/8/H19ffHp3/d/XL3+vzH4xOlxBKS
cqUeRPMIfVne5yltTsE44M4soX06qgwXXSqQkoBcLTukLfCvAvnwP5vFYS0dNPu7EOlsRq/p
WSXhQXNsZlICFgtrN5nLqTCukBg6pesnV3BD68moISmEZPU8sE+ZEKFdvAFtyzRy+QoaaI3Y
xKbsgAjWBxbhjknqYIsgMqZKBBnpfp7iwp02qjmZA7H48vXHu3V3Rks5OQckGFaWCrjdgr6r
WgJzhAeCvVdOBzhSJX1bDPdS8DC4E32F+D+U7b34qGatp2nBKgKGP0dKtNPYurTN88N1+NV1
vNUyz+XXKIz1/H6rL4zFmk9+IkuZn7ShLHWIcRiufXufXzZ10lK7lVRuaQ7Cn6w5FNViIjKx
ryGv2yeGzSWjv2QCScH+byxH1RMfm3hJw7SV5WwmrmtXbVRr7JkpvRDWNwYXhh/AAKeLOeYl
E7fydE9nNaK8OLeqmMNJc0Ep8FKx6mO6vy96Or8tBL+GDJdbiW4bbnSxUMj0kjTkTWXN4yiB
545qrKciFhtKjclSulM3DAN9UYq4uBZQazQNB61c07TrIJ6xxYwBWDAQFDUCBAy9wWe2tFjP
xGuSdVG8Cm1gFEfRArZWlnsDtbQnwaiZ6CocLVu03J9Jqq8grJnq6qIwHOtrUwwp6YogM26O
nuu4vi0dhL31jUTgEqM+5NciPcS+G9sSSy9x2leJu6KkDZNx57oO3SHppe+7Rt+/TQZtpBEc
tE5tMq6Mo0GKx2amS/HezjlL1o6/suUJaEBZUyhMMOnamm6kfVI13b6wtWGe94UF2SVlMixh
s9EYWfZ8SH062KfMtT3+VvTdkc5nV9cZhnIhM9gXmXZPQrNdGJH9XIXDcJO5KAs2FygJROPq
83u6zF3YXaLQtVToeHiw9cR9v/VcL7I2Z6l6kVqYKDcImeOcgMPvOXYc15YTZ/mZYV4lg+vG
jnubMe0CxxI/VuGrOtelziQVprzcJt21KpoV3ZRVt/NCP7aA+Iet7kU1hMfy2ne3FmemnA2F
Zc5V95Hr2XJo8kMFtyM30s8zJpj3weBYtjL8vRVRf8mM8PdzQbkeK2xgKeX7wQCVthb6Z3aZ
c9bH0TCo55MKQ8U2DsuSUqWuH8X+QmWL3nNteJfiYmTpDwZ7jjMsbCWcwzKcOBhY2xnh6Ebj
tNVVtmVVVgyme8r+JSrW2duz611PtspTsWprzbCvGktDMF18m6S5r5puKxxDHAa2lmq6MHAi
64r9kPeh5/k3murBONBSGrLeV0JiuZVQ8bELBst4e4CnC9S9RehhBTn326owxQMk0oIcQqr9
O1KqjUbZOr5J0Ucz0r1M3APo/LILqKB4OsV3DMrKoCRG5baBco+Deu3+8dsndJgofqnvxiNq
8ZFWbvwTfqoOrZxcFptGjnHOqUrUCE4SdxwEMyNVSjwh8UGb6qqzABrIkrxgARitEJVsjlqF
dkmV6yGwR9r10AUBbcc6sZQrFRcHxVSTTiE2qQMffsDw5+O3x6f352/m3a7i83+SfYlrNoJK
9Ic4dDzUYydzjgwzbX82aYxvJkOQy0y744AAe+v42vQX6vyA3yEiOqc5E4X5gBdM9gNlxmYl
npmCR890fPz87eXx1TyA5XIptxhJ1RNDAcVaxHpuMvD25QMC33m6eA9F3J6KNJjw47ukfKsw
DOrgZHTwoSsLORyRBpjtrTMcWvwdooWrHOoWJxGtaXbFVnudQgHG7ywX5JwzTQ+D5amZkcMN
iy4aKMFasGzSKvQHs7UE3Vp+sTj81ic74b2pZ65x/EyNxCdWb0fBJi7km87mezsm16ZUudgq
RZTFZGK9DYuHEhtewNuuvJbNcu7IUxwgEo2lhTSO26Vif+UD+scVuyJlk7IlBp3OYu3CCvZj
1w/Msdmo7pYS+XYZYaKo/rwagG7ptoadmMjRMlkqKwuQls+B3w1nms8o00WzkhIZdnWZbYtu
ry7eMlUYwRntyBTLTrnOQpuynryo2Z/S2Q9RLTDG/pYt9yR62reYorqRQ5mmd4QMGo/n/uu0
igtzLaP4RVMVV/6QUatR4T4Ozep1OpgzcG85Eun6VtuREOSXLWhhjHIudc4IfLLxAid0agQA
JOKjgllN3W7xokDgu3q7VdLaGIVQtlr+UA1B4u8kFbVimjijm2TlKxr9DC1cXs9MKetgMvTv
zDIUzZ6tinImrCqsPJT4m5yNUQbTDengCSdt7n3K/jUVXXgGkDdpYITTmed1nL7whX4wO5Ov
aUs+YzOywFE5sEgjXULwsJZKGY/hGeWQ16QqLrEdjqe6V+UVgE+sDcD4eaCtrqYq9L7/0HgL
B5Q6I306yTa18qLdCIy0a02795uS6DwQeDe2x65HW47JX5xfnrGympeYssILDYM3Z2ADrkxB
6A+bExOC+JrTSU2qOg5j3tWP1/eXr6/Pf7FiQznQqYWQ97B72w3XDjBSZX7YkUsHT99wmJjp
FX25KfCyT1e+fOAzAk2arIOVawP+ojJrc0twa4FX5ZA2ZUZ252LLyGUQbvjqq6/YXuWu3hS9
SWwwMMbU95PiA27Sc9vPYwOfbrz7HZyohZfX3z6/fX9//e/d8+ffnz99ev5094vg+sDkd3D/
+rsykoQsp5YkhbGsXmABOcshYhQGQlAFaQ3UojxqqBmpDhjyKj95ekdZ4tYAdJ9XrHv0D2oo
F3mVz0DWtpbM23t/UCldUfW5Ns24OPvr9DwCm89fmHjDoF+6Cjro8dPjV5zkusYFX/dJ3bEd
efLaqd//5MNHfCz1oRyt0zoKlNKaDY4kYfJJIeBVAN4FegvykAqp9n6mwQBjlf7U5ugvL2VT
er5qqAvRWhmN8JMeN9SzhEuCGBPaFPp8V1uwnQugfUoajsonULDJaWY2QDIyA1o+9SPsEtXj
d+j32X7M9PpDq0Rtqs00XTEFYOCmjGwxVV6fAhpbOjaJZjUJOzR3JqPrKU1B/TvWqpq9mAqq
4SfQE2doMHSnJi4AZJmzAHE9aqMmBUSjG+oUH8RViW2d3quPOQOV6c5x0YWOp5FNvR36bSDN
GQAa1PiQSBonvER7uBw+Vs1199Eoc1JlypiQNgnTShjKMm+1wN+IKLpiMKl2rQ2OBc0mR4H7
Mg+9wWKoD5/DrLd1se4PJIKQzPJmR02eplGEoGYxNtqhb4DDNEpktKfXF24UrjcTJJmW+H7V
Pcr3cxElCE+/SERsYVNGf+CTU+9v34zNtOkbVoy3p3/pQP4FH5hp9hc2cvEBN9ujFXfvb6xa
z3dsXWc7wSeMi8G2B0z1+//Ka7qZmdSKxQF0SUr/ZZVRZo8goIca2CIKF7bAnSJ/11ttFx8/
KdqP6kzia7fJPJkWy7RUM/+aiNcTFbABYeMJa6QynSfynVnk5O6Jnx+/fmWCC64kxl6K30Wr
YRiXJbUYfD21lcJwt0Vqdk4arV2v2x7+c2TrC7kehCDB4VaXbpG8L8/0EzWIgs1ZeiLPPLCR
NnHYRYPedPnhgd+HK92VVEmQeWwY1ZujjhlLoiDXlNQ99n4qPy+ERH1Z5O0O1q/i4lh94Ibq
zUmARerzX1/ZxNLWPBHyoAmCmArQIeBDo3fA+crlQnOY6V2JVM9oV05Vvbf4zQdoE77OL6g2
/kjPtUm3cWD0Zt8UqReLt+EkiUlrHz5LtpnZbkareXrGSVs81IdEo26yyI3dgKJ6sUFl9XGr
80mfP2iGYwwsJNN+TohzEX5hWjT+ekVdYgo0jvzByBTIQRhY5xLr3Sg02oaTA8dIrknKyuLR
gXibBn0Q0z54fAbBZbKtNH3qB/HaHAtwTRyHFNlTLctmIA6tkxjxtWt2UP+xGmLKzwzRyRxB
/QjI5EHQiK7XinMZMVonmWdxFLM13g1XZkf57tolJ63sWsmpqe/HsTEBi66WfZ34mtaCSZ5v
1JYHM6NPt80KYMVOL9/ef7CNf2H7Sna7Nt8lfa0Xo2Ii7rGRm49MbfzmLNX47F75Uo2FcD/8
50UojLM8OXNyneaadd4qVsaFjLln6mxx5lClhZne7Qq5BkRR5CJ2r4//flZLJzTUfS5vrxO9
U454JzLURbVCUSFqE1E4ZOsZ9dPQAni+LbvYoVYg5WPZ4kAFXBtgzY5B17SlBAiVK6ZTDuRb
WBmIYksho9hSyDiXzYRUxI2IYSG6fxLe4U4AAw1Ih2MSURt0OgK/9tolnsxT9qm3Ji1GZa6q
D33Pp3Nh8/ZYJnpsQoUBS3AjC12wMjHieqTN0dsPQsVLuhrnJjFwda9oiGcIsdTLC03Vz0Ka
LOH4TGLLbrz2Ap3Md44rePscFe98ATSWF4/41qKnhuE9NRqcXe/gZJVJOk6oXOxskp4tQpdr
evYcl5qFIwMM41Aa3zI9ttFdC92jitBtLA9eitLb8Co5JEv4mP7moxcNFqvdqXRgQE1t1zJD
4BHVStauKhCNCJi1Rg5pwK6xkK2CmOeSz5+IhmEyMutWOTT1iOCIU/fpEQLJz6PsDEcGXTOb
08TmXuyqsvfDgFJuZ4Z05YZeSWcwuKsgWiob93WsBW8ouxtKqRgyqoqtKWFZabl1TH3NxtHK
pd+jkTi8IDILBUAkmyZIQMDSpAHWhTSwjsnqAWQzT58mU7XxV9EiCxes1/QhmcLkuXRK4xje
JcddzneTFW3ePXEK+4TFPNt+vQqotWpkOKad68hHnFPLZOv1OlAcJPbnir5KBXlK80fgpDHS
gP0jfNq2AOck2WZWYHmVs7IcwDhNbFlsOJcJm+lSyK+RWQ5wNNIg7hfGf+rboiEyGB/d2NUQ
uSBvrueiy6l6yIzbpGh55GP6tpf4BENnd40RCVn7xJ46wSiXl4DhGP8qzvIJeC6R1PXNUepL
oy+O+gPVI6Se4o+KsJnUaLZhUvRXbkbyoT4nl1p1rJ1AbrjC4xTkB+hmyslzYq8bNLqvckjP
IdIzXopGZeL8+P7056e3P+6ab8/vL5+f33683+3emLL05U1RfcZUmjYXmUA7E3VSGeCBpNtM
By0YkY2v0YONLPDL41Okr1bY7lkLj38tGeHgcc5QHbdEl3OpwAYEFiD0ZUA7NyAKMks8+WHr
uZsqvcn24ITrpUoJEZMYxFy4NAFhpWgCD0XRgvJiIkjuGrKy4oh5qYzZmfwSAgOBKedyE4zz
diF9NnqOZA78xA08UWzNe008V8fH4dRt2ALfdcVGsVGUH20BFniiC0J10LwTrFJFJH5VudvA
4+9mKhv+4vy80wIb5tjVtGUPcoxZVEl6TStqg1TYNFlxMz1ibyw9eNH3zx9fnjC8uTV47jYz
zLGAlqR9zDZ/+iVVZOj8yKVljBH2SIW2KlLzJBg/SXovjhw9FCwg6FKLbzLKVgMztC/TLNWr
wNomWDuk8TLC5qkxJjg0nnzuMNMMp+0tBNvO6GsdrCYqOVJaE1E9lYaExMJG23ZJDIqR1UQP
qORCMp73CPpGMm6gdcgu6XO4Uuyuu07LFfy+hmEgieq1uQxQDdh4IenDDOC+CFds3jfKJfC+
TyEKX5Eq2hZQWfLawb2UVvGxCz2twJOxjkSL46aKHYciGq2M5JD0O+WDg+tXWmMYR/0zVdWi
Zjp5Gj7Da59ILF6ZVKbgmKWBoxIiW6aVUZrhjMZaSn3oh3qtGG2t5zjuqXKe+QNaxZHhU2GF
AkxN5tAPuTYoYX9RKabCPlLYEqQUYKLrdiJKs7R94PiUNosgv3PRynQfO7Heuu0h6EOXjO8P
L5TmKbkkd8UqCgebDRRyVIF82TCR9KAPQL+/xGxwehpVuBjym5C+enn69oaxRb+9fXl5+n7H
b42KMVQMKd0Bi8W7jmOjcc54X/Hz2ShF1U4qgaY4xSaZNjz4vZ3eqnA8E1ueMeBJlhUV7ROH
F97CSSoN09FdJ1AdKVG5J4M4SX6Xco7GNdtMXTsE1XMjoxmmW0iTHIQBmUhMUONw0NtL3NqR
Qalm2CMSY1RqB5gw+97HWNiSrBrK9+dy5fiOMR1khtBZmQxSuufS9SKfEDjKyldeoMNC6Jei
SMSrSu3jOt0fkl3SqmTjnlsimtv6CBh7adqtotJb6a14rgLXoSNcjbC1z/ByNDJThDV+IcV4
RbrRCVC7o52ptug2M4NRZ64jUTSz4aabXnm9RedjsB0YjEKNGBOubAvy/LkXkwkLfdVYsHuQ
XMi3YvhauzWbKM3W/oo+UeTibuqFjq0NR/3PHNA8OH/lOtdx45Vtxm1awqy4zZdLOkm/jpmB
bTHkGQRO75NdTjGMT0syoDsqVnQzD5w04UHTIhcTxHZ8raIgVZ6bIdBxYnk1lKAs8GUBR0K4
lkJCo+owddmMCXsWsmM1LnIcajwDWVdZpSFTFwP1RilSiyQm9bmm2KiILFVoSECXjGskt7J0
PdeSsOeSHYII+c02OQR+YCsOonFMH8jPbFZRcWbhGsxPMZ0C8j5sZiu6cu075HBlUOhFbkJh
xHYkgUwmisgWQoTsSLzQIjtflzpUJCCLbogkEsS3XBsURiEFmVqXigWx7bNRLSO6aFTPbvQk
KEbhilJnNZ6QHK+GhqZBHtlMCNFzDqHIt0LqvZte3TVtP6axxR6lnEpMQvlXNyUVV0LIqBCr
NQ01LusPz1L+Jli5N4rVxHFAji1A6L2kaj5Ga4/uOqbp0ksNInTHafYcKhLY+gb17OW6jWo3
8blpOWiypMl6FZDVNBVqCdvGA73RNtvjA0R3t5ToxJba8NbUQq6bSzJyWW5SJS7SgmzGP0Ik
Ld3ZQIOP3eZ6sgWrnHkJQ0yTR5wRmAATL0l6v4rVQGAyVp285eHReVWTOORgBahzLUl3QRVH
IXUoJPEY5woSVu6YkmIbBh370Amps1SFJ/ZWFhELwYiOtjZzMV0ycNm8W8yHUuRV1PNvjliu
spPhjnSmiFxupJMAa/Lr5a5GJte3LJOUTYGNiRygHFvZS29ZSM1TAgUblX1TYwAfFAowFU4V
u7lzc7XxBhNO/DLZFJsN1WSpvseB559y81oWpDVkC06KaZ3laoj/or0e8gkivitwfRkZ5oyR
HpL0306pRJez6urDhcpL4UkOl3q5QGB80JBZV0yJu99kJDZUjaVYRVUfbjVBVVEfY6vao3RX
eVYk15Q1MNgV0u8/cR6BK7q6DEAY8t7SaCPjJmtP6HDd5aUWPV64GH16eRz1b3hFQ76j4yVN
KnwyZCqMgiaHpKx31/5kY4B4LvCcpJ2jTTJwDKDBLmtt0OhyZMPRUFJuw8kPx6iy1BRPb9+e
Kbf+U5HlMARpl0PRVPWhb+uypH11T5v5eF0pipKleDjzj5f3x9e7/nT3Jh4Y/x85HYiNkWRJ
08PMdaWnsQAU7ovXqjjU5KsfyJSDVz88X1ewcV7WXQduV/JQA65jSUTkn0pPlFIeU+YZ/WlV
zr3Gb5bpOQJ5/xQjDI8lRl6eKv0F7tnvWLKjU7p6d1B1eBHPUqC7F8rzf5Q92XIjt66/opqH
W5O6mTtSa7H0kIdWLxLHvbnZLcl+USm2PKOKx3J5qZPk6w9A9sIFtOdWJXEEoLmCBAiCgGAn
si06X2n5eQXo8Hh7eng4aBkMFTTan32iVcEu9ECrlE9SzYZpdWolGIugzvrwGYHIlXH694hT
9vr2qN/I9/T43L9QfQxUXBX6I4x75sTOvcV7SO3ewSpXNQoY2MV8fuFARv5UC6JrIy/sXVSi
08pz3NUbRLPhe0WQViSDyJvN6CamGKt05Cr+qhoZ9zgk2S7whrQpWSOaDoeO2dkFE0NJ1tq4
S+DTKRnf3yK7IIRWgw8mE9CzPhwtf+eNZlNXKZJX6JtMhSwOhsORgy0EznsHN36PTV1fpvN5
yWcwjLY0kl/X/mI4dDSJM280dbA4qxajsWPllHPPVR9Mx3g4KmMae5WOwhH0VXdMtyiW0B86
ECW1oag7zctR7Lnx8/nxFT7pNz60/r+8Hh7vDs93g88vh9fjw8Pp9fjb4F4hVTZfXi2HoCj3
3WiAs5HKzRK4gcPJ36YkE2DHKmrws9Fo+PcHBNSlihDIwPb6HY+AzuchH490bqcG4FY8qv/f
AWzgz8eXVwwT5xyKsNxd6l1ud87AC0Or3wzXkavV2Xw+ufCsZguw3WjAfeG/MlvBzptogfo7
oP5ETFRWjUf0/SFibxKY4DFlUeuxC6vP0/VoQtoiWk4AuWozyHJGx5/vPlrYNUmueY9pgBld
haI4HM6tEcHpHA5J15v2K09/44PgTcRHO/LFg/io2URC0w7SI+WkOQsQtVocDvvZbOSI1N5z
gqsrEntB8YnVSGRkUk6LZnCQfdYnsPbcM4pRBPzRjB78ixHJ/NXg86+sUF7MtZu6Drazeupd
2NMhwZShqGNuNYx3syeEOiSZTbTXWX3fJkYrsl01G5q7KKzKqVEHLrbx1OLWkC1xlFPKMqHi
A+LDC0Q4eachoG4EG/TCanfTxbkO9eOFJs8RFgWk6BjPLHYELdwblvYsAXwych71yirx5mOj
Bgk0BlZs0dZ+dBOOQHLjOS2nYwJ0jdCN0x2zBo1YcbIp7hhzjxxAj+Qcb2yPlyfs/aJSH9Mg
fM7gEPtj4P/E9HeHx6+XcLY9PA6qftl8DYSwC6uNs2XAkhiB3xySvJyOPKcIRuzIHNtlkI6n
I2uJJauwGo+HtL+DQuASnA165tsFw1w6hQgu3aGhxPj1fOp5FGwPQ0SKtve0kJm4tpLxRHj4
61vWwpxyWF5zQlaIbdMb2odsUZuuHfzP/6sJVYA3+MZICFVkMu4i4rQmB6XAgcjhKJXPr0WS
qEdoaUegogf1cg86Chu+uQx6lDjMSsfEKGjzRLaBKwf352epF5nVwpY8Xuyuv7lZLFuuPdox
o0NTN7oNsvAsFUBAXXIDr+on6i1+BzRnXgKtjR7P9fTFrGR8Pl8l73QH8U757VdL0JXN3RJ2
ndlsaqnybOdNh1O3oUacwTxX/phWHpDutIhc52XNx76xInmQV16kA9dREmWd22pw/vnz/Kh4
j36OsunQ80a/KclFKatYu5EPFwtni3lh6Mj6Acw6Z8mc1efzwwuG4QJmPT6cnwaPx/9oq09n
WJGkPaZDV7sMWTLZ6fPh6Qf6zxJm05BIjuoDrE9B0NWhggU8fj78PA7+fLu/xwiCygdN2fGS
bCv5mfhuebj96+H0/ccrbE1JEDrTYgJuHyQ+540hv592xCSTGGThxKvUVBwCkXKQ7qtYXWUC
Xm3G0+HVRoeyhC08TxNyLXjsSFSP+CrMvQmtNCF6s1p5oB76VFYkxFPZbJu2T4ejy5i0zCDB
ejcfq8YJhOVVOva8qf78yA8uE0w0pI0gOVEfTEebg/jl/CBSoT89HFrGIw30K/+dKO+SuwMz
lrgGhr9JnWb8j/mQxpf5FkNRK8vvg9a1dNYKacvneZ0pmjs3fuyNKH8IKoJUB/DoyuJThH/z
1bS1LaTJW2OErENszjk+lyUGr6mWao1+2aDj8JYi8MuQ/zH29KraC6w8Cfc+ncIeqNps1l3I
eK0MV6bgZkhqfHVYEiOFM2qV5bg5WIdf/Le701ndpjqYWvIag4GUkZ8kOQbLvYn+mE2MLuvd
1HE5+WoBh0AEY29FzJqF9mYFwL6X8KMPt1GVUbbSczIDvvS3RGW1LEYlbGP7WaPCn463qHhh
c6yHffihPzFTrgpoUJLxrAWu0O4bBKjG8TQLWUbJJaN9LRAdrKOyJPMYCCSDX9d6NUFeSx9F
rZzUD2Au6QjqiC/KPGSXEZmuRpQqjKhGTTKvrQ6E6VjlWak9iO9hezXcDZJHKbdhSSSfJ2ot
jG6geY7WraJ0yUqDbVaxGl5KQJK8ZHlttHjDNn4SMh0IdbWJ8lTodWQ2a+snVU4nf5GFR1ue
G8/Bdaa8lom9HV1j+N5Yb4XMnaMV8s1flvQTU8RWW5atfVcNl1HGGawr9REQwpPACMojgFFo
ArJ8kxuwfMWaBUNA8UehPELr4LHm+I/gsk6XSVT4oQdIWkUAqtViMnwPv11HUcJdFHJ1rFgg
Uvi+Q5JUpXOWUv86Bu3A6HEZSc7XoSBdyhzf7hvgHBNiRMZqFonoCU7MKoNhQfpElyZbFH6G
4R+A7WmTi6CJKj+5zlwbWYHJawJj0hvg3o2IQk5jAmZwVIEpq0tcIuYXiX8twpJocbR6oLVv
gFhN1ZStCOO+nqpUwlJeqxE5BLCIohCDpJhjyKvIp7wcGxxwFsiUiFuf1VmR1K7ttDTiL+M+
gHn5fM7cy5infll9y6/NcvW1zjaOXCeIzAsekfE5BHYN24C179YoYPcFp/RosQEylub2jrRj
WUrFCUfcTVTm2Il+BlqINac31yGIWT0piBgLkQlwv64pM62QtkkTvbp9HUnI+D4Ng6aH9F5T
mOIB11ZMVNIj1Ty9alR/pVDzI9NvhqJFx9h8HTDMxVSBsh5lIIG1gUCKd3yuUjVo9rZEZTGi
gJZzRBrsl6D3XRKgVi+eKwofOpo4UnDhd+hn0ip80nNFOq+szy+vdEj9/uY2DZxqMeJ4COOj
t1KA9hiDMwhAOdF0+B5fJFWscXqPgvn0S5+T4lKnElsGVXqHbPtOUlSLkQMVboOUrwMKawW4
7lEx/h0P6V6lLFlGfu2aI/2lIABq+IzNyjwZ6vDgSo64VsWaXznKTatLqqk7UBoyx/CnPq1N
9SR+OpvSHqYpqJMVC6hAV1m0NaQS/pJnek3t6KB7IdEp60FPIsSzkQBOoJciN3EGHCgyRYL2
tYq69AEYIomwm4kP/Ww89KYLyn1b4jHs4disDZMEqm8qe6j++kE23fEsTSLL4RAt8hOjsCgZ
Tb3hWLugEgjxxJcEehRwbDUHwLMJfWPe4RcepZ8ItPn4QwBl0G7PqquBu5JYCBozNIxsBL55
p5muw5NxRxvsdKh7U7TgqXjQk9IR3Rqi+Xxmjq/ohxp9T4UaUQo61GxsftC+EwaFqrZXwTv+
3gIvHy++j5++M7Eg2UfehA/ntJVdtpt8YSJQxGNayfahNx9avFeNpwuTS/roOXqlzUsqd6uq
wMfHBq6WVUkwXYyICadev5krRNwPaB8pcT5UOOPjUZyMRwtzVhuEt9vZG4643/nz4fT41+fR
bwNQIAblajloYra9YZRrSlMafO71QyW9lBxuVJpTq6syrIRz0SY7mD6j3fhE2S4H0+FcV5QJ
VI61iCvRrCF7w5npz7fkJ82jFMsOFD8cXn6IHCDV+fn2h7FPdyNZPZ++f9dsRLJY2PJXxssD
FSGtjc5+NEQ5yIx1Xhk9abEh45fO8tOKPuVpROsINDVQBShNQCPs7N7O+oKi/rg+P4ATCato
y5NG6XwFrI9AEy9P5y0xN6enV7yJfxm8ygnqWTo7vt6fHjCF0+358f70ffAZ5/H18Pz9+Gry
czdbmCGayQSbjv6LhwQfjWOBwQAd05lFlZahz/gQzZ6Zs3q/Dt1CrOuFmktVqsRsyeBEoZmM
/dHoGlQWnyUJmfG4tZIe/np7wiEUdwQvT8fj7Q89jVHkX9aG+tafv6iv+4/LKpBKFXXZgeHB
xAsUtdU91BG5DZNehWZqcABaObcQ1gVRAF0tg1O9js0121ST1CvlKyOvVk+xY/gdZQYPtx22
rwOzZEVhqubpE5EmGMDUJAlNMMMmS1VYaJ+IZ1Vr/GSfrtKKQmjjt3U1kcf7puRuHAOZw6kf
R59fZ3C42+21JsAP/czTD/ce+CtUilzWsf0YRBQas0TP7LUVcHKg66YkkmkAsU/zTbTP8orF
1wbzINZ1umzQPEpi7I/ODYiBfbQwubGDo/SropRcCEbPu+Gsd7C5o3mrrwqDAEsTW2/7CCeT
izmlQLAU5yRgTLfKwQ9PaT3sRlHSnEdAs+BcCykisTKafIP79MloDQj8fa6balUMfZWhULhO
VbWqs9aYxwNfeq2iTCbe6Sccn7Vg2HuJopkCPy9rTpvJNrFD0OAWQF2dKWi1kU0+Z9DPagu4
CQvfAi7xOk3VUhq4uMFU+9iWnJIbvFG2CI1pNELA0MzMG7MRSIWVH1x3dhiMFPZyvn8drP95
Oj5/2Qy+vx1fXjUjWOsp8QFpW+eqjMy0ubDrRCF5GVr5KyM/dQOSzvq2h8Xj3fP5dKfuPmuZ
JqT3tmhIjDpk8tx+aFZwri9WPvK4xlUZgzXLC9/x+lCMZ54WoJ5lFcUcl/xiqPvlNQMillOZ
U8eYliJmZdrkbTQw2l1oC2y1MhOsRrDtgXmx1O7NW4xxudOCS39rAzcMlAMjJ0bXvZKFqyjE
dHnk0BVsMqaPUiDLUBJi/2N6QcYsSkKsxHim2KC3etwnLvKoM87GswvH86I+FiYSU1PShHNX
xqBNQF+wQr2IwxBRQaIMLPzAFHkw4jIrhkGI1+mFNsnyzGIU0sH6p9g2qg1m6UIuJvOpsRBb
rIiRQHRcIeFsOlazLRuoqROlGo10zGTiaA7gLihpppAEYRBdDOm+Is6IuqlihdccnFNomaS0
QkZr+IgM1Tb4C4LnI8ouVtD7XeviHlJlGKYPimQT0KYThaSJcvURmYwx5hA4jdK5CWpNFdnC
2TzDSwFruw5E8kt+fnumQiWLc7CeKEBAijJf6sE68aYU81jC2qtmE9o7jqxLKQMONUsyASKD
3tfKe2rp+ocZRE+3A4EcFAc4IArvbm4Lxo9IlXskUZNQNYnQ9uXx5/n1+PR8vrWHqozwbg0G
Rntt0ENFVk5yWIhSZW1PP1++U9bnsoDjTKN50CVqX3ZiFh2+tqzso52e4cy9xdRP/dFLIvJg
8JnLhOb5o0iq/hseA29P9zCKoW5n8X8+nL8DmJ8DKms2hZYekc/nw93t+afrQxIvCLJd8TV+
Ph5fbg8wiVfnZ3blKuQjUmmN+L905yrAwqmpaJPT61Fil2+nBzRfdINk8Qcc5CPV/Ic/0ftK
eblvYetlGa2kT9ekb9KvVy7aevV2eIBhdI4ziVdEtUgAbS2F3enh9Pi3q0wK25kXfom5FK0E
I11s4jKiDxDRrgocRxlQO/OSVnUYuXvCPq6csLZpl3K3b8w2dR5EEafEZrdLk8gqWOpgNCjE
lUErYncPfR3YhfNVYEZQaASJG4T51OiKGucYT2O3MPC2S5+VjtiHxjEtfqb1cfdtgU6exskC
fS6gDFbkQeVTHp4y0xq1CiRmWQYpr5b4K/ATEyttL6utCa9YHy5ZdBmVXv7254tgPCUJZJtE
eK2c5hWgTFsfSnTXqWWQ7i8xVm3Nl56pT7eDDh+3GShAIS8N+6SKDj8ugbOoVBPWazg/Uf26
EIU8xdLdPL3CJuq4FBSIROuXgix2/t6bZykmGg8cKOy0jsqDKMkrnOsw0nw59FFXeo9HGkfw
c3V9wA/gel2k+rZgtg+dWVjmultpA9ovWRbig9QiIGWneTgNVT8lkcXP+Gnm5W6AeMLhoa8G
M2tC1UaoD1illLJk6Wy7Hbw+H25Pj98pXxdYyZSOJBZCpRyHWsh+RUJTrumIHbyoaG/hjsAd
lYVot3JChLM8fXQkU9qL+/oiiXZ9DBHxcv3p4fi39pilo8e4NKuLhadZThswH9FpRxFt3iIj
zFSv9eDBRhs6BYvl+ikXfuN26LrD5glLl6pvFQKkBbgJ+qUNfgn/nxmBlLrjQY0E1hdlXcDW
mlGfgMTZX9V+GGopBTo1HqQU7C9FVWthlbVsMdLSot2KCJB8SdBbUfWsSPL67oT3CmJTUKZw
4ycs9KsIOALOWyVXZQGAWG6EFgPR7+1jysQDmPFeXZQNAHPYMGCIILFRPArqkqmXMICZ7HX5
L0A1ekfnpaifrnzirmti1KUX7dItBPKyzli1N4zc35ah5jyBv53FQNXpMvCDtRaWlMFIA0bv
aQcGYv3caJPAPzu/qqgj9Der4G/q0Di+sOcCoW3Yba2oPh0edRxua1d+tw9ANhMdflXnlbZ1
7D5oKOL1EGkIybMEb1B4UJIOjzuqHwj0OYxltY99WkuC46indWVZ2XPWwt5tdkckJlbsEyt9
rDuKss4w/h0gTa6TJFZHJFh2hWSZvugoxkc2LKYUn4wlXXd7MeGJL2mu1qS0a+3htJvLWcIa
j8m8oK8h8JYLDUWXLKNTgcVovA/K68J8HqBSYHcrqrsx7y69WqXDvgVjEiRcL+gafElBIgVz
E1ULeJt0UsqMWEtxKAiCShlHjOgX84nGjBKmgWKxSyqAoNYzRTY3J+SM5jBWmLZS/b6Hobc+
K0ES7kOmyTyKxE+2/jU0Dc4WOfX6SPkGFcOdo7wMp3hn+u9SlGkEA5YX2jxI9e1w+0O93oZR
77cjlXuNDboB2KtNgJE36aBwTX2y7vAL6Jxfw00oZK8lehnPF7PZ0Nyq84RFdIdv4IuYXi11
GO9NVNskuhnynjnnX2H3+xrt8L+gs+gN7dUzDpRWBS1TwbculUCi1A0BIa2XCsvx5hOTnX96
e72fd3epWWUwtgBYcyGg5Zbs9bs9k4fTl+Pb3XlwT/dYmA/JTknD4polIRwv+yZeRmWmNtk4
oVRpoc+zANBCw6BxiXk4vGCiljLyK+3aBP/0Yqo9FNq97RVQLp0K5LW8uvxLvAi3RJ4fuqSC
HxsTF4kNmgY1l+hMe2tifA+/5cMHXeZGVgN6nBv1zlffYin8qJv3JTMa1UJgIDZ+FkShuPvU
dsWOJLmhTiEd+iZhS/K7G+5wV5MUPt4JUK8b7JJc7NP3oq7WUQbaXPuYqN/sSj91DBiHcwxf
kwO22Vkck7IM2JwWO6lFvS5c/HWV7SYWOQBn7pktmwqolcwrLZCy/N3tTpdo8UfnSv7HaOhN
lGy8PWGCRycx+xHpmtVQAhd0VJpBqkVPfqmQyTpQi9HR84n3Xh3IUL9QibN4tQvtENFdURrZ
EtJX33a7KXq6fV0TPj38e/5kFRo4IwM0BHidQzS/JB+ztUOYZza3LNX76R6G/+IxvXcQUnCC
s9pn4zYaH9LDrs5hMXoEuiC+hq17o+9R5p4l1zrmGtc0wjom3APb/bI0FcwWYsviDmNtNzbJ
DaNskKCaYRZQWhJlif6jn/7TyxkzbHwZfVLRGKW78FfRfjLWPJw13MWY8lHXSS6mer0dZq6G
xDUwnhPjLu3ChZk569GjAho4+mWBQUR7nhhEVGwRg8TZLTUEroFZOBu/ICNA6iTO0V+MXaO/
mLirnF+4egk6N/LXfu78duQ5noGYVLQHBVIJz0Qntm2C+/uWgjKNqfixPjQteEKDpzR4Zo5E
i3Ctpha/oMsbOVo1cjRrNDUbcJmz+Z7edDo07YyPaEyJDVqCTxsRWoogwrdsH5DAWb4uaWet
jqjMQc8i3092JNclSxL1KqjFrPyIhpeR+oy7BTNotK/GmOkQWc0qcxS7cXi/dVVdXmouYIio
q1hbIHXGkPNJv5L99ko9mWh2aekKcbx9ez69/mP7P2MIDrUa/A2i8qrGYO3iaE5J76jkDORJ
ViF9CecN/TDRlEN8WZU1fBe21bZyTFqdLDj82ofrfQ71CU3abKl0s27UbIdW3dhg0YWXi2vV
qmTk7UNLqR2W8LILDtRhlEHj0GiFNpG9iFKjvwSziDT12yohhiLQTZJoh02Mux0v9KfYwmAc
CJoU2GIdJQUdSbNRvftxUF8BJDwFde/weIc+Tb/jf+7O/3n8/Z/DzwP8Otw9nR5/fzncH6HA
093vp8fX43dko9//fLr/JDnr8vj8eHwY/Dg83x0f8cqs57AmQv/P8/M/g9Pj6fV0eDj9e0Cs
YrHBuwDoS3AJc6nqggKRZ3KolUc4ujFR0sSwVh3vdJT4a2Q7WrS7G53Dh7mEOls4JmhEs6pq
SRTPCvSkMhKWRmlQXJvQncpKElRcmRB8zjD7b2VHstw2rvwVH+cwk4qUOMkccgAhSGLEzVws
WReWI7MclWPJpeW9yd+/bgAksTT5Mpc46m6sBHoBuhuwgnlq3FXJjdPlN+KnX2+Xo3oP43i6
+dH8fGtO1pMIkhw0wozanRrLogUz47Mt8NSHCzYjgT5pseJhtjRvxByEX2RpZTkxgD5pbp57
9DCS0DC4nI4P9oQNdX6VZT71ykw509aAtpZPCgICdrhfr4b7BdzARZseg/ZYEAl12zH8mVty
sSlz5l6NaJrFfDL9EleRh0iqiAb6vZV/iBUiD0k4MQ7synC3u1gqdeZ4/f5zv/vrpfl1s5OL
/xkzxf3qOUz7yQvm9WDmLyzBOQEjCWcFI/oueA4I2vtVL/WYNiTa2aryezG9vZ1YuSyVf8j1
8qM5XPa7x0vzdCMOcsD4+u9/95gx+Hw+7vYSNXu8PHozwM20d+3nJWB8CVKfTd9nafQwsZ4t
7bb2IiwmZvR/OzJxF3qsCWZkyYBT37dfLJD+s6/HJ/MWoW078KefzwMfVvq7hRPLV3C/bJSv
PVg6D4hvmUF3htfhpiyIMqCVrPOBjBLt/GF8TFlRxyJtt4uin68lxggPTJcV0tfyRgq4oWb2
XlG2eYGb88VvIecfptQelYiRydmQfDuI2EpMqblWmBFuBQ2Wk/ezcO4vYrIpY/l6fHJGmaYd
kiwSwiqW/mYjKyKPZxPzbKHdFks2oYDT208U+HZCyM0l++ADYwJWgi4U2O9QadQ6u7XfiVB6
wf7th+WB1G1yanUD1HGjdfBJFYT+NmQ5/0ishXRtR744iD7G3lt8LBZgzlFXwR2Fip+yYvQN
nM/VEOp/D+UI6ChP8q8v8JdsSyhCLTsluKXwqUGwZ8rF0v3W/gSWghJA5TrFyfM/9PH17dSc
z5b63Y1SHrv7rHKberAvH/3lGW393sljaw+KZ+Yty8nB7ji+3iTX1+/NSUU3tNaBt+6SIqx5
lifUoWo7iDxYOGGJJoZkiwpDsQ+JocQMIjzgtxBD5wU6/5rKvaGu1ZRG3SLoLnRYQ2t2J6aj
GZ2ajopU1TusSKTamAZ40G8fanfshY1plDgMsMrmrj3yc//9hEmvT8frZX8gBFkUBprjEHCK
eSBCi4zWz3mMhsSpnTlaXJHQqE5PG6+hIyPRFH9BeCu9QG/Fa4nJGMlY84NKXD+6EU0PiQYE
1XJNLA8MR1ThAaBHj6lAPSFW//7jqMKMxH6YkE9TsLnYcOGbJYjkHAQjiWEx5uzk9WJDlzTw
3SWNpgK7PI4FHijJ06jyIRMkMquCSNMUVTBIVmYxTbO5ff93zUWuD7tE71fa37atePEFM1Le
Ix5rUTS0F4RuyCcxavvchuQPtPZZPejoJMk13IYXeIiVCeV3Jr3k9EmdL5ua0wXjZsB4UQ9C
nPfPh8fL9dTc7H40u5f94dnM2IA3WeZJYm45PPj4Au8M+44pvLJ6jUkdOj5MkxnLH9z2aGpV
NTAdTGVTlDRx60X0G4NWKYAGuac6EcqsdAUtrA7AuAahl1NnjOjcyfJaOqPYV9vMcw/UmCAE
1RITFZhR4zrCBLTOhOOpZi7fV7fCvA2SSCQD2ESUdVWG5pUkT/OZFbuRo39GUsWBMFMsqoNh
Zm1dDrsdBLIFmnyyKXxbgtdhWdV2qQ9T52eXoMPmfhIDW1wED2Sss0nwkSjK8vXQClQUMPt0
vZ8s2WhLSm6+NhAGnS3XExg2vGuxwdqYpbE9Yo1y/CIMKD7m7MLRIQeVAlvD3Crp50Adrw4D
StVsOnlYUNKpA6nJ/pluHA6Yot9saxVt0Ds+S0i9IV+c00gZKpRRxUL2ic7zp/Esp04KemS5
hD1B1Iu5JShjVaMD/s0dk5M9tB98HWxD89zSwERbKxtPj9hsB+hTEq4Ng3bxYS5T0EJTy34z
oVjW3NOBmbAafkh/lRJFF4utg/ki5SHwjHsBc5ebyW9g+WNwhhkZhSAr21CCPZDpjlgmlWEn
pxN0KmLSWWYpcsuOg2+xlPXJo3ykxdgL99UJmopnFUGCWEzxQDSGKFToPZ8SC1EXA4mI5Og6
8WFI1kWk7mOMlu4MzruI0sD+RTCPJEJ3Fl8EsDKNQ5udRdu6ZEaNYX6HCq3RYpyFyt2v53Lz
mdFYKpOiL0AU5w/mOKCa1KimAPaqonJaQIli22b2Wmx70rhfWskEbzL1a/b27Virw0jo22l/
uLzIvH9Pr8352b+VVQ92yDQFlgREIL6rYF0W6LdVQEuNQEBH3c3G50GKuyoU5dfO1anV87wa
OgqZoUm3PxNWzqj2/RJHNbbAzk0YaLxBigqxyHOgshJTD85Nd4ix/9n8ddm/ai3pLEl3Cn4y
ZrJf87IHaJVSQQvAHkS9ZnkiPRLN+9U8zOCbYmBkPOAHCca0NJiBirrHBTSoKtAyMApz0erN
p1+Oj8MiZqXJvVyM7B5G5Dy4dQBz4KBfV4kqwCLQuesP9vnqfQzKHsYCDhxKmzWtBVvh5b6f
abF7ruc359/KbaF3waz5fn1+xsvV8HC+nK6vOr9b79OKryKgEp1T6Z11R+0caBom2dIa/x0p
KO/FJF2MgYYj9eBVNHkzL6UGfJHVYmZwHf2r90yA323EOB90m5RU7a2bXVZC8WYb9x351STZ
ahaQyCooXNcbJ4XI6Bex5w298EXkTxb6uHuGnL5l7+q1/P+RxYDVha9/DIQXqZqRUIoZyjCV
9mga4hMndj4vVTYNvsHuofer3ncRI19aVUjpiVDZSeoKvkS9Q6JEMlMRZ37T9xQT0HMlUzhI
fwWDb3MpxleY+p04w1FY9N9ESZSkMoIt3MICnM06h2TbuaGfdmdUS5XSTl30INFNenw7/3kT
HXcv1ze1hZePh2dTAmEWUVyCaZrZ6fx6MIa6VsbhlEKi0Eqr8qvh3Y2Pj6CHRJVBj0r4QCnt
qoKoelnBeEtWmG90a9+ODtU1MpkazeBukQqfQSj7RJmzQ7R6UN0DZus74L/AhWf6UqWLBx6b
RuV0BQzy6SpfGrD2Q+tQQqDdNYXDXAmROSa5OhbAa9R+B/9xftsf8GoVOvR6vTT/NPCf5rJ7
9+6dkXFWVZuXdVyVYiMIZkrlWHK3vio7uNzzdaFcjZ1ySsWDHQgjGqlehyiqo+82HyZ1iIHB
jrCUMLq7dm3y9Vp1s6uB8vjic798q+b9i9m1Rw97DazahbFppPwGjlZXCV76ADNRxrU/QyvF
v7xvrVbbi+LaT4+Xxxtk1zs8LDq7HxcPnvyaMwSPsUX6REshlZsdnaRScl0wx1iJrwfKWP02
5sXaKgOdd5viOUxQUoLoJBJX8craSrrg0BIA8hqTrQjPocQiMYsT40MSDPPta3LbKHPGKQGP
OHFneva3ia2scbgzAAxHaWP5cMZrRanCfUGkoh1JLnCGD62YIXQS0C4zcyDKLRIrioX/4Ohh
fzxPqbkXLI8ezPcF9RDdAqY1VDbnC+4pZJf8+J/m9PjcGA6pVWI70qp8AUQyMwtvG5kKJjZq
uO5HU1jckEOspV3waKGAAR4m35RObliWc+mJN0xtHhpg0u3/R6XjN42Wuv7OWRi5aouFVGrR
kM7k1Gx6qJp1xGwlWs9fBxWmncB1ugXGBzDZ32jU0N6tRmPut6l1H9B4eHqvtlftZM8B/R2P
g/H7qSSuCW2wjC45z/lTWen/A4gbzcuDQwEA

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--azLHFNyN32YCQGCU--

