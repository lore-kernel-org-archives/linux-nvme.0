Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2EEC19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7mZEo1wcBJVsL0jcmhax+Kyu3rcBiXL7om6Y/gNwQY=; b=hWzZ/60J9YMXLGdhDKIjnpKkVI
	DXJV7WHeiDAGc+IGxBpmnPXGNltH2zY1ciGneUgkiVSdiG6TK9vMJuIE/6uIkZYcP5NLDyX9MoT3v
	zmCjcG3r+IAMWRuKDD69+Ruzng1jCgpddg1AIHk3MygIwW7kwGPizDRE8ob4QyXbawLIRLlaBIC29
	oQ80XsA5BgUJeiAiUHFRo7ht06n3yi4dAwKz9DCsYSozMDXvAWyc6khapKKqtBk17S+uPWhSjr8pQ
	EaDMN3wQAq5Ok2dE7mc3eueogbu1rIpobkIypWxn9yF1lfW2QeNJJhrn4sjMw245Vg2wnhmCQWcLf
	sCOjH/9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJHKX-007Y57-GJ; Wed, 03 Aug 2022 16:34:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJHKU-007Y2V-Aa
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 16:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659544479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7mZEo1wcBJVsL0jcmhax+Kyu3rcBiXL7om6Y/gNwQY=;
	b=K71D7aGosmyOfpYXzPBQ3w3/eRdRUInOhj3VZ/cR+ab+mjHP+uDEr7SU9bDpjnq+7SMiom
	FjIrs26YgFjUQQUeD8Q1MkEGfp2GlRNYRxCgROwdtireT5v8+P8OYSg7nyGWhMni2wJ+j5
	+Y9h7yWjO3gZbGiS9keOEwW52jm9nVs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-uaJc_jSLPDWG6JIx7pBFrg-1; Wed, 03 Aug 2022 12:34:31 -0400
X-MC-Unique: uaJc_jSLPDWG6JIx7pBFrg-1
Received: by mail-qt1-f199.google.com with SMTP id t9-20020ac85309000000b0031ee055ad11so11315823qtn.12
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 09:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Y7mZEo1wcBJVsL0jcmhax+Kyu3rcBiXL7om6Y/gNwQY=;
        b=4o6sIK0CGZOmsx/miqV+GWHkkGDLGbLAg7tc0SQmi+8wsD5H8EuV80ngPBqr/50muc
         DlMUFa0xzr5JA0UcZm4Pfy285m/cmaV59TbHRHgCnmJAq+dksSdkHFm3royL/agdJTSN
         1jNkF5QdHkJO5ampNxwLOXNyoDAYvgX1pL1tYzOl0WcuFmPX0qXod8e3ajNLP991EUPN
         T/TpXVCgeU7cCfBD/J/vif15YDmROESwnQ67vgb58TGJFbTFWVHlxAONJ7PA8jim5V8m
         u1QmIKGtJ81xbfbUyBT9Mzuq3/s8h4nNizvKqNkPWagwl/z9VrWlwFl8mJX6S4uvonvC
         XVRw==
X-Gm-Message-State: AJIora8CvoQHl21t8r68nQ+36NJpUnPresNuYGMOsZ098GL//mzLPJLz
	uciz3sjl+QK5nNk77iItOp29QR8Xnru3GhphucEPpvan/gs1joTKCPURs8RGI/aDNPhLOjtxJUh
	v0fY3N6WoGUC+lhDfn/AZTw6DRZk=
X-Received: by 2002:a05:622a:11cb:b0:31f:e7e:3fb8 with SMTP id n11-20020a05622a11cb00b0031f0e7e3fb8mr23548497qtk.625.1659544470690;
        Wed, 03 Aug 2022 09:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOP2eQk3RDZG3U5/vhSN1dYFbdkYJmAKSC1p3WoH26+Hy4E7uo79AbzAxL4Mx4wi4HHFIJ0g==
X-Received: by 2002:a05:622a:11cb:b0:31f:e7e:3fb8 with SMTP id n11-20020a05622a11cb00b0031f0e7e3fb8mr23548477qtk.625.1659544470497;
        Wed, 03 Aug 2022 09:34:30 -0700 (PDT)
Received: from emilne (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v13-20020a05622a014d00b0031ef366c9b5sm12159054qtw.34.2022.08.03.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:34:30 -0700 (PDT)
Message-ID: <35b2f5c0cdbf87b7a0abeb69a0fa0ec1a7bdec8b.camel@redhat.com>
Subject: Re: [PATCH] Revert "nvme-fc: fold t fc_update_appid into
 fc_appid_store"
From: "Ewan D. Milne" <emilne@redhat.com>
To: Muneendra Kumar M <muneendra.kumar@broadcom.com>, James Smart
	 <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>, 
	stable@vger.kernel.org
Date: Wed, 03 Aug 2022 12:34:29 -0400
In-Reply-To: <6c03a873a639253c8af685b0e4849fb5@mail.gmail.com>
References: <20220801162713.17324-1-emilne@redhat.com>
	 <20220801182714.GA17613@lst.de>
	 <0b5001ed-050f-f5d0-72ee-3cc2ffc7f9b8@gmail.com>
	 <6c03a873a639253c8af685b0e4849fb5@mail.gmail.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_093442_488150_5FF70EC1 
X-CRM114-Status: UNSURE (   9.07  )
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

On Wed, 2022-08-03 at 10:08 +0530, Muneendra Kumar M wrote:
> I have tested the below changes suggested by Christoph and it is working as
> expected.
> 
> 
> Tested-by: <muneendra.kumar@broadcom.com>
> 

Fine with me.

Reviewed-by: Ewan D. Milne <emilne@redhat.com>



