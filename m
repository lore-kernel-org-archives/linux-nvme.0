Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC67CD68F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 07:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKMw++vO437Mr+QnCU1zUD77/VRtipxcobfMk2lBDdM=; b=3E78CQOFNp7uaDRqcD0JtbY9xh
	w7Mc3ts+RlsHbSOULa+oEeEb8NC7uPCipy07O0ghPPHM+/oTubyRXhuTohQraZMT0QmWd4coRJPX1
	5PkQKnOgNHPQ2VQUsSugsyZyR42m71BB5eDYcZYaI2nkUATQjGIIGL2SrteCySa3COKPtCZCzaKrj
	1pPVNhTeLjrtV2QLyJ2HWyzsSP6VU6XbMPwe6yJu63lcPova9C3G4tHXNX3rCVf7Son5ZccY0T7mZ
	NQ1/QDuGVLe2PZqNWw5VU/EBSxUOcmGY9+DCnZavxJGpYrgv7WBSVQCfY7yn4ZlFOBDJvwER7Kh95
	d/eVdM1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7S2-00Cjci-34;
	Tue, 10 Oct 2023 07:46:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7Rz-00Cjc4-2M
	for linux-nvme@lists.infradead.org;
	Tue, 10 Oct 2023 07:46:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3D9368B05; Tue, 10 Oct 2023 09:46:34 +0200 (CEST)
Date: Tue, 10 Oct 2023 09:46:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231010074634.GA6514@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_004644_056490_275C349E 
X-CRM114-Status: GOOD (  29.49  )
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

On Fri, Oct 06, 2023 at 07:17:06PM +0530, Kanchan Joshi wrote:
> Same issue is possible for extended-lba case also. When user specifies a
> short unaligned buffer, the kernel makes a copy and uses that for DMA.

I fail to understand the extent LBA case, and also from looking at the
code mixing it up with validation of the metadata_len seems very
confusion.  Can you try to clearly explain it and maybe split it into a
separate patch?

> Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device")

Is this really io_uring specific?  I think we also had the same issue
before and this should go back to adding metadata support to the
general passthrough ioctl?

> +static inline bool nvme_nlb_in_cdw12(u8 opcode)
> +{
> +	switch (opcode) {
> +	case nvme_cmd_read:
> +	case nvme_cmd_write:
> +	case nvme_cmd_compare:
> +	case nvme_cmd_zone_append:
> +		return true;
> +	}
> +	return false;
> +}

Nitpick: I find it nicer to read to have a switch that catches
everything with a default statement instead of falling out of it
for checks like this.  It's not making any different in practice
but just reads a little nicer.

> +	/* Exclude commands that do not have nlb in cdw12 */
> +	if (!nvme_nlb_in_cdw12(c->common.opcode))
> +		return true;

So we can still get exactly the same corruption for all commands that
are not known?  That's not a very safe way to deal with the issue..

> +	control = upper_16_bits(le32_to_cpu(c->common.cdw12));
> +	/* Exclude when meta transfer from/to host is not done */
> +	if (control & NVME_RW_PRINFO_PRACT && ns->ms == ns->pi_size)
> +		return true;
> +
> +	nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));

I'd use the rw field of the union and the typed control and length
fields to clean this up a bit.

>  	if (bdev && meta_buffer && meta_len) {
> +		if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
> +					meta_len, bufflen)) {
> +			ret = -EINVAL;
> +			goto out_unmap;
> +		}
> +
>  		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,

I'd move the check into nvme_add_user_metadata to keep it out of the
hot path.

FYI: here is what I'd do for the external metadata only case:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f21d..bf22c7953856f5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -96,6 +96,71 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+static inline bool nvme_nlb_in_cdw12(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_compare:
+	case nvme_cmd_zone_append:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * NVMe has no separate field to encode the metadata length expected
+ * (except when using SGLs).
+ *
+ * Because of that we can't allow to transfer arbitrary metadata, as
+ * a metadata buffer that is shorted than what the device expects for
+ * the command will lead to arbitrary kernel (if bounce buffering) or
+ * userspace (if not) memory corruption.
+ *
+ * Check that external metadata is only specified for the few commands
+ * where we know the length based of other fields, and that it fits
+ * the actual data transfer from/to the device.
+ */
+static bool nvme_validate_metadata_len(struct request *req, unsigned meta_len)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_command *c = nvme_req(req)->cmd;
+	u32 len_by_nlb;
+	
+	/* Exclude commands that do not have nlb in cdw12 */
+	if (!nvme_nlb_in_cdw12(c->common.opcode)) {
+		dev_err(ns->ctrl->device,
+			"unknown metadata command %c (%s).\n",
+			c->common.opcode, current->comm);
+		return false;
+	}
+
+	/*
+	 * Skip the check when PI is inserted or stripped and not transferred.
+	 */
+	if (ns->ms == ns->pi_size &&
+	    (c->rw.control & cpu_to_le16(NVME_RW_PRINFO_PRACT)))
+		return true;
+
+	if (ns->features & NVME_NS_EXT_LBAS) {
+		dev_err(ns->ctrl->device,
+			"requires extended LBAs for metadata (%s).\n",
+			current->comm);
+		return false;
+	}
+
+	len_by_nlb = (le16_to_cpu(c->rw.length) + 1) * ns->ms;
+	if (meta_len < len_by_nlb) {
+		dev_err(ns->ctrl->device,
+			"metadata length (%u instad of %u) is too small (%s).\n",
+			meta_len, len_by_nlb, current->comm);
+		return false;
+	}
+
+	return true;
+}
+
 static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
@@ -104,6 +169,9 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 	void *buf;
 	struct bio *bio = req->bio;
 
+	if (!nvme_validate_metadata_len(req, len))
+		return ERR_PTR(-EINVAL);
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto out;

