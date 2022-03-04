Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D19C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0wUEO4kVWENooODa+WJepHIvAwejgm/gl13tWmbcUE=; b=EHAyICbadcVt/Ot8fd4KqlAv1Y
	rScYuB8LqJ9lml0WQAUOFnR3jwKz6JZcIiEKhFel0FFDTOtS+HSalBvqyxe+y44/gU8e+9wRYv1Lj
	5yVnWsnmYO8zPfTzaw6oLItbCDmW7MYMVs9SBwlKI6DLAoWjsFkWO8c1xS6A7RkRIm2GEZTpMydMg
	k8QDhGoZ1Heqy/0Teb/0daKDN9tJJ2ZVzPHbOCz+ghVdQPkyetFXTnFMzR7GtVIW0OLTSgy6H2nlk
	oBteN6b0CpX4bsi1M0cBKRReTiTYryK/yZHhCe4MRE4U28o2Hfpnr1kTcaSdXCWy73GYQPfJKodRC
	EP799RZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQDhO-00Bklw-L8; Fri, 04 Mar 2022 19:34:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQDhL-00Bkkz-AI
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 19:34:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D36EB619C4;
 Fri,  4 Mar 2022 19:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BADC340E9;
 Fri,  4 Mar 2022 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646422482;
 bh=nd2/3a4bfzST5ALw5Y8hQGVZfc4S2TZKpWT8b71rPp4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z7wp/FCwTTd2m1BAAR7vCpAG9vwx9PGz9UzbFd1PkImVy9MPDHh0sMCEGrwv46nTz
 mztVdpOSAa6BXG9ah+AlbZuh0dHCBhY8DEDZQSAae2M2VzQ+4UB7Pp7StXvoByovKW
 xV7g07LsQnKbSOFPNvsrgT2RsBKJG96tAFLBsNhQFo4RJbapEWKu86tK4ByyOGdRdO
 nvZDuu095RRK2ZawuGULjdUqdViPzucfbXLgCGQ7SRMmWSdbB4uIhbWvJvQG8UcGTn
 khiCmAr5lAFPj0BgHXNo283X0Er9oDdiSJPJmJEZ9NW6GE2qFW3YYNWWqQ2+f7utlY
 gdLXojztzHI6A==
Date: Fri, 4 Mar 2022 11:34:39 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Message-ID: <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
References: <20220304175556.407719-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175556.407719-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_113443_420313_7D5D0851 
X-CRM114-Status: GOOD (  14.40  )
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

On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
> -	ctrl->nssa = le16_to_cpu(s.nssa);
> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
> -		dev_info(ctrl->device, "too few streams (%u) available\n",
> -					ctrl->nssa);
> -		goto out_disable_stream;
> -	}

Just fyi, looks like the patch was built against an older version of the
driver, so it doesn't apply cleanly to nvme-5.18 at the above part.

Also please consider folding the following in this patch since it removes all
nr_streams use:

---
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 587d92df118b..1bed663322ee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,7 +280,6 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
-	u16 nr_streams;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
--

