Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:31:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DF7610D1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3DF7610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=G/+g2r7pIGkqIuo5fi47/SeaEu
	DQ5PU8N6QS3eumC9+sWBnnrr9W2cPHiOEsHp1f0Hcs5bJIr2t///2MyciikCsaZxuecdQMyXU4ttM
	Jaswb3huOnHL3D6Y4OuS6Kt98Plw/I/5Dv6zmTKBuMzj94n7UAvYmAO3o6Nj9cjxA5CevFQCDC35z
	ll3anUBKgEG9dPMtflvMz29CYrIhMveNHlaH5So3LjUBKyG/8mcaWUAqeIn73TTV9eC0ESzmKDI/u
	0w3qZfMORTvsrLPrs1xdszDsbMxZX4Ztg4Y5vKzJ7GtqQSRHSYOj3VXywGgzEIgaFpZioQq/hRVW9
	t36D6QjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQRGP-008hMv-Dg; Wed, 15 Sep 2021 09:31:33 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQRGN-008hMK-AC
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 09:31:32 +0000
Received: by mail-wm1-f45.google.com with SMTP id 140so1664271wma.0
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=SMgYYYznr1IveiQCTJIgTp/ydZ0ZQ1gJVOWYUvbuDsH3l78W+Vrisg0bLuen8u7pDX
 1NggW7JGXUSyhe3giv4/fBkqSlsdsgbHyOaoQAMnscbWlyVUChU8qrGh043QCEGcTAsM
 fAMfO8Q68sUxzpu5pwCcekvLwIiYZkwsqEyArcKWSJb3bCaNla5vxRJICacYm+bHQTjO
 BMEgR/sctNK9/jSlq7fkCbOhdqX+paa88QvI/m/hqKYx1JLmjZdMkLTVDIPYojcLOZHw
 /WN/WIGswjYfYQosWYXB29hFtFYfVFaZVlKxZT8Dfj4B/4/PkS8KWW9jw00WWb0vzTAH
 +blA==
X-Gm-Message-State: AOAM533Ap2XVsQy591q3mNIPXsJBzQcqQ6q//AGuVHIs9fovyEaKrIwP
 kcZ0P9/JjFYBuwqNH2EhrCPbSo8/Qtc=
X-Google-Smtp-Source: ABdhPJxYeNJF33TKIG0GiDixV/BtW8PbDa+65kid5Tz33TFXhjeps1J7jy9qtLeWXy7R2hHSTb6gqg==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr3458663wmg.25.1631698288065; 
 Wed, 15 Sep 2021 02:31:28 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id y8sm5961829wrh.44.2021.09.15.02.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 02:31:27 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: keep ctrl->namespaces ordered
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
References: <20210915082449.1058141-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <77021635-b6d0-b97b-c5c4-86214e392fd0@grimberg.me>
Date: Wed, 15 Sep 2021 12:31:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915082449.1058141-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_023131_403000_DD537B24 
X-CRM114-Status: UNSURE (   9.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
