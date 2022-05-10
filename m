Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A645C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 05:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DNRn4fUaBHY7dyYdE36lHeZVSZC5IBBeYtKkKpRnr08=; b=C4+aceIOthWI2FtL4rZ2H4dWiF
	6oRLS7gr9HdS1d3wJr8SVCgAVyIcyrJ6e3zXSvLH26rOGoIy/r6eX8WkIxJip4r7UYXLTiJz/mZRu
	ukJF/KtiObsB91Xq6oRwqHWV0zTzTIidwGJAu5Jz40sJH4eOu6HzRH2IwPxB3eqHQC57tiaQiEeAJ
	q7nRJOuZ/R5OXD6d7dioHsvjgiutvGGD+lp23vR/cDwCmwzC1LrnLxTvThdl/R7OIsFZtk3ICA7Qf
	sa7aGHYEBB3dWomOkkcDIkf/fa+qgh/C1VBPg2DN0gi8bCqbEVocGqNz/MKq0J3jxjZ/EA1jMSWFR
	JYoXVWBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noIkC-0003os-AA; Tue, 10 May 2022 05:49:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noIk9-0003nd-Sy
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 05:49:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5617168AFE; Tue, 10 May 2022 07:49:04 +0200 (CEST)
Date: Tue, 10 May 2022 07:49:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: introduce bit 5 of smart critical warning
Message-ID: <20220510054904.GA10460@lst.de>
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
 <20220507065026.260306-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507065026.260306-2-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_224910_133956_AB3D0E4E 
X-CRM114-Status: UNSURE (   9.54  )
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

On Sat, May 07, 2022 at 02:50:24PM +0800, zhenwei pi wrote:
> According to NVM Express v1.4, Section 5.14.1.2 ("SMART / Health
> Information"), introduce bit 5 for "Persistent Memory Region has become
> read-only or unreliable".

Given that Linux does not support the PMR, do we really need this?

