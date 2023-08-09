Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20F2C0015E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=; b=xqiCX/QKZpHIKjOIAoyLPJ9B21
	Svmlr3DZIuABI6qP+BBloSPH7/HorYcLsGLHGC2jhzKWZxVThT0mHYWt1geDT9hf30Jd2Gu7xApag
	RpdpKiFWCpcTycbWwaH9r8JyWbx2fvaS2MXe0YjSEQmCEgeHd/gU/lpaS1Lv/hIOaazixrDhRCszh
	RXOt4Vjf2w7aQtpc1v9hA6x2d8z3AFGp97lWsW6ZQtEZOnqgrMxKXtanv3HhOEm3WxGDXhTLNLxKb
	3Oo/fF8WYH7I4LcBCk2dJ0HpqjSSxwjR6ih6NzH8cluFPwKimBLbld5HCT2zJS4zFUColwMRV+obm
	qt6zjUqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgOg-004X7D-1f;
	Wed, 09 Aug 2023 10:26:34 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgOd-004X6H-2c
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:26:32 +0000
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bd67facffso172300866b.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 03:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576788; x=1692181588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDkTR+M7f8PS8/be8iDMaJh7ylHTLs+4Ib+G3uFDhwA=;
        b=Gj+SWXJHXDZ1GTXuClsB+kuVjcAp9CW1SSpXUqC5HoIe79/5b04Hl4hvgUwai43Wpo
         t4dd8Y2GdUZ2Ji6BI+1WPzumgq5VtF48EHWeltqJteW4ToKdgOhzyMGz9XxXU8yU4pN0
         j1gPvabESz6YbtlSrvJJqIGWqqZ6RqjSCIICyjlktPkZ8wftIgSi61zkYKgyw+ladauE
         vNzuL9b02TGwNhRcogO691S5iqqJnbVt0CdO5871MpqIm526PST+y/auge5UKn5i6A1W
         OBfwCjTstGpMu3XR/lMuKuWXtjHOkWdg4NvMNeqgLWmq7lNSBD0uJsk1quQUV+LOT3Sc
         AOJA==
X-Gm-Message-State: AOJu0Yzztl7mXGRFaCWqc6kVxjLKuMsB7XqtVitViVWJ5H7FkKBVZiEh
	L5RU9wR8AAai7qdWdxqL0jk=
X-Google-Smtp-Source: AGHT+IHrrAYuiejzyXrEWwJQG5HwHifSLNIqSXY8KLeGf6VTsgIKRSyJ8eLSvh+Epiw0ZmQ9q9p55g==
X-Received: by 2002:a17:906:2d3:b0:99c:adfb:713 with SMTP id 19-20020a17090602d300b0099cadfb0713mr1588751ejk.5.1691576787417;
        Wed, 09 Aug 2023 03:26:27 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh21-20020a170906a0d500b00992bea2e9d2sm7734422ejb.62.2023.08.09.03.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:26:26 -0700 (PDT)
Message-ID: <397a62c6-2e60-2690-4d1d-88dba51f36bb@grimberg.me>
Date: Wed, 9 Aug 2023 13:26:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/16] nvmet-tcp: make nvmet_tcp_alloc_queue() a void
 function
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-13-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_032631_848455_0CB4CFED 
X-CRM114-Status: UNSURE (   6.85  )
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

