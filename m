Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B7D711D3
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFUFgiXfv6GbfxBhT/hrLBb+Ak9ukfn2i8tdw0T34GM=; b=aL6xe8vb0y/f+gOHqZRiAJJAMC
	bROZzYabv1557O6z0YbDVLmT/7oeoTj8kgvGT/jNssKxc2r3W+/wTluN//mnNs+TQJTLP1oDbaUqT
	iBa1JqBjEm6iRS1lWG2Cc6+8lPz5UsXgfod96Jam6++p1wODyRZYcfP7MVKwZPFFqrMzkon1yOduG
	BUfa6Z1sjEHzX9TRZvIv9GolGUFrVl7Ud/Nys82+JnawGeK8WpJOoHaT1CCShQKBKUDrNSNMNGOGY
	BVo+NdkX2rxGvksO8S3+5nTvWlm+NVRSo8qIu0SZhHpFubimhctsutvFbNQ/mjR3DJsI/NfR3p+h7
	VZ3CacEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPBq-00000009QWw-2Q67;
	Fri, 19 Dec 2025 01:21:54 +0000
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPBn-00000009QWO-06fU
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 01:21:52 +0000
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-93f500ee7b8so675295241.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 17:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766107309; x=1766712109; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFUFgiXfv6GbfxBhT/hrLBb+Ak9ukfn2i8tdw0T34GM=;
        b=c4dmXkwIUNritby+pmFP0QwmbQLw7KVED7DJ7+2UDVOQHnMr0+CC8mQDUV09gp5NvE
         uU5ZRAFt/CG3uOkEiSgEyznJ2wiMyIdefy/4lZLV9n8XtINBHaf5vd2nEe1IiOhoPpSE
         nHN5tECAVKOz9dBLrcFDBAOGkbp8ohhWOsGxx7TCddk/R40eia1MgjCcqNtom7eWxC1J
         ikQelf4+Rr7z4guBzlQVd8pGzywAp+BMN7n2X0mPM5HEEwK+IvuUIiT2RhjXC8JQ4JN3
         okN5XYTjYk5T7XIrr89iCJWA8c+tBPtCMufI3JrCY7xvQgNM8uDqOhOgAcpIkqSmettA
         hgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766107309; x=1766712109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fFUFgiXfv6GbfxBhT/hrLBb+Ak9ukfn2i8tdw0T34GM=;
        b=Cezyx8hEvsOFPV5raiK4uOgSgqLdlOsfm5w0S0RB9896+LUm+HtS4caitXmN2hZ/7g
         DHKHgi1Iidea4b8GmqrryhRXr1Ex6xiNpY1kcetE3h8igHF+v3yILNbdbyp8PJExYzWH
         iwrHtt2iQDgPiEyUvlUAzMmuotVsfLfva/OYSGraUQVnVFf6QFcCGxmOS9us6JHQg7I3
         Ho/Esk1iW0zxQZYul5jbSIooL2XEad+nxqDgzZXA9XLdv0fq0SNUVueXT8MpnGAyBuIl
         GxswJ0UjUvswltQSAmU1N6TudtyGiZbCKnFLPraltC34q/7UU+aeHNI/oxZx7JmyzDAX
         OK9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDH9550Mi3wI1v94BVWHWe+TIm/sxVGuzSGVaJ+3GBzZYRWFAJDDXBJRocFaPrI+AyJLHuKK9HsCMp@lists.infradead.org
X-Gm-Message-State: AOJu0YwVepcuI39swo45DKcbbO+SAXLSftJLo1mnuwesMkgkPkldUip8
	HkXiN4ntS24d+QBlKMgcArXn5yasBgp1uaqdO+EW0oZ7FCuFwYRvtGk1koprx34Beeyeb4RTtgB
	ShPnQ88B0E2XIcSRKl5LYwZvrTl0jb5j+aY9Oq5IxUg==
X-Gm-Gg: AY/fxX5/gNdYfFc/qNTXotCJPMmSCGUkqj1PMguYQQNEKzIM3Iun1NhXXUke87p3OPT
	XKYgQhcEbN6hgNd5n7kOFY7btgA6SyW4Llr75JxvHkWOnz9fjbhcPzV1/oL3fFQ6L7OolBUEqs1
	t5snWqjQ415R2658IHO6HTK5bSb2XYLx24viP2rVpAp0FVPFDEysPJ4F7hxUNPPuX3P4jaTN32C
	T/xtBrVo0mJ1dE+suW45mhDUK5lzz/P2VEwswLAn+sUTfbe2fdoUjNpRSp0xdpIeWShXuFw
X-Google-Smtp-Source: AGHT+IEH1pg7GatCusUqMJpLa6vp72tzaOkDAsqMEu6XHRpaWdQMUYrtPbN6aH262yCoktinZtjBtOLflPVPm1yMtX8=
X-Received: by 2002:a05:6102:3f4d:b0:5db:9ab3:4291 with SMTP id
 ada2fe7eead31-5eb1a81837dmr452927137.33.1766107309508; Thu, 18 Dec 2025
 17:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-9-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-9-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 17:21:36 -0800
X-Gm-Features: AQt7F2r7wFcp9-_xtSd6cFlR-elIglffODHKpRnL40f_GW49VR1D6Znbs9pStWY
Message-ID: <CAPpK+O1PW7cwWPsbQ701wQGyDH56Y80=yX4kZ7R-Op2ZP9py1A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_172151_107116_ECEBA412 
X-CRM114-Status: GOOD (  13.65  )
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
> A host that has more than one path connecting to an nvme subsystem
> typically has an nvme controller associated with every path. This is
> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> path should not be retried immediately on another path because this
> could lead to data corruption as described in TP4129. TP8028 defines
> cross-controller reset mechanism that can be used by host to terminate
> IOs on the failed path using one of the remaining healthy paths. Only
> after IOs are terminated, or long enough time passes as defined by
> TP4129, inflight IOs should be retried on another path. Implement core
> cross-controller reset shared logic to be used by the transports.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c

> +unsigned long nvme_recover_ctrl(struct nvme_ctrl *ictrl)

> +       now =3D jiffies;
> +       deadline =3D now + msecs_to_jiffies(timeout);
> +       while (time_before(now, deadline)) {

> +               now =3D jiffies;
> +       }
I would use a for-loop to keep the advancing statement close to the conditi=
on.

Reviewed-by: Randy Jennings <randyj@purestorage.com>

