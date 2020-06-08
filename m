Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460DC433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256052053B
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WhWFAOoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256052053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=WhWFAOoLwyBckX7k7ybE/aON+
	C1HYDcqa4aqw8x1TTXnX621mLP+9+MMrQm3bXVvHCksOct1flaeBOvNxrHlUC1c98HYt1Pi/kWj1G
	eujnUj8KyCbTcE1spbNC2JTMPl6FP5hu9DyODCkWP0Ilx1c8asL4OwNAhA/3rqQuifSEMN4MQQb3+
	9bg9U9vDanmwscG8ypDSn5uEBDt5m2j2Xdioeks8KCiJK0IO9GxaZTt0sU0RwIy820q7t9b4NsDnQ
	3DQ1oP2IERitfxo9bHSekJ0reEEKbxct6fuaN/9qBMwlzySSufBcMncWx5D9Pv1TOoVbgxYj0+WsD
	46FxuHPJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiL4v-0003Te-6P; Mon, 08 Jun 2020 16:56:53 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiL4s-0003Sy-Ie
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 16:56:51 +0000
Received: by mail-pg1-f193.google.com with SMTP id m1so9047543pgk.1
 for <linux-nvme@lists.infradead.org>; Mon, 08 Jun 2020 09:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qINYbuckdE+skOhQnwx/PRlMx3oAJHW7lr7bDjsJ2en456zn4OjX2Zi4qK40qJi9Jw
 ++VY7+R5fsaQ9zGcumf5GxMh6c7RzvUO32UmK1kwzNTtYypY7bRQTFWpKIhjL9yCEYFt
 rnBQD8+Duni3gHLTQyPp6DrjPPjtodxqH+QkPOwyEHWgv9lufEnmVtY6ohm2go1i4fOG
 1oqlTnZH4XjXCdQ6xjPRUZCSvBLbEqrw3TKLM4ShwiXHaopJWbRmukH95sFiHl7lvcGg
 HkN+PzWJjZaWJtaAeVkjLjLsPQkvmiou/xW6ny03pHzAhdIPA6CGxYvNp+cMka34SCQ1
 cZGQ==
X-Gm-Message-State: AOAM533hWRmSNB/ixTs+3LLclW7Z1UxFfqKOvZKUbjYCaRsKi1OYBt3g
 JbBjg3GLAG+6EAHuBiJpKSE=
X-Google-Smtp-Source: ABdhPJxkaMnGp5/oDgkdCmAw7VoDdkdA6yItkr/GRn1VNxTA5ppA2XiR8Yaqv54AJuE9hAxW6CwYyw==
X-Received: by 2002:a62:848f:: with SMTP id k137mr12333025pfd.99.1591635409659; 
 Mon, 08 Jun 2020 09:56:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16?
 ([2601:647:4802:9070:5183:321c:38f8:ee16])
 by smtp.gmail.com with ESMTPSA id h17sm7550090pfo.168.2020.06.08.09.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 09:56:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
To: Dongli Zhang <dongli.zhang@oracle.com>, linux-nvme@lists.infradead.org
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-2-dongli.zhang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <512568ce-0bcc-7940-c2a0-a6416788cd7c@grimberg.me>
Date: Mon, 8 Jun 2020 09:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608162002.17017-2-dongli.zhang@oracle.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_095650_613783_2424D92D 
X-CRM114-Status: UNSURE (   9.24  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-kernel@vger.kernel.org,
 chaitanya.kulkarni@wdc.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
