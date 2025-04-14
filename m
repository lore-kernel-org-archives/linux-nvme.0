Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B31C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qgZqdzdFNL0SASXSzIP/dkQ2WJ
	65pQMzWVqAyYyuLSlLnKwAOib2MJfU02sJ7ISqJZL5ETS3p8dLdoRrOp3FBE4xq2XzUFGW1qX49zq
	n7u44uKn1V/J2aD9hCXeWjKXHEGsQhdsaxXiPx+PGmQUHHPfppYkZwzRppqsIsUl2K9K5pMuMbM3c
	j6fcM26kfKWeEJjdy0eYiIx6RI1vjwkPLphVxAKjI9IpE7ACugucQBaiP8eOzuKwLrY+xFGUemObx
	noR+fplUg/kVLPVfH8tcVwX10i+meVmlov+pr5f+QAgWZN7rtYPqUx4PHFdg4Z09BBaVpLlCh+XW7
	HMcHKgug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rzk-00000003gq2-3m8Z;
	Mon, 14 Apr 2025 22:09:36 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Rw1-00000003fae-00mt
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 22:05:46 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so9487371a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 15:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668343; x=1745273143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SUIkBW8MzybjB23c/rlzdl26v6OW2aqv8zr7zBSF7c+e9bM2bTRQOFRhJefFss4Bgd
         REiITYhn330MTyT3m8/ww5KFGMRjB5uEWbPQZMGD4GL2UZI/EY4Ef9/v0Fi1Db7xUSaZ
         hXXFw35tnOwUtjOSWcrLWnjVS2tC8f3WkA9RvU/CAbY3nQ8C+SE3ylSp/rbMnlCwZLf9
         4mOZazxWHWcP9JxYdN/RAeyCfcfHdi7TlAqUDE81ZBMoZDakPQ/silqZkoxDpyrSF0z2
         OJ+ymm4EZxUdC8Wn9207iz6UbQZaqj4Fk+AmT5C3f30dvDUQyfxZHAdFlpENnZJmIMAl
         Tz6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmCm4ZjmXb7yuT+FmeG1xEc3hi/6MdRq62qgpBUCNPsB6DBYTWGcN3x4hSKVvuhPfL6GkBbzJTLLZP@lists.infradead.org
X-Gm-Message-State: AOJu0YzjRDhYrwcAh+TAfThRICIW0QH16BEahphX2AldI4wNvfUO3WNs
	Ig3KAlnjkdvIbvHYpQwGVST/f7IGuuKlwVsZ0R8O++YNEWmH4vr3yiji+0WV
X-Gm-Gg: ASbGncvuifP7WxRa4+9Za3o0Ew+GZCCEgfwSGavgJTQ8zF5G3C3tyAVgekx6dYYGil7
	/Th3jIYb+tuEw5aa5MLOMjEJEn1tDADJDzWiyWyHHAowQzVVLT8dztZGcDkU0cignQcDZ8zF7Nr
	KY45Q1n42sF7G6V0IoPJFicaZqHtxq7JRlaaC5uVJCGLgozBetP+ZQSlNsG9vEBckYocThWZP31
	a5OJ+S5S3azKlypOmiGwmCmxaYP1imp7kmBo4Op5vH5y7n5Wm6jxGSPjANvTmeAkEyFzg2fJArI
	9tOmggM+EZs2Yu4L6WBoa8J+TzlkK+dptfBAUmD6CDPTUJr15IbjIuiFHRx2bFe+jhe0NlAJmYT
	7vwqQCPA=
X-Google-Smtp-Source: AGHT+IFWxUWm2NyR9lvP2Hi3NblO1Cn0M0kPmb7S0PkX7/o4PkOFes//JgbzBI1mcsN8r88GWbjn+Q==
X-Received: by 2002:a05:6402:2711:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5f36f52bb60mr12603557a12.3.1744668343158;
        Mon, 14 Apr 2025 15:05:43 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef56de1sm5775714a12.21.2025.04.14.15.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:05:42 -0700 (PDT)
Message-ID: <cd47f22f-d869-480d-9a34-8a7d50e77f4e@grimberg.me>
Date: Tue, 15 Apr 2025 01:05:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet: pci-epf: Cleanup link state management
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-4-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250408024733.690966-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_150545_052893_7001FB92 
X-CRM114-Status: UNSURE (   5.15  )
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

