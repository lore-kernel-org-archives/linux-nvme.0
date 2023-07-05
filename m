Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12FEEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjX+vhKQ/awlY7dKEp8sWlzDyuIAPICgFzjbXq2SIcc=; b=QTnXWwCDs3Zqai9TT7/A0SfpE9
	uJXOXag+akPw/q6EcyU/++LYUhQM4W70hcbgDCmVkm0XvLkdEvF8T6fk4xrAXqY6wQwQ7ZQX1ebn5
	bXwKr0JXBJ+FTj+vNgFlhnI5d96SYyOHmZ6iQ/ALev+aVLelHdWY7kDI/tAHtgiMC7Jto+SisbSjZ
	Vt/3Rhc24wg+yoJwLdKzUaRQsS3ypt7ItqPNqmTMISwFYwFMunLuZq/hR2WaVCQ7O8uUkzkSQOonw
	PpkWpGiINVfW6O2Qz1NgSh+h4u/1dKgzVRXFRBFrmTocBF8WwbNAdJA54i6AIsYN2QCg6AHZVfL6o
	aBJPhV0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qH9XV-00H4tH-0h;
	Wed, 05 Jul 2023 20:55:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qH9XT-00H4si-15
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jul 2023 20:55:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 610F6616FB;
	Wed,  5 Jul 2023 20:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82782C433C7;
	Wed,  5 Jul 2023 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688590549;
	bh=uiTvJCau7YJw9n0j5AlyOXFdzLt/ldvFjBcrnv8HuVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ajxd1wErIXQtvCUd0gJSO/SNM13g6HK2w4YkygqktkFTco9dijPC6jarBfTiYrzJr
	 KxcEUs2LAPZfuf5VYreCIYDtK7Zx6O51GLZyb+V1En0UPzJglqi+4zDypRtIbPh4+8
	 ZJ7TMdsIamP4N3+QC6XExX5Ihl+HPR06fkF0GVv97mlM+eeuv01qDhQH+8qJC3xQ2x
	 xmTfN+RDB5vYg+YILcjfWKKNlRrcgRk4IhudMpWQp87+QAb4Jsyc3rsc5rI0bY877u
	 Npft+iAS+sW3VT7xCfl9MUDOmCqPf4XJiqoETlum7tcRJZ3fIc0NLlHPsZXuEvlpVp
	 3w0fuDKC8U0YA==
Date: Wed, 5 Jul 2023 13:55:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Message-ID: <20230705135548.52db9949@kernel.org>
In-Reply-To: <0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
	<20230703090444.38734-5-hare@suse.de>
	<1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
	<0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_135551_417080_E98C4B51 
X-CRM114-Status: UNSURE (   9.33  )
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

On Mon, 3 Jul 2023 12:21:32 +0200 Hannes Reinecke wrote:
> > Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
> > appropriate names.  
> 
> I don't mind either way, but I've interpreted the comments from Jakub 
> that he'd like this naming better.
> 
> Jakub?

Slight preference for enter/leave (leave rather than exit).

