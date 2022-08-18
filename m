Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F5C00140
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Aug 2022 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVQ+WBq+5u751FInx0j8YvBG1z0BYpuxlDZgTdqDruE=; b=sDORh/jtCy9az3nJTR8vfH5Rd8
	H1Off1Uz+2UfOMVbKi8m48d1/kitu9PE52P0yavkOPGvRKvEY6ejbO2mmal2lDegJliqUjTTVhV+H
	XkNlEro/BQC58gM5zvawGWGNVV5H/ulox2F4+fVq/0ofP46yXw6B4IyEmvfsIrJ3xk7X3Cl9dOrRA
	5pabAKxwkL+wRZ8Of6qi3cmOuzVzyNne23MMCrpl0Yw5HeAAroG7p8VerY6Ujlg4EeIXn8mJjs656
	gVE6/8RJe4JdAYG/Xbo2bp+TP1ATZxguRhQ5HKPCbrThbECKD2IfUb05m8pXpYyll3X4BPUqxIGXK
	z+AjhVyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOdyK-003xLi-Dt; Thu, 18 Aug 2022 11:46:00 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOdyH-003xEw-Fv
	for linux-nvme@lists.infradead.org; Thu, 18 Aug 2022 11:45:58 +0000
Received: by mail-wr1-f52.google.com with SMTP id a4so1449971wrq.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Aug 2022 04:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fVQ+WBq+5u751FInx0j8YvBG1z0BYpuxlDZgTdqDruE=;
        b=LjLVfxqVl8h3dVlnn1zoJ1/2Pn28ZvA8rROYHZ1NLj2+EqGEvGTwO8QuNwRzw6yES/
         drzDaJ5P+LrwtyS1aaF8vXpQLb5UBZ++Ukx72ED2poSAk1Mmoy6y3cBkHAOcRIQJWNcL
         aiDarDD6gl0XFrlDJ+vZ+8t3UInr75upXhhMlSIEEI7DvBZqiPmo3JId5JqNfO1eG3JR
         C9GLYohl3R7CRY0j8FA+5TmcxEmuCbGnck6K2BpGQ7+U3NUsokPAmmjMHZZ8OCod4xLW
         l1e5MJ72eaVt71Ln4Tgu8N2bzWYecxzdw9PHJJbpe/idRyFwav8c+i9Jl7oJ9Z3OPsae
         AAzg==
X-Gm-Message-State: ACgBeo2xtPUHu99hTOTnqNqpFBv0gx6sOh6yWJZhYqt1X5Q2DIPi65d8
	B2hrw+O+rGYkWSYNYaJdrWs=
X-Google-Smtp-Source: AA6agR7qghW7GIkoW61fQp0fdJ8NJ6+k3Fz3ev/G3v9kBwsfSN5qSHhfFc5dqUJe9tnogfQlnAeOWA==
X-Received: by 2002:a5d:40cc:0:b0:225:26dc:938e with SMTP id b12-20020a5d40cc000000b0022526dc938emr1471492wrq.297.1660823153415;
        Thu, 18 Aug 2022 04:45:53 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003a5c2abc412sm6482523wmp.44.2022.08.18.04.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 04:45:51 -0700 (PDT)
Message-ID: <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
Date: Thu, 18 Aug 2022 14:45:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Ira Weiny <ira.weiny@intel.com>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220817184519.25141-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220818_044557_575141_2397BF3A 
X-CRM114-Status: UNSURE (   6.76  )
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

Fabio, did you run blktests?

The simplest thing you can do is:

$ git clone https://github.com/osandov/blktests.git
$ cd blktests
$ nvme_trtype=tcp ./check nvme

