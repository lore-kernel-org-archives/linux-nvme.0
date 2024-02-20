Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E7C48BC4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 06:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VD2f3ZBDoRPeSmVFOg7Jqi6oPwh+0fQd471Gme7Rki8=; b=HiKaLRvVPInoDe3dBnXrNnDawH
	/RPmzyT1uzyDRDbMOnsOSYQ7EOPmdtvw29C6abh4iQzUCdT9ZihB3VyID0XheGRR6DI4SuFBGyzrV
	viOKDwLlWpnIHDHqT+C2EZyQdCHGoQLea5VjWeUqYu4eQvMb36mHJ5T56IpEkeu20cjQKW7ewbpzC
	JE5CGZysstE9onL3Vm8gBImFm6WgfGBjyw3MQttK7KnD91kC/64jZePziPS+gLxdhd9MYhN7rsL++
	9JEEWu9xwUQQZgRh3dvVS76MxrUUYVDKOBON/gj9uoNSih+A+aksHGky2S5cWYlgJoDrNjN3DhmSy
	rcXEXZiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcK2o-0000000DQwJ-1lyS;
	Tue, 20 Feb 2024 06:55:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcK2m-0000000DQvk-0GQT
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 06:55:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5332168AFE; Tue, 20 Feb 2024 07:55:53 +0100 (CET)
Date: Tue, 20 Feb 2024 07:55:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v4 10/11] nvme: Atomic write support
Message-ID: <20240220065553.GB9289@lst.de>
References: <20240219130109.341523-1-john.g.garry@oracle.com> <20240219130109.341523-11-john.g.garry@oracle.com> <ZdOqKr6Js_nlobh5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdOqKr6Js_nlobh5@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_225556_264899_9799399C 
X-CRM114-Status: GOOD (  10.47  )
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

On Mon, Feb 19, 2024 at 12:21:14PM -0700, Keith Busch wrote:
> Maybe patch 11 should be folded into this one. No bigged, the series as
> a whole looks good.

I did suggest just that last round already..

