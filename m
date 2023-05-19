Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9FDC77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 03:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vl22JpGZsA9Vr0JdNKeCOhOImBidfY/2HAgnlADkxLg=; b=PPYWAcN14kw4pDlT41V7oQ3TJ3
	Fj9mASy6+HMR0sQlERPIukUiy8bSa9trX4mfRHrFpl2lMM0hn20aPiV59Liy/pS087aR/HtUVd3CX
	j/i7GaurkdLvjhjAvxaJtISTcUrvPZNOvLhX0PJoEUrLMepwG/xoEieehggjwAjwhJnGXMYAxIP9A
	NFZARoL8amdX7t3cWAAX/Ojx2UIHDNLW9p0tadU2GQCfWzM56rIhZxHgCX5eavHTKQyWKf570WITA
	+I01FGa3FqgBHLgc/AtgsxeN3WvIAK9aLKMY2AaZ4nb7+Ey0bbPfIOCNH4V/26c4JC9IlxYIPeBvb
	QUilBWKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzqMK-00EtL6-20;
	Fri, 19 May 2023 03:00:48 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpDJ-00Eizk-1e
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 01:47:27 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439e53ed82so560189b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684460842; x=1687052842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vl22JpGZsA9Vr0JdNKeCOhOImBidfY/2HAgnlADkxLg=;
        b=hm5NRkglZA5MVpaJYwpdoygLt+gSgUXD5Okow/oTxfreXdk3agOgpXeycol6BDxpuz
         8GT8EOO4YfFTfs5fK77VGJHeDqBNDKuXQeJdDstksH3p7MUWn5Z3/rdCgRRdeuRhhwkX
         OUihlwJKu8hDHMU0z1LCwc9tl+QUrKNc0kjqHfo8cZpC6rs5vXpfY8PYF5jnpAH37nq9
         n/A5U+e2LZobTX9XWSt5q5vTnVE7sFvIWD8pOTUCy/KbEC8jOKu5wKqYvGSwfEe+m5FQ
         6eUuaxtM+Qb8mhpPG+0OuVRMdZAQu6E+igDXFt6YKPYO50BE26rAqaU89S3d3/1wddC4
         Loxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460842; x=1687052842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl22JpGZsA9Vr0JdNKeCOhOImBidfY/2HAgnlADkxLg=;
        b=EcjL2Y3NzODTVPTw1SSDb6JtFjPLGWdtRCk2MmMyB+jU4JCWFYiM+fNA9CQI5zrwyh
         ACjKXrOh4uEWDjW8LNtjfBUz76FP3svV/ikpTB7b/OJ7wl25M9vrpWdjJgghFrwL2ZnL
         w1j8EiLsqqHEGQsjxGUeeN6Ig71iZv3kQY/5WRACXczuyCwOxpuzyN0smx/ed9jdaz5d
         KwV+SmHRzAPUbQb39fn/OiK3KHwrWmTrMtURrCpMcMLiLF4a2QeAb2GvZ/+UtlQpxji8
         IXPWCWTTPGqwjBllKqCqIJ9JLMbI95IpH1+26NdlHNWQ8uJhPX6OGsD2jL7zatbQUVru
         y0aQ==
X-Gm-Message-State: AC+VfDwtsOHxJHelfO+/qcEGfFCLlAzAEZJ8Ent6v+rrGLkaPM30A2Y0
	ZPBoefaXeUz/iC8bvigdp4r9pmMI1BQIWw/QZxk=
X-Google-Smtp-Source: ACHHUZ4btWCEXN/y0WJMozXzTwrBpCm/2FKYBGOLXBOEs1TkTySJS4QbXbTs4Qga9lEIj2jRymIPBA==
X-Received: by 2002:a05:6a00:1c91:b0:63d:2d6a:47be with SMTP id y17-20020a056a001c9100b0063d2d6a47bemr935180pfw.2.1684460842464;
        Thu, 18 May 2023 18:47:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0064559b58eb8sm1921687pfo.154.2023.05.18.18.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:47:21 -0700 (PDT)
Message-ID: <2f5cfeae-84f6-d00c-b611-ac85ad504126@kernel.dk>
Date: Thu, 18 May 2023 19:47:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.4
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZGbU0OOVRGRBeL+I@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZGbU0OOVRGRBeL+I@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_184725_573423_0E0FCCCD 
X-CRM114-Status: GOOD (  10.76  )
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

On 5/18/23 7:45 PM, Keith Busch wrote:
> The following changes since commit 7949aa46bb4b5c5e43ba3ba8298ffcb48bebf0ff:
> 
>   mailmap: add mailmap entries for Jens Axboe (2023-04-30 16:16:45 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.4-2023-05-18
> 
> for you to fetch changes up to 0649728123cf6a5518e154b4e1735fc85ea4f55c:
> 
>   nvme-pci: Add quirk for Teamgroup MP33 SSD (2023-05-18 17:53:55 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.4
> 
>  - More device quirks (Sagi, Hristo, Adrian, Daniel)
>  - Controller delete race (Maurizo)
>  - Multipath cleanup fix (Christoph)

Pulled, thanks.

-- 
Jens Axboe



