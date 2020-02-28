Return-Path: <SRS0=58/p=4Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3720C3F2CD
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C59246A2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2020 20:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBEmm1Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C59246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gzpv0f74+5C7k1EgnhdfvyUDWZPXSFoKd9Ka5NYCFF8=; b=IBEmm1PlVsMP7ihfS/TwANnqL
	Hw8B05Xu2nHzdbZo/JDYZ4sMVVOyAG4t6PUt8aHdjX/i5U46LIjMFGPEKh0E6dbYGsbcUhk0uAKAy
	o9R8G/ase9cE1ELojv4Sl+qEsB1TW2RCFSER62xeXMtAQZ3Fgfl6E5H4Kg3ULsWEV5ywM3LCH91LM
	SPxJAemC0n4JOuPPg6b6oHDkVJsC6Z+AasjqYlFxO5FgLY6x6jTlcpvJV44jbLHTA4z4QIjOIa93y
	eoV59MgFHfSn0Rkpvi7ASN3RxOxP2MVG+8q72GWQqI30kKJqEhCbzOLtO5cTkSCBRt/qVhzDAo+xn
	jBAGS3p3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7mKK-0008H9-8O; Fri, 28 Feb 2020 20:33:40 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7mKA-00084u-FQ
 for linux-nvme@lists.infradead.org; Fri, 28 Feb 2020 20:33:31 +0000
Received: by mail-pf1-f193.google.com with SMTP id o24so2272281pfp.13
 for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2020 12:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2v8kaHriCobaBu2D3f8E6T6WtRsxKO9HwnU29aliHdg=;
 b=T9gFIvRef85Io0iNb8RvvvDrzbiaEo0SodiP7GU01jwoj1RxBwnPSy+apTONj4TFII
 g3ZVxDEpRlob4ZPKFVVOok3OG4Em175byTSPlMhIGtJvnJ9zlgmvS7ZA6gfyKFq7hDpf
 7w4SvcTgT7SjcTLTHdVAKVA5r5htU59idn2jZPWulKN2uPdNUwR2r51XEBdJ8DWrkeHe
 tnfV4w22hErZKEwx6sJZ2EOD2WDcP7ZveXMIcJUxZX9l7DxVA2p3ewNQ8xe+Hxew+HyE
 Ga5zsEsEXfhHcbxaITF7FAnGhv4NtMnMIKzcIkz+PY3nT82PEh138BfzMXt0QWn1zuDA
 m0sg==
X-Gm-Message-State: APjAAAWfL0KfIlNekqimhf4VtIt20//U9pV1UqshRbjVCuqzFMhCksie
 koaOHw140apKuQkHBhY4HEP/4N7y
X-Google-Smtp-Source: APXvYqynCbpOnJVjwQiJaLzeFDQD6Ii1PhKwRdxCeXH1rDtF1p33CZrfYTZg/PMle4BA/1CuXC00Vg==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr6509150pgd.382.1582922009141; 
 Fri, 28 Feb 2020 12:33:29 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d1b8:1f12:d98f:3f23?
 ([2601:647:4802:9070:d1b8:1f12:d98f:3f23])
 by smtp.gmail.com with ESMTPSA id 13sm11773415pfj.68.2020.02.28.12.33.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 12:33:28 -0800 (PST)
Subject: Re: [PATCH] nvmet: return Invalid Field error on set features cmd fid
 07h
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <20200228125214.100729-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6653e6ab-0fb4-7cb9-e759-eecaef4eddbd@grimberg.me>
Date: Fri, 28 Feb 2020 12:33:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228125214.100729-1-amit.engel@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_123330_519887_0382438B 
X-CRM114-Status: GOOD (  16.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Amit Engel <amit.engel@dell.com>
> 
> If the value specified in NCQR and NSQR fields (0's based) is 65,535
> the controller should return an error of Invalid field in command
> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 19f949570625..94b0ac923e99 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -733,6 +733,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
>   {
>   	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
>   	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> +	u16 ncqr = (cdw11 >> 16) & 0xffff;
> +	u16 nsqr = cdw11 & 0xffff;

I meant that here we only declare, assignment should go to where these
are used.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
