Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A88C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 00:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnXUOZBUeOcsibg5ij1DHNoW0hCyURQ3wcrfWI4twK8=; b=dZtWL1GCSVrUC6u5xgMNWw5Ovg
	RCyChxaY1ibyvTri58H9tdMZyuK1pcEP0VKsZG0dPs4sz8fsB2PViEnTDNRhu1P9h8IlQkIGaANB+
	kR6j9H1rgrP6ir93ykFQcq2nWYhIDoAjFMIBgdn62E2YXhVt/BkHHW3N7pPnMuuvMh2Sn+aZx9w75
	oKEVp9WT6uBDX6bInsp6jpLbOeaz9lbjmdCW7XeEaODBGywhipd08MLKc/yWgxH1/9mOnAKnlkmWW
	6GoMlA8Hhmh6BkuAVIXx0nLccsnwHNv1F8JAtY334OiIBSxFpXYTbyGrRfjS2Dc02rfuVBB4XnAqn
	2J2PNrRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pujIv-009OVo-0Q;
	Fri, 05 May 2023 00:28:09 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pujIs-009OVJ-1w
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 00:28:07 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so2252449a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683246484; x=1685838484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnXUOZBUeOcsibg5ij1DHNoW0hCyURQ3wcrfWI4twK8=;
        b=raKg3g0LRN3EddIR5J4GpocJr51Bz1aZpi+e9rkEU0vnhQfnDiEdfXALM0QLfHjzTC
         0pHlyIs4FN+H04mnnVQ7CK//qQpP3GP6s6KNQ7jD9MUsBR2Ku1s2s6f6h3SqlAhLqeNf
         TEfDSeJc7CoF7LnkKs250JkiRWoOn0xmrWxoZZC3NxKM7mkR/+HWok4RUPpeYJivzAyX
         zjzI4cH7CeSxs41QyYo3CBcJSM/Vzl08z0BMuLPuPm6UsXtBRkQfLWfZyRArwRhwRDrd
         8/f9JXa7Cyl69aUc3hU4hSuydMOFR+REuD7P9vSrGH8anBeuSPerKp9nAaEpjKuPlpc3
         iHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683246484; x=1685838484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnXUOZBUeOcsibg5ij1DHNoW0hCyURQ3wcrfWI4twK8=;
        b=CrXmMFU2/gms9b1hx8JVO5eEE+RCSRo/QzlIcJ/ePALVNFv6bQVfugbhQeyZ3iuo2t
         nLA4JYcVkjQUnJUy1rkLMfIOBhICAfJigwBTmOThGyLA3Qyfv8akRWnS+B5O1Pi8dOG3
         CGtPxvRm9JOeCfDH3fr5eqX/U9Wf7ZDEzhqhvNc6OgI9D6IH5E6hBPYrFQ9yuGJbPgQZ
         dp6ufY/Kf6aczS4EiM1tZmb1GoOVVOdpLOk7wkdBatMLKifIHU67MVMgE6LeoAoDgqyz
         MgHNoxMcEdJwifBhTWfbDyLo/Vh7/Dd7AiktIatRQyi/FsEmEhhENR+u6kM3bJfuw9V6
         F8Yw==
X-Gm-Message-State: AC+VfDxx1SJ8Uk/Vrri/XCMNrwddRfekbkVvGvCFzMMm1iu+1x/XuxKP
	K4jWZ+XHEobzuz65pthJ8vmrmhWTB+qgsV7OmtY=
X-Google-Smtp-Source: ACHHUZ7e+uUjoD6owhenQe2fvsB0Mc5BgZgh1b8/bylG12bxgqOoQLxcgqqOoOzIfw5XwsAiQNIQ7caVkIv0EKKoUI4=
X-Received: by 2002:a17:906:4fc8:b0:94b:958c:8827 with SMTP id
 i8-20020a1709064fc800b0094b958c8827mr486495ejw.56.1683246483466; Thu, 04 May
 2023 17:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com> <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
 <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
 <ZEvpoiDVFuOs8wyw@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxMs00uLcOxxxKXUPpJEgCCEHDVx3JVKbe2AivHCJ553wA@mail.gmail.com>
 <ZEwnL0hSTVJWoMTN@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZEwnL0hSTVJWoMTN@kbusch-mbp.dhcp.thefacebook.com>
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Thu, 4 May 2023 17:27:51 -0700
Message-ID: <CAPiksxOvE+jvWJK3Lya=_QgLVZ2nShu81p0cc1PwCHyE6YeaGg@mail.gmail.com>
Subject: Re: Seeking for help with NVMe arbitration questions
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_172806_659611_EF9C3BE9 
X-CRM114-Status: GOOD (  14.43  )
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

Understood, thanks Keith!

Given that the IO queue distribution is not intended for IO
prioritization, I pivoted my focus to how enabling IO polling can help
the performance. I repeated a very simple single-process FIO job 4
times using the following set-ups:
1. W/o poll queues, "hipri" was set to 0
2. W/ poll queues, "hipri" was set to 0
3. W/o poll queues, "hipri" was set to 1
4. W/ poll queues, "hipri" was set to 1

The throughput result was 4>3>1=3D2. It's expected that case 4 has the
best performance. But what I don't understand is why case 3
outperformed 1 and 2. I thought the IO polling will only be enabled
when there're poll queues. Could you please comment on this result as
well?

Best,
Yicheng

On Fri, Apr 28, 2023 at 1:06=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Apr 28, 2023 at 11:18:03AM -0700, Wang Yicheng wrote:
> >
> > Then this confuses me with the motivations of introducing different
> > queue types. Doesn't it aim for providing some sort of prioritization?
>
> Having a separate read queue ensures that reads won't get starved for
> a command resource by a write intensive workload. AFAIK, it's not a very
> common option to enable.
>
> The poll queues are intended for latency senstive applications.  I
> don't think it will be as reliable if you are running concurrently
> with interrupt driven workloads: the interrupts will just preempt
> the polling threads.

