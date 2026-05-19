Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B2ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4guvGWRmoAJ1W77TIglmNT460MWfK0mUqQ1F4nQB/c=; b=ESnP+4mDk/5PmMsMRivnBy6+Gm
	V6tT8pYO/qCC1YpQf05CP+Ekm23XJFt0N7yixkEnBh8h2vRpCgh6CYqCTdOi76jUc9q4JGegCiPw7
	SPglc2gBoS95cykm+lhB0KCSTAX5DyjJyDp8EqlI6L4LvDN72wrjtJbY/YppBh4ju1KiRUbgKtRCE
	er/i0b/eKyLarraLH9IBoiddm0p5RAyWAqoiBrj9jiu+vvXpbT8DsgP7Gf/J+yw9oFGQgkuknQmDG
	Ii9C2ElskrWrsuGTHpGW7kXiZuZnZM4NenIlqiRuW78Dw/mDE9Jm9eJ9+QGug2Zfil9m+vvWYYQYJ
	jyUpUfaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPElh-00000000TPa-0u3M;
	Tue, 19 May 2026 07:21:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEle-00000000TOz-18es
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:21:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD8E768C4E; Tue, 19 May 2026 09:21:26 +0200 (CEST)
Date: Tue, 19 May 2026 09:21:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260519072126.GA10436@lst.de>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com> <20260518140945.2751273-2-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518140945.2751273-2-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_002130_453505_9BC37787 
X-CRM114-Status: GOOD (  16.08  )
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

> +	if (pname_count > max_count)
> +		pname_count = max_count;

Use min/min_t here?

> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(li_desc->pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			fc_li_stats_update(event_type,
> +					   &rport->fpin_stats);
>  		}

> +	pname_count = be32_to_cpu(pc_desc->pname_count);
> +	desc_len = be32_to_cpu(pc_desc->desc_len);
> +	if (desc_len < sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)
> +		max_count = 0;
> +	else
> +		max_count = (desc_len -
> +			     (sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)) /
> +			    sizeof(pc_desc->pname_list[0]);
> +	if (pname_count > max_count)
> +		pname_count = max_count;
> +
> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(pc_desc->pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			fc_cn_stats_update(event_type,
> +					   &rport->fpin_stats);
>  		}
>  	}

Am I missing something or is this code entirely duplicate except
for the different stats updates helper?  Maybe use the chance
to factor it into a common helper in a follow on patch?


