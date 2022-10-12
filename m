Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45A9C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=; b=gMiWX5b9Fa+DjydWbb85Lmu8j9
	/5NcnzeIZI3G8dKa1L4hEEiWrKpZC/C8jD6md/jVpiS9AxjUSuaXN4rSKV550tViPn1z/423rV6mL
	+lBTVEXwp4K1Jwl32uWeEbZwzbzvw9Loh7KbdgSE2g8YIhewdQw//xZmPOcbFPcGoGDferJ6w252k
	SZK3kxmfVVtGSk6zwpalZUDqzK7INU6Yo4xyV8zfWetlnk7gaAmN/ty7ty65PjD2maQrxEcTzIoH3
	WaoctWju7s4Vu1+FNfXAh0c5e5FELARmIkdxDVcom+BNDoBa+38vPxnSeywmRvZEtl9XPIQoeKCgG
	3ui5OJ7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVRW-0075Eq-3Q; Wed, 12 Oct 2022 06:42:14 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVRU-0075DT-9L
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 06:42:13 +0000
Received: by mail-wr1-f52.google.com with SMTP id u10so24782247wrq.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 23:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=PQslPo63K2k0/GIp4wcNak28HWb0yk7V+aI7CPsZRMu5jrKzXwrm1o2Eq7l9YhS5ny
         Ue75mrxL/UkBJnZWwP7njJ2zgfEpeNaKZi3AvxRvje+F+6BR+6kOyMqwvJlnFYb+i8Qx
         yM4v60th6gcVlAAqBYKLEjadmFpv7MyL6LpVmm012oRgt3zpPTcnwHGZEinC5Dqxx7sh
         JhYlrAZ+muh3c/m1/vuNIUXZvZymxmobMbZt6yMA4eC8gUL5BcLJyK4gYoIDfRMzHPrp
         jO+ZHz4I7jh95/8Vvk8YE2wNP9xspH7XSlaR2NT4OEBl6qYpL3oe3BqRp5l+gL8y14ID
         +f6Q==
X-Gm-Message-State: ACrzQf2YytOeBFTbndfosuDMtwvoPAJ6UZmfyT3TIRo+xov/L1+jLpaJ
	fFC0vo/OgHtRAWid0GrhZtU=
X-Google-Smtp-Source: AMsMyM586XlNgTpBSllXnb1EktWWXW1pq87BOKxjPEU4apEedougWNgj0iUM+NAEqty5dd1GmshJDw==
X-Received: by 2002:adf:d228:0:b0:22e:488d:758f with SMTP id k8-20020adfd228000000b0022e488d758fmr16425838wrh.445.1665556929003;
        Tue, 11 Oct 2022 23:42:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b0022e62529888sm13335483wrb.67.2022.10.11.23.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:42:08 -0700 (PDT)
Message-ID: <38b520c6-b53d-fb8f-16a9-18057822ed26@grimberg.me>
Date: Wed, 12 Oct 2022 09:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Frederick Knight <Frederick.Knight@netapp.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 John Meneghini <jmeneghi@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20221007072934.9536-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221007072934.9536-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_234212_373130_6EE26FE7 
X-CRM114-Status: UNSURE (   5.29  )
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

Acked-by: Sagi Grimberg <sagi@grimberg.me>

