Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61860A260C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZAABXgMw;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IURgjRIJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yp9RErImbmlfNvWa/gGi+JRwkpurCWbLBwayYL1IIJA=; b=ZAABXgMwlGxIT9neUunbU/oLcj
	zkafq/Lr2y/e/sL2UvNIjU0EkHuLxSw5BRMcn0V/bGa/95AxIxztwZmuPFIr5j/6lFdRDLSuaSs1u
	xeBaxc48rw4IQTfVj6kzGqjqJTcx80hVmkLg1Ykhy5elNUtQ5vlP3BUydVzDFOgKmMeJBk2+zlgYw
	7W/Ck/kirSKM3LDz37iNTS97DB2TloqhzDZpKeOP+Y4Yx9kNqcL5Xv1atyUtFXSe8e5Ky9r96tD6+
	WQ7LqKi0MBbve+OGplvjwIUAtkWhdCfspRUfizWriPDjp9fk8EKbvzTsyTdat7gR0ZoqDsmSKJpWS
	QyEJZFIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSsj-0000000Fq7L-3cja;
	Fri, 20 Nov 2026 17:58:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSsg-0000000Fq6f-024U
	for linux-nvme@bombadil.infradead.org;
	Fri, 20 Nov 2026 17:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yp9RErImbmlfNvWa/gGi+JRwkpurCWbLBwayYL1IIJA=; b=IURgjRIJD5ipRy07koBxbwOjeS
	VGXxcJb3f2Asn41wVF2cZPSdErtY2geO62hSE98fx3qVD5TMhIgiyXrS4CEWDjikYn9YSeYm9OhbO
	ujaO/KrwuS7G9wgYFEMD1yuEWsFtZQ1vyRHQTIeXmz3uS5xLT6twtSbu2GE1HQtERljcYwMFC4L+a
	KSH6qdwfdb+ft7S2+Ikz3o/JrdwjHcccuRc12t80qcAK5tVxoL/XlniPdQQSeVJGHusitmDeMa0g0
	iF3HYux+U1Mgm2Dpu6xy9F+eyiPxnyLW6UY6g4q3G2uBKa2gOcVLuOmVngjOKKO5pLESpcKnTkGh0
	tvoKUicA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSsd-000000012hy-1Rts
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:58:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 873826732A; Fri, 20 Nov 2026 18:58:32 +0100 (CET)
Date: Fri, 20 Nov 2026 18:58:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stephane Thiell <sthiell@hudson-trading.com>,
	linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH v2] nvme-rdma: add a module parameter to disable T10-PI
 offload
Message-ID: <20261120175832.GA1726@lst.de>
References: <20261112210105.992764-1-sthiell@hudson-trading.com> <63f323c5-53bf-475f-808a-b6819b187bb0@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63f323c5-53bf-475f-808a-b6819b187bb0@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_175835_375139_6DB8F0FD 
X-CRM114-Status: GOOD (  16.73  )
X-Spam-Score: -0.0 (/)
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

On Mon, Nov 16, 2026 at 02:59:10AM +0200, Max Gurtovoy wrote:
> IIRC, when we developed this feature, a connect param to control PI offload 
> was part of the initial patchset, but the community didn’t ack it.
> I think that connect param is a better option than the module param.

Yes.

>
> Later (Jan 2024) I proposed a per-connect option, nvme connect 
> --disallow_pi, together with uniform metadata settings for the ns head.
> Some of the code for NS settings was merged in a separate patcheset that 
> didn't include the connect param.
> I believe we can also merge the connect cmdline param (better call it 
> enable_pi and set default to 1 as suggested by the community).
>
> I'll check the status of the old patches internally and update.

Yeah, let's get the rest of this merged.


