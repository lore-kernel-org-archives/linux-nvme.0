Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA04C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IBMj2PoAC8po2jTTXF/lcftntgqScghL6weij5Q4iOk=; b=RpOsi4j7sfDyp3VodW3T9diBCb
	wFMD7DhYaZoNkNERUG9ovvpsQuPcP7+5fls4v1TwOxKMTy79rHYOlaKPBi58bdRwOrs3xlpX2jOdu
	oAFRmm0srPecQHvhiiWPvwc2uiyEYLdXGShbjyepsaqfgPW3FsC6DVWE1t044ZPiSzN3ixpuIOAbA
	M/QrZZh5wl3lI1udcMT+Psz2fFPhNqK/5pXADm/pPuC+YY7floksrPHREC4pKq6kNvALUXdX6VQiZ
	khucfRmzHYxfih6eI2ISp24QKkXIdVbrAwWXZgm06XgB+XN0Am/4x7Q3wxQhLHyd2g0MUtYqAfbzr
	BgMrTRaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQYl-00GnrV-37;
	Mon, 17 Apr 2023 15:14:27 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQYj-00GnqC-0N
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:14:26 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so10490665e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681744464; x=1684336464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBMj2PoAC8po2jTTXF/lcftntgqScghL6weij5Q4iOk=;
        b=eDgT5UPQn/MVGpDNd9Px3mf5/Nep/GS5LrpU5mMjcgqtmLGDvzmd6c8m6NTNcXODjy
         Qz+TpyvFkdNsggi7twDijXU5MFFBLdwUZkZDs92fqhTANyeruhCgKpj4enM2ouSuXy+y
         PzKSvBVCYtfGWvvDt2pmTrUyBeAytzydDp9/IOotesdvIfl6pbxOOGkGhFnW6jIBrnX/
         k9uN11R8KfnhD8qoxhTuA2WW57Z6C8YGvRg6F72NVN/M5B0/y42mG0e0u5O2TiZVAY2s
         e/c5mYxTel2UeXi80NEsg0h6DqsNW4K6+kIdRqAb3/hMCvYnByuUEbo/ugsZWDd23iiw
         OR3g==
X-Gm-Message-State: AAQBX9fR8YofIJ6RmO2M91yUkLHgsxx2z1uHKp3un7gZUpHsY2ocpD7t
	q4w0z5S2afv0HZsfpLTgfkc=
X-Google-Smtp-Source: AKy350bpXc+yI3Gdn3/cA+cAl4pjIHePGshs7NAiTjBUBlqie0F/fP4QMzwSiUyx7eymTQ0dMqBJ3A==
X-Received: by 2002:a05:600c:1ca6:b0:3f0:9deb:c60a with SMTP id k38-20020a05600c1ca600b003f09debc60amr8463391wms.4.1681744463802;
        Mon, 17 Apr 2023 08:14:23 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm16105909wmo.48.2023.04.17.08.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:14:23 -0700 (PDT)
Message-ID: <e8912f5b-c523-a682-f28e-fa89872df58f@grimberg.me>
Date: Mon, 17 Apr 2023 18:14:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/18] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417130302.86274-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_081425_150623_8B5EF2CC 
X-CRM114-Status: UNSURE (   8.21  )
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

> Implement ->read_sock() function for use with nvme-tcp.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>

This needs a review from Jakub/Boris/John...

