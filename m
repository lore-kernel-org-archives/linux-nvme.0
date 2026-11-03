Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9F606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x0z36JRI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vFZEO4zt4w8Z9j01sARfz1D8Tc/oYb3BjXxwvZoWoFQ=; b=x0z36JRInMxq30mRlELyvXDvbz
	TJKO4281PaOF+o2JuNFb7nBTYByA3wvQtjwlrmRbrS/ExOwPjj66xw+5yq1LiSsPxzN9f5pFLWuqu
	FNq+6BRgAcbEXctS7VY7keYI7d8ywcm0u0xHAgsgyvC4KRBkS+4Bo73UZ8wIgKRnwX3qbn7Gqq1P7
	bYeP5oael50tPdaihKxiOykm3p++ZJZTO2LlNhe8zsFenKw8uVPDnNOqJxYFmKSKOFbr/xUgxNh95
	P99gjkmTXwcRA8VphePnmgmm8UaOY3F+QERNNTr/U0MQq5Z1iYo5RVvYvW/CgC1MB8CEniXOPI34O
	yKYX4XSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO78w-000000018je-0D5x;
	Tue, 03 Nov 2026 05:33:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO78t-000000018iu-1SUG
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5781568AFE; Tue,  3 Nov 2026 06:33:03 +0100 (CET)
Date: Tue, 3 Nov 2026 06:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put()
 call to nvme_tls_key_lookup()
Message-ID: <20261103053303.GA1382@lst.de>
References: <20261103030226.2685251-1-jarkko@kernel.org> <20261103030226.2685251-3-jarkko@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_213307_533892_3F0BDC08 
X-CRM114-Status: GOOD (  13.64  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 05:02:07AM +0200, Jarkko Sakkinen wrote:
> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().

Looks good, but I only got this one patch out of a 11 patch series,
so without the full context it's hard to fully review it.


