Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088FDEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xS2+TE0PoWNNVCMBiw69alXnWlNgMLCp0CT41onkF8U=; b=rXW6H2b8ZFiarMDEWSbRFgvam8
	Ig2jTO+tLkjXl93B4660mRS+nazWaqomW4WJoXKpZsBxncBw9DZR0jMzCcuhnoHY9tqqHnzL9z4XA
	XgTAxrjU8sndLdn8/1hL2lbh0jWtmUU9E8G6/+hWKvU9NsqU1Tb8DUu6rA4VaFFQFYMAu7VKgk9pu
	sJubrX4Oitz3yvR9dgD47v2MPLhlSfwRtZ7nJeRq2iYOnb2m8AHtUH0HyrbtuOMB7eVHNKVK0ZHEq
	zFIIddZS8PSfANsWs/l+oRp6dFYp2+sl7XgQMBXoEOCntWImn33gIgGOctwVRe/+xC6dQI6kn4Sr8
	v7AAlcOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1by-005KdJ-1O;
	Mon, 24 Jul 2023 19:52:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1bv-005Kct-1E
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 19:52:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DCEF761357;
	Mon, 24 Jul 2023 19:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1BAC433C7;
	Mon, 24 Jul 2023 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690228370;
	bh=kP9LFVtRs+Ccd680KNMd/rso4IU7MRNI/s2gQcTn8K8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgSBdgWOM6O8dH0osz4XFlKo9jOWZ6gGAyBSleFY0cnmRksLenDlC26PBXmkn475s
	 6iD9hEfArzfCxkcjLk6q0oP5NLIVXeUc8djvArC2em9TW/KP4ztJWX1wkoP9sYiJQm
	 iyfLYlYGH2BpSXP6DDFec83DGL9tVYgF6vaJ98nU83TfzlZydgPZ+VBxsNOIyimlac
	 KxXtaEI6gaLpndVzh/s49gopZSdIqPf98IKnG7Kumg+aTQ3BzgNfIwb3L/obEFkYuu
	 mIf+pf6ozPuCmzGRk6NJt7GF0dMBc9ijV01zcbks02tkqYqraJgLm4sr6jIIbg7E/3
	 14s25cH8SkrCg==
Date: Mon, 24 Jul 2023 12:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230724125249.319241b7@kernel.org>
In-Reply-To: <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
References: <20230721143523.56906-1-hare@suse.de>
	<20230721190026.25d2f0a5@kernel.org>
	<3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
	<9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
	<20230724123546.70775e77@kernel.org>
	<ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_125251_457126_2816D1A7 
X-CRM114-Status: GOOD (  14.72  )
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

On Mon, 24 Jul 2023 22:44:49 +0300 Sagi Grimberg wrote:
> > I'm probably using the wrong word. I mean a branch based on -rc3 that's
> > not going to get rebased so the commits IDs match and we can both pull
> > it in. Not stable as in Greg KH.  
> 
> Are you aiming this for 6.5 ? We are unlikely to get the nvme bits in
> this round. I also don't think there is a conflict so the nvme bits
> can go in for 6.6 and later the nvme tree will pull the tls updates.

Great, less work :) 

Let's see a v9 with the flushing improved and we'll apply to net-next
directly.

