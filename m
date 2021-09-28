Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F49C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:51:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7B60F41
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41F7B60F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EqUqCgadc67NIJI1J/gNqcmx3S8I5VHtmOmPNSpEymo=; b=PjAeYRH35kk9cE
	UmcrZEHioTbzwycAJwvyzKFed+nk24O4FbYMG30Dha3Df3ZVwFGyCsE4A8aXrjWwkyHPU4ezdWfEF
	FZ5AMwlSdGjHVo3ooOyINVecxNbjU4j4qPoOw2PrneOrA2XHA2BwUakslN4hyoLjGcK6nFLZGgV2w
	YUh+DHq/ptjzbdGVrWHa7lXnBNsNWj3EJ6rREuTw6jk1ufyzSuTjSubQdUpL9dOA6tmjK2pnj3uPM
	PfaOZ6eOMy9U5guNeQphfTyTZrGphk4KJvqmHrLOufi3OEQk9B29RJt8gUvRB+Dit6/jW5KeRvvjf
	NGpcUSfbom7pGSqq63GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV3Dd-005Mrs-2t; Tue, 28 Sep 2021 02:51:45 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV3Da-005Mr5-7B
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 02:51:43 +0000
Received: by mail-ot1-x331.google.com with SMTP id
 o59-20020a9d2241000000b0054745f28c69so25091461ota.13
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WwkZMvqGRorLPbRNjL9plQGxD380m28koBpzzHspmLM=;
 b=W8CSHj0EPOssfGbZfZvmPF4josUPQeM0KOFddvCrdPmc5kC8nJK51YMBHCUrZI84ad
 xwB1XQT7JqLd6b7goPtYmVgilr0GEPi0ZhRK2EPkwX49hA77z2B5HfrBYbpc+DEUCdk4
 mkPFGUKnCxrSu1mKYWSct0cwtvv6ys0BK9MQUtyyOAdCTwM/dFcWqwFxhsr3dn2Auk2y
 G8g3bRY6vdJ4kDykCKssq2plUTwY7Co+u5rlJPVCXo0iuFHwlMZVr6RN1+KV/8S32hjW
 DMIjyXW+AMBHLxfQulmcVe0uxBe7a1IuzJ13/rG9gE6kUH/gXLTwEibGMYa25Y5p/NCr
 6pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WwkZMvqGRorLPbRNjL9plQGxD380m28koBpzzHspmLM=;
 b=ARWa879UmXP/mrHQI7CSPq6EyAu6LVjv13LAc6murQZ8leIr19VyRa062eb3pjW2l5
 Xn4g1kD5gn3AiKt3D1+au3MNLIMPiSdbKU/OSFZjVSjcAqPTTER4vtMengtFcfczm7yH
 QVKsVfUSMK/tCOxiVDK5IPc7SqWeRkLHaiddHakhnciiaCF551OWXOStM0rf1cC3QYUF
 aCFHCgp8CHrHnqrPnvKRljRFEy6vs0ORqM6rYoX5LT4t6H3yB3ffbFjo6RuG94+YGoMj
 q3/YG8vojaeZzmMfrDff4gwhEQ5yN/hepCJN2SgJGXY1nb0fUeIh5cGRhbHuPIXzzC7o
 Zrfg==
X-Gm-Message-State: AOAM532bz2UoTYLZyQMFGt0ASHd2HFri4PZ6P/9I4zYtYa4I86oI+ZJW
 zLTSCJtaaf1FRih9njoQS86LjaP9gIPyyVK7pLk=
X-Google-Smtp-Source: ABdhPJwwUMie5gQYRGKMvQnSiAKFHRtLB3v34FaQ47Csp7kwuTw8sAwE2B5PSAGds09H3bRV7tA/NRUbxIIWNH/+bdE=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr3067192otd.200.1632797500983; 
 Mon, 27 Sep 2021 19:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
 <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
From: Steven Seungcheol Lee <sc108.lee@gmail.com>
Date: Tue, 28 Sep 2021 11:51:30 +0900
Message-ID: <CAGrZSEw-YnoeJbt3_JQ6v81YWV6Lc3ao7eh8dNA0+aS8p7mWBw@mail.gmail.com>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_195142_286560_6C6FA26B 
X-CRM114-Status: GOOD (  13.25  )
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

I only mean lbaf, lbafe field.
other than lbaf, lbafe fields are not used.
I thought It would be nice to add other fields as well, since the
structure will be changed with lbaf, lbafe.
should I comment about other fields instead of just mentioning spec ?


>
> On Tue, Sep 28, 2021 at 11:19:40AM +0900, Steven Seungcheol Lee wrote:
> > @Keith Busch
> > As I mentioned on commit, Its already been used from kernel source.
>
> You are introducing new things with his patch. How is the kernel already
> using them before they exist?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
