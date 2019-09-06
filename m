Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D8C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6933D20842
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FzvzVb7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6933D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=FzvzVb7Cybb37H/JHTzIx+5hv
	Yk89mEwBUVLovQgiXA4IhR9q+C3C2jR/lrbfEO9zeiXcD/dekpVHMEWhFWp+hR+T8lLh0OWpVpD6S
	JVGIIh5aGIt8A6p86mWmtBKv7OS1XnZgOIO6uAlXTMfu3lOBuEnAA2beSyeefh6Yx9GIw9IRlSyY5
	tR3lUGWyHfNA8vdJHCpDqjIHv8BkAArWm4RssbkIH2ScZVQBQsEXBDA4Fb6nJw3LNwtVDa7GJuOZm
	LZ0FyDoblUvq2Fvt3CaIjJS8ysClQrA3wSsTkh6rtAC74Wt9Q3Dp3rxRsCZbbzMHuGzCrjRkbwZOA
	5QjSRzamw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6NkV-0003w5-Ci; Fri, 06 Sep 2019 23:34:39 +0000
Received: from mail-oi1-f180.google.com ([209.85.167.180])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6NkS-0003t6-K5
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:34:37 +0000
Received: by mail-oi1-f180.google.com with SMTP id a127so6431004oii.2
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=cr7PUmoUrMyCSQ9gqCALRAzBPib4XO3Av8SX41E3xqGmC90+v3M1ZI58ppnFEbj38S
 X/+75QtQp5N82uh9aU66Bzo5fh3UqVCuCHiz0CrT2TlK3TsPktxL4zkC+qf8HnPd6hZR
 zXdHb/dfVfIoWNPmVSGXXU+DZ1xTTTKbuWMG+YB7RCZ1O59DcHXFgsMLIeuaaf+Klp4s
 tVy5dfK92+9xUZwO4TO6GlFXTHtSMvZROAQKOdVgjww9VPkeMbUIxxAkBUeXgy8Lo4e2
 MzLdtL5n9dIio+6ugmfzGsCgB+xnXXtg8O/CWkZqiGCckco/SssGjtnRphyGXgKYdHE5
 MyWw==
X-Gm-Message-State: APjAAAU6lmSN4/ijtzk5ry2JdK4y1MPJa1OhC4F9dQTi/zvUV/UvBxbm
 F1PG2tBQZEbqfE9L+fZt6HQ=
X-Google-Smtp-Source: APXvYqzifzefx7xQBDvAeraF61Gz2AeK2gogdAA47kIXIDPvYrgYZBG2M0FirwBGWf4fb+mVS7/VuA==
X-Received: by 2002:aca:d602:: with SMTP id n2mr9082105oig.148.1567812875665; 
 Fri, 06 Sep 2019 16:34:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 36sm2816041ott.66.2019.09.06.16.34.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:34:35 -0700 (PDT)
Subject: Re: [PATCH v8 04/13] nvmet: make nvmet_copy_ns_identifier() non-static
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-5-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29d962cd-849a-cd31-1bf2-7fd47d06f116@grimberg.me>
Date: Fri, 6 Sep 2019 16:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-5-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163436_664145_C4EACFE7 
X-CRM114-Status: UNSURE (   9.58  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
