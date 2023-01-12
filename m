Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D56CC61DB3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xodou0l4BaDnnpBfVnK1ZD7KmHNFP+cawJfYdg7Sq9k=; b=OwFRY8RKJFxW7SYqzhyaqYsKt1
	gofwpBNEVH3vePH8aQM0BQRVKqMzL1ZBsV0FT9aDbWP+Kv12gj75jebLopsXq+hTDDQtA1gSUXcf5
	LWRtSYAjwvebOLbzSTRtLQf7D+63ZwFR3+HQArgP0c+3z7+wQCkdJ81wFBE9x6WBWI2znfN/UROAP
	D8pSIz0aE+7ZyTj0i7pvPgzgceMxm++ZpZTNO9ATGPKCQHFC+SwSKM3yJ7+0hybgfTTWkO+ujYVl7
	YsQuxIuYp4JiiZYW35MsZ6A0AN/TkSjcOEc7ZKrYIDE14BlNlARYTjNBmDDUNwSbUWJxY7AoBHj8M
	wHENRF4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1AL-00Fz8F-K0; Thu, 12 Jan 2023 17:15:01 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG1AI-00Fz7F-JQ
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 17:14:59 +0000
Received: by mail-pl1-f170.google.com with SMTP id b17so13366474pld.7
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 09:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xodou0l4BaDnnpBfVnK1ZD7KmHNFP+cawJfYdg7Sq9k=;
        b=eCgtquiUZM9ErhxgRLz/97Qm7o3/RjFx+rENyEuG4Lom6HipRKZWiGtqnxJuuxcTry
         asFe+f81hv2IPK4x8tVkPhYAVNrTQ8i5xNNOL6LzLs+7LMnt4I87GtaML4vEjYmw/fg/
         zEIzjxE58zGWROojhdoPr8cORvMxGf+4CoPYOOfB+udtX4+EMOMA6ujVY5AMI92z/em3
         UDIn1vskf8C2qcJPhKR442aSjf5dtYc6tJL0pbKocyD+ABG4OrwNRavZRv6lBbSg/Phj
         xozz1LpKWQt1hkTAu3TTEGxGJug3SEmwPH7qZ8WFne2ClcOB1w2zuIua2euETB66Baul
         QPqw==
X-Gm-Message-State: AFqh2krD4DDpxGN2xRoQ2VxwS3WZbuh/rQsoOugMs6hC/EaCif5WeCHq
	hArEJLJqRvCetEREfLvLeQ0=
X-Google-Smtp-Source: AMrXdXu1T6TtiWxdui0JTEYYQiVYrf+UhwqQFOxRLuIMlT63emy0C4S+sP9uXpGS2+v61jy8xEG3Ew==
X-Received: by 2002:a05:6a20:8362:b0:ac:7a44:db55 with SMTP id z34-20020a056a20836200b000ac7a44db55mr75570934pzc.39.1673543696606;
        Thu, 12 Jan 2023 09:14:56 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3345:7bfe:9541:882b? ([2620:15c:211:201:3345:7bfe:9541:882b])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001930b189b32sm5680480pli.189.2023.01.12.09.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:14:55 -0800 (PST)
Message-ID: <ccc8bedc-1ca0-5da5-289d-330d7a494360@acm.org>
Date: Thu, 12 Jan 2023 09:14:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 damien.lemoal@opensource.wdc.com, gost.dev@samsung.com, snitzer@kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20230110143635.77300-1-p.raghav@samsung.com>
 <CGME20230110143638eucas1p1551ada551876f82df671162860f08d7d@eucas1p1.samsung.com>
 <20230110143635.77300-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230110143635.77300-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_091458_664579_5F2F07C4 
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

On 1/10/23 06:36, Pankaj Raghav wrote:
> Instead of open coding to check for zone start, add a helper to improve
> readability and store the logic in one place.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


