Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29ADCD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 18:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rpb/85FjFG1jzuB+mK6h1a9gdT/7Mf0aBaITrm+7RbY=; b=4XyJfu07S1mvuGhrgefjJx/UP9
	HwuWXrWynCN+9tCY8+SJeC3YHi94jIXlRhRf0kC7G61b4eK7tI6Ks2RLdhUkiBc0Gv9YwioQCjaRj
	U8eYI728tbCDGCTYi1JepMjvn+P6+YFGQcu3C0JXxIfBDXfSaUBW6CRdo9ZvKUnBjn5ue8bwPlq7c
	9GTQVedZIqei8mw+DeDWeLz0RckzOOvVU2QLKaOxPPlUhfu+iypTZOEX1HCYP7yyQsC/P8b/qiIgo
	0UIOhrK+QB0Y9cFo8od3SK6TsZnNtwqVdtCtUxbe+uyCFWzaqYVuBxAyzZA2dlz+yqGnB8I1ynnua
	MiKMGzeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtuD6-0000000GZqX-0S0F;
	Mon, 08 Apr 2024 18:59:16 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtuD3-0000000GZph-1RZf
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 18:59:14 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34602c11302so90120f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602751; x=1713207551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpb/85FjFG1jzuB+mK6h1a9gdT/7Mf0aBaITrm+7RbY=;
        b=QIYDM6UqHI3Ef+VHHu3u+QoK/8z+OPucTGu8AryzretoY0eTWwuVAiREcsx1Gdp+xm
         22P28fmeyZgQWwKNsao9jRH3UeCWFyMRzJ5TemfAE4sXORpJdAmEWgeX6DMY/ITbKw6P
         eCsYm6mL+O49641yNYzsqf5Nw1AgzhPnJ98OTk31PsfR7/ajFyIY/AtIaobIcERAatOk
         eOM4Ier5BhfNW7dPub7QrvvDLbvmdhlkBBk1gcGef99wsSEhgW5/YqUMNE14fTkpt6Ti
         OVjx0DjjLsGCsf6d4NQbU/0vIJv0PfL9o8k3RRa1WyffKRw5OH+jkoH6rxOVTHaS23j6
         I1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUqS8EZ0X8kzrgVXC/IjD9f8zDoWpFYESMTCnkiCzC8/auruliIO7GMSO48GaAg9t0UbUvtmsBrMKw14hMfq9AjEPHjPCdJFRxZKFAkZa8=
X-Gm-Message-State: AOJu0YzGIdU1mP0nI0HJtoz+I7vFm5w37SoLQ/aslRDUD8wk8F8MTiK/
	I/retT+sAdjqnEBuTgRyTmo7V6frEiAcs77YIuZ6IM6n6rUBbYn8agKE7br3
X-Google-Smtp-Source: AGHT+IGkj82lok7Rmwt8Ybq3yYQTRx1ACcyaLp7EE1MSGy0rexWNSj15rV0OGVj8TjA6tRItPd/r5A==
X-Received: by 2002:a05:600c:1d11:b0:416:648f:9a6d with SMTP id l17-20020a05600c1d1100b00416648f9a6dmr3144227wms.1.1712602750966;
        Mon, 08 Apr 2024 11:59:10 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c450800b004147db8a91asm17964599wmo.40.2024.04.08.11.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 11:59:10 -0700 (PDT)
Message-ID: <9a3b111c-409b-486e-b3be-112cff4cf41c@grimberg.me>
Date: Mon, 8 Apr 2024 21:59:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240326120342.105740-1-hare@kernel.org>
 <p6epmhukqjaiomqvxwgpwkoisg25yt46d5texh3sm4lkoump6h@b6ovzgutko77>
 <uvkgxqndcvgkphwuto7o6nimdsria35hc27v43zzo2h7kokor4@5olfmdazhi4f>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <uvkgxqndcvgkphwuto7o6nimdsria35hc27v43zzo2h7kokor4@5olfmdazhi4f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_115913_464571_69A3E3E7 
X-CRM114-Status: UNSURE (   7.31  )
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



On 08/04/2024 19:07, Daniel Wagner wrote:
> Any chance to get this picked up?

I'm fine with it, the only question would be the fc additions, which
perhaps can use a review tag from one of the fc folks.

