Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB8C3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 05:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6QB42zxkx5DaGIMpHLLWmfoGvbJQwm9vjJ8Uu2t6hk=; b=Hg2e9LZLcjJ0pqKuA8Oq+iEewQ
	lg3iC3grjs9yaZ+Jv3omMRg0uC4/SV00ZllUoCScjX9LOZn27s64uwo8zOD7J55d/ecm9j/y/Q0Vz
	ilXp5GRRdy8tf+T40+LTgtT0a4CROnkSsqlz3bu1aqI+pYQkehDGfu7yHY8LaSfbDqx6i2me0LSon
	a7bhcl4oJa88gJ9eH3l0LdD7rG1DsfrTgg5xJW03cpW2p0LioW0AuAYnFFbzazI8jBmaOnL6BA5Hw
	INvvO6iJD6o453u4DcspGF5PjQH0BrJg2FVm1Xaer7uEmmq9CYPSbewz2p4noWQXDKZvLQ3LyN3YT
	gtw8zwyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21BY-00000002kfE-0f3v;
	Tue, 08 Apr 2025 05:07:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21BU-00000002keJ-36ds
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 05:07:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B532B67373; Tue,  8 Apr 2025 07:07:36 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:07:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: kernel test robot <lkp@intel.com>, Hannes Reinecke <hare@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [linux-nvme:nvme-6.15 3/4] drivers/nvme/host/core.c:4302:5:
 warning: 'CONFIG_NVME_MULTIPATH' is not defined, evaluates to 0
Message-ID: <20250408050736.GA32275@lst.de>
References: <202504080139.KuphZ8ZZ-lkp@intel.com> <CADUfDZpvMAGheJ-k7jTa3pfjuTXCCZPt-iprnfd_HHAfS5+ghA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZpvMAGheJ-k7jTa3pfjuTXCCZPt-iprnfd_HHAfS5+ghA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_220740_919585_EF4E7D3C 
X-CRM114-Status: GOOD (  10.49  )
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

On Mon, Apr 07, 2025 at 12:02:27PM -0700, Caleb Sander Mateos wrote:
> Looks like it should be #ifdef instead?

Yes, I've fixed it up now.


