Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB27C05027
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBM9XBklFHpBUqeZTmTKzlvdF89qkTzpVZ/4QTS/EmE=; b=zcRaQg5Zp7MGAZFSqo5vcIKUsD
	dd9UaCsad1KBue4T80QgFKtB2fXDB+AUsNg521qs0pBNsc0LlLeNjergCnTVZPYURfCca5FDQ3TGv
	tiNVoLRX40MlJU1BYCtNEee5f5rrzwm0Fd0r3rG1FoDOQn89rmX+9+gwEmC77RTREKvv/AtrRxQsx
	XyUM+Y293aAzjRtXK0LJpwsemJMwinav5FFOh5SnC7MDBgdwuLX/MMq7mN3VNY9mCr9GuLerEmf5I
	0Wj7cKACz9N7xA8uoS9ZMtqapPG4kAElRHf6P1jGQ3sneG+mY595UK230sXA2UeZ34/nJBeVxGAlk
	QwlFOxoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL1l7-00Asz6-GZ; Thu, 26 Jan 2023 12:53:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL1l4-00AsyL-LL
	for linux-nvme@lists.infradead.org; Thu, 26 Jan 2023 12:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674737616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBM9XBklFHpBUqeZTmTKzlvdF89qkTzpVZ/4QTS/EmE=;
	b=Yj8j9bj5adzaWbo1OdXmAxRXjQFy3gxbK39N+H/ExHrzAjJf2UtdWflipJ2GMmC1/JRKmF
	zmni0s+Vy7Xj6NIHzEohzUWVzr0whUHsvFYUwQb+ERIGfQyiSPHQpjyOleJyZDNNKbJ8B0
	OaDNTNhUARN4aOQVzoG0/iNoBDuyRzY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-kqwu7y3uP0mNVWxngK7CJQ-1; Thu, 26 Jan 2023 07:53:27 -0500
X-MC-Unique: kqwu7y3uP0mNVWxngK7CJQ-1
Received: by mail-qt1-f198.google.com with SMTP id k8-20020ac84788000000b003b631e8cc4dso678506qtq.16
        for <linux-nvme@lists.infradead.org>; Thu, 26 Jan 2023 04:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBM9XBklFHpBUqeZTmTKzlvdF89qkTzpVZ/4QTS/EmE=;
        b=nMngpzRifhdUhOOi0GqzHtQFcQZ6UV15RMRFaEhZLCZFTNZ9CWfSa8wkyKAlQarTkx
         lxaudwORs1Lf6R+aYEBEFwvPa8it4GbUPra0n7mnPZ6xU93L2eu+sBlimiqCAzffKBnj
         Um8OFQKgILrDQVC5vrcMGb4A0KHojAUY+9T413CIHYV1RdlTgfdriSanpWrynTLKBfVk
         Ld8x9pOZT97sU45PjpXDUjg0u1bIdtgF9a4h4U57rWnbSIJ6+4vS1eQ8N/LcjX57EBpQ
         TVll2l2FeP1ZQpWyWgyh+jkU58kcGZM9WB8R79ebrosSjXljpJTgCk4kGqgYUpAHB7UX
         eNwA==
X-Gm-Message-State: AFqh2kor7tq/vtgguzkWLYEd+xx0SBJEJIRovIY4GVhjFDsVfdSYTCNE
	8peeyESjAPfzSH7KljYuNXHSXi0M87+k4r+c7Jbim/hteJA9R7pHtww1lsGxbjI/is8wN1/dXg8
	4KhmPKiTOzomY2nozUk/Mf6W5TM8=
X-Received: by 2002:ac8:4c84:0:b0:3a6:a89d:9ee with SMTP id j4-20020ac84c84000000b003a6a89d09eemr47284085qtv.33.1674737606905;
        Thu, 26 Jan 2023 04:53:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXttQddN8vjdNtkpVaAfR3lrW7h9IqUzywDhn69oFRraVJegevMVrlO1sYItr19mK26qc+jS+Q==
X-Received: by 2002:ac8:4c84:0:b0:3a6:a89d:9ee with SMTP id j4-20020ac84c84000000b003a6a89d09eemr47284056qtv.33.1674737606621;
        Thu, 26 Jan 2023 04:53:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id s24-20020ac85ed8000000b003b2d890752dsm641205qtx.88.2023.01.26.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:53:26 -0800 (PST)
Message-ID: <0344d6af4d953c24d4ef20c3ea48e738ee8682fb.camel@redhat.com>
Subject: Re: [PATCH v9 01/25] net: Introduce direct data placement tcp
 offload
From: Paolo Abeni <pabeni@redhat.com>
To: Shai Malin <smalin@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>, "aurelien.aptel@gmail.com"
 <aurelien.aptel@gmail.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or
 Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>
Date: Thu, 26 Jan 2023 13:53:22 +0100
In-Reply-To: <DM6PR12MB3564D7C8E60D51464F00A5F1BCCF9@DM6PR12MB3564.namprd12.prod.outlook.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	 <20230117153535.1945554-2-aaptel@nvidia.com>
	 <e279ebf025b62b8ce8878d16d1a77afb2e59ca7e.camel@redhat.com>
	 <DM6PR12MB3564D7C8E60D51464F00A5F1BCCF9@DM6PR12MB3564.namprd12.prod.outlook.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_045338_809126_80414A1A 
X-CRM114-Status: GOOD (  13.98  )
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

Hi,

On Thu, 2023-01-26 at 09:47 +0000, Shai Malin wrote:
> On Fri, 20 Jan 2023 at 10:52, Paolo Abeni wrote:
>=20
> > Have you considered avoiding adding the above fields here, and instead
> > pass them as argument for the setup() H/W offload operation?
>=20
> After researching the implication of such a change, we don=E2=80=99t beli=
eve it's right.
> This entire work was designed to be based on the sock structure, and this=
 approach
> will be needed also for the next part of our work (Tx), in which we will =
use the=20
> ops and the queue also from the socket.
>=20
> We defined the ULD_DDP as a generic layer that can support different=20
> vendors/devices and different ULPs so using only one ops will make it=20
> more difficult to maintain from our point of view.

I'm fine with the above.=20

> I will also add that we are addressing review comments for 1.5 years in o=
rder=20
> to fine tune this design, and such a change will open the fundamentals.

I understand my above comment landed quite too late, but I guessed it
was better to ask the question this late then never.

No opposition to the current design on my side.

Thanks,

Paolo


