Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B6EB594B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ST660X4hEpUgD6SL2DviuzCimmbNFl5pVnT0exNCSkQ=; b=XCKZzbuQb6v2qhDOsJtCDk9Z7M
	79hXH26AsgvAIOKuWrHPP/veo97F+j3tFfF0rf4MLpf2WxKEr5PnAGxlEhak5hPByik6Vy2eonHLX
	YXk67ROU+EP/OS4tEepGsJdQcKSGmDMpRI00b1tt96IJZuX2kh6GFOLC+okBR6tbbqr+jzXmLbMHv
	OoqVRXStKQIOXpUjfa2Rvm3Sw4T6zwm9RU8pj4P6MFGplz+Y3XdHatI9PZYIoJSfPRXRT+avJEh8l
	+0JQSp1Qj+mqJ0XemRmoeKWmq1AlS8aG3/TXkYkwAIBjYBCka1ykAtpmkt5JttFplUl0bAjQMCHOz
	rtpe6iFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzTJ-000000006l2-2mU9;
	Wed, 11 Feb 2026 01:56:53 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzTG-000000006kK-3THF
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:56:52 +0000
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-5fadbc3a453so921969137.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 17:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770775009; cv=none;
        d=google.com; s=arc-20240605;
        b=fT5z37nGMnWfWryDuUMCMWi28t2B+1SMprbqDBS6ZDVjJyH6YKoQaQHag5f6REtGQD
         4/eB7OBHahTQIAG9Eg5PG7likZYaF23FToojsQWFHV6kSu4Z872TASMk1O65AjS7mcWM
         PJ6zMoJYEW7I8JGZjCt0rASfk9y37+NBm8o3Gm679Hda6nSRWbg9Vebw8y3AvGoKNiYt
         VIb8FUTiFlSs84HEfuGhNTPaK1AubytUe3LsfYRo2WtX0du2zfeSg69zGWVBfpZpElrZ
         VG05SLdx0cUs8xgPqypPoGpbu4A7IJpbqNCs0m1A1mH2V8BjcdhVRGsNc4+/GkZd4wHi
         CUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ST660X4hEpUgD6SL2DviuzCimmbNFl5pVnT0exNCSkQ=;
        fh=5IVfSQKFZIS0ZTRYEK8NoVreI68OhU7y9TCXti+SCMg=;
        b=L1l0Ohg4aysftMT/A7/wgIhkKTto0LWxg46VLkriBEdSunZyvHBk01JgY53jSJfbT0
         9/+ql/hfeUH6M9HWhCFKsay0EF2fu/b6zTOQmLuoaunRRbA7NQrwpJx0qs7TxrUyYfMH
         VPymWZTAuBoyRsgR77yXZS/DMnhAxMSAOzMbxWuzmNPwod9mttqWkFCqyNSF33adgukM
         2tJfN4O7U5O1i1ZVInZ1KLCmFayLC4NUDZELghcQ0LedU6bP6yFA/g0nPRSdOvPf/DW2
         6Z6Bb+2PqT0VVMCAkfyn/+9IQixsoXbAve3E6SVD/cfBUoBO5Y0kmqQA56fh4gR3JecI
         VmGw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770775009; x=1771379809; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST660X4hEpUgD6SL2DviuzCimmbNFl5pVnT0exNCSkQ=;
        b=dmnkEcP22YvnTfvu6xKKcJcQl7M5oDMB1A72Hu/4GJMBSYIuXGfETZIZM3sKvbNQfk
         MGPjC2v1zvr6EAo6+U+tdHlmkFf/ZMNIS3XYU7+Yp3hn/f6Dq1MaDtnJ8aBvweXJ3Fpj
         V5sKxF1TUKKbh0GaoNyQmrUBWxga2Fl3i5Vx0nA3yyw42XCrlonqKLrZy8J+N0y/R6gQ
         OPZ64USBJcbgTCiQFJMe//tnui7LqzJuYLiwjYoqcRziv5jMgYOEoTaxY2jdwhgBCDaG
         4UeDJfm7Qwc8z4X6s7vFzwkWfTzdklRnlUS0EvPvi9MbDKXJ5D9ex/Ef7DzVUz6FzAbE
         cSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775009; x=1771379809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ST660X4hEpUgD6SL2DviuzCimmbNFl5pVnT0exNCSkQ=;
        b=GLyn6wmOsZUVj3yOUpPhhooDqT1ItX0wV8vc3RgFzzw21jVVo8JHcEpF2WMIJDNHAa
         1EXj5w/YXygYRXNJq/cPcloPp33/dk49rPnbltahD3zXlmOBhViKl6d2LCVurnfd3ot/
         BK6Z2f/C1iy4xpUuen5voyc3uLo1ibWHZpqbr4JmWJh7yYiH9Fk51/iRI9dXD6qWonR2
         iUUc7bmcCYqGNGCnf/+Nt761DmhxgBv0mVfAeWlU5YponJGBeEq8W+9GFE0ahp/nnIMW
         Btb6aD/trp/WjzdMYmpEH12U24Mae0fySeZ3MKF8Rjt6OnF2Y4NdTxUmhrsNG/wazDbS
         4RLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7v+2TH79qYQs7v6Baa//IUZGfvH70fcscjviEahu7Tl9IcHH80FKd56nKdQ8t13XJl7eGqA4iTDPg@lists.infradead.org
