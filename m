Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B5ECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 20:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gviwf/pBETW3ApRV5XrNqqJl3PleJVXhWRmzZgIzzGA=; b=kl/0azmEPdJBDRVuPk/O0vfv08
	X+7D/Rn3l3RhN0s4/0L7CgPvUaV/Vuz6bBvhq5e9lxLtmqNTXmtoHWzLsUHrZ1F49unco7JJtrnfh
	B8y/0HoR1REX1FNUXfjXEJyP2hYfHPnmmn/UdJX9burjgjFM41iI58itleKpuZA3Bz2i8t9bnIHV6
	dI7HHxa0Gxrl5eRx45JfjllSX8sZn2vWZW1i9vtbzAc1OZaK28PARS7Py5sw3OiRDPU3wpShum3CI
	saRdBiIlU7PFNbjYZ1lzbeSlQ4LiibOY0vLsVG1FUqRBbt0zlNNac+HkWZN2QiNYqvGDSzkETWlkc
	uD/6pDiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYvmW-00H4oZ-6f; Thu, 15 Sep 2022 20:48:20 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYvmT-00H4ho-Cv
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 20:48:18 +0000
Received: by mail-qk1-x731.google.com with SMTP id c19so12387481qkm.7
        for <linux-nvme@lists.infradead.org>; Thu, 15 Sep 2022 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gviwf/pBETW3ApRV5XrNqqJl3PleJVXhWRmzZgIzzGA=;
        b=Fri8bVC8qiVuexzxUVe8ku3GuEntntL/5+pM1w2cdKavtsM3XGql2S0KzU8517LCHQ
         D0PrqPC+1KqVYOpeVkaG85Yo1ReCaoXXoHi2V3a0eBqKl2Jo1CjMj5lbPmCviwZrpbMl
         sgb7zJqs/ZFk2a6FbiiCRnpLLB2aEjInXqQ1PSmV9NA/QyfADmBsURcOK23US5zzoatW
         uVsRTcj3zBi5v9h3Bttbjvzb7Bko6E+t+3fQJF+XrjOW5foT1F39Vj8DYuMZNEd0apxw
         vNTdEIZVSOWDeZKdTyBidern6KM7yVTipAxcqwnU//sFieUGf58KaxuATgHrIPPe4Nbs
         lpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gviwf/pBETW3ApRV5XrNqqJl3PleJVXhWRmzZgIzzGA=;
        b=zXneYRFyHGG1FCLKhcYNw/sAV8ckcNGW4AZIz2pkyBDGJpbXgOZw+4DnBpJhh2gmkC
         4ggBAQxh2vMxMfUSP0wACdEel/GvWCtZfwPrykvJls9eLlqgFzWHCDTH51xDWBVh9Viq
         t+MqUe6ckWiqoo9jLpAWrNLGUscwP4nkQFmaixqhLWy5bDXFE5l998HXq0d77v0hKHO0
         MlMhlx4uugoyNadBBRjuyaOWsmXtXO9RG0bWiWkIuLd4gDtAaJOnLGsaLrBFonvrpEVn
         WM5ofeVohOITV6u9CHlA38N/2wWuZbXSKkbpo3b7IpwFVKOveWGowRtBgPujK9CV4r/M
         4bRQ==
X-Gm-Message-State: ACrzQf0J0tm+v16mZ2p6hRJaBm39SBryLXn7Qf0Wb1GqdGpmYjAw27uw
	NtYUSLCQoJuNPCbeMBfWjVaZMeylFfUhTBk3+dpwt2rncWNiSw==
X-Google-Smtp-Source: AMsMyM42Jg1afjU0/tePed23cZRtxQT1R7L2HWr/CAh3KiFDMv/+OKhgnJupk2bnq9hggw5CbMf2ZJ8FWX7u4SKOgWY=
X-Received: by 2002:a05:620a:1a87:b0:6ce:a719:f78c with SMTP id
 bl7-20020a05620a1a8700b006cea719f78cmr1599122qkb.279.1663274893410; Thu, 15
 Sep 2022 13:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
 <CADqNVTp0KfQsegsEQn09-Tuc0b76_jWuir9UbDCe44o+rHr=0w@mail.gmail.com> <YyOFAvJR9mWo+57C@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YyOFAvJR9mWo+57C@kbusch-mbp.dhcp.thefacebook.com>
From: Nick Neumann <nick@pcpartpicker.com>
Date: Thu, 15 Sep 2022 15:48:01 -0500
Message-ID: <CADqNVTqMcQvZ8_+BPez=ti3-V0wE2jOQCuOSoy5eT43RauFPAg@mail.gmail.com>
Subject: Re: smartctl "kills" specific drives on kernel 5.13 but works fine on
 5.15 - why?
To: Keith Busch <kbusch@kernel.org>
Cc: y@kbusch-mbp.dhcp.thefacebook.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_134817_469789_BAA4AB47 
X-CRM114-Status: GOOD (  17.04  )
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

On Thu, Sep 15, 2022 at 3:03 PM Keith Busch <kbusch@kernel.org> wrote:

> Not sure what MDTS has to do with this. The error log was originally defined to
> be a max 4k size which is below the smallest possible MDTS.
>
> My guess is smartclt tricked the driver into allocating a PRP List, but the
> controller instead accessed it as a PRP entry, which could corrupt memory or
> fail the transaction if data direction is enforced by the memory controller.
> Why that causes the nvme controller to fail as you've described is weird,
> though.

I definitely don't know this stuff very well - the smartctl bug
commentary was referencing the nvme-cli commit where log pages are
transferred in 4k chunks to avoid having to worry about exceeding the
MDTS value. The problematic drives have error logs larger than 4K.

I believe the logic in the smartctl commentary was along the lines of
"well, the MDTS is large enough that we should be able to transfer
more than 4k at a time, but we're currently crashing. And nvme-cli
does it 4k at a time always, and if we change to that, the crash goes
away, so let's do that."

As to the allocation, smartctl calls into nvme with
nvme_admin_get_log_page and passes a buffer (that smartctl allocates)
of size n * sizeof(nvme_error_log_page), where n is the number of
error log entries it is trying to read. The fix in smarmontools moved
from trying to read all of the error log entries at once via a single
call to nvme_adming_get_log_page, to doing 4K bytes at a time.

Not sure how helpful any of that is; it's where my current understanding is at.

Thanks,
Nick

