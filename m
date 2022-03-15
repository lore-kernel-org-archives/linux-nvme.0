Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2MaRY3FhQHvwy+duMTt4bpFbWvl+JrvIe5naHSiNFjo=; b=hC9IzqE4bCqOvKXrCKa5Vf4BEl
	bQY+AdeTV36Q6MaB29PIzSBO6tk28ONrqovKF4jzGAnZBuEr22/CYOJyBCUGzCq4ZTDIVbOfCcH7N
	K0MXPgnJUFCuSjsV7GzQbLoFKCMb7iA3qaTfwG+8WnKEyqHm0S2IlfTKWUnWMWen8HChsqCN/VFyl
	2W51nXGeF2k49Lrn2fkDYV25MYlnZDG+8NmgNvu5Q5NYpRVgrYDnKMDMFjyB6U+ZOreqoXJhnDHP0
	EEj8ndmcZZwkaejOibV8CjPW+rQjSQJsi584xmlUs5Hr/pQ6DKIVa0/X+j5rPDvYY9qWy5Ic2H2UX
	x+ec94IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2or-008LNc-AO; Tue, 15 Mar 2022 08:46:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2oo-008LLx-3y
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:46:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5183D68AA6; Tue, 15 Mar 2022 09:46:11 +0100 (CET)
Date: Tue, 15 Mar 2022 09:46:11 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "hch@lst.de" <hch@lst.de>, Sungup Moon <sungup.moon@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Message-ID: <20220315084611.GA3961@lst.de>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
 <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014614_357049_9F44807D 
X-CRM114-Status: GOOD (  11.37  )
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

On Tue, Mar 15, 2022 at 10:42:56AM +0200, Sagi Grimberg wrote:
>>>> +	 * We also do this for private namespaces as the namespace sharing flag
>>>> +	 * could change after a rescan.
>>>
>>> What happens in this case? we now have non-unique shared namespaces?
>>
>> The non-uniqueue NSIDs can only happen for private namespaces.
>
> But what happens if this changes upon a rescan as you commented?

Well, it can't change to shared as the nsids are non-unique.  If we
want to be paranoid we could add a sanity check for that, but then
again there are a bunch of other things where we could be more paranoid.

