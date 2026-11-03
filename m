Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D47606A31B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Dl6AoX5/;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GXioci0F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8Lmt44SSStVfy72XWkasOgo1SS8EQd0qTY1WU8nUAZs=; b=Dl6AoX5/KbDT+r
	lx3IvMATvodAJqHFjUtR7M3IPmu2yzbC1U7BdiAAtRYvLJu8U4MkgXDCszOEs+R45SGAKMR3BLGVi
	jajYAaHMecm3UDx+EjxQYRFjPFvtKwsMG0b8xz+0taJzJCzNKKzphNchjaUeTQiny3amMj5sNFHAa
	5E8OMco1L9kPrw0wrCLpwBk5GSx3Q/N/HQ/ChPIJIsWma0qQjiCLzxlKcNkHfrC+1/ODKLLgnaWMF
	5PIAj4z22hDZcdUOSS51SRyZtGyzbq9N82zHE0N0iKWWHbbgH9gJZrX8GkYy3dWk3ZndrOFGRLoZr
	dRwR4T79lrMLwAM8Z0OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKac-00000003a3m-0YR7;
	Tue, 03 Nov 2026 19:54:38 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKaa-00000003a3E-0a9I
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=8Lmt44SSStVfy72XWkasOgo1SS8EQd0qTY1WU8nUAZs=; t=1793735676; x=2109095676; 
	b=GXioci0FSlNgPabPOGiAW4zlbZ0qWWxNVaieyiiM+UDU2FjmVxjza4k4oz0V0c1hdU1Q7fn9pAE
	HQt/qeiBOVuyAGTxwLZ24RTPMdr414O25nwt5RrMlAGXLWY8ecoLDeQgHTWtuYUZrwww/v2Covub7
	QtGsU1yD88vnJnlfrH+HbdQWQ78b6JXlBAIkeD/E83ZnnQM0OuoIJAAAXero3glot8ZGq4TfONnnd
	erDJPclQTtmNHSd6f+eyTQRoOakoNJxaSdqMLHfQpeIH7d0ie+nKVCmYxmTqW+u6c8y6kq5gmsQKb
	4Oa7T/DcSwpHJQ21PBKUHB6fm8f3uKoJ/8tw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xOKaS-001YYN-7X; Tue, 03 Nov 2026 20:54:28 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xOKaR-0000000Ceu8-2RD1;
	Tue, 03 Nov 2026 20:54:28 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xOKaR-0000000EskH-1nSU;
	Tue, 03 Nov 2026 20:54:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 16:54:27 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
 kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
In-Reply-To: <auo5a1kRTSWsAYtF@kbusch-mbp>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp>
Message-ID: <352cfcec6865cbf636a22442511f16b1@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -2.4
X-Rspamd-Action: no action
X-Rspamd-Bar: --
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_115436_187323_0350A96B 
X-CRM114-Status: GOOD (  20.52  )
X-Spam-Score: -2.1 (--)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 
 Content preview:  On 2026-11-03 16:43, Keith Busch wrote: > On Tue, Nov 03,
   2026 at 04:18:25PM -0300, Mauricio Faria de Oliveira wrote: >> diff --git
   a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h >> index 2d8f6 [...]
    
 
 Content analysis details:   (-2.1 points, 5.0 required)
 
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.1 DKIM_VALID_AU          Message has a valid DKIM or DK signature from author's
                             domain
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
 -0.1 DKIM_VALID_EF          Message has a valid DKIM or DK signature from
                             envelope-from domain
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily valid
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.0 DMARC_PASS             DMARC pass policy
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 16:43, Keith Busch wrote:
> On Tue, Nov 03, 2026 at 04:18:25PM -0300, Mauricio Faria de Oliveira wrote:
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>  			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>>  		return NULL;
>>  	}
>> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
>> +		dev_err(nvme_req(rq)->ctrl->device,
>> +			"completion for request %#x not in flight\n", tag);
>> +		return NULL;
>> +	}
>>  	return rq;
>>  }
> 
> Is there something special about the NVMe protocol that makes this
> problem unique to it? If not, why doesn't this check go into the generic
> block layer instead?

Thanks for taking a look.

I noticed you asked the latter question in the previous
submission/review (Link: trailers), and addressed it in the commit
message; pasting it here for reference:

In Chao Shi's patch, there's been feedback/question of whether this
should
be done in blk-mq, as this is not specific to nvme. I'd say no, at
first:
- Some blk-mq calls for completion have no return value (e.g.,
completion
  on other CPUs), which suggests maybe an API change and updates to many
  callers, all for an edge case.
- An alternative available currently might be blk_mq_ops.complete(), but
  that is handled in the driver anyway, with risk of hitting an error in
  blk-mq (like this) as the code changes, and seems semantically wrong,
  i.e., completing a request that should not have been completed.
- Keeping in mind a small fix for stable, for now, should this be
merged.
- But happy to take suggestions if blk-mq is indeed the way to go.

For the former question, I'd imagine other block drivers might be
subject to a similar issue, under incorrect completions, and can take a
look at this later. I'd appreciate feedback on the points above before
trying to address it generically in the block layer, if at all possible.

cheers,

-- 
Mauricio

