Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556A4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMDcL1Sj3ecZF/PHO33RMl8MajLs+NitzTG2owdTZQA=; b=rmTRZccA5KYG6o8UEWVBs0/Sfx
	4U19adIUyCShlws70Rh0PmPFSh7BpPjeQpezvX/asvj1QKu0P6pM+x1+UNlBTB2KgeyAik9LtMtWH
	VSuAI0JVrSO1R64k79Niotc2hAVJ5H4o6MVSrc2pyLTw8EczJRNylFWZPgtRm6RtTi5AUHyoTHfvA
	ALjXGI8knjwIWvKcX1tKlMrDhlKpD+n2bODgHIqEhc44q6xfrUhDuQcsmjgsDQaXr78Zo+SnxDQY9
	26Qgstgf9D/ZGREzNFFbbuw4ftHqu/sLWeHWeeiGXuFI836FjR6d/22UGOwB0SM5VowWZGy9pZ9q6
	37Fi1j1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqzEI-00EiSA-Ki; Tue, 17 May 2022 15:35:22 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqzEB-00EiFK-L0
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 15:35:20 +0000
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net
 [108.7.220.252]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24HFYsQ9026768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 11:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1652801701; bh=vMDcL1Sj3ecZF/PHO33RMl8MajLs+NitzTG2owdTZQA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QWWYv+c38E0Js5EJ5O4LH7stm0/N/0G+zlZGaxwbAbrJcoBFiFX+I8aMjlxDXtdcH
 HpQFgO3vNojUXJc8f+tn6qApIq1oq89uILHK6aqbgkyPptilbkipvXh8b+UDCORwcJ
 NTcZRZaecteMkr4C9FEtPqcOV8/1Z/mJK25oUPZYeYBBp6sBYjgpZEf9xgcokZgDBW
 jWBIxHO+AVv5V5gBQlM1SENquz5Y+sM7mT5fnlB7PvD9DdOkb+WioPJCoeulEVoACn
 ngUKDte0snQOFU95pMNMLZkRMx8s9GtBCC6kwv6i26eYPhX3g2IKwzeEwICOgNvimy
 LqJbC9V4JwF5A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 8636C15C3EC0; Tue, 17 May 2022 11:34:54 -0400 (EDT)
Date: Tue, 17 May 2022 11:34:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, pankydev8@gmail.com,
 gost.dev@samsung.com, damien.lemoal@opensource.wdc.com,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <YoPAnj9ufkt5nh1G@mit.edu>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517081048.GA13947@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_083515_973970_C2353102 
X-CRM114-Status: GOOD (  11.41  )
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

On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> I'm a little surprised about all this activity.
> 
> I though the conclusion at LSF/MM was that for Linux itself there
> is very little benefit in supporting this scheme.  It will massively
> fragment the supported based of devices and applications, while only
> having the benefit of supporting some Samsung legacy devices.

FWIW,

That wasn't my impression from that LSF/MM session, but once the
videos become available, folks can decide for themselves.

       	      		       	   	  - Ted

