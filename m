Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBB6CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gs1YDxQOs1/Jv+Rm3Tfht7T6bHIW93ex5vfitXcPBJU=; b=d9LhsHd+tLzGqFhipuDmYdYy1z
	bXLDiffu/Zaeoxro9rU/lNJbO/un6fVLM3hL52BbVQ+Ki/HjXeBg+umvHreBy2jAmDvik3enu/ZMr
	xi0Kv4Xd0n22MrAmLp6183e6NvaqBMbr34UeHu1U+boxpNmPjdKolsBQEzopGnWfU0uGNS2nVVoNz
	0Vn+di/u1KjmbRS4A2eekv5s8eRUrodLcTGq1PVg0ZWrrQHQUc/f6ruwSYbcXKu+/X28u0BD3/Zft
	zHjJOVE97wKbl0DZ/9ZJ6K05rtczsF2CJYJS5YwHOxc45xiaaEA4K7pA+XldYHvgljMppFQec7E00
	Dy+pP+uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKpj-0000000CbN7-0bFP;
	Tue, 02 Jun 2026 08:50:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKph-0000000CbMm-0CE6
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 08:50:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DED74434A;
	Tue,  2 Jun 2026 08:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C91F00893;
	Tue,  2 Jun 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390244;
	bh=gs1YDxQOs1/Jv+Rm3Tfht7T6bHIW93ex5vfitXcPBJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajNcqyeduhLNBBjc1kNn7nqKrnT+ceffr01bUkCPXfrEZTnjFhs6JRv7ipjntw7XA
	 tc8XoAhzqZfkj2KkyEW4uZPDqchmV3kr1531burJPNB+Tl9N+DbXHBrp0h9MY2YcEU
	 OnmuPrsNkf/bZHIwyWoYDXXlVzpPErSgjKDfn8G4JNp9dwC3I9DYKJILA+Ja/UI/lZ
	 q8XbrVVhcjCduJoD5CZjmt1zpAPy6MNY7UNuqgAfHuG8UdQz/aN7GQk1DfZD+LtoI1
	 c9O6XuwAYnT3P15qiEezFUicXj4hzMHbM4ALnPQrVxIXj5wvFv57kO9FF3DKJ4xXgT
	 TWxsVtVFTw38Q==
Date: Tue, 2 Jun 2026 09:50:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <ah6ZXmX1anVLrr76@kbusch-mbp>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_015045_124720_0AC2EEC9 
X-CRM114-Status: GOOD (  13.86  )
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

On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
>   @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
>                     __func__, ctrl->cntlid, req->sq->qid,
>                     data->hl, data->cvalid, dhvlen);
> 
>   +        /* Confirm the transferred length actually contains the
>   +         * rval payload the message body advertises. The host
>   +         * response is hl bytes; with cvalid set, hl more bytes
>   +         * of challenge follow; with dhvlen set, dhvlen more
>   +         * bytes of DH value follow.
>   +         */
>   +        if (tl < sizeof(*data) + data->hl +
>   +                 (data->cvalid ? data->hl : 0) + dhvlen)
>   +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   +

I think the fix should change the ternary condition from data->cvalid to
(data->cvalid || dhvlen):

  if (tl < sizeof(*data) + data->hl +
           ((data->cvalid || dhvlen) ? data->hl : 0) + dhvlen)
          return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

But this is a bit of an eye-sore, so let's make this easier to read by
lifting the ternary computation outside the 'if' section and store the
result in a temporary variable.

