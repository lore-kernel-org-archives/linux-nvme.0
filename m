Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC2EC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ll8i+rZbQ1YbnyQcX++PKIoX8eCP91NJ7eepQ3Eymc=; b=QOZuwgGje7o+P6QaEXi+7HLrn4
	STyC3gHtRGvKzKVHushc7Q04VuTvfzjyapMVSOGY+4f6YrDLNqoJQ8dbuQ8495kUDveNQkbVS06ZU
	XBjzZrqRy9gBXFn9ZZM8FPwHp+ZzO0Ba5YaPhl3Lqaf7dEllbEu3LNeaLVqXrhyZsmSoOZTUOnj4w
	8sxSykSapeQtDBIChnoAP+YicUIsLJf6eYsiGqlMcceMw8v5gmWacq6d50jbKjMMTWUDJRBl75mFz
	mFzYvQ4v8pzrBqBwm1nbW9de5/8ucBkfUjCiWBrdiuxprWtfpb7xEM84NCnTSZgnkQ2+SYskHu3jv
	7NgOfHPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUCZ-00CFiV-1k;
	Fri, 12 May 2023 14:56:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUCW-00CFhk-1t
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 14:56:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 038C268AA6; Fri, 12 May 2023 16:56:53 +0200 (CEST)
Date: Fri, 12 May 2023 16:56:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 3/3] nvme-fabrics: prevent overriding of existing
 host
Message-ID: <20230512145652.GC5051@lst.de>
References: <20230511165441.30005-1-mgurtovoy@nvidia.com> <20230511165441.30005-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511165441.30005-4-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_075656_773756_91EC905A 
X-CRM114-Status: GOOD (  11.71  )
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

> +
>  	list_for_each_entry(host, &nvmf_hosts, list) {
> +		if (!strcmp(host->nqn, hostnqn)) {
> +			if (uuid_equal(&host->id, id)) {
> +				// same hostnqn and hostid
> +				return host;
> +			} else {
> +				pr_err("found same hostnqn %s but different hostid %pUb\n",
> +				       hostnqn, id);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		} else if (uuid_equal(&host->id, id)) {
> +			// same hostid but different hostnqn
> +			pr_err("found same hostid %pUb but different hostnqn %s\n",
> +			        id, hostnqn);
> +			return ERR_PTR(-EINVAL);
> +		}
>  	}

Please avoid the c++ style comments.  But If the code was structured
a little different, they might not even be beeded, i.e.

		bool same_hostnqn = !strcmp(host->nqn, hostnqn);
		bool same_hostid = uuid_equal(&host->id, id);

		if (same_hostnqn && same_hostid)
			return host;

		if (same_hostnqn) {
			pr_err("found same hostnqn %s but different hostid %pUb\n",
			       hostnqn, id);
			return ERR_PTR(-EINVAL);
		}
		if (same_hostid) {
			pr_err("found same hostid %pUb but different hostnqn %s\n",
		        	id, hostnqn);
			return ERR_PTR(-EINVAL);
		}

