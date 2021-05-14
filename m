Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F125C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 05:56:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB4461442
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 05:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB4461442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZNDo0MSGRtNwQCt9nN3vP6H1koX8mHzEY8KwtueKMI8=; b=dlyxheHCliJ6b4C3QnaUjgywHk
	wcdPqr0UfmTMxj6mVz2uSVFT0e+KYZ8uRruYebNLisIGqKa96IHf6j7PuiDKA38XizZA5r+n9N8gt
	8oxf+ABIeh8GERCyz1AGTWs31Vy8Uk3fF4//pQ8vpyD9h+ZMMXqhNNynqUAkUyHa0Yk4u80H39kVh
	S9up9w9w65vyg3i95jx4+dsnbvxsW5JBpGvEPGweci35qf+NrXthssoHC8AaOzB2CUnwxQIHsnaKz
	GVwEaihoC7ArteEGaUr6vxnHmhDU4G656Wsdys4+iluCCYVkJSB3HnvFpfoKiJyj7wiT1mJQUilWD
	CIs4mVqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhQnm-007G2R-51; Fri, 14 May 2021 05:55:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhQnj-007G2M-UR
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 05:55:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=QFPcnwW76BCChzSyBUnO2Rk3vit29FVE4gXIVO6O44g=; b=0PqySgn0oy8nFDM5rit5XKnga3
 Ie0ewM6spzEC6qeGrFNivw+NrDgeUjw+woeD8/Kmq2kdbsgVwUFiwPl4UxG1aHxBbD9O8lxRGfdJK
 /b/uL81hfIea3zbVWx94nkzWMBOPOxmAJYBkldIHsWVdPeyQ7U5DAzHVyjiyTmYWjoJgxxNWz7YT+
 PHXEm7nhN4yelgPTM+BUVje9aNf20W+eGKYdHju6p0gLAoKCPFPI7PGMDGGcDL5nPCHesGDZToaTV
 SH0TyoiWk2cP/iF4oVfz90NGr4tBqeLH0/rjgD4SnRkm2hAuDF9EczLlgRE8d8Mj9wW8fXFWHPlAW
 WPGnU+Ww==;
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhQng-00BjjD-JL
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 05:55:54 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5t0RV045369;
 Fri, 14 May 2021 05:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=QFPcnwW76BCChzSyBUnO2Rk3vit29FVE4gXIVO6O44g=;
 b=jB9RFG/xCIfZlItgObzOaaXXQ/OypXcYl9nLxGzKXk3EQW4Xxh7yfkAWif+rnxMRCc2F
 L5UWhcuZCu/tZj0/hX22LXHhEoEfE4loiPkMg9ND5u+3R6zVZCq1I2199SR6+tMqw+ab
 /g+7iLCX3mBOjuNGKABIm7C3tH6PBUeApg9wBjQ6tPe+gtzFxmn+FkKzXJLLBVOo8hn4
 sDMjRhn2t86Qai38IX9c/GpoIq4mOBxm4EP9v7J108JhZ3loR0Bi/N52zdK/VeHwUQFT
 HFOgPW4VmOGcOQEnYNIsEtJecAYRsO6Zi+t6VfZ8Frx4SyMRVntWEVo6TmF/DhAi/gko SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 38gpnekdtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 May 2021 05:55:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5oAjO134540;
 Fri, 14 May 2021 05:55:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 38gppgwtv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 May 2021 05:55:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14E5tdpK140706;
 Fri, 14 May 2021 05:55:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 38gppgwtv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 May 2021 05:55:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14E5tbHB028033;
 Fri, 14 May 2021 05:55:37 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 13 May 2021 22:55:36 -0700
Date: Fri, 14 May 2021 08:55:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Christoph Hellwig <hch@lst.de>
Cc: lkp@intel.com, kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>
Subject: [linux-nvme:nvme-5.13 1/9] drivers/nvme/host/multipath.c:815
 nvme_mpath_init_identify() warn: missing error code 'error'
