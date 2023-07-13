Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58846C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGEyliUCXJSU8koPebhUNQWCpCmY8dz3cK7dturAlTQ=; b=0LMf7wGoK3Wg6t8jrnMo20Drkq
	y93eTV1gkKDVnkDN1UdXfRSnm9GTY1VaawzWAbh0IxMmWRbLMVwTJrskTt79/Y6BHtDkAPkxi3pv9
	ayrhkpCPiaI9lPGju8AuDpTBBuvK6Tgq+3oaz0mRWFKPOnjTP/6R71Soak9u00n6HyqWfZ1BZdW3j
	LaLrI3y8CBvkIZiA6IytlRO1Gx8+b6oidzbWrI+Jfvln1THH54Mk3jfr+ovDa/ldtAlLecCVgiCFu
	0dRNVbxC8icw/pzw2sUcyaNcWXprOb+69Ax6Ahv5dKmEvplsLim515Uu36BQKtzJgAHjHswZiEuAl
	HQuG1LPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJzaD-003xYL-2S;
	Thu, 13 Jul 2023 16:54:25 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJzaB-003xXG-2G
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 16:54:25 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso1715943e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689267259; x=1691859259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGEyliUCXJSU8koPebhUNQWCpCmY8dz3cK7dturAlTQ=;
        b=GsyzB7oNmrB4lIDTgdgx/uTCskKoaCViyBQKUB4ak5MKhIEO+F9Mdk0XQClMWBCV+H
         44oIYpWPYQeyjJqaSC69uEbNo1tC/Eqt/eUL5gcsBIT5nOsIYTgz5/THDm3+2DYgrfxb
         sXHrg26jG9nLbIvOKwYLm+whINeAssFYXPoQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267259; x=1691859259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGEyliUCXJSU8koPebhUNQWCpCmY8dz3cK7dturAlTQ=;
        b=Ki6tEVBeeRz8hoV6e61OYyHLbX/cEDDgZVDtO1T0jEuhYssbBNOAtP/1+M533fKLs2
         11fztQsfUia11xxslf2Y7ogRrO75KQuWHQefNhUo1o2h+32gsSPFRz2JW1YtWJAxNUzH
         tVRzMPFFGjtzDaAn0A9D+b/U1BLxzx1JSODTVTDob6BdJ2fgNiXSUFKbHFpsgqDqo5CE
         VJXJO72mH9K6qBjS2iumZAGGn367cqO9HUPMbjBWH3vjcP6t8dOqH8Nj0G+fNCgSM4Py
         SG/DPYLhEA8QNsl5WWpEEdZMdUFMv40ahBmUnCde2diCXpHppCDVoPtNrU1B/F/ez4ym
         j89w==
X-Gm-Message-State: ABy/qLanohdLQmzZxorl3P4gNpYZIqp3vGj7ltKetVPXUVJ7nH3Nmhuv
	pBqwUW/HWPkADlUxDVn+li4q7tEjBvIuC0eDo4V4Vm6T
X-Google-Smtp-Source: APBJJlHqxQ2hH5K8HX5GJIYINWVS1fxc1jE0Perx1uyl05uNmp34fY9BWOA8ibHWXD2mDH9hRP1MsQ==
X-Received: by 2002:a05:6512:304b:b0:4fb:a0f1:f8b8 with SMTP id b11-20020a056512304b00b004fba0f1f8b8mr1678445lfb.63.1689267259026;
        Thu, 13 Jul 2023 09:54:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u1-20020ac25181000000b004f3ab100161sm1188994lfi.15.2023.07.13.09.54.17
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:54:18 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so1743724e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 09:54:17 -0700 (PDT)
X-Received: by 2002:a05:6512:b85:b0:4fb:9075:4fca with SMTP id
 b5-20020a0565120b8500b004fb90754fcamr1900310lfv.11.1689267257561; Thu, 13 Jul
 2023 09:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <20230712164546.GA31434@lst.de> <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
 <20230712165721.GA31965@lst.de> <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
 <20230713114412.GA23427@lst.de>
In-Reply-To: <20230713114412.GA23427@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jul 2023 09:53:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVArJmE3rB+sHCURUP=oK-mW5-QfVyiRwZV9OLpWwxGg@mail.gmail.com>
Message-ID: <CAHk-=wgVArJmE3rB+sHCURUP=oK-mW5-QfVyiRwZV9OLpWwxGg@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Christoph Hellwig <hch@lst.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Keith Busch <kbusch@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, "Clemens S." <cspringsguth@gmail.com>, 
	Martin Belanger <martin.belanger@dell.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Javier Gonzalez <javier.gonz@samsung.com>, 
	=?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_095423_767640_2C4CDC74 
X-CRM114-Status: GOOD (  16.52  )
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

On Thu, 13 Jul 2023 at 04:44, Christoph Hellwig <hch@lst.de> wrote:
>
> Please stop putting words in my mouth.  Maybe instead of shouting it
> would help to actually read the text?

I have read the text. You spout unbelievable garbage. Even in this email:

> You said we've never seen devices with reliably IDs, which simply isn't
> true.  And that doesn't mean I'm saying all devices have reliably IDs,
> which somehow you're not trying to make me say.

When I say "devices", I obviously mean in general.

You seem to argue against it.

OF COURSE a _single_ device that has shown to have a UUID is likely to
then repeat that UUID reliably. But that doesn't mean it's true in
general.

The fact is, any driver subsystem that deals with more than one device
manufacturer had better not rely on any serial number for uniqueness.

If some device layer does, and there is a device without serial
numbers, then the bug is squarely on the driver, not the device.
Because the driver author clearly didn't think things through.

THAT is what I mean by "devices do not EVER reliably have uuids".

I just checked. I have on my desk access to three machines with NVMe
drives. Of them

 (a) one didn't have any UUID at all, didn't report namespaces and the
"wwid" exposed in /proc is that

        return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n",
subsys->vendor_id,
                serial_len, subsys->serial, model_len, subsys->model,
                head->ns_id);

     thing.

(b) the other two had a NULL uuid and nguid, but seem to have a eui64,
whatever the hell that is.

So just from my limited test, one in three didn't have any UUID at all.

Deal with it. Stop claiming it's somehow "reliable". Two out of three
out of a random selection is not "reliable".

And it has never been reliable, judging by those quirks. When we have
manufacturers like Samsung, Phison, ADATA, Lexar, Sandisk, Micron, and
Kingston mentioned in the quirk list, we probably have covered most of
the consumer SSD manufacturers.

It's a sad that NVMe - that started out as a "lean mean low-overhead
disk interface definition" results in this kind of mess.

           Linus

