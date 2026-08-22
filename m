Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB0C5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iW/Ek6Y2MPl84IGt7gfwNPvcZhF260WSBSWevUoFsBo=; b=U5QnyvKKXcT5LfpQsV/PKXYHLf
	+EbpMBcObXcNd82rWCPr76KvMh0q+QlvumZR8+J8kf6nQACw+50mE8gOGu2jKvxK8tud3egMi81PH
	4vzkv1Kitn9fFNzQcMyOuwJq1gKDeh0UgEFMEXk16TGbBNZODEsJlaCwckIsi//qa/h1DlUHxXt8E
	yfTLRUvWYxJVCZ0iqeUdEYvqkA61nSLA3vj9ZdtMAc+HgDVoRUDeLQjzfCL6g1794kY8oVJnbZXD5
	ziH3r17y71rwoKo1sDBHC+pOlx+RyrqcaXvQbwiHJ6Qkd4kv8K12Hp4s8M6cfGNK3Ydc2r3YdsKU4
	uR93wylA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxteJ-0000000EpGx-3N83;
	Sat, 22 Aug 2026 21:53:11 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxteH-0000000EpGc-1ZI3
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:53:10 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3897497a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787435587; x=1788040387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW/Ek6Y2MPl84IGt7gfwNPvcZhF260WSBSWevUoFsBo=;
        b=MFaJoTeiAW4i97j0PxTbyRLMti07UclaH6vXs/FdqojwQBNj++irjXWzitF4xQghk0
         c3mpeLq//svOGsOsVOnh4nxNINCilF+EVxyQw/9QJWhycFOxLyHrZawL9gvAykApD4qb
         BWjpU8h8f3HN2cGC2mM/jwfatRiwbC9+sYXQzKgPlhtqYmzagNm23TNQyIcJwSt9wdPG
         nvt6JXU1pcPZ2/NB5maOC+fosYyBHAKCioIpg6BIYAhzDQ57C8HjbjYl1KxSIpjScenm
         s7Zwx3av/b9Dyb3WqUL4FV8mpZh5QL2QOFoSwf6YCBdCflagks0bTVDBWExB9LRmNUp3
         nFBw==
X-Gm-Message-State: AFuF++l8Ce28nnozd1Qpeakw0W4N2eiUp7H3KcFgu8dEcut4Vg+3btGx
	jhMnw1VStLhsPIiSD68FwM7BcMNxXPnGK523Fr6QSURpyLMdR0MqO+0tRa75Dw==
X-Gm-Gg: AR+sD13A+qfq/ds3yvWlZEKGPnlJXopnfCOThY5FYJYfZzmdunU0u6PpdDzk2TYjdeV
	+C3LgSDeC+TMpfH1JQuDD7+Ry7H3LLcMMptv7klzXSIf0cLUvfZOM/+4hcWZr0iTojndHBFN4Nj
	+PklDIJ5yjaL/YQruv0ZS6uYoOxYAAmbcDXksypO7SO3UlSLWYOZ+QyiYbxyC3lImdESZGpEmnE
	kzcMTQ+V2ki05DhEPA/JqS7SATjwbLW3ABffZExDfEH39ND35y868wX3Nq+GoYOVyTxbojGCI+p
	qQxfNAVbMdRnwlpCRSLkhlX65k/4wPXmXTlI/PTlsg2nj81V08lKoal6dFo3BQsPm7r+YR0JL4Z
	1ThHmMPnMIBtmvItcfEb/QjuQaiAtub+u9ha7bXKqPKO+MZqdDqjJMKrdw48JCICXGKBVoY+Jql
	QhyxBcWQHtdv9TcLabAfN+PRi1ljkS1jr5EssbUYrjFlC+Ckg3fbcA8sdsxS8MNpW6uLQsLKZTo
	srjdEn6o/AXYUcha+KY0VoVW4z85sjO7A==
X-Received: by 2002:a05:6402:a50a:10b0:6a4:cc9:e32b with SMTP id 4fb4d7f45d1cf-6a582b608b0mr5720111a12.9.1787435586932;
        Sat, 22 Aug 2026 14:53:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff170601sm13411347a12.25.2026.08.22.14.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:53:06 -0700 (PDT)
Message-ID: <4aa2e0d5-e519-4125-b537-e4b035d07847@grimberg.me>
Date: Sun, 23 Aug 2026 00:53:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvmet: passthru: use Invalid Field, not Invalid
 Opcode, for unhandled Get/Set Features FIDs
To: Marko Ahvenainen <marko.ahvenainen@helsinkimemorytech.com>,
 "hch@lst.de" <hch@lst.de>, "kch@nvidia.com" <kch@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <IA4P221MB1623401F07A6952EFC9895FDF4A32@IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <IA4P221MB1623401F07A6952EFC9895FDF4A32@IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_145309_477958_2BAE11C5 
X-CRM114-Status: GOOD (  27.72  )
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

Hey Marko,

> Hello all,
>
> My first kernel patch, be gentle ;)
>
> nvmet_passthru_get_set_features() rejects any FID that reaches its
> default case - whether intentionally blocked (IRQ_COALESCE,
> IRQ_CONFIG, HOST_MEM_BUF, SW_PROGRESS, RESV_MASK, RESV_PERSIST) or
> simply unlisted (e.g. FID 0, unassigned by the spec) - with
> NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR. That's the wrong class: the
> Get/Set Features opcode is always valid here, it's the FID that's
> rejected, so NVME_SC_INVALID_FIELD is correct.
>
> This surfaced while debugging why nvme-cli's "dump all known
> features" mode (get-feature -f 0) completes against a native
> controller but aborts over nvmet passthru: natively, FID 0 gets a
> plain Invalid Field rejection (no DNR) that nvme-cli tolerates and
> continues past; nvmet's Invalid Opcode + DNR is not tolerated the
> same way.
>
> Verified with this fix applied: get-feature -f 0 now enumerates every
> FID over nvmet passthru (NVMe/TCP) without aborting early. The DNR
> flag was not the obstacle - only the status class was.
>
> This is a status-code fix only, not a policy change: Get/Set Features
> FIDs are still intercepted at more than one layer before reaching
> this function (nvmet_parse_admin_cmd()/nvmet_parse_passthru_admin_cmd()
> already service ASYNC_EVENT, KATO, NUM_QUEUES, HOST_ID and FDP with
> nvmet's own emulation), so native and passthru queries still won't
> return identical results for every FID - only this early-abort
> failure mode is fixed. I'd rather leave any broader forwarding-policy
> change to a separate discussion.
>
> Unrelated aside noticed while reading this code: the
> NVME_FEAT_ASYNC_EVENT case (and propably some other) inside this
> function is dead code, since the callers above already intercept
> that FID before it can be reached.
>
> Signed-off-by: Marko Ahvenainen <marko.ahvenainen@helsinkimemorytech.com>
> ---
>   drivers/nvme/target/passthru.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index e27f84e3cf2b..df1396081f87 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -483,7 +483,7 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)
>          case NVME_FEAT_RESV_PERSIST:
>                  /* No reservations, see nvmet_parse_passthru_io_cmd() */
>          default:
> -               return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
> +               return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

I think you want to set the error_loc such that it can be viewed from 
the error log page.

>          }
>   }
>
> --
> 2.43.0

You should make it a proper (non-rfc) patch and send it.
The below should be removed from the actual submission.

>
> This e-mail and any attachments may contain privileged or confidential information and is for the sole use of the intended recipient(s). Any unauthorized use or disclosure of this communication is prohibited. If you believe that you have received this e-mail in error, please notify the sender immediately and destroy all copies.


