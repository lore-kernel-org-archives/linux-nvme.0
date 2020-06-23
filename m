Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6406A20781
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdNtJ0eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6406A20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aIFOGbn+j1IMmz0hytnNSOvGzWBDKQJl0FebqGyAFPU=; b=gdNtJ0eNvIczTvHEjAmNB6VuP
	HBXjdEWIcOUWaO/jbU6WUEMLR9iy590SI7m82GvYKlP6yyiU5Em568/Nf85Y8sVd5EnMQ4SBuDcEV
	Hl9zKe6P1B5HPd9IWHqgNJqKidO0jqeMP89WpLt9btEMLq7C62qqlamk1+1XbYct2gwUdbqw55F6h
	tZHgOWkpyq7k+PTRPt7VFy2TGuKpweEbbKGT8+rpWMKIR1B6TI4Ym4L73y4aIKWRX0lZvwVlOZG3s
	BtyzPllhwAeKBDDhE0+KAZsr/a1On/6Fb524/3IyaVCZQzsjvpWaNQdHwQfBYOviHgZdjOwannXBB
	19Oc6bmXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmr7-0003wo-Oh; Tue, 23 Jun 2020 17:37:09 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmqv-0003tO-1W
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:36:58 +0000
Received: by mail-pj1-f45.google.com with SMTP id b7so1320435pju.0
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6w0d0NBh0grU3PHnd6VBiloqUzWoBBLST4i4IbRgb6E=;
 b=S2sSyZiTJMzrRpBLV303GY2L0qCp0Uj6PVs0Dp/U5oXWpZ45a2UzmQVbqNZALJCFjv
 3RelfRR2oCmXpyte2prR5vUuSQWhY2su/upp8F85nlff07l0z34USdbjvCf/iGOFtqnT
 numzuFK5XjBKczgaC57PRXLOC3FsU2PiHaCRN9BnVeXSVhGEtWNMXLEDrKXUQqN3t4rC
 x/OrO0l1Ak9qUujwln1XN5uoP4IW/hjuet5/OPyOVR+uPCSHRPWBSJWpGler2c+uiSig
 DjD5i5iVgOaU2va/27tCZ6BW7SBPh7yODaJywb+8nzRE5ApUns5MuQqgupJ83rF7y6r8
 D6/A==
X-Gm-Message-State: AOAM5317Bw7ABVoWuxPQre6pGh9QlLWG6iqEAVIiL2HmKzpgcAo1d9uu
 LWp2Patuyu6JencTFqPYZrk=
X-Google-Smtp-Source: ABdhPJySl4WeJ1NTRr/FskmEOpyPj3quPcpoAS6fwy9LJ8D1QIo2piQjKfvB8Rtef+fHpR50tXdvFw==
X-Received: by 2002:a17:90a:ea18:: with SMTP id
 w24mr10131764pjy.158.1592933815764; 
 Tue, 23 Jun 2020 10:36:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id d2sm14088405pgp.56.2020.06.23.10.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:36:54 -0700 (PDT)
Subject: Re: [PATCH 0/5] address deadlocks in high stress ns scanning and ana
 updates
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200619233456.379778-1-sagi@grimberg.me>
Message-ID: <6f043269-98da-0ede-33f5-fe2fe0204111@grimberg.me>
Date: Tue, 23 Jun 2020 10:36:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619233456.379778-1-sagi@grimberg.me>
Content-Language: en-US
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Crickets...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
