Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE5C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBM3kLO+OmxSA5ObktuYd2lmMDcK+c/9PBGCKy5Y4PE=; b=xd38a/5u2wqHqAKTgVI3Iw9LmO
	i5xaxuYcr/RBa0UfYZcnzYz55I3Ufo5ugRDkXNhXu8l+02MuIZ5rhMxTtOOHf+NWwCdAAM1xeexx5
	i7cYPlNfH2yElL1QhDCQqVA9648wknNlrUMwpwu9KHgcAJ+u9WlrK+YbY71PNOTkFpl4cC5rlP80v
	GyOCHA4fzkl7ZjoOeSHYmcgC8XbkyPL5yVENt+WdCXecnQ6jwRqwfeyDqfEfsnM8srb9I7R+wPIGl
	89WCgUcnD+qv79XYiX29Q9GBXRz/WTnh7cj2JnRQdWCQIZ/yRSGndCB7N4V3tq9bYepiTcx6RuAkF
	WUSsCpDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiCj-00AXee-1Z;
	Mon, 25 Dec 2023 10:29:01 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiCg-00AXbF-2T
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:28:59 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3367f8757d0so660554f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 02:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703500131; x=1704104931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBM3kLO+OmxSA5ObktuYd2lmMDcK+c/9PBGCKy5Y4PE=;
        b=ptPEEb1EofOCIHN1T0MLAt7gWl+zrvD7WaREE8y1xQzRuPxM7y6z244eoIWL9IzNBt
         QSr4J3TlOTR4We3Lm0rgDsyVse8eRNejLAIlIrlWbYoYR7mB9DJyIziKvhTkcXJG2vJe
         I5YDSdgFVGpO89anC9F3bnO4Vu4qk1Fdmc8BXyi7sPQr5hYHJUFL9gdX9KzpHZP1i5j/
         jQbwiMD3buqI1+fTFYqyHNmxrCWrtr5m2KggilHWv32KRs16m6tx5Ki5Nw6SwgMPxKci
         g2JLfOG6jivc5584/8s7s899FXyfyZzXyKkZRP7eQ8wTM3GvpXlu0TdoMdPxk12jiLag
         eugQ==
X-Gm-Message-State: AOJu0Yx1ZsOoUCmsKLd6h4Z+z4vLvU/EDSQLNCorxjzQJSTPJnt29sMo
	jR3LpP+3nEDVZHvR11axP+Q=
X-Google-Smtp-Source: AGHT+IGXHiTI4p3II/+WWg5JLWwrPZPlTZG3Hbw+s++48zjcIk2BnkgkQNnhTCryloCvnGwKaE+2hg==
X-Received: by 2002:a05:600c:3584:b0:40d:5329:96a3 with SMTP id p4-20020a05600c358400b0040d532996a3mr3687509wmq.0.1703500131424;
        Mon, 25 Dec 2023 02:28:51 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b0040d4f95dcc7sm8569275wmq.8.2023.12.25.02.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:28:51 -0800 (PST)
Message-ID: <7ee13656-551b-436a-a0d0-1d08a8c526f4@grimberg.me>
Date: Mon, 25 Dec 2023 12:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] nvmet-tcp: remove boilerplate code
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20231222151750.655751-1-mlombard@redhat.com>
 <20231222151750.655751-4-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222151750.655751-4-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_022858_803462_26DAF9D0 
X-CRM114-Status: UNSURE (   4.06  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

