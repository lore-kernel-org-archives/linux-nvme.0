Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE79C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50CUTD+eXlDFcOOIGMT4jmUgN1KvlNlJfvsnt0dgNiQ=; b=OlVpSVeD2P3tUkWObM9EaKSU24
	5hITtPlL5RfVmYjem3c6Nq8M5yv7nCZQZv6YwS/+3B3IwbU26h1qUsBd0SlaIVpi4+NNxzkNUJGTs
	jZg3A3+ng+5akoeNIuWZKALlpRqDs3jhYXfR+aW91Krc7JFRfstIFlpFgra6r8cUP+b4OMeNxAcgc
	5pmLTIC9RDN1wrlCWX+lcsaE9TmUSe3+k6f48+481s1RjW6Lq4UDhd5v44sqEKmwmy0suFFfzdkqu
	w4EIQkCVdRm4CBkkHXmha/9z7ctlJo7TRGDfLa8ZOnbwjBGHNBn06gWfyrWHfpDehceEEEvdO4dbc
	KauNLheQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm9z-0000000ABHs-04S8;
	Fri, 31 Jan 2025 08:13:55 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm9v-0000000ABHB-3vjN
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:13:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43618283d48so12501325e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738311230; x=1738916030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50CUTD+eXlDFcOOIGMT4jmUgN1KvlNlJfvsnt0dgNiQ=;
        b=FVOrSfhedrbTCq51D7iQujFIcdQdbiSEh5wxLn3JWUCSKZHXhc13MPJ8sX2bRaCXY2
         LYJ3mYCkKFVAzDjgQUwb/6XJdUA5pvO7qAVx+0C/k7dV4TQ+2ihZKsv6554rFRLBxZJN
         goaEFB2prTKxVO5XWrePvjBmnctHhzYzGL6sE82csFRJXf0ntIRZUzNbcRHPegz0qcW7
         Kiea6F6FnSGCVSs1lLtsvcU8kFYWEdYPy5QhR/uCq1BBRkXbI6iQmWUtFBhzkQR4kqTn
         CzE/VPlBLZL3GfcJv+ujNNwx1Sc1mpOyrprsresm9U3mUzdQQZdyUIuIRLKG1UEWg2v6
         E0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjBALiigbVNrgbtkvexRq1573RFRPIyxZ8P4lmRsae9r9ta3PP2wx+2d8TPHxnlnz63hn6ZZz9hd18@lists.infradead.org
X-Gm-Message-State: AOJu0Yzs4vWh/m9H9WYiMQvxVj/LLA5QhtRhKIVaEtXmDyrToCpKELIH
	F+/SE5yzrOxAat2Wumwy6MQMsIf4s9I/0d+Ea/ullC5pruq6/2Rv
X-Gm-Gg: ASbGncuN78TYm5AjVcriuT2SaiQh5kwnHRO8E5eWv7uQOLUOJDGiEjAYYcGklRW8DBt
	ABXyXxhwB9xOxJfT95CdXDXwBASeFI0CPoisA16ijbkSS4YU4Ja17xrAhhYiHZAS4jcS5okCYPi
	AH8wY9JE9lKQfTmpkzL66kIH8MEL+8lOLPQgmmqPENqly9KaCHJFBS2aV1I+pJLUef9C/uuY9V9
	LE5iKd/gW9Io7POt6riei8kyAAS4LV5SQOKIU38zmCpFmsQJy6BZbM0OAhTkzmOO0m5FC2z43aX
	isMLpGxV8MJJCprDQmRSG+qpbD/xyI2t+NnL7WzQdZD8Omq0N60=
X-Google-Smtp-Source: AGHT+IEHmAcCX7brBdYswAnG+ah2odio1aZslsU8WT8VXhb3+lqKiizin7jbBKbTFIpnR2Acwshg1g==
X-Received: by 2002:a05:600c:5252:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-438dc3ca802mr92486035e9.13.1738311230257;
        Fri, 31 Jan 2025 00:13:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244f087sm46717975e9.29.2025.01.31.00.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:13:49 -0800 (PST)
Message-ID: <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me>
Date: Fri, 31 Jan 2025 10:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_001351_977218_613DF7A5 
X-CRM114-Status: GOOD (  12.09  )
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




On 28/01/2025 18:34, Daniel Wagner wrote:
> blk_mq_tagset_count_completed_reqs returns the number of completed
> requests. The only user of this function is
> blk_mq_tagset_wait_completed_request which wants to know how many
> request are not yet completed. Thus return the number of in flight
> requests and terminate the wait loop when there is no inflight request.
>
> Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")

Can you please describe what this patch is fixing? i.e. what is the 
observed bug?
It is not clear (to me) from the patch.

