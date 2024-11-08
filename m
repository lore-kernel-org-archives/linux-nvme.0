Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80540D5E142
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NrSn01O7zVzIegbTYXDgYZi+xE+AVBPXymKhqxLJ6Uw=; b=t4KOQ6XWgq55wweqATcbkws0dt
	zMbx4SsjpxAtjLTW0dU2HDS4DYBIsohZlG6aU+1lUqZ2zLwmi9XWSpxlhBtr4YdgBcTWp8W7Wb04f
	Amak4+8GfJIyRrg1lz1i0vYuiqkoC2WEJlHeRUG0BKT9yq8uYRfE3v1NXj+P0PTQpr58LzrVZOKA7
	dhYQ8/mq9XlCFeZFBiBEFFoPcxZn99r1Zo7/0g8jDZJn4Lb1v65HXlT7vMrfUswV97CBLt/5X0OLS
	m0zHHefBPv1vbi+kodmlowC5HAYAvnHRF23Xz0lEhfIfO46lY0DYvQoYYEQ721iM12544M+T0d2zV
	n6mtlp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J8u-00000009alL-3Y6q;
	Fri, 08 Nov 2024 07:10:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J8s-00000009akh-0ea4
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 07:10:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A94E568B05; Fri,  8 Nov 2024 08:10:43 +0100 (CET)
Date: Fri, 8 Nov 2024 08:10:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, Keith Busch <kbusch@kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [linux-nvme:nvme-6.13 7/7] drivers/nvme/target/pr.c:857:34:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <20241108071043.GA9339@lst.de>
References: <202411081109.soCWJfGT-lkp@intel.com> <c44c4ea6-ef4d-4152-ba21-9a76011dd75e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c44c4ea6-ef4d-4152-ba21-9a76011dd75e@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_231050_362681_2DF2F3F0 
X-CRM114-Status: GOOD (  10.34  )
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

On Fri, Nov 08, 2024 at 11:29:35AM +0800, Guixin Liu wrote:
>     I miss here should use cpu_to_le16, should I send a v20 to fix this?
>
> Best Regards,

Just send an incremental fix that can be folded in.


