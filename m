Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23305EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eML3dbDdV7FB4Va827hh5Q5QJm9umEJcmICBYPAeFZo=; b=P8jMvSqwk30FjCP0ZacUkmvZWh
	jgHmiVkTM1c0Ad3KWp+7JZuydeeNwTAx8wdDZPyV0OC8MFZDtn9vL6elfxP1hkx8qkwL06icPGYyZ
	MuiMp8N097197cw1XHcjFhe882Tln9qCqzVsXNSVfyF6/HQUpC4Xnvw1eUFocCynXMBcHRV+528ir
	v6zkZgMWIs7djxea3UG1CIah/TeUQ8ZK1C3doLRe8mY5T+vWKry+c0vc14ohtEm7oE5V5bVPLYE5d
	1ZvwPiD1cFnrLbXsiuoq+i7a02EONAzl/4tpSW39XoS4cGw3xZJmulIVGum6PlpnB0HhgKUrhQGZp
	53ICpS/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVU1T-00GdFa-1y;
	Mon, 14 Aug 2023 09:38:03 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVU1Q-00GdEG-0q
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 09:38:01 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1295332a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 02:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005878; x=1692610678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eML3dbDdV7FB4Va827hh5Q5QJm9umEJcmICBYPAeFZo=;
        b=VIsDalsWSd+t9zBUkNaGU6kl6Ai2CRGOJhfH3u2WyIjs/OOp0kaplEjpOJIZQd5uIt
         aCvneiauvBTFcHvThGvZfEt4E9TVgxhX/mILoysKjx2UqoIfrTwtWBQt3a6NnjLqEkLK
         PN4AcYnqFivY5SYSExANlnKc1LIoTFS2cvNrbZmFjiFqYm7oUZKf6HxBMNU77Z1sAqus
         EdgUS10aV5VYajhLh50IK2kP4NjEkxZWEN9D2eMX+Gr9RxdfeKlDy5B/oNO0JXjJKem+
         Ug1fe0ogpltOGXWG+Z87rNN+TOTD2Fn2mMWmu8XhkcEofFIkwVslrSh0SLOauhc/1A0X
         wnOQ==
X-Gm-Message-State: AOJu0YzuYjpKjiQ8Vggaf/RsMDu1R/PTW1LdvwVRrs4lC72ehB9b2HKr
	l2ii5KyNq5XxzNQhGsX216+xdrb7bzg=
X-Google-Smtp-Source: AGHT+IHCqeZA5fZuiYWf4EyC/985KnonSfc9jEbo9VIu7+DLlecKfF2ztCbvN47WBzVZb3o2n6c8HA==
X-Received: by 2002:a17:906:7394:b0:99b:d682:f306 with SMTP id f20-20020a170906739400b0099bd682f306mr6364779ejl.4.1692005878299;
        Mon, 14 Aug 2023 02:37:58 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lj5-20020a170906f9c500b0098d2d219649sm5556604ejb.174.2023.08.14.02.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:37:57 -0700 (PDT)
Message-ID: <149f023e-e4f4-3b36-56d5-e2d0f486439f@grimberg.me>
Date: Mon, 14 Aug 2023 12:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Bart Van Assche <bvanassche@acm.org>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_023800_299203_60AE9F16 
X-CRM114-Status: GOOD (  10.14  )
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


> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.

Shouldn't this call udevadm --settle or something?

