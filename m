Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0E2C4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T3lRGZKHaIqemN8CkaWZrriIJ+fsbbDtBtXBBwbbcVA=; b=uYyxBjYUcSUAv/ONVr7LXZYx2x
	I1LwHgJxntXmMSBDrJscaZFanZG6ltWoDlcyJyDa9wXH5MbUWb9wkedWY5Ls0LJgxMZuWz/+XQkxX
	o+TrYFIaZ3L18cZQcJUcQ+Kxxq5E+GmnFU4XFRq4RVWpE9qzvyvd4M9EipoVqzmshn3AweXTyfbkj
	+9fJVUsAzShycXSqUiBjEEAFMuHo85wAMKh4CvD/8C7+ONVlQUcpXSgDuFLoA64HcN2XPseJUI7f4
	DKm543nF9m1vYGAJpblrO8iXJEUth9UNdmepb4ewfFnFDSFqOmgNBe5c7YXSAWVVLeXgfWTaBMBIa
	6L1fBugQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWv9W-00000002ase-0aPA;
	Mon, 05 Feb 2024 09:20:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWv9T-00000002ao4-0phh
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 09:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707124817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3lRGZKHaIqemN8CkaWZrriIJ+fsbbDtBtXBBwbbcVA=;
	b=NxqK2FE/6YydIYg40gs9cFO8YdhrUnZysXGHupQMOKMRy2mjUYuLlCIBIPE4TVHCEY6z5K
	Zl1jK2DW/I1pTUT+yHAYq4kqznBts4vWi52xOLukjPHOdyy2okbom0R6Y8v63cI3HS8zLU
	IKDUl+NYjIVGOr3chCLPbCNjtf8oV+Y=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-HF1N5_OGOoGSm9YwWe6l2g-1; Mon, 05 Feb 2024 04:20:13 -0500
X-MC-Unique: HF1N5_OGOoGSm9YwWe6l2g-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46d2fd588ceso188466137.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Feb 2024 01:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124813; x=1707729613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3lRGZKHaIqemN8CkaWZrriIJ+fsbbDtBtXBBwbbcVA=;
        b=jfAAz3EJ5YkuwMNmdf0zRDneJB4NCHC3HpEgUmJO5jkH9zEswF1UNsFNHSxH5sq+ol
         gPMK19Ow4/7IowuV5WARDvBNvRk8oMribztLCilNUCm3m98ExHfHSkZXMghf1d+snFkF
         KOjsUFOyH+uyZBqL+CsfmOANI/04lCA0U1XddXWcv4bdyBy+aEKpABw64U+uIyvy/6FA
         jjNrJeYnm9o2Wrg1Qe+5O4c14Gi3fVIlmPe6P2wlWfz+cyQCF+klRAzONDrwYdOoBz6A
         DGuOeH1tMi6dNLm1srQMJ2NHfPZeTrEurM9zlq5yY+s0vip91JMClARZHu69elb+BX0i
         /TYA==
X-Gm-Message-State: AOJu0YySWmSZlJ3qBuFJlAsLju3Q9SeL49TLPSiYKFugABxxpE18ndRv
	DQyVWWVzv23QwPqPmYtMLQ1RrgqY9C7PQtG94s2Q2bci8LUGRYr45dhJbaTEkw63kX08tyYUp6b
	/HHWwBNGo5KHk6Hevjo5YBgfRaOs5BMIOzzJjm+u0kD/BvyGu3rcmWcLCi/xy55ytfYV5FJfZ2C
	a5fKTXZpRys/Ni3W+fFuLzSeVec2WOivbLVRhCJfU=
X-Received: by 2002:a67:fb81:0:b0:46d:37c1:6cd with SMTP id n1-20020a67fb81000000b0046d37c106cdmr279842vsr.8.1707124813416;
        Mon, 05 Feb 2024 01:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzU+hlbJax4De2Iosfok3zbx3LSVY43JBiZy5ov+nCHMA0kjFqqKazmb7D4lIyPoSiDxe4d3/f0Ksj/+v/ZuY=
X-Received: by 2002:a67:fb81:0:b0:46d:37c1:6cd with SMTP id
 n1-20020a67fb81000000b0046d37c106cdmr279826vsr.8.1707124813110; Mon, 05 Feb
 2024 01:20:13 -0800 (PST)
MIME-Version: 1.0
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de> <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
In-Reply-To: <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 5 Feb 2024 10:20:01 +0100
Message-ID: <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
Subject: Re: Re: race between nvme device creation and discovery?
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_012031_336523_58384C9B 
X-CRM114-Status: GOOD (  15.00  )
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

po 5. 2. 2024 v 8:47 odes=C3=ADlatel Daniel Wagner <dwagner@suse.de> napsal=
:
>
> > While we could add a retry logic to libnvme, I'm not really convinced
> > this is a good idea; in the end, who's to tell how long we should wait?
> > A second? Several seconds? A minute? Several minutes?
> > Also not that sysfs_create_link() has a return code, so the link might
> > not be created at all ...
>
> Yep, retry logics have always a smell too it. What about the idea to
> add some sort of ready attribute to the controller sysfs entry?

I think I had a similar problem with nvme-stas some time ago, it tried
to delete a controller right after it appeared in sysfs, causing race condi=
tions
with the init code path.

Maybe you can take advantage of the NVME_CTRL_STARTED_ONCE, exposing
this information via sysfs with a "ready" or "status" attribute.

Maurizio


