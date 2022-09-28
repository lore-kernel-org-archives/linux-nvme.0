Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAB3C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/kQdzYFRHVocu5jgYOcurkfnMXluJDvXF/UrvXHxvY=; b=MaHLb1NKD8/B42iDlSHY5X3rTL
	uKD1BfXjaBIgFAtjr3EOmF1zgSLo+zDnn2f8ih6w53lp+LpJJRqduQJ8u82ylwPdXepeqFmOEpV1F
	pfqWeKCekxdYMJE6sxiUnJtYBKFXL9UKz+BQL7YB9qkMA9as4FIh3u3+hMjvPUkuWpCkLd8VJZycw
	dM/7UcBkz2Rk0rW/vGRNYPLNT14/bkgSzJ+IVvlVPSlTNoKfO9QGs/I2fpy8HWU3qIBib3LWk47lI
	3DFLAzLEhoEuOf4/Ye/p7PfeRf63Wlf1lXXfEG0UrfwXElfyuZF1W/OgdqOThR9boXvTrd6eAAt41
	B8N9rWtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbKx-00HUcp-7E; Wed, 28 Sep 2022 17:59:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odbKu-00HUbz-FB
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:59:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A3E768BEB; Wed, 28 Sep 2022 19:59:04 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:59:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 7/7] nvme: wire up fixed buffer support
 for nvme passthrough
Message-ID: <20220928175904.GA17899@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174642epcas5p1dafa31776d4eb8180e18f149ed25640c@epcas5p1.samsung.com> <20220927173610.7794-8-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-8-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_105908_676188_074080D8 
X-CRM114-Status: GOOD (  17.29  )
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

> -static int nvme_map_user_request(struct request *req, void __user *ubuffer,
> +static int nvme_map_user_request(struct request *req, u64 ubuffer,

The changes to pass ubuffer as an integer trip me up every time.
They are obviously fine as we do the pointer conversion less often,
but maybe they'd be easier to follow if split into a prep patch.

> +	bool fixedbufs = ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED);
>  
> -	if (!vec)
> -		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> -			GFP_KERNEL);
> -	else {
> +	if (vec) {

If we check IORING_URING_CMD_FIXED first this becomes a bit simpler,
and also works better with the block helper suggested earlier:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1a45246f0d7a8..f46142dcb8f1e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -94,34 +94,33 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
-	bool fixedbufs = ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED);
 
-	if (vec) {
-		struct iovec fast_iov[UIO_FASTIOV];
-		struct iovec *iov = fast_iov;
+	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		WARN_ON_ONCE(fixedbufs);
-		ret = import_iovec(rq_data_dir(req), nvme_to_user_ptr(ubuffer),
-				bufflen, UIO_FASTIOV, &iov, &iter);
+		if (WARN_ON_ONCE(vec))
+			return -EINVAL;
+		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
+				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
 			goto out;
-
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
-		kfree(iov);
-	} else if (fixedbufs) {
+	} else if (vec) {
+		struct iovec fast_iov[UIO_FASTIOV];
+		struct iovec *iov = fast_iov;
 		struct iov_iter iter;
 
-		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd);
+		ret = import_iovec(rq_data_dir(req), nvme_to_user_ptr(ubuffer),
+				bufflen, UIO_FASTIOV, &iov, &iter);
 		if (ret < 0)
 			goto out;
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
-	} else
+		kfree(iov);
+	} else {
 		ret = blk_rq_map_user(q, req, NULL,
-					nvme_to_user_ptr(ubuffer), bufflen,
-					GFP_KERNEL);
+				nvme_to_user_ptr(ubuffer), bufflen, GFP_KERNEL);
+	}
 	if (ret)
 		goto out;
 	bio = req->bio;

