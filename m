Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2326C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C2XBbVBZODxWI6LW4HrLeDXnAaDkwLUx6JAlxTEeQJE=; b=TcWBNm3yhvZCOAdBP4L3COXRdX
	mkLQktv8ECkSYEIlLRbHChFS12QIzA3aCTubgi9I+2bWnCbXOmc49oPyL3kO1LTWKnHjn0OBadfL1
	2cxEbrwLQp1YRWmqNAz/9JwGkxxBwfAvAW6Jtsd2URVlmvWXtHHrgdhs0wYqygSpWmrLHw5RZAUTG
	UtrnbASReR4vel6pSKqPOD+e23Sl8wdWhnq6vw+RLVb+6jFCW2R1C8d7xIPIjq6bGPVQDSwtdmJLY
	ed2/ZpvjHQjSetj9YFZetbHwyXIZfm32Rcc2gOwJA8T73gIZGQccAkh0PeYWyQbvcFWhe0DMG0pt4
	ld9/euNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFseL-003brL-3Q; Fri, 04 Feb 2022 07:04:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFseH-003bqa-KC
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:04:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D9AF68B05; Fri,  4 Feb 2022 08:04:41 +0100 (CET)
Date: Fri, 4 Feb 2022 08:04:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 gregkh@linuxfoundation.org, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: driver core patch, was Re: [PATCHv2 2/3] nvme: Add
 device_update_groups()
Message-ID: <20220204070441.GA28558@lst.de>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_230449_834133_C8995342 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Feb 03, 2022 at 04:17:47PM -0500, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> This is used to update the sysfs groups after device objects are fully
> initialized.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>

This isn't a nvme patch, but a driver model one.  Adjusting the subject
to bring it to Gregs attention.

