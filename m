Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B0BC83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eD0dMxtq3zdgvUtswNZo9PdrXzooqbvcShS9Gnl619M=; b=KhvIOUW933O7LSm+4w5RmjKAjJ
	vBpF1RgHTkL2TslOTSbYH98TEvTHO6udZ3bGby53I37gqGbI/lqF66nTBScaLiQHnPKaBgsFCvsjg
	SntiXCY3f8o5fdwstdWaos253R8eQMjHahLgCegJ03QWcTeouUwBMbBOfK5OWhd2U2/VZ1tbbsYyU
	CrJVevkMcs/p4DCXPhm0Z2zvZxusmafL1HUe7ca1XQkNj5DAX5163VsUeXJG09SqohmKKV/vUQnrP
	Et6gBaiuyZWFziLxKdnH23QB9RWaFm/vlW3hV+vyFyaByV2RBWFKK0Dmg2tZ+qkXbIVaGvppcwPPM
	MDpWoubg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJLB-00000002Jnf-1LNe;
	Mon, 14 Jul 2025 13:35:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJGB-00000002IlN-3Fa8
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:30:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A1C8227A88; Mon, 14 Jul 2025 15:30:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:30:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714133014.GA10090@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132407.GC41071@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_063023_955332_75805FC1 
X-CRM114-Status: GOOD (  14.30  )
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

On Mon, Jul 14, 2025 at 09:24:07AM -0400, Theodore Ts'o wrote:
> > Is is just me, or would it be a good idea to require an explicit
> > opt-in to user hardware atomics?
> 
> How common do we think broken atomics implementations; is this
> something that we could solve using a blacklist of broken devices?

I don't know.  But cheap consumer SSDs can basically exhibit any
brokenness you can imagine.  And claiming to support atomics basically
just means filling out a single field in identify with a non-zero
value.  So my hopes of only seeing it in a few devices is low,
moreover we will only notice it was broken when people lost data.


