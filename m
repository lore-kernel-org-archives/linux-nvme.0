Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48976C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sXxDzt4RFD5vcSNbCvy+fbX5Zn
	QyhDL8KNx8xvhyghtK4fZ77Pny5mOq9SyZLOqxSIgp54WkRTJOJnO/7SCPbaoH/BzKInjw72dR5Eu
	EMTVwsrL0DVOvIpszqVnPegU8AxDxGvpj2nGqiyDsQ+HCkgXi7DKvlRNHdixqeGorIbBK6uQKP70H
	ukRIvz6m8IplyzZFOGR15cz6EEvfPdQ1vy8XuiO0vTWhKp3Cq1GP9+FYcxsWJWBD3kyxifWfwuZRO
	eIEjlb/kYreRV+bLVteaBs+ZJ5buKefRyj9/QAIxV0EVZb+J4uuL5NRJMrlwhG2MKy7sKlu+T2diP
	W8MSPCFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neDi3-00DHFn-Lo; Tue, 12 Apr 2022 10:25:19 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neDi0-00DHD1-Ay
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:25:18 +0000
Received: by mail-wr1-f45.google.com with SMTP id w4so26962928wrg.12
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 03:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=DzEFn+r1gmMLX2nDlMMaNXFyaCQ5Tu8gI277Uu26uttebEV0c34QoMQ0qq3dyuecdn
 Ek3LEExPTHTVRayBWS4r2TkjnCwlSm3HjUcXrZixZ/KCogHti7IFM5Madi7PwKzcG29x
 WyB/hMw0nvWAzJboxDrohVpZ9tcPieUBO0fWqF4XNfE12Fs1Nz3vRZS5PAynndqNMCSn
 Fim4jnQ3iEyH1YNEmzzqDhqHfxfw9ly1rh2Jgtcxsd5B7Hava4qyIV6uenFVvsECCB3a
 wWXuvBWfdTVB+5jslsUvslwR/aOqVLWpa1f/WBQd4P1mhBrhbeRu/RgPFAseyyEwvK91
 78Aw==
X-Gm-Message-State: AOAM530gpKVx7OxHNfAnYf5Um6fX4pZth+oRVK7RSAX+KRfbr1Xwosrm
 vvCnNYx2UxKHZMYWi1s6gUU64f9iW+s=
X-Google-Smtp-Source: ABdhPJwbJSFVYrYWkj8GHY6D2BuYGaKBPrREAKQlZB+Pt8xL5m83pCB5hZptdJBAdvs4Gq2Ma4sIqA==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id
 v7-20020adfebc7000000b001ee945affb4mr28479023wrn.641.1649759111592; 
 Tue, 12 Apr 2022 03:25:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 o5-20020a05600002c500b002079960cdc1sm11369251wry.44.2022.04.12.03.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:25:10 -0700 (PDT)
Message-ID: <9638f53c-00a6-428c-9429-25fdb8382be1@grimberg.me>
Date: Tue, 12 Apr 2022 13:25:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvme: add a quirk to disable namespace identifiers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220412061126.244414-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_032516_402413_361D0F6F 
X-CRM114-Status: UNSURE (   7.79  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

