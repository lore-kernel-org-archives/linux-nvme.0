Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868E6C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4uDy51q6J7T9qTrfYMnu7f9R/QNr5wo+MVRo7j2hvs=; b=CPpY6MIbxAbjbmFBjnjemjjfjT
	XBxrsvPpdFOQiY45xFjZZACGO+PC0odLX1YYI0bXJJ/2ATMl6sIPOG+ZDMvWVRCPZRIEGUqGR8HhX
	qWK2n/6U/TiGcPhkh7C0O93KxRXB/F1EZ4R5hBpG2wVlKmZVikEC8PgvWMHJAOIITGINvfs0TVB40
	eLRsS+KmDgJL1w1Gcdy2BXrKsihNLNZ8neqNmXj/o5GOivzLeRcIOjx6cE8UxKFgpBzFrLwPZVwL5
	OSLDLc1k5f0MO7Oh2K/DHEADWtWIRYKKeXz1Y+86knv/nRXA2htmlfzZmX4fGevGdFAOin9A9QHDd
	W3PzIR+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0j9P-003yJk-0y;
	Wed, 08 Nov 2023 14:03:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0j9L-003yJN-35
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 14:03:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48D5767373; Wed,  8 Nov 2023 15:03:13 +0100 (CET)
Date: Wed, 8 Nov 2023 15:03:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alon Zahavi <zahavi.alon@gmail.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in
 `nvmet_ctrl_find_get`
Message-ID: <20231108140312.GA32730@lst.de>
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com> <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com> <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com> <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com> <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_060320_140989_0A3DDEBB 
X-CRM114-Status: GOOD (  24.77  )
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

On Wed, Nov 08, 2023 at 01:02:38PM +0200, Alon Zahavi wrote:
> I think that although those patches will fix the bug in the two
> functions we talked about, the non-terminated strings are still stored
> in the `struct nvmf_connect_data` object.

Yes, and that's a problem.

> Is it possible to add a NULL terminator after each time we use
> `nvmet_copy_from_sgl()` to copy from an SGL to `struct
> nvmf_connect_data` object?

Yes, and that is the best thing to do in the short term as it's
easily backportable.  I'd much prefer to move to counted strings as
in the seq_buf type, but that is a longer term project.

> Also, I think `nvmet_copy_from_sgl()` should be considered as unsafe
> when using it to copy strings, as it doesn't check for NULL
> termination.

Think of nvmet_copy_from_sgl as a memcpy from a different address
space.  It works on a very different abstraction layer and thus
doesn't even know about strings.  The callers really need to,
and maybe we want a helper for that.  For now that patch below should
fix the issue you reported, although for me KASAN doesn't trip up
on the reproducer with or without the patch, so if you could test it
on your setup that would be great:

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 43b5bd8bb6a52d..0920fe7ce4ac99 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -244,6 +244,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN] = '\0';
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
@@ -313,6 +315,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN] = '\0';
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {

