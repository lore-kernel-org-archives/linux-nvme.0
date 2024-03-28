Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED9FC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72RNy9RVbySOmuoSnJCaRbr4WtO837H325AdzawF+9U=; b=sbPWmruPPmfMadrZO+X5KPxqG7
	qyRLhJWKJ4peBh8XQyPx09ZeDDCOrLfc7O86qIRd/e/2WhAb+HEVNHv49K6glusOjZodBFj3tWaAP
	azZJMMndXJRYPQAReTCHQAE6YEXfkFXtEWtpXm2HxUUhXxSlWewuE4EqgVIsABNqvvuWshCOZxTPm
	tj0brwloKvKv8kgJ38VrASpTsCvtJnboOW2l7CrZ1+WZVBOCsITc5e4oiEdg9NEnfI6HbVG8apES8
	jgmgR3nRBQ98xrfFEpMqceJmqUfBke18fpDK3Ene/nADm0jPqKiHxT4H3nNHVMiYL4Cav8jOFCn3d
	g7QaTJVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiqr-0000000CdvL-0yOr;
	Thu, 28 Mar 2024 06:03:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiqo-0000000Cdux-1vf2
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:03:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 44CC460DCD;
	Thu, 28 Mar 2024 06:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8232AC433F1;
	Thu, 28 Mar 2024 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711605776;
	bh=xf7kJzpeIm6RcIL/MDwpH6pOPcv0ZcyQXGWenvh9/gQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EzCaLu8Lf2JkTeziR6DDJy0IexFP5KRtpIE1EZbBCPbqHXE3sAaq9JTh++pc+CGF7
	 dB8zL8+s6h/sM1j5U1u5hZ+X723x/gax8GBAbZ3zKevsoqobe8imoNef97yIh5Xlti
	 oLPMy4TJl9DpCdK959syCd9RsBhFRhy7s1DKBo6CBzFFY0mtXTF2QSWHjPJOH5yDzu
	 SwL4GdZc+oj2AjweuFTaGEVpjRH5wIyFUMdWL/F0LXPgXuB2t55+77XEeEhvlfph4Q
	 TED88fWEHIly4kme/2VmXT1WctvbmmUHodo5KmExtObyw1Mx7n8jB9R5xrLfzFKEHN
	 +TSptpRMkbyoA==
Message-ID: <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
Date: Thu, 28 Mar 2024 15:02:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de>
 <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
 <20240328054652.GA16237@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328054652.GA16237@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_230258_590897_33D7A0E7 
X-CRM114-Status: GOOD (  16.88  )
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

On 3/28/24 14:46, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 02:28:40PM +0900, Damien Le Moal wrote:
>> That was my thinking initially as well, which is why I did not have the
>> grace period. However, getting a reference on a plug is a not done under
>> disk->zone_wplugs_lock and is thus racy, albeit with a super tiny time
>> window: the hash table lookup may "see" a plug that has already been
>> removed and has a refcount dropped to 0 already. The use of
>> atomic_inc_not_zero() prevents us from trying to keep using that stale
>> plug, but we *are* referencing it. So without the grace period, I think
>> there is a risk (again, super tiny window) that we start reusing the
>> plug, or kfree it while atomic_inc_not_zero() is executing...
>> I am overthinking this ?
> 
> Well.  All the lookups fail (or should fail) when BLK_ZONE_WPLUG_UNHASHED
> is set, probably even before even trying to grab a reference.  So all> the lookups for a zone that is beeing torn down will fail.  Now once
> the actual final reference is dropped, we'll now need to clear
> BLK_ZONE_WPLUG_UNHASHED and lookup can happe again.  We'd have a race
> window there, but I guess we can plug it by checking for the right
> zone number?  If we it while it already got reduce that'll still fail
> the lookup.

But that is the problem: "checking the zone number again" means referencing the
plug struct again from the lookup context while the last ref drop context is
freeing the plug. That race can be lost by the lookup context and lead to
referencing freed memory. So your solution would be OK for pre-allocated plugs
only. For kmalloc-ed() plugs, we still need the rcu grace period for free. So we
can only optimize for the pre-allocated plugs...

-- 
Damien Le Moal
Western Digital Research


