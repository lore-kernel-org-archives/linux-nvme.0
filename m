Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91670C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hVCg8D81wPT2qMFpGuzk14zv8S
	fB5ErkK6jxX6oMl1AHblluKegoFTm6h8kL+D50/uPdTnSK0p3ttfA2uXMeHYKfRyfyz8pBo1O5CJ+
	TNf6eOjTuU+se4zLERK8bgGjG7hxqdIBVL3yNd7do45RLsK9IyK0atZewdeiTK1Q+BwtQkUaB5WoL
	iwJv2ssXcjjtxKVmLVUvfJY8BK7xv6lydz/DkeQe/uH+5mD33E+CkH2/L2ehuhww7i1VtO+hFotwG
	af2jB/3+ajWUmrGmHvx4kA/Aj+cR1CSHl3YKvFlJZlzQkuoSwwaC91RZyBbhSEqHmvZgfO+qz44Wz
	7KjPXutw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petaK-00F7sc-29;
	Wed, 22 Mar 2023 08:12:40 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petaI-00F7rj-24
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:12:39 +0000
Received: by mail-wm1-f49.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so10858378wmq.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CmRMzORZXJLsWOWx0ciDWn6DrWQ4kMLC884haxqcb4i6aowX5mHMH1tBC/SrExKGTb
         1J3W205qSf5tR09OiB4xI8Nr6OKidajYGW5AVQuoazrHZWWp0ioCxLUNWjhRlO28MTid
         HJSPIbEKi+k5myARosNEha+mwKBDTa6pCirxs0Dgk+921mhYPEawiYNfnCbnVogUicVO
         32BHlGKI/vacRoJVVU/PtJrDczf2GtmVCitRM2t0Af19TOXkSHhNGdntm316+TB6s+bE
         1w6mXj/yAzr7kqYkH8xkm4OofZhL0nER8g/DU3MfkEWQugQ936wmOUSrZFi4fPNaCJb5
         Z//w==
X-Gm-Message-State: AO0yUKVoWQXWY81mfCDvTyZgh5WR1CKUG4JoX1ous5QnerQ7Fx0n5hPs
	1g8kN3kAbSwC9rQsOVHSHCaHhbbtYN8=
X-Google-Smtp-Source: AK7set9/mPA3jTF4vuQAKwXKxYuuyiJtwvMH9mEZw1IqjXVyVXUvtMTIFnNuB3ivLFbR7G1x+aI5Uw==
X-Received: by 2002:a05:600c:4515:b0:3ed:2eb5:c2e6 with SMTP id t21-20020a05600c451500b003ed2eb5c2e6mr5562864wmo.2.1679472752895;
        Wed, 22 Mar 2023 01:12:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003ebff290a52sm22649124wmo.28.2023.03.22.01.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:12:32 -0700 (PDT)
Message-ID: <47f65a76-a6c4-584f-c9d8-a1ab04032fe7@grimberg.me>
Date: Wed, 22 Mar 2023 10:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmet: remove nvmet_req_cns_error_complete
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20230322080930.230269-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322080930.230269-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011238_680186_CD9E882F 
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

