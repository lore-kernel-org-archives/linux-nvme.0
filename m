Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F7EC10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 22:11:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6048D206CC
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oav4lYCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6048D206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=Oav4lYCvN7IxrKPtAyIWqFlSM
	tZv9Bgp4iXkGi/62vvLLChBT4C1KWjlJKhOoyCSqLyuVCeoFx6iasElaFz36wAp3qkQ3PsE6fSmVW
	ZGB4knvgZmiESWAGoxo4Cgn1QVQqPQ93HHj0b2VFvFiOUM/IcW9gXuKOOGlyRMtF5+If2pfrvb2rw
	8zp2t/X0niXYJjAWgZLWl1oXbsMsKjcd8v4fte9eJLQUqxm0lza03BYsP+DImiGT81OOM9+/p7lJT
	qQpAtIWJMQoplFmjLBOo3j1fcdqj4/hvo4EmkYPoBv+g8N1zdxEbvplKC5DgD6XA2MB3lKhFarBWP
	nJ7tGnhIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jALBu-0007zq-8t; Fri, 06 Mar 2020 22:11:34 +0000
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jALBr-0007zY-RQ
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 22:11:33 +0000
Received: by mail-ot1-f45.google.com with SMTP id x97so3999670ota.6
 for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2020 14:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OGvgRAYyo/30RE5dR1wjSfMCH8sFxdDsvB2Hm1WzL/6FFbxF1rMKI9mFLt6nEQ9pxQ
 BX4il+zz988iHyY+EEFH7XrDy4Ji48xzD9JbenWFTG70acRTiiU636x4TFEQXZRi5H+E
 qgrM06D1u3WCkqLIh4qnQ1Yi5QzPXa93rBiA4yATHWhpNR4Vh3f9jBSVsVRCDv6kBHYi
 tngdnqkJqo3U5UFyxeSLPqbfxnQuv4L8NFjZ1SMZRIG+aQEahYMPL24LOCzH74/xfxsY
 7XgqqoB4MhhGx7jY7q6RZcUjFTHN8H1JLFkzQlzIDt3oYkdpC6Y9sOPA7rH7fQqu+Wfb
 UCmA==
X-Gm-Message-State: ANhLgQ3AsJ6nVIW7dm6Qf9QT9FpTdbEQAovlThvXSbS6lDzDBrHp6rwn
 rmZjKLTo3ds9IX1GdJ7ai0V/H+We
X-Google-Smtp-Source: ADFU+vsjtyqrtGROKeGig2DHm6eUoMkvZ6ZSrmbyDYDXpMqQym/cabyDJzTNVY/u5BFZTk9Tt0bvIQ==
X-Received: by 2002:a05:6830:310a:: with SMTP id
 b10mr4326501ots.210.1583532689781; 
 Fri, 06 Mar 2020 14:11:29 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id e10sm280211oig.36.2020.03.06.14.11.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Mar 2020 14:11:26 -0800 (PST)
Subject: Re: [PATCH 1/3] nvmet/fc: Sanitize tgtport reference counting for LS
 requests
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200306130440.16864-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e7a58278-a8c3-2c84-c0cc-f556aaa4061a@grimberg.me>
Date: Fri, 6 Mar 2020 14:11:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306130440.16864-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_141131_887424_C2C12A4A 
X-CRM114-Status: UNSURE (   9.67  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
