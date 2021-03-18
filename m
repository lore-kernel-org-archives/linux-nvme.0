Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E60C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 02:01:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4516364E4D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 02:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4516364E4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p0S0OTdKW/OBMa5+arQkEUnY/eVdqHaCF1MGTcVQ4gM=; b=j0U5+EE46u0zaDgkXWnUWFxwn
	BPvroMW2SzTyVEYbbWfyqFXFfNNUiYSOLHBMy6OIZ5RmodzI9/igvGiXDB7FJvXzRkcPTq9DVQr+l
	XXtYSk9GhPDdv9z8xBSl7mkYpYrNBijnynaNQAPU2KisjHZJvm7hNoXfuVNT4fXALdJFpHufr/oiu
	9dy2yGvmf0zUwHG54S/3woA1VtrpUxkoUJhBfQ0t0fP1g64rFKB/cRmyV8DYkm5dA1DUg46RM2bZC
	pBlp7uqYFjaSjxT6WOqXWSWqWjIG1I3Hy6esro/rpSM1Gelr72JF1SCjLTbqYy3B2aqXgeGqyhLEs
	s/cvrRwJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMhy1-004Gp9-NZ; Thu, 18 Mar 2021 02:00:53 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMhxh-004Go5-B8
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 02:00:35 +0000
Received: by mail-pj1-x1032.google.com with SMTP id s21so2098445pjq.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ODoKXUhtutfeJykh+BdqA+UVUCvqefCNEQIF4EvxaU8=;
 b=mE4Ubp3MpXzQsFwcSzRv584+sa6h/n1j5f4GOFGMVypBIjT1S29vg0HGFaeg2kBvT7
 SOJAVfE809dgVGOPJAXNWQxPXfLcguCGGvTWZX6kHxYqlTpHPs2xdmGwAj82YUWkqJRF
 +Wvd4x7KGUH1ngwcZPjUi9TE7HF3agfMi07TtgfF6CnqLQK5k3yuqjmKP1oI80E8X5+e
 RqRilotBig6t0PGG5fOmAPpgO9e3nEd02sAhyzIXEIfqa1qne8XaN+XUyP+2C9ZjehL4
 XcfJcTZ5yinl7Fnaq7wnGtzhRJCrfQj+5DfIa3nX7f4z1+NELVxKFUJAce7GNA0MbXJm
 ycEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ODoKXUhtutfeJykh+BdqA+UVUCvqefCNEQIF4EvxaU8=;
 b=JSg/kkhvDNLnb2MGqiboBtqTqIBRXL/KeHzA8lGweUvupKi9hbNq7T6HdZqvfIgGHt
 L/IlnRVmd27movniUdjmlFUwnqFDnSoq4dJnI/TMqKOCiATSe1w1l02gpTpJZJHMZ5yd
 21odsqaUjIzNd09WawkCNeYxq1hUnXgwLGmuAp7RobELQwXqhb/qG2DN9I1yH65KqBif
 to9NAUM1eauoMPy5ZE0CclvC6OofGpaBG7tkRNHA2/YpjlLpHwuqvj6b5eU61dyLtDN9
 HFjIXHEI5HQAurT2RVfOMToyFFxU6oTzbtgZNzlATvY8O0ss7/etrjjuLdhlu5j30V8S
 BMyg==
X-Gm-Message-State: AOAM533J6Zz9oPH0UaL3p0c/uHMJ3SClMFNXpKgCCmq9aUakChjOT4Uq
 eBBHfTVYH+p7nIHM1XGkvlkBY8sp3cy6Fg==
X-Google-Smtp-Source: ABdhPJz3NrqRki3QqGC9Lwg5IT5h+zzCgx3dTbjFVSoL7CR663DrdFtPHPdzCgSLl8AIpeKRhqMpAQ==
X-Received: by 2002:a17:90a:a513:: with SMTP id
 a19mr1857100pjq.210.1616032831765; 
 Wed, 17 Mar 2021 19:00:31 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id 143sm338752pfx.144.2021.03.17.19.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 19:00:31 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] nvme driver pdu enhancements for passthrough
To: Keith Busch <kbusch@kernel.org>, joshi.k@samsung.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20210317203703.17391-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8a7b7a34-0001-c470-7c11-a15df71f4d89@kernel.dk>
Date: Wed, 17 Mar 2021 20:00:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317203703.17391-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_020033_632786_7024D031 
X-CRM114-Status: GOOD (  12.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 2:37 PM, Keith Busch wrote:
> v1->v2:
> 
>   Improved change logs, added reviews.
> 
>   Retain clearing SGL in passthrough commands (hch)
> 
>   Added a comment explaining why REQ_OP_DRV_IN/OUT is a no-op for
>   nvme_setup_cmd()
> 
> Keith Busch (2):
>   nvme-pci: allocate nvme_command within driver pdu
>   nvme: use driver pdu command for passthrough
> 
>  drivers/nvme/host/core.c   | 23 ++++++++++-------------
>  drivers/nvme/host/fc.c     |  5 ++---
>  drivers/nvme/host/nvme.h   |  3 +--
>  drivers/nvme/host/pci.c    | 12 +++++++-----
>  drivers/nvme/host/rdma.c   |  5 +++--
>  drivers/nvme/host/tcp.c    |  5 ++++-
>  drivers/nvme/target/loop.c |  4 +++-
>  7 files changed, 30 insertions(+), 27 deletions(-)

These are both nice.

Reviewed-by: Jens Axboe <axboe@kernel.dk>


-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
