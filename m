Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE651C54E60
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WpM7APihcKQtMvzuapLZyOp2x53r3GT9Tq6/HjpPAeA=; b=ZBLgWqs5PDcxkWI2YR7fNRhNPB
	J2WRPwIaJWRnbCe5inkXYXRYK33iCm4/9mwZc8yKTHofI4kN0MrvCOEBwm7RoTJBQY4C3JS4v8uYj
	XxPHk+w5p3KLtEGs2tfnhgZYuAtt1GZWNg5SQVD6bqTrfFx/5e6IkwXAMEEabb4x6BWv1kgeXhaTl
	yjVk5mXWL2zgRw50JvWB4aiH0Yz2ZMSwVDaljiFtBBMeIWxByyn07om32aR5aWVp/Ky5PwecyQ/wb
	STeLcIBcstzkMsRPMRJkrgdl71VNu4+uu1VOewpIWCT/I8PQnG3qWw4pSHacW1lQDopbizjsJFhw0
	j267p4bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxFU-00000006NEy-04I9;
	Sun, 17 Mar 2024 20:36:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxFR-00000006NEL-2SKQ
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 20:36:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A530668C7B; Sun, 17 Mar 2024 21:36:45 +0100 (CET)
Date: Sun, 17 Mar 2024 21:36:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [nvme]  63dfa10043:  fsmark.files_per_sec 6.4%
 improvement
Message-ID: <20240317203645.GB5975@lst.de>
References: <202403151552.e3809b61-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403151552.e3809b61-oliver.sang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_133649_808282_38273317 
X-CRM114-Status: GOOD (  10.54  )
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

On Fri, Mar 15, 2024 at 04:21:13PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 6.4% improvement of fsmark.files_per_sec on:
> 
> 
> commit: 63dfa1004322d596417f23da43cdc43cf6298c71 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: fsmark
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> parameters:

That is kinda odd and unexpected.  Is this system using one of the old
Intel SSDs that this quirk is actually used for?


