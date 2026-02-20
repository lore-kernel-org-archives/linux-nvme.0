Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2BBC5ACC1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mX3Gfh9y0Kt7rFh9kNJbU6lmghBDbpYgwSqpoEcYuv0=; b=lwfxzFHQKQXbSwgi8aZ1hE9+gF
	heTwOUejOui+2hyckpX/K/AamoCFGQ2jf9RQgnQKR4fbIg+Sv4CbjnGTXwnImgD5+Zm2IxfCb4HSm
	9nNKuOdnwPgkO1gfvgd7oz35Fp3gugQ5iDPA44Vs5cX1I5nmA+EiyT/Jju0nQ/aJfkuXXH6f0Q7ok
	SjXhPKf752NhlmmnyqnkaKTne6ux3lSSptFm9UqixV4HZTseZzUDE6PTJvpK/SSpnVoyAH5ROuK6H
	U89sj+d9oMioGbwIxb8FrphjIcFawjtnQSqGOby2iX5wwNkX7Ixy5555wiiSHuABttaXQNhiV3p/9
	Decd3e4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTdI-0000000FJQE-2nNF;
	Fri, 20 Feb 2026 16:45:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTdG-0000000FJPR-2Amd
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:45:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDB3C68BFE; Fri, 20 Feb 2026 17:45:30 +0100 (CET)
Date: Fri, 20 Feb 2026 17:45:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Abdulla Nasirli <nasirabd@fit.cvut.cz>
Subject: Re: [PATCHv2] nvmet: lift blocksize restriction to 64k
Message-ID: <20260220164530.GB15907@lst.de>
References: <20260220151259.20372-1-hare@kernel.org> <20260220153237.GB14359@lst.de> <8d50557c-86a8-4364-b5e7-d40b36ad9f60@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d50557c-86a8-4364-b5e7-d40b36ad9f60@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_084534_718935_F20C24A7 
X-CRM114-Status: GOOD (  14.35  )
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

On Fri, Feb 20, 2026 at 05:42:25PM +0100, Hannes Reinecke wrote:
> On 2/20/26 16:32, Christoph Hellwig wrote:
>> On Fri, Feb 20, 2026 at 04:12:59PM +0100, Hannes Reinecke wrote:
>>> With commit 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
>>> we can now support up to 64k block sizes, so lift the restriction on 4k for
>>> file-backed namespaces.
>>
>> Still not sure this is a great idea by default.  Yes, modern Linux supports
>> 64k sector sizes, but even then just for a few file systems.  And this
>> changes existing setups, which will now break when upgrading the kernel.
>>
> How so? There cannot be any existing nvmet setup with an LBS backing 
> device, as the device will be rejected when trying to setup the target.
> Which breakage do you see here?

There can be a setup with a large i_blkbits that we limit to 4k
export LBA size right now, and with your patch it will be exposed
as something larger.


