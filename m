Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBC606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RRP7rib1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ekv8nZV2KRWXLq55UMkFX2h8AsIUilC5jxcfXsbLa8w=; b=RRP7rib1YB8a3dwVOY5JzwYCJS
	JuGoyIcotZZ6aGJvTTev5PhnTeMkkC//Pu8/lEHgOtk5OfmQoIFIfTJ5ksmVLb01+Y9cbQgth3obd
	E77Dh+oV0u/QB/mvpv17CjytcgLcCd+Ln7Le97SKnEtzySDgHo1NPbtcqzFFD6jtHC8JEnrcAFiyl
	lTK8zy5Fxbpi4pi50s0L9kml3nE9RM/S1fhuOBnQeEDrwO0QsK/yoKvw5Jq6dgQnCO4jL4rf+nFHR
	CWoatV+dT5v9uoIF4IlVMgTY65IpdxrJYmVnpcFYh3zuNs5zwWQ1/17md/fSbrLvhQZQZVAcbsycv
	cCQsIagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsAu-000000082Xv-41He;
	Thu, 05 Nov 2026 07:46:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsAi-000000082XY-2gvF
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 07:46:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2517868B05; Thu,  5 Nov 2026 08:45:55 +0100 (CET)
Date: Thu, 5 Nov 2026 08:45:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <20261105074554.GA17781@lst.de>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop> <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_234611_740704_6D1DBDC2 
X-CRM114-Status: GOOD (  11.99  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> Given Qiliang's response:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks.  I assume you're fine if we carry this in the nvme tree?


