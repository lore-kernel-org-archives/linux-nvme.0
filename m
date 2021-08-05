Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E69C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203FD61004
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 06:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 203FD61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cdXBE1dhnz//lSxfF+iaN32G8vtbecCtUsqspYbpU7c=; b=jnG1VJJ43cfBra2wfxKAvuFejE
	CWG6FFmObAYbnAVTVGHllSyeSOarwzdzbkuRb9MDP5b3JliVkeGaiQEzD81qznG6WuSOIrkBDynDe
	g02sx+scGFUGGjjv94FWTKvrvYZsku7IDSrrlb0t3mAYs8PNjDur5H68xLQc4sHUWTDNYLqCQ91+b
	8HWIqSFeF1SkIzjZpiy4nF5Cq7byWAzEXYXSCr3LpjdzBvlosfkJOI7KdLDSVGDceYyPb9kFgPHYt
	z5xoftFRyfX08kd0ItkTF9ZXga/mLTSnf3CcizG9YBf8BEM3gKGlt/XZJGB6XSR1ysPl7HEwG1LLn
	IXiBTvrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBWiO-008DXJ-Mr; Thu, 05 Aug 2021 06:18:48 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBWiL-008DVS-MD
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 06:18:46 +0000
Received: by mail-pj1-x1034.google.com with SMTP id
 pj14-20020a17090b4f4eb029017786cf98f9so7123540pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 04 Aug 2021 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ocYl0lCYl+j1GcrIfp9er+irTI4CSJ7rYdDh5XPObFI=;
 b=WvGiPCGmVtjQw0hDt4ZAF2/3bbazcUWrFeITM4bMhidFqFIDpHMSt0CiU48efWfe0x
 6LAvPkz/XMWYeIuCRsmKsGTEsb0gHtAooHycwKNp6qofLj6aI5XiMr6KDFVGa3AcqEWv
 01LOZOLI3Wqx8Ifw8LejVJwUmx3txXPYRyw59NzVpnUGv7mgWp/33zCgM9Ehj7Acp1k/
 I1hCk10cmBwVovvrz6ITbYt5BYTZOmKTcqZHmk2zSvAUmw6m9B4r3kujYA5/SUerjl/R
 QSFFsw2wjuVVNjk9rNIji8+gEhOHTVTbRqkS62r4bbjV7sfW66o7Lcs1sjqaJtVLSCvA
 RlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ocYl0lCYl+j1GcrIfp9er+irTI4CSJ7rYdDh5XPObFI=;
 b=OJzE2J9WcGV0xrzKBrbeykOzHGj8I+zeq/E49mzXaDGU1CFc7STfWIQXYs3PTfghO4
 C23rVbMbkfIiUe8Ih6sjJhlVnanmbuuSwWHX3crbrvpxKp7S/mvQ+bcUjLRvQFfjWWXJ
 KVxKE8rTD5KqUH3P17WGecrM3n5rzCFvWwdz13cf/9GWH6aIBXcpy6Wat9bkwm+20JPn
 0TzDHB38TNJ2VLXxIS5+XJFo4KuYzCNQ3wfMbH68SUwZ2auwR+9ZI1ft5dM674xjsJ3V
 6EAMiDSs/6eDs5AbufUTrK20whAdaAX+R7vFoxOf3zOvptX+quJwKmlvztRaK5K6edVQ
 Qpiw==
X-Gm-Message-State: AOAM531I9Ojgekg0peIrwcGftR/DKQtcJWyLKSf2OPqTW3Ep7oLnkUpT
 60Sz6Zf75JYGtI4f6K/8LcFXCA/jGZZDgQ==
X-Google-Smtp-Source: ABdhPJyHd4QHSPwwXixlarmYZlg7H9dGPI6xfPhN8oSuPvejBwmxHCp7CquFb7MiVHKFJDgMC1gb/w==
X-Received: by 2002:a17:90a:4549:: with SMTP id
 r9mr3064036pjm.147.1628144322809; 
 Wed, 04 Aug 2021 23:18:42 -0700 (PDT)
Received: from [192.168.50.71] (ip70-175-137-120.oc.oc.cox.net.
 [70.175.137.120])
 by smtp.gmail.com with ESMTPSA id k4sm4450049pjs.55.2021.08.04.23.18.42
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 23:18:42 -0700 (PDT)
Subject: Re: [PATCH 10/15] sd: use bvec_virt
To: linux-nvme@lists.infradead.org
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-11-hch@lst.de>
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <68d900a7-deae-5924-0ed2-e112c3c026cb@gmail.com>
Date: Wed, 4 Aug 2021 23:18:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-11-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_231845_779986_93DE2E78 
X-CRM114-Status: UNSURE (   9.61  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/4/2021 2:56 AM, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
