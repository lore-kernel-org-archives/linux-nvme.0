Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F1C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D91224D4
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HJIhHc1X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVRuy/9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D91224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6G2PMe3gfVZ6986pOXMj+lJWE8oSblBThIF3Y2g4DXc=; b=HJIhHc1XUGHFJYhfCwsYIK0ov
	lo8Zi+gO+Rdu/CJUGJxcZLhD8DmjP2oez9iFUxKgYNkBvphTBRUp1WwJtwyKMQAFhMjZkH1Vjk4L7
	1aI+aeABYAu2S7rBci1nhS77BTmPmGKLjy8bSEaW8/lDyS0ZlzPanSM8hFOXBX/sDoOz+RyfDOwSi
	hXQIiv4x2fntcofDQL5fmr1scxCE75bvVEsNhzZCHJox8KQivYO0YQ3Kkh+HyyERGnkpvQiA4aB3N
	oB0al29QmdLJY41mznA0PYV58AbgPfYXIRR333SlDoEjDXJHsEMbPJ3wayBnPnrGqYyu04O4OsoPk
	CiUApEZow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIahc-0002sj-FP; Wed, 16 Sep 2020 16:54:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIahZ-0002rW-NM
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 16:54:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9762221F1;
 Wed, 16 Sep 2020 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600275276;
 bh=Ggu67kQ5Z6Y2gHRAwgKBqvNHtiu2B+7/8drm5WugluM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GVRuy/9TjeVkfwZYcbT1oCJkkYu7TBej+6nKXQPKxmKMxqFJOPxa88bFP+19ymmrj
 BSHB8MAMBhLTkjfpsB0sD20wGRZsKz3zj2biOWQFMxA4mHfLPCatUp+q9jZmf3SRVm
 8bt0/gIzYHAei9/QHb9+C/J2x0ZEfHpq1GjYWSOk=
Date: Wed, 16 Sep 2020 09:54:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916153648.5475-1-ztong0001@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_125437_835031_2228D658 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 16, 2020 at 11:36:49AM -0400, Tong Zhang wrote:
> @@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (!req)
> +		return;

As I mentioned before, blk_mq_tag_to_rq() returns NULL if the tag
exceeds the depth. We already verify the tag prior to calling this
function, so what's the real root cause for how we're winding up with
NULL here? I'm only asking this because it sounds like there's a bug
somewhere else and this change is masking over it.


>  	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>  	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
>  		nvme_pci_complete_rq(req);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
