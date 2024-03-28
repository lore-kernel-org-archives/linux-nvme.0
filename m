Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FEAC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Q7NOmFzaXQohDrjkFZ/CDKx1TmzJFEEukLoJJmS67Y=; b=me87zhcSU1ZS3VdK3ESnfZoVzd
	B25ps9cVHKNqd4k7WhNaIKG7P5M0ipVfAzy5TsuhmshWdFJx96Js6YJ+EoxkiUeTtSPKhWb3d8vjz
	xsGD6cE6dswZ4+FqZDd4GLljgb7v4um5H3hMvV1y3VmYKLNy68N/uuL6la/3J6DZ+sEoIgguPPQZd
	wKh/LHjq7Fk4DE49Fqo/xSnkKPFZ0kQjC+vlj8KZKnwMs9HkmCAP9WrcwGCrCDM4jXytJNNWIvRyV
	2+ZUWhsLEaCZCMobPtln+ibZVMuzVaD7ApBGdnWp3uJacrzbgZfxJiqQthjKasSPpezFaUcIMOKzJ
	8DQUi5bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjeI-0000000Cm0e-3uRe;
	Thu, 28 Mar 2024 06:54:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjeG-0000000Clzo-3YWr
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:54:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C93CA60DCD;
	Thu, 28 Mar 2024 06:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF19C433C7;
	Thu, 28 Mar 2024 06:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608842;
	bh=QD8flYEO8Q6NBPd8BtzH+Rj81pW2lJaMX765KevEl5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6kQ4YCZs/fyfH2pBg7q3ydUlAxyF+3x09RDNHUgYPzgMlJgyCe5MC0OCaXZjy03q
	 fUMyRUUFOpKncSMB2igTgYU6B0HDJ92FsD4DvO4JwII3WpTq7C8FmP9/Ra7+SQFbKb
	 pNWJCpmTZPaZeqyCdjCLGlAlVQAc06guQu5/o0NZTr6EZcJGzJzl+m3Dh8jrQqqys3
	 r96xl2xg+6CGA2/3JTw7oqAalKw99W09g+gwHP5m9ZcjL594knWVBu15NbGw3e7I7r
	 pprxQkZbZMIYKTuEoOgtetKe6hi0yLqWKfXlFeh90wx7loX1/DreGXFK+B/xs0JSF0
	 3ZLMwZzWwdmMg==
Message-ID: <7587193d-f4a3-4a2c-97d9-e5ea8e9fdd0e@kernel.org>
Date: Thu, 28 Mar 2024 15:53:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328043016.GA13701@lst.de>
 <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
 <20240328054652.GA16237@lst.de>
 <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
 <20240328060357.GA16819@lst.de>
 <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org>
 <20240328062237.GA17225@lst.de>
 <0d54c569-f586-4b75-a8a3-509e3f3717e2@kernel.org>
 <20240328063816.GA17642@lst.de>
 <b144a7f1-af29-4c0d-96f7-c0f16b2299b8@kernel.org>
 <20240328065256.GB17890@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328065256.GB17890@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_235404_972461_48AD901F 
X-CRM114-Status: GOOD (  11.21  )
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

On 3/28/24 15:52, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 03:51:09PM +0900, Damien Le Moal wrote:
>> I am all for not micro-optimizing the free path right now.
>> I am not so sure about the mempool being simpler... And I do see some
>> improvements in perf for SMR HDDs with the free list. Could be noise though but
>> it feels a little more solid perf-wise. I have not seen any benefit for faster
>> devices with the free list though...
>>
>> If you prefer the mempool, I can go back to using it though, not a big deal.
> 
> A capped free list + dynamic allocation beyond it is exactly what the
> mempool is, so reimplementing seems a bit silly.

OK. Putting it back then.

-- 
Damien Le Moal
Western Digital Research


