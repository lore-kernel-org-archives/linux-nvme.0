Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB0EC4452B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=; b=Rd2wgtSwRVzhh/aV5u5kn7rnge
	y6lcTjH14d9tJ+p62rqouz2RCeix/u7QkqvGGCeHznrAYCBesYEn9WfVGr1MNRXqWFIL+8ZapExhD
	jsWUx0nuXbl/VnF/PuWwy515b7ucMq/tLP2NfS5iTPIxfQn4UPGOBn7x3huTVZHNJae6ddEncAxA0
	OMomc86Rz9zUzxw9mGg5Oklgi8imUbFbCaEIwy7A/jaKAHKz/g28zTNnHnyGt7asuekOkFg5kgDhB
	bjyvT3Nq6AlxRgS13Px7x4lzivIkqa1Y4zENN/815Kad1M7teRfVMXLcCeFUOLNF1lLZCV4gqIs6+
	iPcrosPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEdV-0000000A6hq-28JY;
	Tue, 21 Jul 2026 17:52:09 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEdS-0000000A6gv-3zF4
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:52:08 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38511175ad3so9466846a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656326; cv=none;
        d=google.com; s=arc-20260327;
        b=TZPKAYwqDST50Q+LvMx/hTcHqFniaJm3oH0bFdARRUOAXq4fflp+L7U7ttQt1QbzLn
         lUAO/Jw93oW/2v7F1XnC9ohzA2edjoYYbWhnkz0Z/3HqQLuWXASZkQOo8Byw2laR7DV7
         sxnAwemcZgdIRikPmgtKbnhEGhxili8B1OQkwC22E05DplfNiG3xG98JjuGYvdeBVIYP
         ThtCDwWJdrlPbPbCrCAbSJ8y6beDknyU6sT+OpDQQKLafS1/pVRag+D0zwjgQS+gIIEX
         5tuwmqOjqIUjSBPFQ81/+x8qz4sCmFOm1GWyhH0HV3AY4GgPrTIMkj5MGfxzwTOWlglX
         ngSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        fh=o/veFJrKWAz/GB/ycHF2eE3BWh5r20xIU/hgN6cv9GY=;
        b=IlkDnlvd1Dee2hNPAAHDDBEFlXR8LeHuhJqhShLEt6HGKbFBawDGaACNz0qE3m8CjP
         bxzKJkWlV0EHT/PmSoAqwl9nXvpJjmbXgscHvZq2vtE+1AkPHVgyu09Hafbr3jJW0igA
         oQvAXA6S0wGIKIzkDIOtmbv2anxXDzN64VV0Hz7ExN5ZpNqPSyLlmzP+/bZmJEetDqXA
         Kx/Eg6v3D8Su3MMhQ9QXDZso/z/ApM0dPiXPnktlDbhJzAWcJtLGwb4kYMoLIkHQJc/p
         7QDspaNblMr0q/ZhcnnGOvqK71idZrd1p3YJpbVhm7IhbsW1hjtremHM6t4BkgCDPGcZ
         DzOg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656326; x=1785261126; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=NOuQu/BzezJvPNxMgDSBoyRY1p4mLcpxBGBYm45G4gTkKnotFIrO5Pkj5iKkIkCsIJ
         CHA2/KEci5OhstMbtryL4YDwXkOZbTAh17LXBClYivckTogOCG8EKuRffwBxVSkGmG66
         xe/mARQYmOCY3yTAq5fY8bJsQp5xr1NKEOiysecRkpHlKHCgyq9mpP16W5EK+fWt4Gzt
         PpPDXry5pU4Cymx0xuj3GQ+JoQfUCIwSjH8Er205lmuEv4p9cGGN/klpUjsgCBIhonNd
         fGo39/Lxzyt/YZmS9V3bgJ/+f6KseXDvCFYZkjB+xr7hd2x8PxGWBj7luQe6j5lwFNel
         mOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656326; x=1785261126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=LrEUFU2PLZPz9ra+MKP0NUMIf/A8v0xHp3IpZo1ibty1bQ/OiA7Ke2VkZvcg0qMJ6B
         sFLa4XyzS3YNDaIZTeERhdpompQR7KK3nmeO2ACnYBx3WwXOQg73b9GR1Gd+lCh5sAR7
         z8Wk62rRPPziS8KxWAYhixyb9UyDg7TCl+BRd+1GGBj0xI7/MyhhM2xjgQGpkT+/UwLS
         dDXFF0jWW7Jyl+5MaaJR9hbZgAn+Obx0Ij68L4VYnHerAuJIZx9LqX+8E4iJ1sk3tU3F
         jsab4K69y3MYlmqE5QtKjIOfwLGhWjhxwvEMjlWKlggIS9AOh8amorMBzskxV5oT7puS
         yCTA==
