Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D21C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:07:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B24214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jw6A5ucI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B24214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F//pNS0tB3XyQVTRu0pXZMtvib+Zj+fZuyVwk48JI/c=; b=jw6A5ucIRook5WbPvjE27VKqA
	muy12KPgwgE27rcgSDaj94dcFXMhUi8thlxXU2RWtxfKKLt4KHTrUtJKqdBqb3re3q8P4JzWxoHZe
	188ad1w10fmXhN0LzXuXISd0VuWVHXb2Owm4rio6ChsHtLKw2R9erbLtBsTJ/YjnvB0SyKFqLN0y4
	CUF3QG7Z6ARCUYEfN0q5FsuRJkpdz4co+JyxU1LJ6/cHzRIAqGWKKztbRGW8pD+h5uZciDKmHLR0A
	o66vlINvAn5rmUE6iqp2vpSqv+sbDRUwG0eQDt/wQIcK5TcSTIID1CHhHIC8bjYM/xsZIKkpWwOXn
	NGGB+CUBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCpDO-00018k-Eo; Tue, 24 Sep 2019 18:07:06 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCpC4-0000uL-Kc
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 18:06:07 +0000
Received: by mail-wm1-f45.google.com with SMTP id y135so2157235wmc.1
 for <linux-nvme@lists.infradead.org>; Tue, 24 Sep 2019 11:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eoMKHj//ONDW1S1NMnFnwPq2ttmM7DvL+iTlG4Z3yag=;
 b=TEH6EgF9dsNGnHjS92mwQHv3XN6YaAgOsonR+T6MpEoGWR78Tgq3BtJCK+EZBGnS8F
 zYDYQgWqreo6QlDRSK/35L8ugYEnYg4612UfGld0wMC6qFSgXIP3kYF0iuQxCSfaG8W3
 Vdi0RxDiO0NXnggn4cj/UjTLWP13MgMH+4dLdt4CSdOm29xnZHUj0z906dBIbDoDEeC0
 gOamsyhvNpYz0aWtQ12lhusyInEisO+PZiGRfRzsOM1VUr+AkzQCsNSazytpzJNwrAGz
 Fj+OaPMWmG4iSRXiuvdag0H/rLYqty3RSEaXYAKq5mFQTIwWMeEpP2mNPVYhx9GyQyQH
 hb8w==
X-Gm-Message-State: APjAAAWp7MyLJ+hnzBTQab2iy7THDa2TbMu8dQii8Vhj20TlyGnhui/U
 ax9mWxn1GScY47ErlyuSqf0=
X-Google-Smtp-Source: APXvYqx2gIZsA+0WBXME1MOWCslOJYjqVk5Ti5jwdHHfsJvrML+LnKJ29/yWryQj42KGIUeSDEAb7w==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr1529049wmk.30.1569348341388; 
 Tue, 24 Sep 2019 11:05:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id b22sm953231wmj.36.2019.09.24.11.05.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 11:05:40 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: allow 64-bit results in passthru commands
To: Marta Rybczynska <mrybczyn@kalray.eu>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
Date: Tue, 24 Sep 2019 11:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_110550_701982_C2AA5E9A 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Keith, Christoph?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
