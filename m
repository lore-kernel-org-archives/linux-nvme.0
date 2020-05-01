Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A061C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4414324953
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxNuZlO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4414324953
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=MxNuZlO8mPOuJKJsre/tovCo6
	u00cYdidxUbhR9iSveYmQ8v1lM6JZtwBSNSR1rzgLsz65qtUoWL87h60O+Z81W3NFnVU1RWBMDifg
	8WQtwlu9KIbHXVleLP7rpwo3bPx8URplrVtBxktsWzuqLAyiW9ziWU1mePpfGoDV8ef0MgfnJ9I+A
	lquvq9GlgddarFYbUR0+kCORRv3+lNRZ4/tEJd5+UQiZtH9PdK3YEampwbL0kx0o0D3tazea0Hg6l
	hmmHKfCZecTv8j4VTbIFOwNXKMrvUxZeiFHIXrRSO8tcwBM7oqj5NUfZBag8vpODYMFbKdLJnwebc
	fg7S7+0MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUY3W-0005K0-7Z; Fri, 01 May 2020 15:58:26 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUY3R-0005Ij-Jo
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 15:58:24 +0000
Received: by mail-pf1-f194.google.com with SMTP id x15so1759306pfa.1
 for <linux-nvme@lists.infradead.org>; Fri, 01 May 2020 08:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=O0qxKJMtTIoFrJW0bY9L0lEDz8VUWusgkwJuB1hg/gMCDThKmukV4TMGtwM+/fUyh3
 eC63AJ31LQj59t7JzKBPWH7o9NyCU+Q5xj8QCLqfXeUuJhRtQ4oWo59bUOMlqqY4DV/4
 dAAcM4jSOtDRWRFr7IoKrJkVjXt7oJETEbtLy38ntNRkfFw6EYocMq5gTjGeF0iIhkvu
 JfBM+3rNHhGurpH0asnKwQdVNlyvTEeAeHVhmOea5hvuKae12lIlF0Ch4sSOy21uypSr
 KuQDjMgFZMmWTyYu1SK16i9RR3r1j7nT5e1RWygS2R06qNEzqC1OqXjZUlTGbOeh9JuV
 A3CA==
X-Gm-Message-State: AGi0Pubi+E2moSRB2eB80rDXdLQY8ki5uao+hfUotF3xh54I3PCjMdHu
 PIKBR3tkB4PRTtjhzjb8fglBtuFc
X-Google-Smtp-Source: APiQypIRnzZOzWylca3oSROMFi5grStmRWG4IrUOekUPB/5yliR9IT6O0OX9IDBjUJjEpzQ1y7hWEw==
X-Received: by 2002:a63:5907:: with SMTP id n7mr4663532pgb.439.1588348700357; 
 Fri, 01 May 2020 08:58:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c3:8135:9a7c:5f17?
 ([2601:647:4802:9070:4c3:8135:9a7c:5f17])
 by smtp.gmail.com with ESMTPSA id o6sm2596015pfp.172.2020.05.01.08.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 08:58:19 -0700 (PDT)
Subject: Re: [PATCH] nvme-multipath: stop using ->queuedata
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
References: <20200501130825.2627529-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8954836-e846-c9a2-7604-84b8070a7d03@grimberg.me>
Date: Fri, 1 May 2020 08:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501130825.2627529-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_085821_646759_93E6D27A 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
