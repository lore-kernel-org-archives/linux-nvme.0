Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D62C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253A261004
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 20:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253A261004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3xz/1uhjJJZZVB0i6QUTlvvrhp6l56/lQsPHE1CuZGs=; b=yPSd8YrrRzMDlE4BL97Anpr4Jc
	DNa2yb5mI1w0ClwgOET+Q4KNgXdFfpCLJW2smBKpwIB1H7cizfqvgIr3kep13xlbeJOD3XmkKux3c
	kuEa85Sb9WDfELBCF1vApcFLEHTcYLYJ9MNpIfEu0/eDlnLsFSaic4NP2UGbLEWTPSltlmE7gwuK9
	+FHkYdUSl/JAlxJNF5blGKSG5KYSHlBBIL9jpzI9jfyEYYwsTCYyI8bn0+3MomPykR1UnOSAX57yQ
	C+PqwBczMHX18/3lwIHDXaHGHq9EuJOtPPW0/HmO3qHlIBJrFTtXe8+2yp3sRJVZqzDVxPx9SL/jt
	DaaJNLyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5wM4-00DraD-4O; Tue, 20 Jul 2021 20:28:40 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5wM0-00DrZ3-UM
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 20:28:38 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1M26iv-1m7s9U1YhV-002aGq; Tue, 20 Jul 2021 22:27:49 +0200
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-7-hare@suse.de>
From: Vladislav Bolkhovitin <vst@vlnb.net>
Message-ID: <2946f3ff-bfa5-2487-4d91-c5286e3a7189@vlnb.net>
Date: Tue, 20 Jul 2021 23:27:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-7-hare@suse.de>
Content-Language: en-US
X-Provags-ID: V03:K1:dV4jZRVKUd80jgKdUBVpml2f835ViidI6XcAZn8BhG3MNtWLP2Q
 f0nt3S6gKnEZywn1Q2PE04M5RZ4hU/RLIBKqBZCXo7U1F3Gi/gv50xCWOCOS/bZP7BApTkc
 G7TnqruzRNjD3dDL9DN3VGAjsL6WnHMb+BeNqjwKPjxu3VLsIv9KLABTVBMkiOeKKt1On0j
 DwvrM1+0f51OGxKS4g9xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/6Y1UxJomSU=:RyE9yXts4luQ9BIQMHPL8N
 P5Ku7iHEKWgWY8Bka+p86GcUcWxCnrlKJ9g7NaxEUf9tEOW8yGcM3z0H7tnVGaLIY6kPtwfEk
 RptMvMocpxI1pXCUAlyhrSFTZgbfErf+gTG0DumntrzUpDVb0NpfnBae/zoWWIvQjxF3W3PmB
 BD3zOW4dbhM79iZt9VSHGMMDtK12dTkR0sqQeQm59c6j+EzV9ngbMHmwiRezUJhZ2UGKHrwVf
 tUe7yc+m9gvz6fpZGeHcZKEL/uOttbGJUY0hzOdk+6Cw1qURKeDYH3ZpxPq6yeK/RBLHyeBuF
 NLqLTuZc6qjolJufzxGSMB5SheNrKZ3qftLZMhgJFJO5pZxC0fWZXQcu2YPB91DVzGBFBZh22
 SyVmMrCmvKCizsLMJ0RZVMu/Jq5jijvOe5ZbBtb/n3ZjoZTPXhIkOd4ZVane9pN4LFil+YSL0
 YKKQj0TJIwhGfOvULBv+YzVmU1zj9NYiWWoiBhjiLhYvyct6Q6/Yk1gjKRlDh8bQHPubv5P9b
 fjYxOkD+lCbNwSg3PNVUvIdwlNC1PoKrVUqqIuXIZWktKrFTJE+dmBiTKuNE9estkhCkOANff
 z7qMERmY2D0Ad5vpmFIg/SsD/TBeQ3k8kAQxtH5U7+REzvWMvhQ4VqUxqYFqIPIFfFsXCtet6
 WxQH/XgEAlF1JEs/DojmKgT7CueCXEp45ST8gJQJHH3Zd6xfKBwfcVkKpBpffwpU7HXjoU6IC
 mPtLmdITVqLAdA92lBY5DoBdr0sUpm8+bgeRo5MOdlah84btKZXjlSeCxwudMJd068SegzVgE
 PgsRiVK4U+e0rt9IjdWjMf8e9CxhF6ALZ6cShw0Byr91Dq/R9OtJKruGFS754hYtRhVc8e5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_132837_327232_6CBA8D73 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
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


On 7/16/21 2:04 PM, Hannes Reinecke wrote:

[...]

> +struct nvmet_dhchap_hash_map {
> +	int id;
> +	int hash_len;
> +	const char hmac[15];
> +	const char digest[15];
> +} hash_map[] = {
> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA256,
> +	 .hash_len = 32,
> +	 .hmac = "hmac(sha256)", .digest = "sha256" },
> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA384,
> +	 .hash_len = 48,
> +	 .hmac = "hmac(sha384)", .digest = "sha384" },
> +	{.id = NVME_AUTH_DHCHAP_HASH_SHA512,
> +	 .hash_len = 64,
> +	 .hmac = "hmac(sha512)", .digest = "sha512" },
> +};

"hmac()" is always here, so why not to just auto-generate hmac(sha512)
from sha512?

Vlad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
