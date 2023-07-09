Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE92EB64DC
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Jul 2023 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=aAV3GbloYx9TPCRslVYlOQ0FQ5
	MqvMTzMe7gXDTCcN4/VO/Iimzcf99yztmY+aeNzyiUCZEjKQUk7xzEoMXKhwhjxgKQ5i+O0w/gNRr
	rcAouq1AsAOb6qmdajkOxV1HPDyrPA3nvUyOr+uRvzZSekP+Btn97JDhK9facmddAAAIaoeJYWXTb
	CMOA0TB2Un0oUWWZwNxHHSUt9rW9dXvPzKq3DD8XUwe+bdo9xHtGoOE/OttcQ7otHydlQiVu1XmO5
	ogRB4TShjmC5ErYwT08Mp0/GZ3bPoxc4cWavVCV5nKs+/Yq8HyFHD3mlpL+gQCdqWa8z/Ij0PmH/R
	zHjqGPjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIOwI-008bBj-02;
	Sun, 09 Jul 2023 07:34:38 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIOw9-008bBD-1f
	for linux-nvme@lists.infradead.org;
	Sun, 09 Jul 2023 07:34:31 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3159709a705so78293f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 09 Jul 2023 00:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688888065; x=1691480065;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Lsy50LzuZjpa22SzesebZgJg55jvWfK81YfCMCsRlX/tSxC4Ia+htw0ap97Ml0VfFH
         CxnfOIYENuUAdKXFZ+qWUryJYi+FUjCPmwn6azhr6B1xqt42UWZ9HRsyQEtiid2ktJK6
         f37Ood1N3+7K0cGoWP6CJnCr/IbgedHg7fWAPRP1p894zDOFSZ0wJeBBojEobcjqYqgy
         bXHZOXTI0VnrKLOFXbybXafiQoikZk/KHFKOHbH9ldMW9m7jrJqBM4eXdjKUu4eqP7oW
         HNbrDWrIY76c+cdIpQr9+V7hZwetNZNV28oT6CsaO9j0CijNcLsnzItD0bgPnEglA4hD
         kycQ==
X-Gm-Message-State: ABy/qLYNuCIBD6BMgQ03OuKIGgTNgs9qDGhhddOCMImk4Buml1klnpnh
	zZIKSPZIdPRZo3CrkQg2KpylZPRUJ0g=
X-Google-Smtp-Source: APBJJlGO61p9jSwG0FQkdzhC7ch8DtsA+hu+PsSZHfT2pNLFtAe6KYoi8dwROTQ9LshVYh67i0qaAg==
X-Received: by 2002:a5d:42ca:0:b0:314:3dd7:bb9e with SMTP id t10-20020a5d42ca000000b003143dd7bb9emr7565015wrr.7.1688888064609;
        Sun, 09 Jul 2023 00:34:24 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id b8-20020adfe308000000b003143c06135bsm8557881wrj.50.2023.07.09.00.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 00:34:23 -0700 (PDT)
Message-ID: <45bfa8ac-2493-dcce-37d6-f8d27b3b9313@grimberg.me>
Date: Sun, 9 Jul 2023 10:34:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: use PAGE_SECTORS_SHIFT
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20230707003222.5854-1-dlemoal@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707003222.5854-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_003429_576090_9AB5B875 
X-CRM114-Status: UNSURE (   6.01  )
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

