Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F65C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:48:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E846364F56
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E846364F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=GMfZ4oaL263mRq1a+rWzcePK2
	YAV0l0sNHR+tCDaGd2L1LUhJGlff+Sauo6hvrUmExDU1LL3Yjyp9hey8fpWz5yIjn+WDPZ86ttOAe
	lSsU/lEN1yPcqHRH92NcRbRmC6V29JbirFwJzOKKlGiO8p/t2uGDfLGQNTVFHJ6Ju/NyfKUfJv5JI
	GPlbpeXaG/TcbGnLiPDFknqB7mMgtKVP/G0+lhUeirVpJHfz0DLxdI92yKYeJ0pflSwkO9x4d2Xzl
	cjPkLkDSK4Kq+HP/TG1GcTlMOYDHgLRrXWpOM2ZtIHKGaGf5Ikv63rOuAE8rtLE+HVnTE48Yh+1bl
	4acSmYNJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrKI-00GacF-0j; Mon, 15 Mar 2021 17:48:22 +0000
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrIz-00GaLY-6Y
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:47:05 +0000
Received: by mail-pf1-f178.google.com with SMTP id x7so7051780pfi.7
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=G00JcsiEUZPzjwxz14nN9CQClm+6fRkTSUb9Dme9lV0pLKa1+GyTpuIFPG0rSzbBe6
 kaFFBBrz6AEuZtbfFEGi0fSmFQH8RS5eb4LJmb1MSXDFRBtAJJR3h/VUTQEQqUfl0byi
 G0ZruwSO338ASxvehRGZULTtxu3Bh0tpbFrsSBqeJKMDa0vZQCJLxe7EcNWaS5NsTnIw
 qFmPIdGkKxqjuVuaJs0UIcB8Hozuv0xfvbTtRsYQMwS2pIfuKDnqmc+wat67hs/OD3lC
 TPFouJLf3/8B+Srln2nc1bAkeamAQn8A5sFCZk5Vut29ZYJgRBrqdEhjsnOKJTKY5yDG
 bz1w==
X-Gm-Message-State: AOAM530Wysc9JmG9+q6vmyASeDd0/ai2R7NhCvO8uUh2cjSctX2mpVjb
 4QPtbSh7o577suHYRctbAWU=
X-Google-Smtp-Source: ABdhPJxclto09oxrfnGnv4ffiF7hGvfRQ2XkE0BVESUKNMrV9gXtoPCG94kCu2PIMcxAqcG4CY6mfg==
X-Received: by 2002:a62:1b88:0:b029:1fb:d3d0:343a with SMTP id
 b130-20020a621b880000b02901fbd3d0343amr11500933pfb.76.1615830419918; 
 Mon, 15 Mar 2021 10:46:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id 1sm14901892pfh.90.2021.03.15.10.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:46:59 -0700 (PDT)
Subject: Re: [PATCH 09/10] fabrics: fix some memory leaks
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-10-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b54bd172-c761-6f96-e526-3db8894d90bd@grimberg.me>
Date: Mon, 15 Mar 2021 10:46:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306003624.21102-10-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_174701_793260_1E48F158 
X-CRM114-Status: UNSURE (   8.24  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
