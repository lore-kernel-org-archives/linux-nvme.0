Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B8CA0EEB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mV27vbineOK6JDw65BnUffjmOjGWtSpuHxW/5yWjJJA=; b=UnMC6ky1x/ZvkM749mH5EKwjs3
	Bs48W+l6U6Jp7yFwMx7oujriQ/za8+nlwcLufxTDgomWYq+/5ARWYo2XOYqSMMsg3uSmRIcXhKftM
	n7eeSsa8hOe5Fr/ASkZKrVl3KQQ0XpoJr5Rk5hLDwgutwqQF0kwKVsxAVBIDWqw91qWe95nxio+JP
	kkf0YXtQ4/4kOdyL8QGzdev9rFSGyBOgq1ZVrny6p0Xu2F6jHwsPSakW3VmZ8/rU0aUvLAS5b/qbc
	71vF2spviH8mbed1VbtpfkZt1jZz92q0tvYfpF3cstXYv0ewO5D/gPpzTQYfCJl2ynX7w7iWFJnN9
	v93jVsVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upKzv-00000001f8M-3GvT;
	Fri, 22 Aug 2025 06:11:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upGHi-000000017k2-19dh
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Aug 2025 01:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mV27vbineOK6JDw65BnUffjmOjGWtSpuHxW/5yWjJJA=; b=Zkyvws7lluVZeutlkOjrtsRbmz
	Gl/jidik1ufJFs/hIMMWdkwrhB9wv8ElfjyhMPbmh4SrdxcN/dnz/gutnedmXd7HxCLEEmF2dpqp2
	fSBOdjwOsSn8srLLAuOR/Zy+c8qxFnTT57CM99QPKNKPnwyaGRwuIJA5NjWqc7KyIYMcAVmSWxSZJ
	tV5+rxwGNaIPhGJd3WH3hQ3YaVr/AY/lxAy0p5UwILWHxu67COZYbBJif2HSWP9MQ9LWTfTKVZBGy
	ZtdDBWNCRoaTITGJsMSrpoUB5se/gXtJG4hdDrs7nUPXO08QxHu9B+tws6cXFl7fmIDQOBc/DDqKl
	pja2HY0Q==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upGHc-00000000ihs-3jKx
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 01:09:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 919475C5C75;
	Fri, 22 Aug 2025 01:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9512FC4CEEB;
	Fri, 22 Aug 2025 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755824967;
	bh=k4PCsDsUCHvA5vPL5ktK42szk/ObKfJNjwQcew+ZCiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY7Ljr7SWfiZgHl2xEOrdQRdp7fR1j/52QnLDlgmH86R4OsL0SW2T/qQ+cXRTV2wL
	 ICLa4H5AvNrQVebj5lMylebpnq3Y/6YjYLmZ4jTcArBlJb+jR1LTTtMDMlmOd378jS
	 fri+m6P2Z2xxa+NnOf7Rc8EsvAGdmULpz7+xpiUGhgxCpoMyzByhAw4XgtG99/YEO5
	 tooV3andRzQZqj4M0FrPGJnKgkWW5d+gQtxeS9v4tzzbvtclT/U5k991hQoPHk8VMM
	 PlwCCUERNDoYCP3fhaaIbxKVL6bqzdFLUyt62GPH8XBqouFKAtzzjyXp1h+ZHtzn2v
	 JYMA8ntH5W8Vw==
Date: Thu, 21 Aug 2025 21:09:23 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nvme: fixup HKDF-Expand-Label implementation
Message-ID: <20250822010923.GA2458@quark>
References: <20250821204816.2091293-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204816.2091293-1-cleech@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_020933_688431_F51D72DF 
X-CRM114-Status: GOOD (  15.02  )
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

On Thu, Aug 21, 2025 at 01:48:14PM -0700, Chris Leech wrote:
> As per RFC 8446 (TLS 1.3) the HKDF-Expand-Label function is using vectors
> for the 'label' and 'context' field, but defines these vectors as a string
> prefixed with the string length (in binary). The implementation in nvme
> is missing the length prefix which was causing interoperability issues
> with spec-conformant implementations.
> 
> This patchset adds a function 'hkdf_expand_label()' to correctly implement
> the HKDF-Expand-Label functionality and modifies the nvme driver to utilize
> this function instead of the open-coded implementation.
> 
> As usual, comments and reviews are welcome.

Well, it's nice that my review comment from last year is finally being
addressed: https://lore.kernel.org/r/20240723014715.GB2319848@google.com

- Eric

