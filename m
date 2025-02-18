Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB93C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZ+folBKi+sv7PcRaPfzS6636pp68hHmzdYmWbTivmc=; b=lhnzJl8Nr2VDhaVIIx7tXxQ6KU
	qlOfYwjMEuDszk7HLtQj44G8bgX56kUahh2NXK2Z9DDx/JHj75rjFhXs0Yrgrd0JwUUoftasHbnZU
	g61sGF2rIsCz5Midr2ZYV38z4TJi1EQsu7NgdZKa4y9OjeQHrIt9pTfiawVmfWZuZAMGM8vtvtGG7
	ijucx2RNhpjDkWU0fzoHgD1MNF6F+0uweShgBQcT7G6mE5jOk2FQXk5R1s7WNZsQEaIZOFxQUv8SU
	kfvwfhMJB3OuEe9jI3agaiEiU4PyBbyZ2+9OtbheYB1eaW41oWKp6dMktU1xzJT92Pz8ddToUMzCU
	0UddADbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPlx-00000008o3d-1Pv5;
	Tue, 18 Feb 2025 15:44:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPlu-00000008o2f-22Ke
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:44:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B44AB5C5ECA;
	Tue, 18 Feb 2025 15:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA30C4CEE2;
	Tue, 18 Feb 2025 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893469;
	bh=BO5Gb3YNfiGHhEeNU6JWBAZL1go3+sPlxBPa9tvk+xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC+UTRc+WVHIFhz5FySHK3n8cOJpgqlDKvu4nnMmxq1TjT5Xz/8BBZb+pZvgYQFhM
	 uFCa3OYt5t43iqj3aUZdTZcT7DuamuW4ykqaB72M8eF//ZIZ1U+YLoKKKPS1qks+Vf
	 AXQdsK9kPUU1p26oehoFYYGPEPYPsso9iMRdQaabbzdIuowkRK1jsbRpTGZe9HT/VQ
	 JZxCQ+Z8CjGTInUCZqElpGKdWOcFhZR6WBD+igOsQUOpYA3Wx1kwjdUkBk9b/qhRBh
	 +WTffCWcL+jsFK+awxAoWzHtABMAM8+XXstqbfE6WJuk15Yb1AgaVVZw9+KsOGvzFc
	 eN7CPpYgYNQYA==
Date: Tue, 18 Feb 2025 08:44:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH V2] nvme-tcp: add basic support for the C2HTermReq PDU
Message-ID: <Z7Sq27iIEBYAqg16@kbusch-mbp>
References: <20250217160827.369977-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217160827.369977-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074430_563902_3220743A 
X-CRM114-Status: GOOD (  10.66  )
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

On Mon, Feb 17, 2025 at 05:08:27PM +0100, Maurizio Lombardi wrote:
> Previously, the NVMe/TCP host driver did not handle the C2HTermReq PDU,
> instead printing "unsupported pdu type (3)" when received. This patch adds
> support for processing the C2HTermReq PDU, allowing the driver
> to print the Fatal Error Status field.
> 
> Example of output:
> nvme nvme4: Received C2HTermReq (FES = Invalid PDU Header Field)

Thanks, applied to nvme-6.14.

