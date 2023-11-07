Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A951DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQzyvHkxhjVgJkVGx7d1Cci9yhyiDl0vAQA8cx52MGY=; b=ib28trHgzTf0nn91+CS28hai6o
	/cD37i9g6J+0D1ryjj2hHMITj6S5+U41jaDNiuTev5EWVXOlOgW65+yUE/++8p/b6nvnTHsoFCj5I
	vpPpV23glJiQGbpqegmF5/RMapJM2tVLgDBJ3WtrUqLLoa6kfq9JIN9h/SnDXhsBSyBRGrMAzESEc
	GKefeJqbpKez8aF8pk+OtEugo8NCPsVhvDMaoK5bcafpcZu5ApBonOjhXH6aG6Nad0zDa9o7cMsG9
	bldKCOaOfir/V9PhnoaW07d2hBcEgop9IWtIOJI1ebHtrMA28t6f0FgStnNoQC4GVCAr+OhuLN/oe
	wRSo87zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ULK-002We7-0Y;
	Tue, 07 Nov 2023 22:14:42 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0ULH-002Wdf-1Y
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 22:14:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 991E3CE0FAA;
	Tue,  7 Nov 2023 22:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9501AC433C8;
	Tue,  7 Nov 2023 22:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699395276;
	bh=AQzyvHkxhjVgJkVGx7d1Cci9yhyiDl0vAQA8cx52MGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txpJKczeNIjxzSjCvDPZ4JUtK2wwB9jk83CVAWde5ndnYkAQ9MPm+4Ki8uEG0fHLe
	 bMGSFjW7OFYcU32RApKJ1SEME1dY4H520VJj40EHVjt+rghWcrl2d06L5D+DvDcDqG
	 lmOWznVwrqslyN6xOqE2G9yU8gJoATG8U0eFA2qGKpDALp2rEwY7MGoEi81FKmKMDQ
	 aO/O8mVcypkhErSKKKR43vgQ9XhuuZKkUUEfoxmcgz+XNvmPk59zjUJgaGRt9slZCB
	 w2AK8IomkwOnd6b7XTqp/WJu6pypUyxx+HEPkCSguAdertPyiJQ+wxSBtjbKKI3CaS
	 dKQg1jHs/pflA==
Date: Tue, 7 Nov 2023 15:14:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZUq2yp6-LB8lY7Lj@kbusch-mbp.dhcp.thefacebook.com>
References: <20231107212331.9413-1-emilne@redhat.com>
 <ZUqw82QlbgXhDwpr@kbusch-mbp.dhcp.thefacebook.com>
 <CAGtn9rmaF8GEFjnnZuM_k6fPxGDAooQrN-7W8bHay1cXqK5Zxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtn9rmaF8GEFjnnZuM_k6fPxGDAooQrN-7W8bHay1cXqK5Zxg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_141439_690348_2D5502FF 
X-CRM114-Status: GOOD (  10.31  )
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

On Tue, Nov 07, 2023 at 05:01:22PM -0500, Ewan Milne wrote:
> The patch uses the existing flag NVME_MPATH_IO_STATS in the request
> for simplicity to see if an atomic_inc() was performed before doing the _dec().
> If we really need to keep the count for passthrough requests (maybe we do)
> then we would need another flag.

Oh, I see.

I didn't think you wanted to tie path selection to whether or not the
disk stats are enabled (and maybe you don't?), so that's why I thought
we needed another flag for this.

