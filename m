Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB39BC4828F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Feb 2024 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXGEyMd1IEA24pbNMSCGDqokCEtRF5iaiBCtfpPJUzQ=; b=xBc+P8jexTtfreoasuIpP/8O5J
	2NewjYmYtNuZwDSZcZZZR/M1pFZdz5DIaz/PdCzb4NsufU1eYAjfaHjaAIAkFxr59qF8OEA2bfdxV
	1FApHlHoKUTmVwe8+kwhexjK5HP8yWN7grPQgO+2Sj6qDan8zY9s9+lwEaSsBTbc1biUW2/wb4C5c
	ypGXgbhDCde3rONvuP7QOBk5I1xfgymCHNk8cX+G4fb3+Tqh7y5L5SK+8HzBPh8EX5gcE1BVvO/aD
	ziFHYVwi7JK252fGEe/yKeWO3YcLwHLoXuPlYhbvq22q/uR7B2KQrUfpqx66GKlBzyfS1z+IcdOgU
	RsOuCfBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWRYM-0000000HXX4-1fcn;
	Sun, 04 Feb 2024 01:44:14 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWRYJ-0000000HXWC-2Rsc
	for linux-nvme@lists.infradead.org;
	Sun, 04 Feb 2024 01:44:12 +0000
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso2019575ad.1
        for <linux-nvme@lists.infradead.org>; Sat, 03 Feb 2024 17:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707011045; x=1707615845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXGEyMd1IEA24pbNMSCGDqokCEtRF5iaiBCtfpPJUzQ=;
        b=HZH/VRfy5bj3bqLfndeQj5MVEGJnnA9xT2DF5kDrKwYPOZKjoplX1gNlDaPy3JFJJO
         RjsA0rlekGP/qZKmfDk/MibWn+TLfd/g0yx/ZWNqgYnc5p/QIl5UGKWtMT/J4qd/5Bgu
         sFCJ9iJ3y+ggahsgyeLrih23D8J8KXp5aLCa3vaEKJcFEQ0RNC0C3MATlV9mrXHjYSYl
         lq8glm1va1ab5UGfAcahGGthpYAm2/GmH4AcieVC4ON9OwLbMFJcIlGS1kkUlrPzCsKB
         H+k74eh7G56C20vz/cFo9RXG0yJ5Npr1RwLULKTv8xX33GXguZ6nthBmdvwLYue25LfO
         g6Qw==
X-Gm-Message-State: AOJu0YxtbV0vgTJDt2uhb9//B77EeKb9vAI2+SA12SLJLFkAbMuwbkio
	xcguYwcSylYYdX6d9Bp0kPOjAIL/mUYq02rmdxfk+8G1aff8E84aAFxm+fN/
X-Google-Smtp-Source: AGHT+IHaxASDXrPhBJzyavNYlYsYKCd4MU/bswyPtbbns+o5UbgnFl3GNhKIpE74Fx1IecDd3LqX4g==
X-Received: by 2002:a17:903:41cb:b0:1d9:6c71:19aa with SMTP id u11-20020a17090341cb00b001d96c7119aamr3613384ple.13.1707011045316;
        Sat, 03 Feb 2024 17:44:05 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e20400b001d90a67e10bsm3831305plb.109.2024.02.03.17.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 17:44:04 -0800 (PST)
Message-ID: <ccfbb194-c355-4dd9-8b06-689480f5fb85@acm.org>
Date: Sat, 3 Feb 2024 17:44:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVMe suspend failure
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <294cb317-22b1-4c03-9b12-b19c55ec3163@acm.org>
 <Zb7l5Lk814W4064a@kbusch-mbp.mynextlight.net>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zb7l5Lk814W4064a@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240203_174411_657396_D0256D48 
X-CRM114-Status: UNSURE (   5.76  )
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

On 2/3/24 17:18, Keith Busch wrote:
> And this is happening during a suspend? What kind of suspend? Like an
> S3/S4, or idle suspend?

I'm not sure how to determine this? This is what I found in the logs:

Feb 03 09:02:20 asus systemd-logind[1208]: The system will suspend now!
Feb 03 09:02:20 asus systemd-logind[1208]: Unit suspend.target is 
masked, refusing operation.

Bart.

