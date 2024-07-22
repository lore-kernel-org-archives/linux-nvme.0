Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C0CC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 22:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AL4EvkoZgs3kGBwsaMYkfRHL07eFZ27IqyrSEI8RNzI=; b=IKaprvGSdERKzBb5HL1CnFvIBa
	cUZuYcNsfx2EBI5vz58pLpkYaOEOW6m70psXIYC/9Z+GdVUXDf2N6ma06tDgyK3fCqEpQykCtsLlu
	CgFUapCI43OazyKW/e3lAWKlHMPAow6swhEYI1RyUjmSLn2Xm5Y2fx/HGZg6nJBoAVHycxqpzGXei
	M4pEQgOYJWdoW3Uj0AXk/tnmfuMAi+jmH5IU5jGOC8IWADiTpFAy0BhOaM+5m+kLq4mQ3t55zfL98
	7qCicF98WmcZ3neP1j2iqSp/IabZqHjyhT4Z8JyypIwrrOZpceJ1UJj0Y4SSyfGs9k2DdNHbtu50n
	QNDkoYWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW1W8-0000000Al3j-1g1T;
	Mon, 22 Jul 2024 22:28:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW1W6-0000000Al2V-0bvi
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 22:28:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3611E60AE3;
	Mon, 22 Jul 2024 22:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DB7C116B1;
	Mon, 22 Jul 2024 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721687304;
	bh=DiorJv7n85mq93NrB4uHNHaSNBzJ9vO1L9Ub7UPLr0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8RijMTa+iqo+AFG/Mv8tf3ulM91Me2Zi8TVEsItw6DVjImlYEKiLD3M5mjnQTkNh
	 zhn9CcgJdR+l+k9xH9+q3ay+lNAbEkRt7iDmx9cM8NgIoFtU1WG6HKC6IAYzHZiAVb
	 PTOrdG4ZaPLU8hca71OFbMnszO5CEw74uZvQxjtlz67xsSQuCE77gjp4TxUHCeUKl7
	 eMr3v+G2i1cYLfKcu4LdMQOtCG6mbU2o4YKQfSh3Jrgu8tMvX+zyBM/vYTKh29Q1nk
	 6l2Eay98AmxXN2RRPxjxx8sbhqOsi9NWtqp8xFgINIbeSSCXzaKIH6s6RmV9JBKfDV
	 14WoeQM3viLJA==
Date: Mon, 22 Jul 2024 22:28:23 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 0/9] nvme: implement secure concatenation
Message-ID: <20240722222823.GA2303815@google.com>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_152826_268545_6E9E4837 
X-CRM114-Status: UNSURE (   8.82  )
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

On Mon, Jul 22, 2024 at 04:21:13PM +0200, Hannes Reinecke wrote:
> 
> Patchset can be found at
> git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
> branch secure-concat.v8

Not a valid git URL.

Also no base commit given and this doesn't apply to upstream.

- Eric

