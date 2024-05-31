Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DFAC41513
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjmUNaBnKJHVeFcmGtFfEbKdSyy2gzJv6+pgUU8eU6U=; b=ejIv2X+XRRhE9WtXX1AgMnipN9
	uch6scjLut41yVcz+aBhxSl++AWK3/Wu7ioOkEnNx7lWD+7P1XDeM7Ui1ia1l4pqbPDMUVW2kVl6K
	Vm2Nl86DRhgEqFz24f5xjXbcDRLNjY8zjTzejaLvGvuM4HjuMrz8zjHKe6/uYBxDecD7ELlwtE08X
	iasuKxfJFa16GFYnxhwuR9exdF/kuqpK6nb7+U2NruKFsriVnKdE0+Vjqy2RM3rXiBsDiAl0hmWk/
	xs9yK/xqVnz4veF3Tnlo4ZaGcPrYnamfMjE6lAhTGVzgI4vpVS3NGLSHCaxs9/hvtQkatDZUo4LBX
	Iuvgxu0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD0qx-0000000A7ba-3gEB;
	Fri, 31 May 2024 11:55:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD0qu-0000000A7b7-1Idd
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 11:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717156518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BjmUNaBnKJHVeFcmGtFfEbKdSyy2gzJv6+pgUU8eU6U=;
	b=Zhye52R2OvqssOuwWowoW/hcHOazg87oOK9NeDrAia2lSvUoArE3zsAzqhcGcsH3XKnvgx
	n3GrDnviVB78Z7Df/+CrMm1/Py2mPy5FaCBWfgT+0vNDxJVUAGkyRV+C7tHNx0wR+k923v
	WP2epWaBlysnCOgDBjPd4CUvbbaDlZw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-_3TL3DuGMV2vaDDO16OApg-1; Fri, 31 May 2024 07:55:17 -0400
X-MC-Unique: _3TL3DuGMV2vaDDO16OApg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-80acfda7350so261974241.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 04:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717156516; x=1717761316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjmUNaBnKJHVeFcmGtFfEbKdSyy2gzJv6+pgUU8eU6U=;
        b=Qvk9G1HC3yZ+CUts4lkgf9IcjHKHQyV4ndbFdf/++S+WvS43cKp8cPfPbAhFe59NDb
         7yYF33Jov3u92mzm8A+P4KOI9tGDW0peXk1hTGx+UWWcNwcnl06W8HKlO/81W+uQ+rs9
         16QAV23RObslKWfE9BsybMS9whXAOSNgGcH84gP67LdIbsLMmC3xLickrlEOU+uTVxo5
         Tn2Zw7FhLmRHosaHtFfDBE5yfBCoRmul479Ae4slnxQbV5msOqdm6etljWA5lVG7p8t2
         m80JprqMtIL/+8/8aqGP/XlTk6V0Mh31XT8XCG3aLLfMTFndDd5ZeQmLgqrqSLmuNGMh
         tIkg==
X-Forwarded-Encrypted: i=1; AJvYcCVhpQTaS0ZpHJBwRRmcxRUMrVb7buQIhIpz2mhp8InkyHZDfj93HJpZjjoopU1PZUnGygDNl1b7RjILz0MQkjgcY/6Vrlzh06NlUTFOmJg=
X-Gm-Message-State: AOJu0Yxu07bj8plsYbPgtzjImrUML+8PZEXMzliyxHvbPKzheVzmdj58
	z/ccfuETFWV1dhillQUsj4wsPhJl2j0cnmxw+m9DMPz1j16xv70wg0JHbOWxXB47fo2uIyDHouS
	UP1eLBXwMpU+1bZtvyKJQDXaFIgnNz5E7cLeiinBbOtsN54pRZstCsg5QHZT8ozePSyw/8YlJbm
	eCFP16i94UYAvbDoLTZwGIhwHqj9e03bf8pABoKHO1fSFMjYEyXQ==
X-Received: by 2002:a67:cfc3:0:b0:48b:c5ed:7ba with SMTP id ada2fe7eead31-48bc5ed0b7amr929452137.28.1717156515795;
        Fri, 31 May 2024 04:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMtjyxDaiEiO8PsUMZj4W73VUx3aw8MxE9LaGPg382x/o2LtS/zKEwVO7LeYvrfxj+s1EiiLbseQjvQNhuAyk=
X-Received: by 2002:a67:cfc3:0:b0:48b:c5ed:7ba with SMTP id
 ada2fe7eead31-48bc5ed0b7amr929434137.28.1717156515415; Fri, 31 May 2024
 04:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me> <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me> <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
 <Zlipe2FVAIRmas1e@kbusch-mbp.dhcp.thefacebook.com> <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
In-Reply-To: <CAFL455kq_prujkCbNUwJzpqhL1B_P_Yu+b83kBSc0FQRAhQs8w@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Fri, 31 May 2024 13:55:03 +0200
Message-ID: <CAFL455ndGuGRCv7X6S6qtiEi6KhBs_sxgeyfzoLCqu6i8TyNuQ@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_045520_444992_64680DAC 
X-CRM114-Status: UNSURE (   6.11  )
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

Maybe a better idea:

move device_initialize() to the very beginning of nvme_init_ctrl()
initialize ctrl->instance to a negative value, so we can check in the
.release() method if we have to call ida_free() or not.

Now all the fabrics drivers know that in case of error they have to
execute nvme_put_ctrl().
Could it work?

Maurizio


