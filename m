Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB0FC71159
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dn6f1nlScMt+oKC5LL8tB827ck6ifqwMce2B8rIL5J4=; b=sCBRVY8hkUsMpn
	ylYeUS/PzgiQ0FstZ4vI16NFW/sB0MkKXqdGcQ7g1SG6KD+8szDl0yCEzc3ZDDDneHP9hqSfEyUWF
	n5fkZzyqy+/cVq0NOdU3cpeNSEbO1EuqC6Vstwl7yIjdi3rqaV44RBfv/bExd7qRbPe7u8uto3IkM
	cUwiXPxGqnNdPzZ1xf0Xhli6q7vTinRfE99arjQBeWHWs8pgiRXtbRQXRVbw3+/WwR91FFegoCGwo
	otmabRyL/lmBxdqqPQKp/xU7rFJ2pOsc3PMXKb9zN9/QtWPZGd5ONHEz26JwLY1W0sajoJgiq+KHX
	u8DxkXDof+T6Qs8hjaxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBic-00000004p03-3fny;
	Mon, 16 Jun 2025 15:25:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR95w-00000004OJ1-1bBE
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 12:37:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3EDA95C5F53;
	Mon, 16 Jun 2025 12:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B86CC4CEEA;
	Mon, 16 Jun 2025 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077467;
	bh=X54pGA1PNRxdHTHaDj+xP5TwzrUJrhRYjQi48QEarW4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YYkGNiebf3E1gWCLa0EQzuguystPkqMpnRZ0617+6DwsUY1QYlUNPkTTlrhEIk6Dy
	 MaA9s1o0APVglEt9eq4jz+M22Z6lECOfZvq3m+/mFG3HiXUiKAoagAmUQH29bvBM1D
	 zI8m4KXoi5nV79exxe/yaM6kaxxrg0wzDDml2vFMMH6anZqaDqVVxkFfG69cYeBvOl
	 07xbV/dZwrNgs/Q4ZP+OzbqHczibwr+KzATxxUA/3uweKvEoWLZAsu9TruHEvDFfmW
	 OyzUYDKdPndmOmKjSrprQ6qGIS6F+oiMV+Pb4tF0d6VDEA65253OSR19rrlIJ20OdN
	 d+5TKCbjg6DyA==
Message-ID: <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
Date: Mon, 16 Jun 2025 14:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
 <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
 <20250616050247.GA860@lst.de>
 <2105172c-5540-40d0-9573-15001b745648@kernel.org>
 <20250616113141.GA21749@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616113141.GA21749@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_053748_462164_AA52C4E6 
X-CRM114-Status: GOOD (  12.87  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 16/06/2025 13.31, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 08:43:22AM +0200, Daniel Gomez wrote:
>>>> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
>>>> and status is BLK_STS_INVAL.
>>>
>>> I went over you comment a few times and still don't understand it.
>>
>> The way I read the comment is that status is only valid when
>> blk_rq_dma_map_iter_* returns false.
> 
> Yes.
> 
>> But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
>> default switch case).
> 
> The status field is valid.  Your patch below leaves it uninitialized
> instead, which leaves me even more confused than the previous comment.
> 

status is initialized at line 160 after memset():

	iter->status = BLK_STS_OK;

So, what the patch does is (for blk_rq_dma_map_iter_start()):

1. Initialize status to valid (line 160)

	iter->status = BLK_STS_OK;
	
2. In the if/switch case default case (line 181-183):
	It sets the status to invalid and *iter_start() returns false:
	
		default:
			iter->status = BLK_STS_INVAL;
			return false;


Removing the invalid assignment "makes it" valid (because of the initialization)
and also matches with the blk_dma_iter data struct comment (lines 13-14 in
blk-mq-dma.h):

	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
	blk_status_t			status;

