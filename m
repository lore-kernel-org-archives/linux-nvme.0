Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CF5C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 03:19:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDD7206F0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 03:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gt6COpgJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNllCewC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDD7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3GbconONEH8Dxw2/pdUEdgtUn9sEh/oEsFkH2dvEsw=; b=gt6COpgJTEqq/lF5dZxsT7ZrCc
	7WaQ4oErOKphzWgjQAsIglRFqJnUF94533c0ryWcjEVqdzgPq5+c6UzQ0k8gyoQwEQFeB8oV/8hsc
	af+yJ2iDg+rtUlUqQgYCm0XA3tOmbbqMiGswwZsHX8tOKyM5Idj8DVZJRqVx+dP3CqU0ujIFfRDtW
	zxIzkoywkbqvP1eSkHbZulcIT5dzpylSN5+lktwJghHy6EH7SaxmLelvZqPoEx1/a+JFc1+Gmnhvn
	CA06iKBLESN+2YiFm8xr3stHrSLy4Y+7CXz1jpfAeyRXNvLPaYe1NvHFSbKeuQU5+pX1VUN0rqL1J
	kDG8eHGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAly3-0005ci-Jr; Wed, 26 Aug 2020 03:19:19 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAly1-0005cN-7t
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 03:19:17 +0000
Received: by mail-ot1-x333.google.com with SMTP id w10so403393oti.2
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=S/uO2JGEt6VlcwgweRTSgQUieeaEFDQRG1q4CYaSAeg=;
 b=tNllCewC+zb31nP1huKtZkuvu7oXQnkAImKMMvvFuJYQHZfrOOaHa0oR9NEmkTU8NS
 OCXKfq7yBYG9r3/JSFuldmmL8XObBT6AC/ExASNEmKVHMmX4h8X4phJ4EFb1S/sx8B4a
 907lF0iVk9Iejh73to4xEZ9hhVd++auIwjLwkCE6eoWNsh0JCQnZtV7scbT/wsxibGji
 G6KHmbtT6jviRt4sjTbIyL8FvvZl1WYIpWvZw9fHnijzulcXv9N21sDTGjzcML5WGQkq
 4RNqwtt04gIds8fzbOgEXbZK/PNI6HkfZQA1sWi374UAZDQDC4be6vlofYRqSuQABrsx
 6bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=S/uO2JGEt6VlcwgweRTSgQUieeaEFDQRG1q4CYaSAeg=;
 b=lWyIqFGPN9syvlf1vVifor7KeBEeGlR176YaiHD0IOUWPRNxOdackkNLmHz25/KpbG
 pHcX5MiG5TYR7Wt4MSi9bZsq+jCqK4wZT4qOZuI8+ITeax2qzm5lUP5As2R/FeqgVQvu
 185tyzp7RP7568CKttLc5KPxEfZhsBMXD6hErSUMCkiQmr73AurxF0se/OeDj5V9xWyu
 xdSmEymo7eShOlJK1xeaqXFrKjqf9WaDIomfI2lKvyHhWeeyhnsxBE3cunVR3ypRllNp
 RdcDJd892opV6hVLaf1iPEru7pbKd2Uc9dabB5jv6S7itb1LbfN0WAqA9k02T9yANbxM
 Y+2g==
X-Gm-Message-State: AOAM530YSHN2NcT0LfJmHSVaf7nU+ViiOHSEnVd4Gssjl0E3o5gbrZpR
 G3AqCNwLB/VI8wwIzL/JuVgJhYfptJ+z6u3Zov/CwXJStqM=
X-Google-Smtp-Source: ABdhPJxoh+V3QEYhbZ8hlx4TwwVXqd3IryeRY6hIZh1QbsMXlOU1a47HqdHAP7cjZfdaLdm/S415LsawfNscGONHjR0=
X-Received: by 2002:a9d:7449:: with SMTP id p9mr2024784otk.26.1598411955118;
 Tue, 25 Aug 2020 20:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANWz5fhgxK5QDJpKKnpDYQ9qfuOmru9M=oLdGEf8OkaW8bd8uA@mail.gmail.com>
 <20200826010348.GA2149583@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200826010348.GA2149583@dhcp-10-100-145-180.wdl.wdc.com>
From: Chris Worley <worleys@gmail.com>
Date: Tue, 25 Aug 2020 17:19:03 -1000
Message-ID: <CANWz5fihD7gpoc=PQxRKSOi=W90vFBj-z-+yb=OF2+DTJOChGA@mail.gmail.com>
Subject: Re: "Connect rejected: status 28" from "nvme discover"
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_231917_335024_7FD8C7C6 
X-CRM114-Status: UNSURE (   8.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 25, 2020 at 3:03 PM Keith Busch <kbusch@kernel.org> wrote:
> On Tue, Aug 25, 2020 at 11:59:28AM -1000, Chris Worley wrote:
...
> > Hnts?
>
> Does the target's dmesg mention anything after the failed connection?

No, the "enabling port 1" are the tail of dmesg.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