X-Gm-Message-State: AOJu0YzkS8uy35XNnAa439LG+Y29URjeWt3pjRoFoGBNRm3YLbw8dGBl
	1lPAltHHBiY7SnVs9xK0a/3knf5Mrbwgd6n6e/SU1R5x14De8ZC9puGAN+iZbX/gfxJCmAssuw0
	XkSnSas53gMBnZm2vJhrLLwz80okLP5bzPLSVkSOigA==
X-Gm-Gg: AZuq6aJq1fJbZHUUkYoDeiG9O5IQU4YU6fPFo5aEoyTd5IrpwLwE3QMa8w4pUcDYBjt
	Acg5sY04mJgy/yD17AGUblv+6wvRbbsA3sHf0wunkXC2qZx+JH2XNSe7MrjGI7JVUp/DwBsrWso
	DwD9Fn8c3SX8J6Nay20d+VsH6CtnBJMY7ooiSFh28JrnHkCm490OmWn630a0dhjs/UU3TFSrAvs
	+URmyKDnQBHReAFfk5IqGLZT1JWIFYBhQKXIJjMipBWqGHIRI70vFiXpFe4SgN5EwDubAjAoWQF
	GVBJSGw=
X-Received: by 2002:a05:6102:cc8:b0:5ef:7221:aa9b with SMTP id
 ada2fe7eead31-5fae8aab91bmr4623011137.18.1770775009419; Tue, 10 Feb 2026
 17:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com> <20260130223531.2478849-7-mkhalfella@purestorage.com>
In-Reply-To: <20260130223531.2478849-7-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 17:56:38 -0800
X-Gm-Features: AZwV_QgcNBZ3z-Vegt9TPNWyZplvjx3Vh6wfL9VrS_A7X9vCt3rK9ZXNro5CBxk
Message-ID: <CAPpK+O1pTsWDokwVC_c0TpZqg8hsSB2K8p-RvkhodKACs8ek9Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] nvme: Rapid Path Failure Recovery read
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_175650_874740_BCBB2B9F 
X-CRM114-Status: GOOD (  10.08  )
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

On Fri, Jan 30, 2026 at 2:36=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> TP8028 Rapid path failure added new fileds to controller identify
> response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> controller identify response. Expose CIU and CIRN as sysfs attributes
> so the values can be used directrly by user if needed.
>
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> limit for attempting Cross-Controller Recovery.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>

