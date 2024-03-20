Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EE1C54E68
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9G9vK/EcbzB2uvH8f3HH1Z1ocydAjTXyxBkXIHoLmJo=; b=V/zaWb4EO4npufbKTjE5GBvaIP
	xnOOQC4WlLx4XwBTHKA3/NgWn6VDWmldTiNmmFSiFp8kiDGWrrMZgXALM5nSZkW4La5o9dJ3HtOHq
	M4aZ3vR4Hzx8nyKm9TqnQ+FNq35i+NKN4jk2yzwdIv3EX1YopXYnnIkVqfQxiyGIOg8AxJbpD5zWx
	3w3TIVKU/A6ElzL9xdaPBmTYyVeI8waGt5gBs/Gpa/IIZfFF9M2LWqDWtyZnghQX3ufKsYkphhkJx
	k4rGSKQCXfxR6O12qffpjGRqoZymyiJ1hhQ7zL6UBAF3kh3n8L69DfVcZK9IL3GDODyhRBqsz4r5+
	2PRhL8fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlF6-0000000Ez03-0mah;
	Wed, 20 Mar 2024 01:59:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlF2-0000000EyzD-36gt
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 01:59:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90EA068B05; Wed, 20 Mar 2024 02:59:32 +0100 (CET)
Date: Wed, 20 Mar 2024 02:59:32 +0100
From: "hch@lst.de" <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Message-ID: <20240320015932.GA14551@lst.de>
References: <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me> <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com> <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me> <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com> <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me> <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com> <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me> <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com> <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com> <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_185944_950076_BF9841AE 
X-CRM114-Status: UNSURE (   9.52  )
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

On Tue, Mar 19, 2024 at 11:19:50AM +0800, Guixin Liu wrote:
> I am adding a per-controller percpu-ref to ns to implement 
> preempt_and_abort, the v9 will be soon.

Do we need that?  For blk-mq based backends just doing a queue freeze
would be enough.  That doesn't work for bio based drivers yet, but I'd
rather improve the block layer freezing for them rather than reimplenting
the whole thing.

