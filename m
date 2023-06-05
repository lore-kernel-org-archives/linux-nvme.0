Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662B9C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=; b=pcZwRvBTxjppHsG7V7ymTSC7Ci
	2iSk+9LgnQK2xDDU5/rpjDP1+t6h61AarmvBm7zkY5iOLaCmZKtRXVVQ1egFH+1B1YdJdjNgEpSwP
	FsewW8Rh877UoZMZikBOv6zGNB09UlrTZ8zEla6NGSLn4WaFGjwEzv5KpEP5tRKfqt4xdRmghF+0j
	rhxP+3hT04oeLIO/JNJTQTYJqPcmGiP2jxifbBmuI6XnqHcdQLHtDYs6lrjuaSEWaSr/d+HsoCQsP
	ydEkNGM6VskZuPLLh9DekcBy1sbKPS59En0CM3pmGjIBc+t4aIyCiVXgGIbYn/Srh7GyS5INOnMjO
	COXY0WSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IBL-00GvoN-2q;
	Mon, 05 Jun 2023 21:56:07 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6IBJ-00Gvng-31
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 21:56:07 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f4453b607eso793169e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 14:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002164; x=1688594164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=;
        b=NDWKl78wfeeTJyD54H3iBWSPsNSjZnMBopdAcUn1oAv5PxA67oob9eujwHy2TwLsvW
         H7waeDhb9ebXXsUfZ8Y7a7OLC7RttyGagYFzaxf1nqmxJP48PnS9rkPgyFT5PrqB4bxo
         WWJ7nrZQovSffkvb+GhZPx+aqnS57Z42oc4CIQh9yKiNCBu+1BDa7YAb0lhxpYoYTPBz
         mwYPBEFDEOnTx2d4df+Vp5pN/5u6c+pH7j8p+6VWOaBRuPZ+MLh55FjB3t2J6U9s7/oy
         Yz57CB4zPH3eoS33yo1KTnw0wY9Euvpeim51LCIqwYSgWxya7EtD31pDdzAphSYdo5PO
         M/ew==
X-Gm-Message-State: AC+VfDwrjI0d5GeEFRkZjcQRxVbGWlKx3Fwx4SNVD1YZmxONmRy06Sux
	RcUdOFIsHwys3FCVum1b0TrfkLpPJLg=
X-Google-Smtp-Source: ACHHUZ50bmrLQTrU1aZpwX/Q+parBI51l8UlE6JC5d53VGOYgq3EtzDUQF3i8YqyttVCgPp6uNcc1Q==
X-Received: by 2002:ac2:51b1:0:b0:4f1:45b7:2e5b with SMTP id f17-20020ac251b1000000b004f145b72e5bmr91463lfk.3.1686002163952;
        Mon, 05 Jun 2023 14:56:03 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id f7-20020ac25327000000b004f3b2d3fc25sm1246542lfh.10.2023.06.05.14.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:56:03 -0700 (PDT)
Message-ID: <1a32515b-455b-2670-3b65-035c6be0976f@grimberg.me>
Date: Tue, 6 Jun 2023 00:56:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 1/3] nvmet-auth: use common helper to check secp/spsp
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20230605091920.34253-1-kch@nvidia.com>
 <20230605091920.34253-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230605091920.34253-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_145605_970503_7DB1C63D 
X-CRM114-Status: UNSURE (   5.69  )
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

OK,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

