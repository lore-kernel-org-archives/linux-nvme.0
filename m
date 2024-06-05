Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94947C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=BX6qJW59JVn3YPecq/i6uieMJW
	jAR+Q5JMYjnKxDpynUfwtvdO8FVRvRTW6pkETHIJhRgthEDXTFG78KrVw7CsN7IYax5hVbv772xi6
	0Ty/odGRSX0EgQSX+SGI9NifLCiqNXnQ3Zfm+FV/XHQnkvNnRCkpEeDfqOfaAwZ4jVICLxaFbBVG4
	eCeUtn4tRiG93InBI+ywTnlbbzKgtVzudutu+5UXYBziJ6oLQo30CaHyvOdWWIm0uzaRpBeJdu4F+
	j6YbLaXuH5FB3u0wi4yABBWxELOhNu2WsDUOhEn40Ct2JJn3BZeEukdRdwo+qzc55AoVRD5BIAvlw
	HJ6UZIPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmR8-00000005J1H-0G44;
	Wed, 05 Jun 2024 08:56:02 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEmR4-00000005Iy1-1ZXF
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:55:59 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35e5495be42so372391f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 01:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577756; x=1718182556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=u3LGiyjEoEs4G0XnYitL9gdmb/n1bYWaFkscEjqufc0tbVSKEIC1abRHka+PVgcjg9
         g03oIeo+AJ9sCS2P/zJ+E6SSP53QICaZHbVqYPXABE93rU1lpNy4yja6m6+2971VL34O
         6naWZQWMqPdezN6FsqMrqGOD507fdDly5CxgZwdTlc0p3csF1OoNmDRgM8pR1eTM3ZGM
         c45Ryu7v/xbOs12x1XZNJF4M5OJaU6YDo1MGodgaR4MUUF+ttYNAO5qfx30JuVaUJ69L
         G0V7Zt6W+EJJHVM/mZApFh9HBiIX5H/daqi0i7dFoGV3Ltvd9uIRooCXZf1HijWGfeh+
         QOIA==
X-Forwarded-Encrypted: i=1; AJvYcCWUDV5NBIMIuIWHkQJ+I45EUswcQ78kuMfFJC3tj3reM4z+STa3MtqPhm3jFUCKFMOXljbuePsIole5guWrXGm58hUKa2hf3kTtIHrFts4=
X-Gm-Message-State: AOJu0YzkqwxPmEamcfcAlOssZ+mN1eVxnJyNWuYANXsLqwTXxnXYmkrQ
	9YUfqIHvjXLfkRcfE9cvbVnP6QxMLku/eMxueu7LnyEdHG3iL+1Q
X-Google-Smtp-Source: AGHT+IExSLu8wEiDfBwhUZVEnyiJ1jHaLGX9fyEvJ3fsf562UKpb0UpECmigQh//ct0/fu7NTHXe4g==
X-Received: by 2002:a5d:6b8b:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35e8ef92d34mr1161661f8f.5.1717577755611;
        Wed, 05 Jun 2024 01:55:55 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca48dsm13832935f8f.29.2024.06.05.01.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:55:55 -0700 (PDT)
Message-ID: <a574a6bb-317e-41cc-9adb-ef0431e100c9@grimberg.me>
Date: Wed, 5 Jun 2024 11:55:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvme: rename CDR/MORE/DNR to NVME_STATUS_*
To: Weiwen Hu <huweiwen@linux.alibaba.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
 <20240603125702.97368-4-huweiwen@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240603125702.97368-4-huweiwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_015558_420105_CB0D0635 
X-CRM114-Status: UNSURE (   5.22  )
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

