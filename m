Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF1C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iKy/i1wkQUBWeoWVu77CwP62gx1NwOIv5m+PqcqUQZM=; b=AQOaFgG5tr/a8EjdECTopsM4dB
	H2uvIb8cM80Kra23jmaecihrSRzMUUY+NmlVxHj6+vu9Q1aVzXKZvNWh6iVJgk6QqP/D74CStoe9E
	uXnTpofbdHMYNGWE/Vt8fXTZAY7qkc++DG4tWA9uhsh87rfFrU+vQf4O0V36cQzoAVHNGgN5LLkxA
	zqmofvevSOG6n6giCrd0Hdl4LpTHvRD+EClblVhZU3aULtyIb81rw3qZQ6aKcmJX48IIeJyqDNdS2
	4xXevCyqaaWwfGxLcL41Q/a1ot/00VPyJ3mN3U10cT8uXT6A493UuRv5eU/wrZTBjjGNU0snZ4ZxZ
	bmGoWSiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnBn-000000056Pa-0BSG;
	Tue, 28 Jan 2025 15:07:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnBk-000000056Or-1TuO
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 15:07:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C59CF5C5FDD;
	Tue, 28 Jan 2025 15:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C888C4CED3;
	Tue, 28 Jan 2025 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738076859;
	bh=iKy/i1wkQUBWeoWVu77CwP62gx1NwOIv5m+PqcqUQZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4eVDLogK1tW4N75ASvFB+QuPDdsdVDV6sl2kPcLFgF3sV++AVrYygg8IY3qWEDFT
	 MhcKwK+f1M0iaBYxfANo2h0vJ9WjKqW7sMjnHTF5Y5N0fjGd4bzeHBKxYHpCzK/RO6
	 CTxfdYk/Bs369DANxLcw6tZmOPR3AKMZrf8sXk1UaNLX+emmY9YDoQg/wQf6iTEXUT
	 3sCvpVXRKjbUJY4IYW+MN13/fAaHBpp2KubUvogV6TydWheHdg6qwsa8ndDAtVE282
	 4A0fswJdcemHs8POB6hRi5SvhhLORAWGs93v1lWO7PJ9lxsDeI4OoA/2uReUfB/8JE
	 aJtgHq6NTA3dA==
Date: Tue, 28 Jan 2025 08:07:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: endian fixes for nvmet
Message-ID: <Z5jyuVNLXC4ndQt7@kbusch-mbp>
References: <20250128075539.693870-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128075539.693870-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_070740_434130_2D50F1EE 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jan 28, 2025 at 08:55:32AM +0100, Christoph Hellwig wrote:
> this fixes two endian issues in the nvmet code that were added as part
> of adding the PCIe endpoint support.

Thanks, applied to nvme-6.14.

