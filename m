Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE876C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:19:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAF661004
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FAF661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=67ymqalD8BqW9G5jMLGfJZmDc1bLyBCUACBN8EJR0t0=; b=nFyq7WdQ01S9Y/2C6lE7tbl2tM
	ZujJSstVg4ly9KkETcsYr9/sAbTfV0AMKdVQlaoI9tUn2ILgI4rhxByX+88CX/1nwjMBXhMYWFJ/W
	13bo61wgH9X2gE8h3NX+lGti8afBBK7BYeUeY+/6nmzRMWXdId3sAB/79Y7MGcSaQOvw3t8Fkh9kl
	5UNfHxsT/tWbSFLl3K3EK6gp76XM9sfCkH7pZd4ne0ktG+M9EcWgMYP2jyiUb+ZuHcYw4pOOLpuya
	AaF0znKCUnFCkfx7dR+8XSqvJYEu2h6MPGhqNuKXfmWYGrn7Te7oRb3o/i55papeafqRH8ofTWV0I
	JCSAuVHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBWiy-008Dje-7O; Thu, 05 Aug 2021 06:19:24 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBWiv-008DiD-9l; Thu, 05 Aug 2021 06:19:22 +0000
Received: by mail-pl1-x635.google.com with SMTP id u2so5816331plg.10;
 Wed, 04 Aug 2021 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GPxSQQeg/1xiiyvVf6IgyfR1PvTtE3HCXKKlX2KChmc=;
 b=V5w+ybPXrBNZFwHylRHg7rLTipyjlhw9ZDQ76A723nwt4KYZXnpCLhNt5qRXWJLnUz
 ns0pAxgoAX0FbczJG7KHplZcFTegN6qQUKWb/PSSmwZu/OvBw0aHUhbNf7soDCUxpQpu
 dJnsbdhyVy/Mey/zdLlAwQJ4qCmrYe/ZXqRSxEvP/islz8hze1WIb5AsmPhoG/k+6Pmx
 yliX/LegaE3ek+3cBL+qyZYBcYOdCC/tlouQBW3cUQiV/inabja4Uimyhv5d2PiBKLoY
 Q60AKN4ylBZpw4S84Bgk3HjSJ/J8cxSsTDaLqoZ3frHqIliZL+Y6mBTMfQcJvv5O6gyq
 yltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GPxSQQeg/1xiiyvVf6IgyfR1PvTtE3HCXKKlX2KChmc=;
 b=CQWe+w6lcwcWYUHvTjLRd4GxvPVrd5TdjmlU8wR2wGrwSye+M3B5wMpq7ehQbDwfDC
 X50aMLMiVzpXuGCPxWCbKybR5aifGfm1+E+OkUupefPhusvCKD5ZcbcnIczb3qu4HK+Q
 9lXLBiSKUmlt3VegBJ7GnrHXQAWPQHSQ4Vw/OzDSHOSQIMXnq7Y2VjgbJ/W4Bo/ITfL4
 MKx/n2IsGDhBY0V0IKydhYz4nhkt8z3JsxP6dpOBN5XM07KdNw7rYapahfJ1p7VSGyIb
 CmO7XgdY0rFfBa9+rK5lEtBm/d5dpNs4GXYrew6dfTFmRwwlu9xu9ZkDif/AlIbPAMwT
 Ppnw==
X-Gm-Message-State: AOAM531WwSQW23+AodyNZKc19umyEalKQUnpOx0YmIi7OX/VIdLQaqbx
 CaIYVTt35BHnhe5L/SVNpps=
X-Google-Smtp-Source: ABdhPJzeskio9QxTfARCpVMY2gidZf6SLUjVWuxeo150xpv+qmxRaymRfQR/fNIHsIoETSfCeZLEfQ==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id
 m12mr1622578pjd.107.1628144360352; 
 Wed, 04 Aug 2021 23:19:20 -0700 (PDT)
Received: from [192.168.50.71] (ip70-175-137-120.oc.oc.cox.net.
 [70.175.137.120])
 by smtp.gmail.com with ESMTPSA id k8sm4815975pfu.116.2021.08.04.23.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 23:19:20 -0700 (PDT)
Subject: Re: [PATCH 01/15] bvec: add a bvec_virt helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-2-hch@lst.de>
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <77fc6660-9c6a-0810-d04f-b6661fa0621b@gmail.com>
Date: Wed, 4 Aug 2021 23:19:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_231921_399562_E179F60A 
X-CRM114-Status: GOOD (  10.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/4/2021 2:56 AM, Christoph Hellwig wrote:
> Add a helper to get the virtual address for a bvec.  This avoids that
> all callers need to know about the page + offset representation.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@kernel.org>

-- 
-ck

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
