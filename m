Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5373C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=px1GjypAxb9tOBfQKwseTGXFesp6HilyedUgvQsI2KA=; b=hVyPOoOnzHhrrLuT4n5YVQvx63
	bfPoY7YjBhXT3KC0Pt+zBNY1d+XW9LKX2PNVlcbnnslg/4IHrrqqAr0h6mj5cHd2wgflm/zLWlhIt
	3YkQqpx7suiEkQe6GK7BfCM+T2P9Gurd8b2yMvv4LBYfgnyBtFyrghQd1s4lpdczeDzyDPn/f1ila
	9ohwJQKXIt6BoHxbzgNDprlDvjaJxJtETZcrUGSLoEvq1phc3ydEQwab0zXDdkyZDjUaDo0gjv++z
	o0subIfO4N1Ri6hzrZPB5q5e4aS53SC4etC8LaT/6RokUuC/payjtQYCS1wC/BYrzy0oUKdju48Ie
	gAUPxoBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1E1t-00BNoh-VT; Tue, 14 Jun 2022 21:24:53 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1E1j-00BNjE-5G
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 21:24:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DDCEAB818C8;
	Tue, 14 Jun 2022 21:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC62C3411F;
	Tue, 14 Jun 2022 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655241877;
	bh=+RQt2hOB9p4fUSoPh40Dqnoes2869OaWZvlo4exv6xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nfej7XUtOHMw+HnL1NzLJn6B2Nn0wHFAIuXqxQ/+ARRKo2U7dskcFH1CbYkSlWr6t
	 UyNC4lrz3IABFlUOnIc9u8h3lYhMKjhH2plPGDFsE49TGuVfmxkGB1U5kTspPPD1s7
	 ffEf97WR26vUOcpaM4BtrbKRdainAFRb+WFeCU24KTwKhn2sKbqbT1J7GAi8zNf+pw
	 diQRmBrAMFAI1FIkvXOx+iGwrwG3WYEWz/1eEzl6uXHx2VBFgcVkOJTmySLNjF4GFl
	 +JLS/UnPx6PqYammuaBGJ6df6w30b0z4Y7/VCT06mWzIsnpe+D7lXo6gAFABO9fJ9W
	 mzwKwKclXIAVg==
Date: Tue, 14 Jun 2022 14:24:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nvme: Ensure char members of struct nvme_id_ctrl are
 null-terminated
Message-ID: <Yqj8kkqwb1JA3qBe@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614210902.744318-1-e.velu@criteo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_142443_429052_940207A3 
X-CRM114-Status: GOOD (  11.62  )
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

On Tue, Jun 14, 2022 at 11:09:01PM +0200, Erwan Velu wrote:
> +	else {
> +		/* Ensure that model, serial and firmware fields are always null-terminated */
> +		(*id)->mn[sizeof((*id)->mn)-1] = 0;
> +		(*id)->sn[sizeof((*id)->sn)-1] = 0;
> +		(*id)->fr[sizeof((*id)->fr)-1] = 0;
> +	}

But the last byte here is owned by the controller. You may be truncating
information.

