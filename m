Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D39C98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsCIkli++gFDBegtwdL1LQ8y/V8RXq5VkCQBlMaxTeI=; b=RgVvdfzCOPpmmoP9l/yeIw/wex
	KcONBKbatBGjMqvWbMu6TET344rUbTne5JHsQbWWibMbguB/E5dg9MDoaYjS7i8cp5kUmQ8Ocy0DX
	zZrGJZ+L3JwQIqr92jVxUtkwtb4Xro2UZ6kpbth6u2z1stunnH6pypp8Cki88jl4QHU82tb3OWvG7
	m77/V89qNbmS0YpnzPdTQIlroP+iOX/sDLapFPFRxcKMyZC4IVyGTlaOx44lB1O/rj6DqLnDENX24
	z3APtg8weRI7VP3iEoEMaveAgGr5JfojspH6HTxAXwqLQGARM2yag0iZLELLalTUCRciB9xNwE1Hj
	fyLerCYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9F1v-000000078SR-0akT;
	Wed, 23 Sep 2026 04:56:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ExW-000000078Iq-11cl
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Sep 2026 04:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KsCIkli++gFDBegtwdL1LQ8y/V8RXq5VkCQBlMaxTeI=; b=MdnZSGtuftX8Cs7E15SiPje+Ng
	B490QYkHEI2S1kc4q3kleMtRqmcF21Yiq2rAh1zTfS5WCvtiCh8c/siUmjC+2AYoX5feewcZRw+VM
	s6EPV2hwE2TKJjPyIxx4cWy3S5oLFwG/EsRwUKTJ6BrUSvP4l32qM7/yrrabj3507uNsBIzgQezeI
	pa/DATOuhuJ+E/FIq/KTqYvmwG5VF5yPeyJqeqSbKkqf0+aEJyue6xQLUatEhVIl0dTfY7DkRuKPe
	m+sj+MSO9J/tPFnvkE+L1CtLviULJIhjIiMgG7RMc/1REV7Dwl2mmCt8o/1XEiGQnfEoL9yy7pVXG
	wFwnqIuA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9ExR-0000000ELkS-3Cou
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 04:51:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B01F68BFE; Wed, 23 Sep 2026 06:51:44 +0200 (CEST)
Date: Wed, 23 Sep 2026 06:51:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
Message-ID: <20260923045143.GA26231@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com> <20260922131610.GA30468@lst.de> <cce62c72-278a-44d1-9cf7-e0beb0b72688@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce62c72-278a-44d1-9cf7-e0beb0b72688@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_055150_835184_E054D412 
X-CRM114-Status: GOOD (  16.69  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 21:56:25 -0700
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

On Tue, Sep 22, 2026 at 02:54:25PM +0100, Pavel Begunkov wrote:
>>
>> Can you please expland on the splitting considerations a bit?  Preferably
>> both in a comment for the details, and in the commit log for how we
>> arrived at them and why they are fine for now?
>
> I'll add something to the commit log, but not sure which specific
> details in comments you mean. Do you want me to expand the comment
> above limiting the number of segments? Maybe I should add there that
> it's stricter than necessary and might cause more splitting than
> necessary? This one:

Yes, explain why we apply a relatively arbitrary limit not fully
exploiting the hardware capabilities, and why we thing that is okay.