X-Forwarded-Encrypted: i=1; AHgh+RrMgOsHg8mbLTitCx0i3zln1CEstmbYfw89f2gggWA/C4g+NcDaDl6TBG+z1yDI6WLiKmTA0wsDMC6s@lists.infradead.org
X-Gm-Message-State: AOJu0Ywr5yT4xW55K4CXRXdjhPQiez8pMLFWVAYphyH1Kq3WNtrDmird
	3vWurLSyBxIaShjJvbXz876BseimWTHYMU6JnnH5Fe23S3FeQ3EX3xWgnLZwV7FLMlvm1p4DkGk
	PksOa/9jN/Y3juqBIhWVvRpZIusQdlwa1BF9+ts2X
X-Gm-Gg: AR+sD10t9kFKpAD+C988296sJcRhdM/DlMISKk2djWV/l6rrI8efljFRRH5A+1guz5z
	cgam4IAsTkqtRFHfVdcPlX/lRMaKtjH3HjH+UqXZLcMyHGezwo2cBXYCgD3jqPTzHo5IDh51zsF
	FGCSOgFzKxD/vUg/D70US7WlQxxY6mlVGyKO404FZi/L8MP71+Y6lDoLDagR7jZK2qWdgIG4iru
	2t7E7em/cZtxy+6AKy3jxzIzVbRBuAZy2hQ3MMLdWZplspxPhx+litlu7vr9Wr5hpz0UtUh12W4
	aoiwBHZwy6yNz9x9RGbM6JYopeVOA/BiKFGib0WXeFI=
X-Received: by 2002:a17:90a:d2cb:b0:37f:ad36:8fc5 with SMTP id
 98e67ed59e1d1-38e4b515bfamr20269142a91.23.1784656326031; Tue, 21 Jul 2026
 10:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260718162547.448892-1-mykola@meshstor.io> <20260720124304.GE110966@unreal>
 <al5IJb-L0FpztnYz@kbusch-mbp> <20260721124944.GL110966@unreal>
In-Reply-To: <20260721124944.GL110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:51:53 +0200
X-Gm-Features: AUfX_mzytkhLoaPSiTn9RmB0hwu7xEFpMpTLbojjFKRzqIcqMRM-jx5SaIRHGbs
Message-ID: <CAPzsNDuY9OB8FWb8aPTpxpVYC0u1ewCmFnvQXfSKQO6xqEJhBA@mail.gmail.com>
Subject: Re: [PATCH 0/6] block,md,nvme: correct handling of unsupported P2PDMA transfers
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Henrique Carvalho <henrique.carvalho@suse.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_105206_991236_85B736DD 
X-CRM114-Status: UNSURE (   7.81  )
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

On Tue, Jul 21, 2026 at 03:49:44PM +0300, Leon Romanovsky wrote:
> Yeah, too verbose and conveys almost no useful information.
>
> Lately, I've started ignoring such submissions to prioritize commits
> from people who put real effort into explaining what they are doing.

Point taken, thank you. Please check v3, I reworked descriptions.

In any case, the problem is real, Leon, I would really appreciate if
you could review the RDMA changes.

Mykola

