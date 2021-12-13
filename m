Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB59C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WT65iHBGMUC3uCLCU6CxS+tWDYE2wAUYflFjY2xn8fU=; b=o+8YkQqo52jtibZGBtiDCvdBik
	dNqOOERwwdUtaEHW5etlVyQTMfPWv2bYAc3KA41q1oxYHK+weI6T9B1zEg90lICoW0GvwoUL/t5p6
	SoteL2dRNtsriwkcv8JhfKyg60Tg8jtNbAEYt9WvAcrz1GEs1Ph7eU0/C6Ol1BQQpNrXFZOc+2R4n
	1f0GR302jLxNyAm1+BxyNxfjG/Yh8FPjYpAEzQ+3ow+fZrdF5jnGvpogcaKrxQjfrfy0/lb4z94aV
	DgKV9nPawi0H3st8PFG/rs+dkhn3Ixd18C7bJDX2wObgjYTzpkLAt/GoHzUxC6bwSzLvluHygUuoT
	8TE/9QOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwhfW-008e7m-Of; Mon, 13 Dec 2021 09:30:50 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwhdS-008dPY-I7
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 09:28:48 +0000
Received: by mail-ed1-f53.google.com with SMTP id o20so50288165eds.10
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 01:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WT65iHBGMUC3uCLCU6CxS+tWDYE2wAUYflFjY2xn8fU=;
 b=vsP2RCWJYM3wnFXrjMpvkKFgJqCttb2t4xtaddtPp6vaQktS1ubClOGQJws0R5+x/N
 SYP2I5V/aqy/sMLqKI8Invfyts6J6xVw14KvATZoEPSZu5PTxrIldGjK8A1lulxb78h9
 cvncQyAOkT5qHZtLe1/OVAsLXItfgD+6pK8iOwoJlao0rgIxlu4U0HI2xE/dXJfLxXry
 TGL2eB94TvpSpVibw6I2U68gXuuFjkrOyWEAIfqOAtdPD3JmhVgNMNhXgWqDFYnfEM3v
 ebGZ06t4yBdoxcWdIJMAMIuU7IeeUpjasOCbQ2MseuNBwlZWYC6KmMqxYbEDk5Cmro8/
 oLtQ==
X-Gm-Message-State: AOAM532KUOrVrrwmvmwWWCHhi58/DZIQ2WZNiKKtGnIcbi7fcU57GhKx
 Qn2Pt3+7YRMZt3cjdX7B7rsYD2c1Rzs=
X-Google-Smtp-Source: ABdhPJxk+fSnJEBuLPVQ18hAxEmzYvbXF7s/e7m2H+WQxf3R/q16RHtihIK4zIr/l43qctn1zoqE8Q==
X-Received: by 2002:a17:906:c113:: with SMTP id
 do19mr332433ejc.386.1639387717187; 
 Mon, 13 Dec 2021 01:28:37 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id e26sm6121659edr.82.2021.12.13.01.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 01:28:36 -0800 (PST)
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Alan Adamson <alan.adamson@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
 <20211213081217.GA21297@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d0ce19a8-1e1c-1842-873e-dbb5fda7fcac@grimberg.me>
Date: Mon, 13 Dec 2021 11:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213081217.GA21297@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_012842_657422_E0D91FE0 
X-CRM114-Status: GOOD (  16.18  )
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

> On Fri, Dec 10, 2021 at 08:56:48AM -0800, Keith Busch wrote:
>> I'm not sure having it be a new Kconfig option is a good idea since it
>> requires a recompile to enable/disable. Could this be toggled with a
>> static_key instead so we may disable/enable verbose logging at runtime?
> 
> We need to think about module size.  NVMe is not only used in big
> enterprise setups but also in deeply embedded scenarious these days.
> 
> I'm also not really convince of the usefulness (but also not strictly
> againt it), but if we support it it needs to be conditional.

Agree, the submitted patch made it conditional though.

