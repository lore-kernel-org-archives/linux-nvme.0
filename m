Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3CFC5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0xW84Rk78A4uW17wmOjzcEpk54UByRLFL9ToR8rFEU=; b=CDAKu/dYRW9p4dX6keF9/EjLCi
	QOzttDl5gCkXQ4BF1Tq7dvUUS8G/Dmh7oG/dsB2nrrVfkpOLA/xAIF9nQyNyGON+rsPQ2mHndO+uW
	bSk8OcS827hsW6qLAVyNU2iyBsypUiH70cPjVuCZKwHATWk6Z8B8igDcE0xxt3IjgmDuVa6P1GNYh
	M7VzR6LB1j5CDGqq1fKvVEoWgIQp6wnDgzanGglik897g06ikPWPYA+y3rVUBKVcu3hJrdGyIR53f
	PhmiNDxZOeZ2gzR3VnL/yO9hUVE3K2WyjxiIsTJj4DQnMl5kOrb7gWl5tXk4w9oq+Q3CGnF4MdmnK
	DrIUZDbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8Wn-0000000GEid-1983;
	Wed, 12 Aug 2026 12:57:53 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8Wk-0000000GEhn-1EJN
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 12:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786539470; x=1818075470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAaq27bG1xoJR0GZbjdsKyHko5Bbb/ApRKzkUInf38Q=;
  b=n4KHH9a6E8O4iR4PPp1pl1dVZrYu8P8Afx7x1ei5FN5Rf4rNlFy/XUfS
   GW/SbzzUsjxjYzK1vfYdkt38aaEuNoQc/XgO8G8yJ5D57lYQqOa01p8YE
   rBPQX13Z5kI6h4vBvdRMWJbNwCXG7ZejFWh+JteagCkM6LU5d+Q7i2bpj
   Lrh3Lgspr9+UffwTqLTwYmAgpUJs1lOVLjUflNFV+a3va/UrDLQnulTzk
   KejNqOB5ue+uHp4dxsqnNyPwiabSin9VdWwNtkCcmJUIOVXk+KXb3TBWb
   olp+1ezM5ymdvh6kZSWpdHz7VkD7pihw7ANvMKeNOQ9RDNzm9Vzroe2Hm
   A==;
X-CSE-ConnectionGUID: sdLlgIrpRSKOB6xqbDC+uw==
X-CSE-MsgGUID: 8JTbFHHISy24EpHkrHgasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86052309"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86052309"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:57:48 -0700
X-CSE-ConnectionGUID: boqzykYPTJOqaFEAF2goIQ==
X-CSE-MsgGUID: /FkBDvrTTL2A0vI043o8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="259813861"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:57:45 -0700
Date: Wed, 12 Aug 2026 20:57:42 +0800
From: kernel test bot <yi1.lai@intel.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
	gjoyce@linux.ibm.com
Subject: Re:
Message-ID: <anxtxmmGcYq7uUOt@ly-workstation>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
 <20260727151652.3660476-3-nilay@linux.ibm.com>
 <202608111002.8c383e35-lkp@intel.com>
 <7c68c535-8ae0-4a93-a5ee-5012edcf529b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c68c535-8ae0-4a93-a5ee-5012edcf529b@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_055750_346106_50E089ED 
X-CRM114-Status: GOOD (  19.16  )
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

On Wed, Aug 12, 2026 at 05:19:56PM +0530, Nilay Shroff wrote:
> On 8/11/26 2:06 PM, kernel test robot wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed "blktests.nvme/048.fail" on:
> > 
> > commit: 657b4cd151e042afc228615869b2a6876b91b8fc ("[PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count")
> > url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/net-add-helper-for-device-lookup-by-destination-address/20260731-154725
> > patch link: https://lore.kernel.org/all/20260727151652.3660476-3-nilay@linux.ibm.com/
> > patch subject: [PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count
> > 
> > in testcase: blktests
> > version: blktests-x86_64-72a6349-1_20260804
> > with following parameters:
> > 
> > 	disk: 1SSD
> > 	test: nvme-group-02
> > 	nvme_trtype: tcp
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <yi1.lai@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-lkp/202608111002.8c383e35-lkp@intel.com
> > 
> > 
> > nvme/048 (tr=tcp) (Test queue count changes on reconnect)
> >      runtime  4.358s  ...
> > nvme/048 (tr=tcp) (Test queue count changes on reconnect)    [failed]
> >      runtime  4.358s  ...  7.340s
> >      --- tests/nvme/048.out	2026-08-04 23:49:51.000000000 +0000
> >      +++ /mnt/nvme-group-02/nodev_tr_tcp/nvme/048.out.bad	2026-08-06 06:04:55.281322408 +0000
> >      @@ -1,2 +1,4 @@
> >       Running nvme/048
> >      +expected queue count 3 not set
> >      +FAIL
> >       Test complete
> > 
> Thanks for the report!
> 
> This requires changes in blktests nvme/048. So once this change/commit
> is merged upstream, I'd send another patch to update the test.
> 
> On another note, you may want to check your automation script which sends
> auto-email. I see the email subject line is empty.
> 

Thanks for the kind reminder. Will adjust it.

> Thanks,
> --Nilay

