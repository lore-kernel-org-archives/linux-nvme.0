Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D568CF537D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kigagIscJF02f3lL336vHodIFlhUzNDF+UvGDpfAOrE=; b=aG15jxVBc8rliQe7xO4fcXS/hO
	PsFNRb7Bu3sIX37QevF1EKZqKegeRo6OIGUI7GdJxJaSJMVTVTBTTKWRY1ZR1BKAKHeM58RasYyTh
	hB3Yq1wJtBlZ2FWvDXqsr1tjJ0qj3yg0cmtsTj/BkgHDTd+T214AeDA5rtl1aAijzkz+6AdUeYFnQ
	o7qvw/PyhURGwBip6LZEJnpdSwcDt/jiX41USdADMSp8pyTOBQcXEEkaoMHhguCVlSHJhDUFpPv23
	LF+U4e7omAtrD82IuT2bh4Oe0iBG1rpfFvq8iPrV41USJoGJnHz4AvN7lWRRRRmJLI8joJzMllkQ2
	IhZSB+tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3akN-0000000ENG7-1oav;
	Wed, 23 Oct 2024 12:45:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3akM-0000000ENFc-0Dkt;
	Wed, 23 Oct 2024 12:45:54 +0000
Date: Wed, 23 Oct 2024 05:45:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
Message-ID: <ZxjwAsny4yOUHvUD@infradead.org>
References: <20241023100915.11263-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023100915.11263-1-ikegami.t@gmail.com>
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

On Wed, Oct 23, 2024 at 07:08:36PM +0900, Tokunori Ikegami wrote:
> The PI is the first bytes or last bytes of the metadata.
> So its size is not equal to the metadata size only but below also.
> Then fix the function to check PI size if metadata size or below.

So basically what the patch does is to make PRACT work for PI where
the metadata size is bigger than the PI tuple size, right?  Maybe state
that clearly and put less emphasis on the mechanics of the change.

>  		 * The current fabrics transport drivers support namespace
> -		 * metadata formats only if nvme_ns_has_pi() returns true.
> +		 * metadata formats only if nvme_ns_supports_pract() returns true.

Pleae stick to 80 character lines.  Also a few more offenders below.


