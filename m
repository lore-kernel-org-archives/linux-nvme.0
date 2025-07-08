Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F59C83F09
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsEgXqZShUxY417/o46Vu7TSPvOurD8gSW0nrnSnH9g=; b=T/IKc5j6I0WIRX+3HbP7lbUF9F
	Kkwd1mGAkWAKrzc9JIkalBzcgocyT26YpeV9E79j2c4UL7c/DGAue9QXb8yJ6O638gzWxyK8G6msL
	SAnvviUts4sPmigUkWHda30Vm0qeufdJTQuHyP5FthJFsudf18cteBP6s/nOTM4cEDgOPoEO6rFkx
	EoOv3nSoc/eJz477P7znZzq/IcUU3ZV58ujuIS1i0RfUJpHLI81tWoG8lrqBvXV2FFhuIDZDSQEL5
	lT/ZIrFgFU2spon5Trf9TikBjuFahh+EhjmT6gAECLRqO5niKO3LJyS8W/etLIViAKoRSzbMXkao4
	nnnKor/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZAQ0-00000005q8r-26Uj;
	Tue, 08 Jul 2025 15:39:40 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZA6a-00000005lXT-0AS1
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 15:19:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E11C2A5389D;
	Tue,  8 Jul 2025 15:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E232C4CEED;
	Tue,  8 Jul 2025 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987974;
	bh=8DQsrgvQi7kSBbdxmjyQivePr825j0lx1nkfT/q8/a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9CnsbrPXZqNEd7AFivWGneCYJczJJ3d484wQkrWGdji8N4Mr8v3pB7dIMLgBIpGK
	 yDh7QtVsY2VwqESKRjjNShxxVXZFThupqg1xPCGcpT4MZ6zUKh4NhyjHvFer+oBqVY
	 fjGkBqTxONx340cZz6/mYwOeWtTzugzBNdLzKckAxZ9dlqhKgZukSeOBETFrX1xXHX
	 mhAIaadtdxKIlEcFKGH8kbxb736KrwjrzZ4pcKJV/JmWy3tSzoUXxfAgcSVhGM8h5f
	 wj0QFPS/JwSHsuinoKZXFBO5fY6nZ3hE9jzJcPXGnuI4hc7StPEGvIZRSx2ISjQqiR
	 9TeZRlZyhImEA==
Date: Tue, 8 Jul 2025 09:19:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aG03BKRk7O5JfVtN@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGvYnMciN_IZC65Z@kbusch-mbp>
 <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
 <aGvuRS8VmC0JXAR3@kbusch-mbp>
 <20250708094748.GB27634@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708094748.GB27634@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_081936_142201_5F6AE2E9 
X-CRM114-Status: GOOD (  21.65  )
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

On Tue, Jul 08, 2025 at 11:47:48AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 07, 2025 at 09:56:53AM -0600, Keith Busch wrote:
> > Just to throw AWUPF a lifeline for legecy devices, we could potentially
> > make sense of the value if Identify Controller says:
> > 
> >   1. CMIC == 0; and
> >   2. OACS.NMS == 0; and
> 
> What is NMS meant to say?  namespace management support?

Right, namespace management support. The spec calls this field 'NMS' now.
 
> >   3.
> >     a. FNA.FNS == 1; or
> >     b. NN == 1
> > 
> > And if those conditions are true, then the controller and namespace
> > scopes resolve to a single namespace format, so the values should be one
> > in the same. The only way it could change, then, is a format command,
> > which means there couldn't be an in-use filesystem depending on it not
> > changing.
> 
> We could.  But are there many controllers where that would be the
> case and where people want to use atomics?

Maybe not. I still have a lot of 1.0 compliant devices where this might
apply, but I don't have a use case explicitly needing the atomic write
features anyway, so it doesn't matter to me if the driver doesn't report
the limits for them.

So I guess no need to work with such devices at this point, but maybe
just something to consider in the unlikely event someone complains.

