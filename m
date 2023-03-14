Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B5C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5BZGmZpWENLXzHCg3uMpOWvPGd2yicVymOP6EEZkdo=; b=L0GrAXeIl07kOFoYCxucHBEElc
	sUI/XBF6/O7hYMW0H/Zc+vgMnQ9WSQNvYGP1OjH5sgeTiDWkJV1vRr1ALgPQYZghf9mpjIIJsJ9xJ
	Cf6UBV3TxilhtZPDGGKXZOu/zOhOXu1FrwfI9OeIGJxe63NCeyEWDxY9dkVry8/dQ5JTzHkZjqgjA
	VVD+GbDviZG+PpgS1mhj3j6+UVXqjznmv3lWixfXCdjny7TFG84LyeNMz1IeQcJrUxw8VWabrhtL7
	Sy94IQUSqt6A09XZ4D1WdpFw2edAGDsFdBKEga/NEcTn1GU89Nxy02iI4UtEopjAxHpE5EBUYAH0d
	VAEkouNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8FX-00AyUD-0b;
	Tue, 14 Mar 2023 17:15:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc8FR-00AyRy-1w
	for linux-nvme@lists.infradead.org;
	Tue, 14 Mar 2023 17:15:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D95EE68B05; Tue, 14 Mar 2023 18:15:38 +0100 (CET)
Date: Tue, 14 Mar 2023 18:15:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v4 07/18] nvme: Fix reservation status related structs
Message-ID: <20230314171538.GG6780@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-8-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224174502.321490-8-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_101541_786916_3A198593 
X-CRM114-Status: GOOD (  10.74  )
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

On Fri, Feb 24, 2023 at 11:44:51AM -0600, Mike Christie wrote:
> +	__u8	resv10[14];
> +	union {
> +		struct {
> +			__u8	rsvd24[40];
> +			struct nvme_registered_ctrl_ext regctl_eds[0];
> +		};
> +		struct nvme_registered_ctrl regctl_ds[0];
> +	};

... actually - I think both these zero sized arrays should
be the modern [] notation.

