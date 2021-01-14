Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9FCC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:11:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8F5235FA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8F5235FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jkPCq6TePBTPByhHVlCvQUtncZPHzqoQnr8z1Tfl/oU=; b=X9gaHHN5kSNkYeeBNw6/6hv3Z
	JpxIwcox/kip6Ff080q4h8vk6Zny1RNHAWyJTy1zPx5nxYwqYLFF+4vSKejA/Aj5lAvWWSIhYt0NN
	0daAHaXE27YqwfHOzlrbF+cbyd5QCo47c0O0w5NmWYiqMdY6sLgOEN0KP9qAARm4GQI0j9/se2nJH
	qM1uF3fbDD1shRn6n3e49IBhJRA2iuLV8suV2bXAiyXjF229QKBzCKWYjw0yGhk4FcAbdc95VO2Bm
	6VSw5LIjeM38wG/gjI40tnIPf9dmIk0nngt59DYrUcNBjcerbguxP9VOZuUmi5HL/R5CHET+fdSNf
	THmyr3u3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzt2U-0002G9-DI; Thu, 14 Jan 2021 03:11:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzt2S-0002FV-Bv
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:11:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0786E235FA;
 Thu, 14 Jan 2021 03:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610593865;
 bh=uLHWQbuedDPcaHc2U2TMoOhpzmQvHbXgND2Q7kYmujY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jsjK+hr2Qz0gSgcjcginvUyYhsnPKCUl8ntTtY6+gMULWhZkgml/lZxy7LPfHyM9u
 XRlgMfxGwD3KUcLCnR5nG5piNSSjg3nAkrfRz/3n6985XakXDCPso5fvBQZ7LyxHec
 7VrkcALdBLvsgkZbqtF9sWRL5UfFO0edFSEWZ6GD2t4uA8AgKl9XP4w3mEYqD6egfh
 REC1EJxrmsfD5KGVnTMc6Cd1todd5YZXttSyCcBXDj0q4gbLq4oM7sARgxyvbIqI3T
 hgv+mMJAdkRstNxHGjMxBbIlrdIAKc2c1DMtBVduXDrWQf+O41lUS/8ifQYrWYxMzr
 eCyZ/lyl9f2Mg==
Date: Wed, 13 Jan 2021 19:11:02 -0800
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
Message-ID: <20210114031102.GA1509941@dhcp-10-100-145-180.wdc.com>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210113143538.554-3-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_221108_492700_D9E98EB1 
X-CRM114-Status: GOOD (  11.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 11:35:38PM +0900, Minwoo Im wrote:
> @@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  			return COMPLETE;
>  	}
>  
> +	if (nvme_req(req)->ctrl->acre) {
> +		if (!nvme_is_path_error(nvme_req(req)->status) &&
> +				!blk_queue_dying(req->q))
> +			return RETRY;
> +	} else if (blk_noretry_request(req))
> +		return COMPLETE;
> +
>  	return RETRY;
>  }

This is returning RETRY for path related errors when blk_notry_request()
is true. That will deadlock initialization on a command timeout. The
check should be something like this:

	if (nvme_req(req)->ctrl->acre &&
	    !nvme_is_path_error(nvme_req(req)->status) &&
	    !blk_queue_dying(req->q))
		return RETRY;
	else if (blk_noretry_request(req))
		return COMPLETE;



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
