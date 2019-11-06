Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F092C5DF60
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 01:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06D21A49
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 01:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n19f0emj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06D21A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sCsJ/8jjJ4fRhhZgpUezUj8cYFYmJQ+r9B3pAXnPi2c=; b=n19f0emjkJD/yh
	vmW8C9kHXTrR1UMcj6dWbkC31DWiJ0pvnbp4dMV4cgQR1dJ3hRndOCzfVyO4e9Pbb95UUHlskrCAk
	xSf2OtQGeDcfg9nnd1GcgBTL9v/zj4Jwh3frY3jv3gUuxEAmltaX7djY4bCoNlGVUXZYqoKuVa/31
	mqPflxcFQ5YPCGJx0zCLzOHASZiyp3PoDfceFz3kbhFmG6KqIOsXGJbCp6QDogkSRQQ22E5jbZg1d
	FwLpyrn4Y8Cby73Ltr84OheKH0/8UnMHmYcXanh4MGraih5D4LpqGwApBOMivKo/G6j/O9+SdLsIq
	VOPwErk94GcJNTmMMCSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS9pa-0003do-Ne; Wed, 06 Nov 2019 01:09:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS9pX-0003cP-H8
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 01:09:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 26E0F68AFE; Wed,  6 Nov 2019 02:09:41 +0100 (CET)
Date: Wed, 6 Nov 2019 02:09:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Message-ID: <20191106010940.GA3474@lst.de>
References: <20191105061510.22233-1-csm10495@gmail.com>
 <442718702.90376810.1572939552776.JavaMail.zimbra@kalray.eu>
 <20191105153144.GA12437@lst.de> <20191106000836.GH4787@sasha-vm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191106000836.GH4787@sasha-vm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_170951_723536_C37682F0 
X-CRM114-Status: GOOD (  10.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Marta Rybczynska <mrybczyn@kalray.eu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Charles Machalow <csm10495@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, axboe <axboe@fb.com>,
 stable@vger.kernel.org, kbusch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 07:08:36PM -0500, Sasha Levin wrote:
> On Tue, Nov 05, 2019 at 04:31:44PM +0100, Christoph Hellwig wrote:
>> On Tue, Nov 05, 2019 at 08:39:12AM +0100, Marta Rybczynska wrote:
>>> Looks good to me. However, please note that the new ioctl made it already to 5.3.8.
>>
>> It wasn't in 5.3, but it seems like you are right and it somehow got
>> picked for the stable releases.
>>
>> Sasha, can you please revert 76d609da9ed1cc0dc780e2b539d7b827ce28f182
>> in 5.3-stable ASAP and make sure crap like backporting new ABIs that
>> haven't seen a release yet is never ever going to happen again?
>
> Sure, I'll revert it. I guess I wasn't expecting to see something like
> this in a -rc release. How did it make it into one if it's not a fix?

76d609da9ed1cc0dc780e2b539d7b827ce28f182 is a backport of
65e68edce0db433aa0c2b26d7dc14fbbbeb89fbb, which went into 5.4-rc2 and
was not marked for stable.  It might kinda bend the normal merge
window rules a little, but I don't see how it could be considered
something to backport.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
