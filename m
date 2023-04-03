Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0638DC761A6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Ixef6iu509BbU/eA3x9h6zTU0gboEx253oUuoAO+LU=; b=pWiR4EtwscVVKymZKCiEgvFzOX
	S8aLLHzzOs4bhPWUX8ebfdv7mayytsnVHYcEy7UDvtWwJ0pcWFonUfK/ny2Hf/j+LsUzOUbkppAmY
	/JXHNqgvxCz+JKaBjgDMin4j/7as/8ba/EUpn0ejPtgXivDcaJomNNiAFmPy+7ZCa/uok71/TC94t
	lBgsbyvq08FmO528t9C+oerRcTRoRbSWksxO6p6wrtk+IZuWN7waCRv3U73HECAwMX+jRnbEqp9Uu
	PnTWRS3zzjzOA3jxLLN0C44146dljBDJJd/rM++en8h8ThN6+nQ4nUY+ziE/8WtjEXMYLqDrQNTX3
	LvUs4NMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJqC-00FNrf-2N;
	Mon, 03 Apr 2023 13:03:20 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJq9-00FNq3-0f
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 13:03:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id s13so17050962wmr.4
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526994; x=1683118994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ixef6iu509BbU/eA3x9h6zTU0gboEx253oUuoAO+LU=;
        b=mvVn0BnR4VIDE6GANXp0Tw895hK4b94X7MjYOCF/fTQhXKvBV9bwKtPRymwpP1O99z
         wB+nrSgRpu2/xttX60HXhrIpdEx6mDqBT/WKq/YhEFl7uXIgeZ4714XfCTSdu4jb83Wp
         Kjq339ue/X7KKwq62R3d2nt/bUn13W5VRT557uJIF0GeHonZlY090fbHeyzqiXwF7Uuu
         ytiVQryuyCM8RtcGMKTeA+D6M7GmDBog6XrVC86GVBiqj5QlzHyPgZt2CUQx+wGYjflR
         penaaH74TLorZUBMjWk35f6J5/yhf61/7l7jDFIkSydw/r0TnzH46kV9CE90kKkxbC1q
         u5Xg==
X-Gm-Message-State: AAQBX9dtZx5kS85Qdxno4Fty+vh03d54itEByqUXbWX+xV5wd1VCFSsc
	xjKYLu1LDn5zVq/YOgR9XTPKJLcfop8=
X-Google-Smtp-Source: AKy350ardo2Pog514uByZ446mtmSmnm5bo9ea27wJWtbDP8DjsFUSyj2AIDVRrvMc59l6RBjmBcRrQ==
X-Received: by 2002:a05:600c:3503:b0:3ef:7795:e5b1 with SMTP id h3-20020a05600c350300b003ef7795e5b1mr18329257wmq.4.1680526994489;
        Mon, 03 Apr 2023 06:03:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003ef6f87118dsm19787750wmq.42.2023.04.03.06.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:03:14 -0700 (PDT)
Message-ID: <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
Date: Mon, 3 Apr 2023 16:03:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-19-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_060317_241978_53D72521 
X-CRM114-Status: UNSURE (   7.76  )
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


> Add a configfs attribute to list and change the default keyring.

is the keyring an attribute of a port? or a subsystem? Why the choice
of making it per port?

