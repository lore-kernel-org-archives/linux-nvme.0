Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8B7C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Cb0ktkShL41fe+NDEqAnr71Zi/
	IS2emsjCR0nnA3AGfAQpqTskzT/DAKLD7oh26wqFh66VZLRKSUwaCC4oLBnFS04pyCknxaa89jd0p
	ET92bklaZdHBzicMmQrCsxd7pMHVuCcduZNMLDzdjn1SHOh4Nf6QvaB0nDGQsaoKFqA7jpbg2IwwZ
	buJhJHVKSTsbyIwDhHWbaFB/ihlSc2ycMvqlCnLHycIRJv6tm/xT3f0Otwsx773i31rEPYr/ncNXW
	0IPqvKmilFeS/8DVvYnoIP3Zzod3ySOG0GalNbe++Wh1a2AVg8WxlgmP+MkJo74Z11D3PzROBJCjD
	5HxF9JnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siZzE-00000007XY9-2EtQ;
	Mon, 26 Aug 2024 13:42:24 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siZzB-00000007XXe-3l1U
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 13:42:23 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367990aaef3so2040039f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 06:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724679740; x=1725284540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BBxWEIloKYhg8BQKbEgy8CfYZwNT0s5Y1MERhKElVG2AInqpV0HoCyEtsJzBCmOK3M
         t4q53SNwkWomhvRMc3pIE2iy4zMKXQ5H6QRU9x7JIEEaYMnn/CeGqNDhP6RS+epAmcIq
         qIks/8WK2LOHgs7rRlOsekAbg/+gU0xcBK0vWgPZZJZXEULsEaVZPq0WTddFQVEzWMrF
         qBfMGFKq1JVDlScMyWnpAzKk444SDp7T1YJPKtv/xbMNbX7sP+Ar9f0uDCFKqnqiy95I
         XTVLHBXIGmqRMcTzfMABN/wfmJ8X9t7BtiIFap88wquQu/4zfDZ6ob2mOKTp+36MGTl3
         Q2oA==
X-Gm-Message-State: AOJu0YzZe3Z5dD+1qA95uPvMJdnocJ804zB6bRFW2sZvp16zLYzdwNXE
	aWZnJSBDTCDS32q/rqyXkUImqqcH6DULfHK8J0878quwj6WxaZ6O
X-Google-Smtp-Source: AGHT+IGS7JJXylRmY+ZSxgLsl1g2UpgcRz/TDpMfusEwXQgYqk/AJpsqGlOf5zkV5opNUPLWRM/YNA==
X-Received: by 2002:adf:9592:0:b0:373:b87:55d8 with SMTP id ffacd0b85a97d-37311840c5emr6333101f8f.3.1724679739631;
        Mon, 26 Aug 2024 06:42:19 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb33sm10727319f8f.13.2024.08.26.06.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 06:42:19 -0700 (PDT)
Message-ID: <bca2ad17-f625-4fa2-b92d-593d3c00f9fd@grimberg.me>
Date: Mon, 26 Aug 2024 16:42:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org,
 axboe@kernel.dk, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com>
 <20240826103943.143962-1-anuj20.g@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240826103943.143962-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_064221_940121_C131D71A 
X-CRM114-Status: UNSURE (   4.64  )
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

