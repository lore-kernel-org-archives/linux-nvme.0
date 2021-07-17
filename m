Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8178C636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BF9613C4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 06:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BF9613C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rpAswAQxGINoaR4O1XqlLbebQyScdaiGhbEsEBijew=; b=QRcMczI5l+DuICOlQGOphSB9Uj
	q3DyOSa8xz3BdIarz9UiE3msgGsslIsrLwZsS/MPDXmDe1w/0sW5RbDO2V2P5Di1mSPPMriVLca3r
	mYTa3h721/bemZriRLI4NAUauqtMjsw0MhCFYdn/kIKW2hvyPympO3V4gEWNe46BNHbiNu6/PXS6z
	/96pjnSMh8uiy220G4lgwhIwIM7iqGEkOCSxdofT+LVRh8PvL6YO41rAfq/RzttdUPGTyEhE61CCF
	JqXBGr5mBDrezpdLSdnCLVvRLqvQx9HF0noiAd+2yz0q5TBKYqXNWuYYS6pqqZAEHcWZN5GP0Xghr
	1+92o9Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4dVJ-00622X-Oe; Sat, 17 Jul 2021 06:08:49 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4dVG-00621z-QW
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 06:08:48 +0000
Received: by mail-pg1-f172.google.com with SMTP id y4so12112752pgl.10
 for <linux-nvme@lists.infradead.org>; Fri, 16 Jul 2021 23:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7bkGk4qd8BNFUCpN1SnNG/l355L+MGvYUKumYDjE4Nc=;
 b=f8B/+5jot960M99CvgFiLNbRw7mUECMzQzO9E0sJ73uRNHxoMPVn1MwF2pw3QNGbeN
 Am4uUrg9mFL8pHYG4uyQNnthZY8tc6dHjnmKeNMPzG90BDewGxZUivk6miA/pvMgHnar
 7PBkNf/teJYbeCdwsVNgv7kUXySWPIr1m1a2P+opCmxLT19Vcz4GcS5A6BjvibZIm2g+
 2ujx7uNQ2CWfOZtIMMZvCzexuft3oDkmfH3uAabXI35fVQiAdN4seiwoPibCY17ra69c
 zeFe473MVa9cdaEkMRXtlQF5kkGWQ3dEzel0qLgHZKdW6bq/5IiTb8qZ9ynTuJHXvsoS
 qjhQ==
X-Gm-Message-State: AOAM532Eo7Fgce5KctKQefk1Uf+e9IfRmLejrKTU1Bc0CdPl0jgjPLg8
 2hecrEAA5VSHdL+7t8gM0kc=
X-Google-Smtp-Source: ABdhPJzCaMC36xCcGaYRuo2yGZ1H6SVDV4ieMjYhkrLdDl/e4oTd6GzAYgTfBv1b1uPa+P+dmiZdLQ==
X-Received: by 2002:a63:5b51:: with SMTP id l17mr13439310pgm.408.1626502125967; 
 Fri, 16 Jul 2021 23:08:45 -0700 (PDT)
Received: from [10.0.0.146] ([162.211.128.122])
 by smtp.gmail.com with ESMTPSA id u6sm11996770pfn.31.2021.07.16.23.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 23:08:45 -0700 (PDT)
Subject: Re: [PATCH 02/11] crypto: add crypto_has_kpp()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f587a3f7-c516-9461-7cf9-2873fdb28029@grimberg.me>
Date: Fri, 16 Jul 2021 23:08:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716110428.9727-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_230846_927494_EB9D9323 
X-CRM114-Status: UNSURE (   8.77  )
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

> Add helper function to determine if a given key-agreement protocol primitive is supported.

Same comment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
