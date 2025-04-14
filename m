Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560CAC369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BGT/AEEIaOvDWb4X8rSJ3uqAg3I4nP5pusypyoph5kY=; b=Efx2lsi96fcN+NwSVHZ0cvzCtW
	BTe6iTsDPrs/EBIV9UY+yVEGa343keXqfMe9Iaymh2MkGuT/IofnkeSP3QogCISdMAV5/lktrnRqy
	seTdRkhxRWYQcFf9OJwhCkCyl9k4cJj7d9atEAvYyxZRHphzlB4cV4P13/9cIOFcEt/nqWME0HEfU
	7DfRsXNXLbD/dZklLayvoGZM+eHuDrjn4XKzgpVqN4egRagFYYu++HipMop4nouk7N9l2eTgP/xh9
	+y5NnXWT7v5DQLWZ8ecUa8c7zOfnmjxvrKdMu/EmP10eEOJdrDGCe5KEm3ePnC+gppB4vq85erftB
	d889FusA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IaY-00000001skj-2RMJ;
	Mon, 14 Apr 2025 12:06:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ITV-00000001rbi-1AHh
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 11:59:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB0C468AFE; Mon, 14 Apr 2025 13:59:35 +0200 (CEST)
Date: Mon, 14 Apr 2025 13:59:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, hare@kernel.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <20250414115935.GA14345@lst.de>
References: <20250414090959.2015-1-hare@kernel.org> <20250414111916.GB13225@lst.de> <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de> <20250414114128.GA13822@lst.de> <564eb846-6208-49c0-bdf9-409568698dd0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564eb846-6208-49c0-bdf9-409568698dd0@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_045941_457872_74FF7CAC 
X-CRM114-Status: UNSURE (   9.89  )
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

On Mon, Apr 14, 2025 at 01:55:26PM +0200, Hannes Reinecke wrote:
> A simple NACK would have been sufficient.

Not, it won't.  Your behavior here where you keep for something really
stupid after repeated NAKs is infuriating.  As is the OEMs behavior to
even ask for this behavior to start with.


