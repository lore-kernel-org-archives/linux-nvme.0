Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD7D68B32
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JL5O0qb8v98C7q8j+mjUZWNs1oIo7zUrcyAP7o2cq14=; b=LQaGqYYNJ3DQXuqCRCxhiyb3Ec
	z/IBzSsZVvQUBsdIem+6sJf9FSHnYxp1eIkFY4Iw0KAGcRomQDnexFu0vIlDrHeQOj4eiui5J+bwk
	HDWOEWXV3pSXOX983xol9wxa3DX9zdBo+/edbJx6a7XTlBKq9t2dIGMww1bU7EmI8S3raVaR/5BJ/
	/ihq4F2L3SxwrjrgrWZ4kxQgiYAf53z6dqmTr3HzEewqTZhb1xUdb9muJ+JU3EQA3vjwQ/vQvzyap
	74mJUWGKRQ3uKiVezhkZOexMQN3knyJvdQUcslfDYzBgL7JxUjBzJWNEG41l8OcXMa3iXjrHKvMzZ
	YaT3jRcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbqk-000000000aD-0xIO;
	Thu, 14 Nov 2024 15:33:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbod-000000000jO-0L0O;
	Thu, 14 Nov 2024 15:31:27 +0000
Date: Thu, 14 Nov 2024 07:31:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
Message-ID: <ZzYXzuM-8AjwVVl_@infradead.org>
References: <20241111170935.4540-1-ikegami.t@gmail.com>
 <ZzLZCzXfrLAP_RO8@infradead.org>
 <52a74c14-e95a-4065-9b38-8aae830ae239@gmail.com>
 <ZzWHRSFI2dS8O0sa@infradead.org>
 <26444a5c-8b93-4aa6-ab7e-891a83811afa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26444a5c-8b93-4aa6-ab7e-891a83811afa@gmail.com>
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

On Thu, Nov 14, 2024 at 11:43:22PM +0900, Tokunori Ikegami wrote:
> On 2024/11/14 14:14, Christoph Hellwig wrote:
> > No, why would it be?
> 
> Understood. (The reason is BIT() used more than BIT_MASK() in kernel and
> also still I think better to use the macro instead of the shift operator as
> below.) Thank you.

And this still make the code less readable.  1 << 2 is totally
obvious to any one with the most basic knowledge of C.  BIT(1) OTOH
requires looking up the definition.


