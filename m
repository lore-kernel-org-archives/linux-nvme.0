Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B92BC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 23:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E1F61185
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 23:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E1F61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HB7g03SVziwESUCVYaUjE8tHBTFfXPB6e3gyaHPj1aM=; b=FaKDXyy7ZogCHq67J1Rmeo9GA7
	9mMJ2BZLE66nacuvjNLXIJp7mXPRAI+kVyFZSY0MDkGOu8ACguoOHQDrwR1BNF1IWUprGEHtNrk9u
	55l/jexesBZQWqo0HUVRFxhJVPH+pVrmScifA0zfc0mSxi9+b8qzf5KvhjzxgHU6v0LaEsqQDopAZ
	q+6lP/vaqphHV8Npz6OLUjhEydqfgE70u4RFOfh7DnhhWyGo6zA3aMCwbrz730kEhJZQK00I1ha8C
	mjokC2ZUx5glPI9Hp3gMQc87MMYgcCHY2HBnGnde0XfaJ/64xwpmClX4Zb1ArTbs39iTZPkLCG+Jp
	QB8PwRog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqlJh-00AlnD-3Z; Tue, 08 Jun 2021 23:39:29 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqlJe-00Almq-Uh
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 23:39:28 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 3-20020a05600c0243b029019f2f9b2b8aso2990388wmj.2
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 16:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RnJ7pXM/OyaL8if4OKFrVjjYGY6Q450QrULoPKinDaQ=;
 b=FB5xiE1JbhDDl00OTIKOpQvOyoaG24MFf129ZgkC0GTLemb/Fb2A7j7vnO8m9tuNCh
 bIyNFt4D4m8zkD6rrAdTTOOpRd/25rp/0jTJ6b2CB8eVqNIOb+urw/wLOWVBngMca5D+
 40gRuhSDANgFxcWZWGDbS9LycmJAdmpjbCo+8aRkpI7s7M/NEh/jnNf76jyiaV9E+fbg
 qZv1FaYgEGzj4Uil4xeDhrvCNbHlFXLCoey2LUmRTuCHRqpRkyfoSG0E3fPYZmwxHBVA
 GIAcdN0trZC3og96CsekdCmteCluVpuKF97Xs/9K5IaDiSyHeluosLpMP0EhJ9K5Yypa
 HLfw==
X-Gm-Message-State: AOAM532vTZlDKzs/RSeY2WhCdDd1H8kfPmrNQKRVozb9OdNuxO8/QwCP
 0QVy3Zq0IIxayb9mmMA0Bw6cCpCwhxI=
X-Google-Smtp-Source: ABdhPJwOhR86LlvyTGgHOJD3rvOjECR2YIyssTAy+VrahR5W2zR72SJD+L7SDGNd0eyYdSF2Wbf+zQ==
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr6740467wmb.57.1623195565470; 
 Tue, 08 Jun 2021 16:39:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:12a9:2416:ca98:264f?
 ([2601:647:4802:9070:12a9:2416:ca98:264f])
 by smtp.gmail.com with ESMTPSA id z3sm22831103wrl.13.2021.06.08.16.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 16:39:25 -0700 (PDT)
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
Date: Tue, 8 Jun 2021 16:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_163927_025697_2D4C6193 
X-CRM114-Status: GOOD (  13.87  )
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> 
> A correction to the below analysis:
> It seems like sock->sk is NULL and not queue->sock
> 
> As part of _nvme_tcp_stop_queue
> kernel_sock_shutdown and nvme_tcp_restore_sock_calls are being called:
> kernel_sock_shutdown leads to nvme_tcp_state_change which will trigger err_work (nvme_tcp_error_recovery_work)
> 
> As part of nvme_tcp_error_recovery_work, nvme_tcp_free_queue is being called which releases the socket (sock_release)
> 
> In our case, based on the below bt:
> nvme_tcp_error_recovery_work is being triggered (and so sock_release) before nvme_tcp_restore_sock_calls , which end up with NULL dereference pointer at 'rwlock_t sk_callback_lock' ?
> 
> Can you please review and provide your inputs for this potential race ?

Seems that RH8.3 is missing the mutex protection on nvme_tcp_stop_queue.
I'm assuming it doesn't happen upstream?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
