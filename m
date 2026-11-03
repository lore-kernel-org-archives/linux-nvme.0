Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3C606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3TgxjSwS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VVI2BEPcphI98oQDYKHMPWx770bBBVfS5vHEb2ZMpdw=; b=3TgxjSwSdoITBwUnzP3kwoHflH
	IvLWVm3Esw98dhHZZKd2EW9pIO9OeUbdyhqFqEFdfc3DsfC0LbzJ6kVHdm5RJvS1PkwNKNQ8YTF72
	dKRpme2tjQZz0jAvysN7lQQim2Gu4kR5mF/6b2jpC7EuoHhWEVvr9xtfofuae8uSreIRbD+xqlck8
	VfiJ9GInWcTyoEKElWxo4iAm9g3nN0wTs5kntcg6z+hjKRZvaSoN1Feta0wqljuLagpLY9EOjD4NZ
	F9Ch26dQXIhrY2l1cUQBsRRq5CcH76bA+otMX58fEzeaCHegtSeDexnO89bsLXQmFNh6p0p24MPzi
	DfzBXtwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9gQ-00000001W5Z-2gOL;
	Tue, 03 Nov 2026 08:15:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9gM-00000001W4L-3UmX
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 08:15:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8055868CFE; Tue,  3 Nov 2026 09:15:47 +0100 (CET)
Date: Tue, 3 Nov 2026 09:15:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: drop the extra RCU grace period in
 nvmet_ns_disable()
Message-ID: <20261103081546.GC4301@lst.de>
References: <20261103-bug-nvmet-ns-disable-rcu-v1-1-ff7ac5623923@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-bug-nvmet-ns-disable-rcu-v1-1-ff7ac5623923@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_001551_019005_DC65FF75 
X-CRM114-Status: GOOD (  17.00  )
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

On Tue, Nov 03, 2026 at 01:31:25AM -0500, Qiliang Yuan wrote:
>  	 * Now that we removed the namespaces from the lookup list, we
>  	 * can kill the per_cpu ref and wait for any remaining references
> -	 * to be dropped, as well as a RCU grace period for anyone only
> -	 * using the namespace under rcu_read_lock().  Note that we can't
> -	 * use call_rcu here as we need to ensure the namespaces have
> -	 * been fully destroyed before unloading the module.
> +	 * to be dropped.  Rely on that wait for anyone only using the
> +	 * namespace under rcu_read_lock() too: the ref can't drop to zero
> +	 * before an RCU grace period has passed since the kill.  Note that
> +	 * we can't use call_rcu here as we need to ensure the namespaces
> +	 * have been fully destroyed before unloading the module.
>  	 */
>  	percpu_ref_kill(&ns->ref);
> -	synchronize_rcu();

This assumes the percpu_ref is never moved to atomic mode otherwise.
Which we don't do in nvmet, but maybe leaving a reminder of that here
would be useful.


