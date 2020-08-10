Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD1AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:41:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4582E206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3DPvou/O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KM31fTLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4582E206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tfpPNtmfGSZEPWJD1fcT8glh+tZSWVMySgL4glPM81w=; b=3DPvou/OkcdvjtZainwhkR0VZ
	pNVWkwMyFrPWR/W8USDBBxRzd9Qdj2vsUnK7rqd4xM7Ofgj6MD9mNFpMYDTHG+O8ryWyTvowKDXII
	l8q0hAIeS9W5j1rnVn+m2NggF6fnVVNFesWFffCq/1H1AenKj01qRrz7A9+2dl9oP2yN5HaxfLrQX
	2UF8WndMDTVh/BAWeBlgzeA5fPmYW2X3xaCmoVsbEKuGZtvmeLvgKFqhed7N4xNpZh+L6N0J061G4
	W/13IDKtw7kmJsJdsp+OdpKHsBLMuQhD0k0vyyAOr8lM2Nagt/0nbR7uivxnR+2khye7wcWEwQZLR
	luiq+CBKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GTv-00052E-9C; Mon, 10 Aug 2020 22:41:27 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GTs-00051n-Sk
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RllGTVQ+hHEvv8y5aJjLwHHn+QM0MyQ7Z5nvp7EdcKU=; b=KM31fTLj/GWfV1mE+T1snx9jHW
 JsC7LlAM5PFPh/PhDXtOJzPpXKUVFS+qHEjZeMizn0pRC2aA4GeHx3h+C58TgiTicL2ZKJarDhhYg
 XFuSmlQ2g4mWFHG1jlSKbwmv4NMDG3uuQWtIbkX5x4o4VduyXd1juf5PT4M5qVYTNNRycYZqv49bH
 /XUoQwOyVYxOYar8thyPBOTerejKbru2QsTIVXtXg0/3HPQvcLEObT1soYfhlUsi3Y6I3cpZMGVeF
 04slMCMxgdUrg2UFb8rUGyi3a4XMQGaZv4VW7QdRXJ2P185sK0xPoae13TbeehccSGpfYdAR8QSk8
 8mHbX5JA==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5GTp-00017H-Vk; Mon, 10 Aug 2020 16:41:22 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-14-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <40106b8e-ad65-6f47-def3-eb3a08880eb0@deltatee.com>
Date: Mon, 10 Aug 2020 16:41:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-14-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 13/14] nvmet: use minimized version of blk_rq_append_bio
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_184124_964959_6B26BF40 
X-CRM114-Status: GOOD (  21.78  )
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
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> The function blk_rq_append_bio() is a genereric API written for all
> types driver (having bounce buffers) and different context (where
> request is already having a bio i.e. rq->bio != NULL).
> 
> It does mainly three things: calculating the segments, bounce queue and
> if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
> case.
> 
> The NVMe PCIe driver does not use the queue bounce mechanism. In order
> to find this out for each request processing in the passthru
> blk_rq_append_bio() does extra work in the fast path for each request.
> 
> When I ran I/Os with different block sizes on the passthru controller
> I found that we can reuse the req->sg_cnt instead of iterating over the
> bvecs to find out nr_segs in blk_rq_append_bio(). This calculation in
> blk_rq_append_bio() is a duplication of work given that we have the
> value in req->sg_cnt. (correct me here if I'm wrong).
> 
> With NVMe passthru request based driver we allocate fresh request each
> time, so every call to blk_rq_append_bio() rq->bio will be NULL i.e.
> we don't really need the second condition in the blk_rq_append_bio()
> and the resulting error condition in the caller of blk_rq_append_bio().
> 
> So for NVMeOF passthru driver recalculating the segments, bounce check
> and ll_back_merge_code is not needed such that we can get away with the
> minimal version of the blk_rq_append_bio() which removes the error check
> in the fast path along with extra variable in nvmet_passthru_map_sg().
> 
> This patch updates the nvmet_passthru_map_sg() such that it does only
> appending the bio to the request in the context of the NVMeOF Passthru
> driver. Following are perf numbers :-
> 
> With current implementation (blk_rq_append_bio()) :-
> ----------------------------------------------------
> +    5.80%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    4.88%     0.00%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    4.86%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    5.17%     0.00%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
> 
> With this patch :-
> ----------------------------------------------------
> +    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> +    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good to me. For this patch and the previous:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