Message-ID: <202105140250.xTxn7Eqi-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: eJXpQBUYURq5OqDIbt0P-n0DhGGupfgD
X-Proofpoint-ORIG-GUID: eJXpQBUYURq5OqDIbt0P-n0DhGGupfgD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_225552_756259_782E280B 
X-CRM114-Status: GOOD (  11.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree:   git://git.infradead.org/nvme.git nvme-5.13
head:   e181811bd04d874fe48bbfa1165a82068b58144d
commit: 5e1f689913a4498e3081093670ef9d85b2c60920 [1/9] nvme-multipath: fix double initialization of ANA state
config: i386-randconfig-m021-20210513 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/nvme/host/multipath.c:815 nvme_mpath_init_identify() warn: missing error code 'error'

vim +/error +815 drivers/nvme/host/multipath.c

5e1f689913a449 Christoph Hellwig 2021-04-29  791  int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
5e1f689913a449 Christoph Hellwig 2021-04-29  792  {
5e1f689913a449 Christoph Hellwig 2021-04-29  793  	size_t max_transfer_size = ctrl->max_hw_sectors << SECTOR_SHIFT;
5e1f689913a449 Christoph Hellwig 2021-04-29  794  	size_t ana_log_size;
5e1f689913a449 Christoph Hellwig 2021-04-29  795  	int error = 0;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  796  
66b20ac0a1a107 Marta Rybczynska  2019-07-23  797  	/* check if multipath is enabled and we have the capability */
92decf118f1da4 Keith Busch       2020-04-03  798  	if (!multipath || !ctrl->subsys ||
92decf118f1da4 Keith Busch       2020-04-03  799  	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
0d0b660f214dc4 Christoph Hellwig 2018-05-14  800  		return 0;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  801  
0d0b660f214dc4 Christoph Hellwig 2018-05-14  802  	ctrl->anacap = id->anacap;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  803  	ctrl->anatt = id->anatt;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  804  	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
0d0b660f214dc4 Christoph Hellwig 2018-05-14  805  	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
0d0b660f214dc4 Christoph Hellwig 2018-05-14  806  
5e1f689913a449 Christoph Hellwig 2021-04-29  807  	ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
5e1f689913a449 Christoph Hellwig 2021-04-29  808  		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
5e1f689913a449 Christoph Hellwig 2021-04-29  809  		ctrl->max_namespaces * sizeof(__le32);
5e1f689913a449 Christoph Hellwig 2021-04-29  810  	if (ana_log_size > max_transfer_size) {
0d0b660f214dc4 Christoph Hellwig 2018-05-14  811  		dev_err(ctrl->device,
5e1f689913a449 Christoph Hellwig 2021-04-29  812  			"ANA log page size (%zd) larger than MDTS (%zd).\n",
5e1f689913a449 Christoph Hellwig 2021-04-29  813  			ana_log_size, max_transfer_size);
0d0b660f214dc4 Christoph Hellwig 2018-05-14  814  		dev_err(ctrl->device, "disabling ANA support.\n");
5e1f689913a449 Christoph Hellwig 2021-04-29 @815  		goto out_uninit;

error = -EINVAL?

0d0b660f214dc4 Christoph Hellwig 2018-05-14  816  	}
5e1f689913a449 Christoph Hellwig 2021-04-29  817  	if (ana_log_size > ctrl->ana_log_size) {
5e1f689913a449 Christoph Hellwig 2021-04-29  818  		nvme_mpath_stop(ctrl);
3b7830904e1720 Logan Gunthorpe   2020-02-20  819  		kfree(ctrl->ana_log_buf);
0d0b660f214dc4 Christoph Hellwig 2018-05-14  820  		ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
5e1f689913a449 Christoph Hellwig 2021-04-29  821  		if (!ctrl->ana_log_buf)
5e1f689913a449 Christoph Hellwig 2021-04-29  822  			return -ENOMEM;
bb830add192e9d Susobhan Dey      2018-09-25  823  	}
5e1f689913a449 Christoph Hellwig 2021-04-29  824  	ctrl->ana_log_size = ana_log_size;
86cccfbf773faf Anton Eidelman    2019-10-18  825  	error = nvme_read_ana_log(ctrl);
0d0b660f214dc4 Christoph Hellwig 2018-05-14  826  	if (error)
5e1f689913a449 Christoph Hellwig 2021-04-29  827  		goto out_uninit;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  828  	return 0;
5e1f689913a449 Christoph Hellwig 2021-04-29  829  
5e1f689913a449 Christoph Hellwig 2021-04-29  830  out_uninit:
5e1f689913a449 Christoph Hellwig 2021-04-29  831  	nvme_mpath_uninit(ctrl);
bb830add192e9d Susobhan Dey      2018-09-25  832  	return error;
0d0b660f214dc4 Christoph Hellwig 2018-05-14  833  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
