Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F9C27C75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 07:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PTduoXaMWLg2zGXL6xBOSMS3VRzIKmyB87NwGGLZMPg=; b=rgPGMTt2Y9Dnc9Iv7dqMtEYmSU
	+iWVTpdOqCpjWT8lUCbXI9EkK+moI8nd0d9D4cBmU1jQYizK3uxENWUjHI1D1o2dkb30CZjQGRgcF
	fI6O+Q2TU+880EMxuygeHz1iDw0PEoZX/U76sOFeGFfF5/Sl94FlARAtL47PexBzLH/LhMwR5HYhJ
	KFEywqsiOjKuAO3bWQxL8H/NSe6RKPCTZVXZHwhaBlw2X3gYAjsD3rQ1KC9tihmisUH1IzGhvMQFk
	7Hj8a+q52wEb9/7oldZ5O657DmceE8W0CnKMZ5bxHPhzPN89RhjqKBUDA52M5hjXm5hhZMWc7UD8Q
	3gB9l95w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHeUV-0000000FOxC-1N9p;
	Thu, 13 Jun 2024 07:03:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHeUP-0000000FOwg-1Kn6
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 07:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718262195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTduoXaMWLg2zGXL6xBOSMS3VRzIKmyB87NwGGLZMPg=;
	b=d1T1o+ZiH/Hkeev8NjrfnAM+1QQPlKy3zR54p1y7TbuhPr3ItaaiZsebVwPT0Quzw7DMq+
	BCzSC6KNUERZx+aUUfRKLf7mFxbLc+jPmCIlT5oMS+T/4rBSl99/J+QpJ+yXdGgYL8ugwa
	Wv4AeIoodQKrdk+XJNfk0E+IRHT8XVU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Ifgc7GBnOs-bl1xMnK1RSg-1; Thu, 13 Jun 2024 03:03:11 -0400
X-MC-Unique: Ifgc7GBnOs-bl1xMnK1RSg-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4ed02be3439so254992e0c.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jun 2024 00:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718262191; x=1718866991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTduoXaMWLg2zGXL6xBOSMS3VRzIKmyB87NwGGLZMPg=;
        b=gUakQzgMd1Dj/CgPEYeQxCa0f1RycEgIo82u6d+1P9NoaYBZoaPI9gLT3q/hIyto8N
         wXJGAtTq1Er7+77juL98JrCFJwZAmR8pYuQ2YE5qLcFW1SZE2M5z5C7YBwD07VQLxW+S
         xAaQGjzJHf92YlLabOkOdaT30bck4KVMrLeDDpPY5LvZ4u2SavZJomiK4DbavPsXUqY2
         zV7FeHIlge6TJHflJizQELzWMwbvyRVtlgu9UQ/Bm0sZ5bHiLGnODf0zU3beV2Tk8Z3H
         Om9agNoXer2cYqTC+p71O+H3wotiX6g5NxB8y2gses7bQXrMsZ0UT3iA/VFpO5VHc2N0
         VyIA==
X-Forwarded-Encrypted: i=1; AJvYcCWetDYZcieOQCNmJq1zYBsjl6dRNvBe4C1sTLxvjg5TXH7spn/h8YGuT5l771sa/PxkQ5XrF8VQSaUp4cp0ZanM5N3AH2UElUh8J1fUW7w=
X-Gm-Message-State: AOJu0Ywk4GguepFIJxEkHy+iybsGyCGPtcLS6qPu8TeVfGT5L00mgK8g
	jHKpqAUerGpEgS9Qx/AzeQ4whYV87SVwst/sooQDlTsnuYTNoJ1bx64+WPqxgH6SKo3Y0ersJ8A
	bwWbRV5wVH/MZQcJuNcf3aOo4mebxtK+cr7xbI7HyRdXuO3y4Penp8YlG2eY/W/QTPmHcY8O29W
	HEqNo0zdrddhAkkD1epIr0/wvf/5+VVuhaMPhWwyI=
X-Received: by 2002:a05:6122:3c55:b0:4ed:740:c2a9 with SMTP id 71dfb90a1353d-4ed07c38805mr4512451e0c.16.1718262190859;
        Thu, 13 Jun 2024 00:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPrTKR8twFegfwR+/YgSTi/tvYtAByYJmyC4RXtGXNadzP5WCSfXWki+I8YLJABFhaDvXNpurxhtZ++UcDJUE=
X-Received: by 2002:a05:6122:3c55:b0:4ed:740:c2a9 with SMTP id
 71dfb90a1353d-4ed07c38805mr4512436e0c.16.1718262190531; Thu, 13 Jun 2024
 00:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240604091523.1422027-1-nilay@linux.ibm.com> <20240604091523.1422027-2-nilay@linux.ibm.com>
 <CAFL455ndCZipuN1bFTWgqjj4Sfh6AB3WUX014W1V2WY4gqzK8w@mail.gmail.com>
 <15192c9d-ce45-4dbc-bdbb-752cdfd4e663@linux.ibm.com> <CAFL455kRzW25EB+89dWBMV608PyDVEfuM0Re1q69gXKZ3Uc=mg@mail.gmail.com>
 <d9d64808-397e-49ba-9f03-e9a8e773d135@linux.ibm.com>
In-Reply-To: <d9d64808-397e-49ba-9f03-e9a8e773d135@linux.ibm.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 13 Jun 2024 09:02:58 +0200
Message-ID: <CAFL455=+bOyYXT9zpbiFfLtR4J8HHUNsAEdqZxFe_8tVR16d+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem reset
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_000317_453074_216719D5 
X-CRM114-Status: UNSURE (   7.32  )
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

st 12. 6. 2024 v 19:08 odes=C3=ADlatel Nilay Shroff <nilay@linux.ibm.com> n=
apsal:
>
> Ok so in that case how about calling nvme_wait_reset()
> from nvme_tcp_error_recovery_work()?

That would work, but if your patches get merged it won't be necessary
because it will be become possible to switch the ctrl state directly
from "connecting" to "resetting"

Maurizio


