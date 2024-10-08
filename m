Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD203CF0429
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 22:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZY+W+3G1uNtkfanpiR93dlahys69f8eDzfOkTcdzUm0=; b=ehDan07/98wHNSCvXl5VGqhTtP
	gm4fL1XhlQU2mLxxvU6VBXKerv35loSG1ug6cvVtffIgIuMexyqwf9VgpVeKkgjX4/qO+QUpOyAU+
	Da17Mv2VLogeu3h7HFYXWxw1soYfzeI84bUnISxJX4wPqvtKrBMmPYZpcz9q3sUELBJ+bKjz88R7n
	nT0YTB1ZcV2zI/9rkiTC0eNWv3XfbKZfBUWiQAdarsQ4EUbzug7hrNXHr5IA6fDQ/AlOWn2JhR+rj
	J/RtA0VMjNZVyYTu/T8Tqs9FXDyXoMdi7RS8qaE73sUwQUGHSrzWwaaZtgvbCWNwt5m/HDCndIVur
	jHR7uq6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syIJh-00000007EbK-3eor;
	Tue, 08 Oct 2024 22:04:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syIJe-00000007Eab-04pT
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 22:04:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2DF665C01D5;
	Tue,  8 Oct 2024 22:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED1C4CEC7;
	Tue,  8 Oct 2024 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425065;
	bh=iow1JAe/82UMDIUstBevpkrdK9xWZnfdRJ6+IethTys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0wnRx5rjoLNrS4vpGE4v5saqkSKNgOSvij8i+fdhoyS+pQVFuAg+jmBVOicGvjYA
	 ynzvMGBQsfTh6kM+SehJvK38H4isiV/wqpCdpq4L1fWWyJhzFyTOfdaMEiBcyKzC3M
	 zLkBuR/nSuDfkZia0pepICsYBMO7fsUJDklOA/2vxIUI9mGzcR1f5DF4Xsp4SbO/ge
	 q4+CZWSRD2qw2UJy/FHJl4FgCWR5XyQB5r2vrYkj3mRVFe32O6AYlxhAexyKtM5six
	 mBdTgP2alF9lfIdvk8GzrZrRFsJu1XgmOJzsjaH8/jgBcB5kaLTu/M4ZOsX5i7A7L8
	 FcKaZz9Y24E9w==
Date: Tue, 8 Oct 2024 16:04:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwWsZvOrQGQ2UR2P@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
 <ZwVMLIt4iFX9MUjV@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVMLIt4iFX9MUjV@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_150427_239734_38351589 
X-CRM114-Status: GOOD (  11.55  )
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

On Tue, Oct 08, 2024 at 09:13:48AM -0600, Keith Busch wrote:
> I still hope to see nvmet report this. It would be great to test this
> with HDD backed nvme-loop target.

I took the liberty to write one up. Looks like everything is reporting
as expected.

---
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 954d4c0747704..e167c9a2ff995 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,35 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
 
+static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status = nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	id->nstat = NVME_NSTAT_NRDY;
+	id->anagrpid = req->ns->anagrpid;
+	id->nmic = NVME_NS_NMIC_SHARED;
+	if (req->ns->readonly)
+		id->nsattr |= NVME_NS_ATTR_RO;
+	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
+		id->nsfeat |= NVME_NS_ROTATIONAL;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -729,6 +758,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_id_cs_indep(req);
+		return;
 	}
 
 	pr_debug("unhandled identify cns %d on qid %d\n",
--

