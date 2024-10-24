Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92318D0E3F3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoN7+JK2pdECzkAMZNFEmVK16cvvQOin4MzhA+IYKuA=; b=RCF5F1LZe2dpezIL7yo9FcGXcb
	sC91ZBAaqZOhSOuRcxsE9UkR4pMRXp9sA2K3frHehxSjm6lpO6K55I7lihB1LWzrRKb9/rtO2i3yA
	VVG7T92pk70sHf+i4qGOb/wxe7T6CYaDNwFhoZFazh36dVKADlVy9qrl90SnP3+7MpTw7pCNVS/E+
	WKhUSYszgS7GTqtAD/wG+GHXcIzweZhKTdgeCg6WHGzAHj9JV8ffgnU9teqLeFoPq5Iq119Lue8Ob
	WLAReizNiuQFMzRH5gJ1UGZedQw55RlG/ZPP+YcuvqrAKoKt5JzIaKz2IE6Y677wTdkO58oUDiNpK
	qDCoNX8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t43ks-00000001cZW-3kro;
	Thu, 24 Oct 2024 19:44:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t43C0-00000001X6W-3Z52
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Oct 2024 19:08:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PoN7+JK2pdECzkAMZNFEmVK16cvvQOin4MzhA+IYKuA=; b=FXiLDIrsJPjuS9JMXBev/9CUNx
	ZFK/LnOZKJ/Btt3SA0pAP0G6ga5TLd2MzFOEXxp0XT4uYMzzy5MbS7rTKojFKVC0UtwYhB/Dpx5ZU
	RSRkcX+tDmjc9Lo1S1D0Sn9qIEgQ1FIROA020KYrN872e1QfJDKxrx2dqvQ8QwENNcUpnLgn1HaaV
	fpUBuVIJKskp/TB5nHwqQNZd9nw5CtD/tQc04jk0qlbTUUdT/tTBqcmRu/G+S4jqwA7I2xJqvBRAj
	1mKt4oiiQedWHStN9v2iiYj07FWxq1Gn6QVKxTkfj50EJ1ozYKdQbR1LaiTIaCnpFBk+isq8o78r/
	NjV7FBWA==;
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t43Bx-00000008k2W-2ahl
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 19:08:19 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so1013914a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Oct 2024 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796894; x=1730401694; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoN7+JK2pdECzkAMZNFEmVK16cvvQOin4MzhA+IYKuA=;
        b=k3Putj1vAV1A6AP1Qm6eMmh5ULl7vMmhe8cNH2kBkyGRvJP5AiqhozheKXbfR03vFM
         3FGRQ5W7DIH/fAHWLBzxhP7m2TJ2TZNra1Ms5GmIpzexPZH/O/NXJJvXBrWIEdlzHM6m
         +kBIGDrDdPyxh3CbVylVwL085yQiXUNxAQsESDGhZg+MXd2kysme5y6TeSfXEQu520KV
         /XOaP01YMvM0NcuIgDTfoF2EcHXjKCPNedQnr4HQvdrIeoUYhDV5Zm4DIZW9P2cQli1n
         Jawu1XKsm1y73Qg9q+d29deIDqgNfK8aFMKfW4HtnWQzgp7p82ZRnhb6p+yReBssMmtX
         m6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796894; x=1730401694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoN7+JK2pdECzkAMZNFEmVK16cvvQOin4MzhA+IYKuA=;
        b=L/LwjORFMVrmrYhZSElox3xz3UdVa7srWjPtlbPEk4cmpyTGk8y8ykeaI533+WmjKz
         veQTgpmMIhw19dD3uni3svvwJBY6YUDn/lppVU4y8Vbm2DY6uuchVar+tD+7M5zLaRJk
         aHN/4IVQjBJ87hjQ49eX1pfs4yPamcE8jGAZ1tmQzf0zj522Xwqyad3D16plAoxRZJpq
         tOmiTagkEbrdDpmLemz+9TlfkDS1SRfESyb1p8QnARJAS8jCN2E2u2GgfGnTUMAeLfDi
         VwHw+3J8ElZISzPWp6zCF2Z0p+NuDI1w5hk7Vg87YSqqlYdh4rsmov7m015+tfbps2i8
         6+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWXpIm/leJuethR6AugSTRKNC/7lxXotW2+B/q499KbqQgOL3gM8QXm5FD2dnRLYxIZeReUtBn/oCag@lists.infradead.org
X-Gm-Message-State: AOJu0Yyy/3dTtVgQXbrj4kmgH1Y2cm0OLfkT66XmZuHwcL0M/8ivtcBc
	KDKrN9HZFpB8erGtURKHz5Z5KnwUeMXA2hkeFhggUBtrZ5Ja49n9
X-Google-Smtp-Source: AGHT+IFvDSjYf5mNWVqrH3wM1h1FzlvM/0cZW0+92j+BYLFvqFzzHiTuBsIdYgZmUKTK6ZHnX434PA==
X-Received: by 2002:a17:90b:3a8a:b0:2e2:d3a6:a84a with SMTP id 98e67ed59e1d1-2e77f7199bemr3332304a91.39.1729796894018;
        Thu, 24 Oct 2024 12:08:14 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:37fd:4e4a:8837:ca18? ([240b:10:2720:5500:37fd:4e4a:8837:ca18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4e4008sm1861565a91.24.2024.10.24.12.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 12:08:13 -0700 (PDT)
Message-ID: <7220907b-bb97-4ad8-be9d-82c7291e783e@gmail.com>
Date: Fri, 25 Oct 2024 04:08:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: martin.petersen@oracle.com, joshi.k@samsung.com,
 Keith Busch <kbusch@kernel.org>, David Wei <dw@davidwei.uk>
References: <20241024154923.3156803-1-kbusch@meta.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20241024154923.3156803-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_200817_915707_4B154D4B 
X-CRM114-Status: UNSURE (   6.79  )
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

On 2024/10/25 0:49, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> +module_param(disable_pi_offsets, bool, 0444);

About the naming "disable" is negative meaning so seems better to be a 
positive parameter like as "use_pi_offsets", etc. for example. By the 
way the permission 0444 is only for reads so is it needed to change the 
value by any code change, etc.?



