Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3EBD711CD
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8V+u0s2K2bNQuXq2cWtTDj7cNZCiVM1qlS+9oeUNUPI=; b=mlBxiUO6qVtNYdkYony1HgrcWZ
	eJ9bBTNztvVU3OQ53FqOxn5zBSM1fudIUGEOx/Js4bvBp+7wqxgREFBfc4KDoMWGN0fHVI0FjztzI
	/6oGqYvkwwHOXaRNN4NlOotPPpipSTd+miKBqjkOrFHDQMfRTM78hWqq8H+ALLhme2FFGpxqItGra
	XQIFqBmgYMMDg3GcQVj6hF+JvFloyuYREcfrjdws6pZc/uoBQs4oGrIhYonvP3XZV6Acphzy4zpw+
	OOsCRtt506aUKGgwOS2Uc95olo5bgEub8/k9kBdmWl+sgOxjj0NPBmVOx43qTQszDR03Dg5QtAmiC
	SiXWRKwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWNGZ-00000009JBS-05m0;
	Thu, 18 Dec 2025 23:18:39 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWNGW-00000009JB1-0tXp
	for linux-nvme@lists.infradead.org;
	Thu, 18 Dec 2025 23:18:37 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-5eae7bb8018so454120137.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766099915; x=1766704715; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V+u0s2K2bNQuXq2cWtTDj7cNZCiVM1qlS+9oeUNUPI=;
        b=Tx4GPYOkizDGtaWfGxz3JtMdmr6Rmc55sFmKJw7K0CiC/DJqqQYIZUY4QxyWXJvUpD
         7jD6veQvk5dgCmv029r/QSy9b6iZGbvv5HoOpyjvQu3RQcA+OJ7N2kYJhmJ5bm+EFEAg
         XhoCV2g8lBrc99me/A5I/33XjcFD7NZSy0Wjebpu7G9wepJmDW6jDB+zEMsrFGIU42Aj
         NCDSS7Duy6Z0p1P2JLuWC9VAucB9xG9apXCr9oaCfm5UtM4RWnYbQx7NSA9ahEMD2KZi
         K7Rm+kjaLHHUgLO8pMOftMmIxq/nYJloKECGTcrB2kwNANIJyEAQuUcJi3UAn1+qmon/
         fJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766099915; x=1766704715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8V+u0s2K2bNQuXq2cWtTDj7cNZCiVM1qlS+9oeUNUPI=;
        b=asnzVhn/UOyFjOGCO2HZWJfo6A8Q29ZQw3kQOint8E767mDYNL8o9uUCDxAmiSNceb
         doi+RBSj9e2SeMGuaXZOKfGC36H2RvGXGaBpzmeg9sdWuZsweHfoAfDnlol0pmwowGSE
         OiM18aJYUXWAciqELEd+vN0xT2O8JBUr/c0jc4PFL5q4TglDyYLSJkWFmTfcTdz/onCd
         AC7sbj/7pxgu8O3rj6y1sABwsqkv7lpzhojLaFZIg91sSVLofDJQlV7xnA/gLEmbzmnb
         y9kU3/qH+ck8nHkmt2Sw8sqR3pzlrcRlJ+lfP8ct/K6X/lI3nvbd1hI4wnDDV3RaiUSd
         TORw==
X-Forwarded-Encrypted: i=1; AJvYcCWL58UIm07iWuY79QIkAGpVbp5UTdPa7LYdNrnDeeVbchltP0BYf0wJZn+wg6VaYVFFqlrcNr/ynlVw@lists.infradead.org
X-Gm-Message-State: AOJu0Yzcs+QSPbO27yeKuk2V4IMI0o2BINwiX5QInzk8sudvW0nHTKHS
	Ujpd2K3k7Onss4RHtmG07ls2sZboOY1eE3+MkY1zJ6YVuC4KZgpvu4kPi6g9wqrz//3xoW3tLY1
	0oH+7T5hMtcG8/BGjMAPwHnQqj/ZNkYVUNB8pnMK3/g==
X-Gm-Gg: AY/fxX5iIgVa1cK8SMDXnmbr0v023RX4zKwiMUlYl2bCRbz9pjvb2R6iCOM3VbMV+iS
	ZP4vKPADZxeMi+7q24eOciZ/FP1aEtJ/XCY3jknZlkfkqctSJqbCNVtm9QPetr6qusyahmjOI5q
	oQdWwV1pS+RiK54PMlIH2pxQiv4Y4hjnZjIkKxA8erxoZZc7klJletud6xL/GKBGihBY5KAlKCn
	T2Z+hndwOvL+hA3+/SG9JVYFywMK/kj6y4zFOZVo8ixR6w4S4eEzQ6C5AGbUU267Pn4K3hN
X-Google-Smtp-Source: AGHT+IEg1ykmlWdWe+e2GaF++GOvb8lguyVNf3T6mePDCdwM3Ai08r7dkhC5Fad5WGSnKHzLdj8Rs+sDbGbEONM2VlE=
X-Received: by 2002:a05:6102:152a:b0:5e5:6360:1f5c with SMTP id
 ada2fe7eead31-5eb1a848e8amr321598137.42.1766099914601; Thu, 18 Dec 2025
 15:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-8-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-8-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 15:18:21 -0800
X-Gm-Features: AQt7F2oxE_vkKnPh7SIvS0GGLVDZj3NXGfs4WQ-lYmp9Rt_Y8-fgXoov_iTtYnU
Message-ID: <CAPpK+O1j7_AeMMgysEkzyqr48hWGzD8H97DzNnP46mnxQEQF1A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_151836_328696_997A2F38 
X-CRM114-Status: GOOD (  15.60  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Add NVME_CTRL_RECOVERING as a new controller state to be used when
> impacted controller is being recovered. A LIVE controller enters
> RECOVERING state when an IO error is encountered. While recovering
> inflight IOs will not be canceled if they timeout. These IOs will be
> canceled after recovery finishes. Also, while recovering a controller
> can not be reset or deleted. This is intentional because reset or delete
> will result in canceling inflight IOs. When recovery finishes, the
> impacted controller transitions from RECOVERING state to RESETTING state.
> Reset codepath takes care of queues teardown and inflight requests
> cancellation.
>
> Note, there is no transition from RECOVERING to RESETTING added to
> nvme_change_ctrl_state(). The reason is that user should not be allowed
> to reset or delete a controller that is being recovered.
>
> Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
> about to schedule delayed work for time based recovery.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

