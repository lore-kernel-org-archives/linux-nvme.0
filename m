Return-Path: <SRS0=SS5y=X5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C89C4360C
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 15:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C1B20873
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2019 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GachI6Ig";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVsyXeM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C1B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i/NxYtAOcr7pM6+3jL4nxQRS5zXDNxZn2FFORBCtKRA=; b=GachI6Ig0yqFRuufHokDsVPb6n
	zuWBZ/FAlgYjYmhCjo/wbXq3HUH2v9Ea2yZVI9yKMhCh7DZdVLPaKDLRJVhoIMBnN4Pi5OEIeGgWM
	n7DK7G1S1v++0fas4ZX9S1dQGGO6fH7I/touD2WqjhcyM9vBgrOoroPDlhBwsUobp9z2MvDbJJuXN
	GcFMu0MWQ03KkYHmbUVOmguRRRizeo08VXeJeNKaIc5omBvGeCHpmcpa6mgqoF7qjTLnxAtMd0NvT
	s1cvOAlGMpzQuz1ZDR3nHEJ+PrkvxjlJsiD8dKvfRj+FMizOLroCqo/HzsvzMaCZYJo2of6sWbYB6
	heYVqVoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGPcn-00013u-GD; Fri, 04 Oct 2019 15:36:09 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGPcj-00013T-FF
 for linux-nvme@lists.infradead.org; Fri, 04 Oct 2019 15:36:07 +0000
Received: by mail-io1-xd41.google.com with SMTP id h144so14416172iof.7
 for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2019 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=7wtWmNaBzWvHZFXd7ETJjhq/Ls8R+LbN1dmWdsPcLY8=;
 b=dVsyXeM+omMSii7CtpS0Du2za9NVA5njCkQUFjCWvClC5TIp4AfWCO4StgcM+JsVYO
 lj2RQdcQ7punxe1uv6ZBQBHk1CW5E+xCoVocUtDIquHCr9hdFneeQcAGmipReTC/pU6W
 lLTqG8QfMAqlPdFapGoA6BTIG5MKWJycO00e5pjiS0dRgDYsyZVFUKpcSWHcxE/9gUeL
 nbJhvaX0/XVgmENdcRDA5da1eh2dw/d7/0Pe5LIJuSAJOT+ASgS8ysIed0PwDZaS7eXJ
 Hcu0fqTZNPVsUVDDu9CbYJAXK88Sb5XS9WwhFXYh/MFJmJ8ytp/BiPWwDn+V1cuilSkV
 8NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=7wtWmNaBzWvHZFXd7ETJjhq/Ls8R+LbN1dmWdsPcLY8=;
 b=knxksFbIgAUZdAHGB1cuLjtlBRnJW9pUa9yQyV3aTe4oSWiBK4yVS9cPdq3Hq9W31V
 ViHq1Zlj1Qw9DrB8eRQzx5bLIs5wVQSM10wWLsipK3OtRwQE/BC3PGg0V24lWkS/Qbac
 0I4GTtsL3wxYCTpUOZV5XCoZbj8TwJ6zZZOuaLE91BELDNSARIXMXjT3TehV1O8gnnGp
 nqDDq8yNGattGH7gDKPmocFFtJGSEulwpOEHKoS31ISa1nMGpf0g/hTLLR9NSYnTv8w/
 VFDN90z7q164o6g65Mmhg66rsiVTz5uYAQeLGK8d3Q7VCBcH9FyxemSm77iSkKznOnxN
 qNYg==
X-Gm-Message-State: APjAAAX66tG8bmpi/kWiCnr66muUx/HoRQr/y4jxHTkWgh5jHUFVvOfC
 spvtgW9zCY+kByiM1XctVrKZTHpko3g67+OYVDg=
X-Google-Smtp-Source: APXvYqwyXYuqJXNQSyqexuyIk1RBvL29kVGFINewYpKfKOnPBcgWsjdT14kVqNJH+073EwFW0A+Dv6sYwrOooEet4mk=
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr9811572iof.179.1570203364443; 
 Fri, 04 Oct 2019 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191003191354.GA4481@Serenity>
In-Reply-To: <20191003191354.GA4481@Serenity>
From: Tyler Ramer <tyaramer@gmail.com>
Date: Fri, 4 Oct 2019 11:36:42 -0400
Message-ID: <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191004_083605_535637_BB9C70EF 
X-CRM114-Status: GOOD (  15.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Here's a failure we had which represents the issue the patch is
intended to solve:

Aug 26 15:00:56 testhost kernel: nvme nvme4: async event result 00010300
Aug 26 15:01:27 testhost kernel: nvme nvme4: controller is down; will
reset: CSTS=0x3, PCI_STATUS=0x10
Aug 26 15:02:10 testhost kernel: nvme nvme4: Device not ready; aborting reset
Aug 26 15:02:10 testhost kernel: nvme nvme4: Removing after probe
failure status: -19

The CSTS warnings comes from nvme_timeout, and is printed by
nvme_warn_reset. A reset then occurs
Controller state should be NVME_CTRL_RESETTING

Now, in nvme_reset_work, controller is never marked "CONNECTING"  at:

     if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING))

because several lines above, we can determine that
nvme_pci_configure_admin_queues returns
a bad result, which triggers a goto out_unlock and prints "removing
after probe failure status: -19"

Because state is never changed to NVME_CTRL_CONNECTING or
NVME_CTRL_DELETING, the
logic added in https://github.com/torvalds/linux/commit/2036f7263d70e67d70a67899a468588cb7356bc9
should not apply. We can further validate that dev->ctrl.state ==
NVME_CTRL_RESETTING thanks to
the WARN_ON in nvme_reset_work.






On Thu, Oct 3, 2019 at 3:13 PM Tyler Ramer <tyaramer@gmail.com> wrote:
>
> Always shutdown the controller when nvme_remove_dead_controller is
> reached.
>
> It's possible for nvme_remove_dead_controller to be called as part of a
> failed reset, when there is a bad NVME_CSTS. The controller won't
> be comming back online, so we should shut it down rather than just
> disabling.
>
> Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c0808f9eb8ab..c3f5ba22c625 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>  {
>         nvme_get_ctrl(&dev->ctrl);
> -       nvme_dev_disable(dev, false);
> +       nvme_dev_disable(dev, true);
>         nvme_kill_queues(&dev->ctrl);
>         if (!queue_work(nvme_wq, &dev->remove_work))
>                 nvme_put_ctrl(&dev->ctrl);
> --
> 2.23.0
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
