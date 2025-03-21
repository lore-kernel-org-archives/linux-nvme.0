Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB3BC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtymOAA43Ywb343QihXwnioqcYtnrITZ2ESm0dLEJgk=; b=DtDmU4uo7bCFq+BlX6z4VAxO9D
	66cWMGisjq3YvIxdhijitUC923Z4D5zJYKpmOQgdClo68VkitGHMGc2g5ISGaEaXwxIzNDk/ZpQ2+
	n0TqxqtMjEnAw6h8M8dZzEKq51vy/KHsn79PYm5lFwFfkzxhMiRwviKq2muEVJ1fyEl8r/Ua4Ulnf
	ZBYLsBnwfPtuSSTFuCXJi8EjOnp3l3Ikc8Mrck6GbhuHORUjUc4xuf8rkj9MZ2cfkQlWXmS6M9U8R
	LGln2f9KatkL/gvFKQn1kVX6ZUgzeGNF6iuo4vOyvZJGMcnCDGRbolp5JqNgx6dp3o873/xXrVV42
	NYUuZPOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVdq-0000000DxqP-2LK1;
	Fri, 21 Mar 2025 06:14:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVdn-0000000Dxpu-3c45
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:14:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CAC768AA6; Fri, 21 Mar 2025 07:13:55 +0100 (CET)
Date: Fri, 21 Mar 2025 07:13:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
Message-ID: <20250321061355.GB3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231400_037126_A192D5C4 
X-CRM114-Status: GOOD (  12.50  )
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

On Tue, Mar 18, 2025 at 11:40:03AM +0100, Daniel Wagner wrote:
>  };
>  
> +#define PORT_DELETE	0

The way I read the code this should be PORT_DELETED?

Also maybe add a little comment, once we grow more flags that really
helps.


