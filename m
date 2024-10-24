Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E21D0E3F7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wmAT2VEA9hKeS2nIDOa4PVrvlp/nX5Z3THP9pXorsYo=; b=hCcJMJsVMzxKrSzZZJMEOac2Dc
	Xlwgp0MUN9ayXFZ38rBgyErUnA9Fi+zUtP2vJ6ANpOEkpW8Wg4daPlLzuE4MilPu7WgnthAFGT7ZH
	Bbz5ZdYE9AFTeBEKsxEtEHyUwO6YUGfbISzoFc15A5djIuaaCWGUgbMuPgSBlbCHemNIJFwqjiwzP
	3GuLdaEz50pthKFXdbrCHG1YZUU73llmk9hzX0VQ6dKT/AvhffbQ5Unt3/RZ2y4Fk6LcRpVqM4I4x
	8zI56uFz5UiHjVkvIGS8JxzuzQDjBKOaLlfr9f5yXnDv78yCQkhgu4LhY4dZ4S7CUujCK/ZxPvghB
	6U37/t2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t442x-00000001gTb-0O5E;
	Thu, 24 Oct 2024 20:03:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t43lZ-00000001dAJ-3k6U
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 19:45:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C02675C5DD7;
	Thu, 24 Oct 2024 19:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73751C4CEC7;
	Thu, 24 Oct 2024 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729799105;
	bh=c3ndfUOsrrS7srSLbBC5XHM8epxlV6CY0XRm3bJUdrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMm7iwRB0IZhUym/BkBFYexGqZs5nJlZjVp6oVWt2Y+QKne9rEfQ8OP5uGohgohK5
	 OiLmtiC6Qcki98RPMySRRWlpwcdMEmFLZ+/OQp8MaYl4f3oON41x5L0VpNeY3PMrYg
	 ANIwH36Hdj6UkfYudeAL5AwSm4C01OH3kIlZD7LXJHXDrRglTNUiU6c0MYQsvr8c5o
	 W2CrIRTSUcfVjtU7jyIVcfJkDZ2qCYFfmze8hT/onGmRyUslacLh8u42UKGSt+E5bD
	 0isyu0ZkRtRKyd+IBnN5hp7ulV05UaHP1cOFz4f9nlbiQDrqwRGML40hlhUkWhtRjG
	 zNWDjrPygqmnw==
Date: Thu, 24 Oct 2024 13:45:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCHv8 2/6] block: use generic u16 for write hints
Message-ID: <Zxqjvu0w9OsJN2uB@kbusch-mbp.dhcp.thefacebook.com>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-3-kbusch@meta.com>
 <20241018054643.GA20262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054643.GA20262@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_124506_047503_46567814 
X-CRM114-Status: GOOD (  22.48  )
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

On Fri, Oct 18, 2024 at 07:46:44AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 09:09:33AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This is still backwards compatible with lifetime hints. It just doesn't
> > constrain the hints to that definition.
> 
> So in the end we'll end up with two uses of it - the existing 5
> temperature hints and the new stream separation.  I think it
> would be cleaner to make it a union, but I don't care that
> strongly.
> 
> But we probably want a way to distinguish which one is supported.
> 
> E.g. for SCSI we set a net BLK_FEAT_WRITE_HINTS, for NVMe we'll set
> BLK_FEAT_STREAM_SEPARATION.
> 
> Either way this should probably be the first patch in the series.

I'm not sure I follow this feedback. The SCSI feature is defined as a
lifetime stream association in SBC-5. So it's still a stream for SCSI,
but you want to call it "WRITE_HINT", which is not a term used in the
SCSI spec for this feature. But, you want to call it STREAM_SEPARATION
for NVMe only, even though the FDP spec doesn't use that term? What's
wrong with just calling it a generic hint support feature?

I also don't see why SCSI couldn't use per-io hints just like this
enables for NVMe. The spec doesn't limit SCSI to just 5 streams, so this
provides a way to access them all through the raw block device.

