Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BDBC77B7A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 04:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iLxRvZ+7lUNZWojUx0sDac6+8i+ApwSrWoB4Zu7LMnE=; b=QgcKzoX62pA5e6SF3BBHNqQJd8
	UN01nSdUvDTUrYqNGJY4hVDGtVnD8BLL2kKR+j6Zjml0mKuV1iw+zXc55Tz0v6leSlfNbFux2q38H
	s8uPwGBjgdtcEDc/DQIgig93jvMOFsPS1NrZXkT2aExRp4qba3iCBMHfz9DeYEbqza8Z/p+bR4nQM
	bnwZ7JdqGnRqipAp7qbM6HoODNoyqAC51JM2tYg0qIiYvz/4zo99ahlUaKxgDBuVm4Fkf564XdhAG
	MTrMyGBD/1110sTErC2iBJh/ydSqJISl3FbDLKTGawm68Tovvc6XIDmPFNXMEBJAsHdIW9xMqbMj7
	kvzQ/GNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4wpO-005jHp-1Z;
	Fri, 02 Jun 2023 04:55:54 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4wpL-005jG1-1r
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 04:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iLxRvZ+7lUNZWojUx0sDac6+8i+ApwSrWoB4Zu7LMnE=;
  b=XPqqeWHT6ewjok2C9KYzUURSb3I6VWOaOZ07IZ6oGl91XvCRX/xPCPUC
   /CydWsimcui6X2ZOTkOU8lXQPbIox6JMpX3rKADs2eRMR9gYTJxHjWJe7
   e4gKRLCsHKsF2uh85ai5H9IYxOXaH8XUfD06aCelmQSuHW8VhR5MXdXYZ
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.00,211,1681164000"; 
   d="scan'208";a="110830311"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:55:44 +0200
Date: Fri, 2 Jun 2023 06:55:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Max Gurtovoy <mgurtovoy@nvidia.com>
cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org, 
    Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@nvidia.com>, 
    Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-6.5 15/21] drivers/nvme/host/fabrics.c:96:2-8:
 preceding lock on line 85 (fwd)
Message-ID: <alpine.DEB.2.22.394.2306020654430.2925@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_215552_095323_1C590F0B 
X-CRM114-Status: UNSURE (   8.79  )
X-CRM114-Notice: Please train this message.
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

An unlock appears to be missing on line 96.

julia

---------- Forwarded message ----------
Date: Fri, 2 Jun 2023 09:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [linux-nvme:nvme-6.5 15/21] drivers/nvme/host/fabrics.c:96:2-8:
    preceding lock on line 85

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-nvme@lists.infradead.org
TO: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Keith Busch <kbusch@kernel.org>
CC: Israel Rukshin <israelr@nvidia.com>
CC: Christoph Hellwig <hch@lst.de>

tree:   git://git.infradead.org/nvme.git nvme-6.5
head:   14ad91f7a9a29562f23bedd205ef209255d8b8d1
commit: f0cebf82004d610be3ef47abf315ddf95aa2dcd1 [15/21] nvme-fabrics: prevent overriding of existing host
:::::: branch date: 9 hours ago
:::::: commit date: 3 weeks ago
config: riscv-randconfig-c032-20230531 (https://download.01.org/0day-ci/archive/20230602/202306020909.MTUEBeIa-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202306020909.MTUEBeIa-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/fabrics.c:96:2-8: preceding lock on line 85

vim +96 drivers/nvme/host/fabrics.c

f0cebf82004d61 Max Gurtovoy      2023-05-12   80
f0cebf82004d61 Max Gurtovoy      2023-05-12   81  static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
07bfcd09a28855 Christoph Hellwig 2016-06-13   82  {
07bfcd09a28855 Christoph Hellwig 2016-06-13   83  	struct nvmf_host *host;
07bfcd09a28855 Christoph Hellwig 2016-06-13   84
07bfcd09a28855 Christoph Hellwig 2016-06-13  @85  	mutex_lock(&nvmf_hosts_mutex);
f0cebf82004d61 Max Gurtovoy      2023-05-12   86  	host = __nvmf_host_find(hostnqn, id);
f0cebf82004d61 Max Gurtovoy      2023-05-12   87  	if (IS_ERR(host)) {
f0cebf82004d61 Max Gurtovoy      2023-05-12   88  		goto out_unlock;
f0cebf82004d61 Max Gurtovoy      2023-05-12   89  	} else if (host) {
98096d8a787f05 Christoph Hellwig 2016-08-18   90  		kref_get(&host->ref);
07bfcd09a28855 Christoph Hellwig 2016-06-13   91  		goto out_unlock;
98096d8a787f05 Christoph Hellwig 2016-08-18   92  	}
07bfcd09a28855 Christoph Hellwig 2016-06-13   93
f0cebf82004d61 Max Gurtovoy      2023-05-12   94  	host = nvmf_host_alloc(hostnqn, id);
07bfcd09a28855 Christoph Hellwig 2016-06-13   95  	if (!host)
f0cebf82004d61 Max Gurtovoy      2023-05-12  @96  		return ERR_PTR(-ENOMEM);
07bfcd09a28855 Christoph Hellwig 2016-06-13   97
07bfcd09a28855 Christoph Hellwig 2016-06-13   98  	list_add_tail(&host->list, &nvmf_hosts);
07bfcd09a28855 Christoph Hellwig 2016-06-13   99  out_unlock:
07bfcd09a28855 Christoph Hellwig 2016-06-13  100  	mutex_unlock(&nvmf_hosts_mutex);
07bfcd09a28855 Christoph Hellwig 2016-06-13  101  	return host;
07bfcd09a28855 Christoph Hellwig 2016-06-13  102  }
07bfcd09a28855 Christoph Hellwig 2016-06-13  103

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

