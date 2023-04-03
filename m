Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F27C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JZVg4/np5qvszfLT2babo0VhP1
	JW0Xq55n29IFhMPj+shi09A6X6514K5EWC7c22jHubxSkvXOO1F4mLQTDxuxG2Ofk4kbKMijKROvI
	RIcqGfFoejyknxAZCSzRRcCfKTpRXPKCn6PbUyKCJoL8ABqZIBAezCbrZOcPA+f6jixeSHFznU4H/
	3PGItut3k/TThIN3KB/thffOeUFqOUW6SN/TYktxJRM/FlxdKcb0EVPVZPUZLnmDV/H4hg/Kb/5xM
	vKjAXGvJH3IPE+6xEVnaqhjQUIzPeY5bFKqKoIXQuhhJG0qpaVvWvR0iE/6gCLsrURKNxAdOFEZyq
	OPgYqQLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSqb-00H6Uk-1O;
	Mon, 03 Apr 2023 22:40:21 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjSqZ-00H6TQ-0W
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:40:20 +0000
Received: by mail-ed1-f43.google.com with SMTP id b20so123333055edd.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 15:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561615; x=1683153615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nSsRgOTI6IP1p3vOKp+LtpX+mat2keY5xutmVze9RqjSiRPpdscvwElzNzKs4haxiH
         ovZnMLeZHeTExFy5R02Zb+nZJ8odNa0bJRe48ngH8h3dpssEDxJDj7yDQvbNWh3nJCyf
         lj8Ij8YIl0mye7z1Tvv0eeDsJ9snufKthxYpAZkDaES/v9f/B8coZa/4X43+RwZxMJe2
         KWdGsCbINOKWyhp/JojoJg5VrasyMX65/HoWbNZPMHMsjGMWUULpO4ma6He5MazAfK49
         T7J38DhujzrNbQgpQLJeA2GZFQ3BtoD9jDhjMv+uplx8g9fdOKg+vUjYvP+NHNEDo3r2
         0R9A==
X-Gm-Message-State: AAQBX9cBy5fR5r3EiCVh8ktJ+qYvuoJKDWUL0JhvonZTD/FDdftlJSmq
	/ofAb5mG0QtBLixWAwQcfQ8=
X-Google-Smtp-Source: AKy350ZxT+XYilRtSQIx7mYAZdjTjyb4tWOwrV/CxTjjNdHqkIaIwWqYLmV/c5omsGc3hhp7qSvRiQ==
X-Received: by 2002:a05:6402:524e:b0:4fd:2978:d80 with SMTP id t14-20020a056402524e00b004fd29780d80mr595748edd.1.1680561615447;
        Mon, 03 Apr 2023 15:40:15 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402518600b005028c376d50sm3863858edd.71.2023.04.03.15.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:40:15 -0700 (PDT)
Message-ID: <26d8a0b9-77d3-2976-08f0-c19a8a9e5aea@grimberg.me>
Date: Tue, 4 Apr 2023 01:40:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme: fix discard support without oncs
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Tom Yan <tom.ty89@gmail.com>,
 Laurence Oberman <loberman@redhat.com>
References: <20230403200925.1641963-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230403200925.1641963-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_154019_193825_8941C31F 
X-CRM114-Status: UNSURE (   6.43  )
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

