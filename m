Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D375FC88E45
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQhtgmYJbGnl4jzEgaW57/yVc/C4uVNFXjb6bqrdM/Q=; b=qlbmsiogZKuckO22RqJSqDUMBe
	1B8N9FO0757G9jOKMo9Tz+UpT6OmEWhQvjKqApm7WZQTQfH6Sumh1Mc5U0BcX2x8VbtlWUH3H/cpI
	z0IeqB5PdmO4mH060tWSu68gLlP3hasv48VmloKxz/Jbro4jMAgvCuNHbEYGK62KiwSOKXaVGuv/B
	5jDSDhysFregFNmJmCKyLBc/VYCwPW3IE+Gdp4T3NPG1sRut3pCHL9z/fYyRs6VGYCUBk2EkSBmq3
	RAEpr+7WuT7aNcV4P584AmHzXD5MsMJ+DvZ3jDwMKpG4FzPbawfEiGj8UJCeE6PZ7iPGFov7xS6mD
	zUfylYCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x534e-0000000H1sa-22Ja;
	Fri, 11 Sep 2026 15:21:56 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x534Z-0000000H1s0-3bYn
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 15:21:53 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-90e7c71f86eso8109506d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 08:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140110; cv=none;
        d=google.com; s=arc-20260327;
        b=mp53dC37ZWC4yzoGaOuT6hEXthOE5MNg2nnEg0+rO2WswQdbnIHLZ6YXB8T1j844PL
         s0T4Y9d3I5lzw1lex4D4VYbXqtM7X6wnaLQDBn+LoZ53crHv4mwOGvB5bcEEVuw7bnnd
         1xypjbo527b9BRuMGZ5XdcNt/lqAzfJX0qH+sSvLBd6zUh7tWRt14REHy7DIVF5ox8Zi
         zGkDAuS4MPAnAPVrqqdU0KpKqGdkHKNxabKhnqNa6yjLYSb9f4VHTbotg9udDgRkoTRW
         xhYAyK1QTvjeZHm57h2R622NNeJvy3c0k7wugEkKNrYJTEpz04tBlzK/sc95cIvx+SgW
         smlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQhtgmYJbGnl4jzEgaW57/yVc/C4uVNFXjb6bqrdM/Q=;
        fh=P9Mx6SJg8HmFSipx9C5IIXImBjQ8mIxh/RG0QgFMMr0=;
        b=TZFr6yh+pR9XuSJHOBxF143BDWAyCF3skqQxXYrSiBC+ObNZCGYo91OxzLCtguOIrc
         omZJDBy0XuPXRLzp29KVUO/i5LrPxjTYSE1po/3GaHEXp0rJvpBKDXWiMclixJA7xKuv
         s0osEGXXNwx7EZqLtZWyFLJdVRHLsBq68PIoxbytfjm048/1CqbboyUBJEjwBZasRF90
         RICdWzN0VKVr53l1Xvi6+F8Kx42B9eeOXa2+hLP9w92grWmdR9F1cay9PbsxqJpXIEt/
         aEE/HF1pdWSUFYc+DwDuZHASnKNNDCn46LUDdPnDyenhtjHR0GUigvgVH+Abbtxfdl5J
         pGJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stellman-greene-com.20251104.gappssmtp.com; s=20251104; t=1789140110; x=1789744910; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQhtgmYJbGnl4jzEgaW57/yVc/C4uVNFXjb6bqrdM/Q=;
        b=RjNCp/ng48r7/PiAfl9ip3pzFprBN3MuqrikmU+p53XPzSMSHF+Mh+yKzjhEZODCL9
         kXevT+Dp3FbxVCiMLIqWrz/7JkLAnuIPcTmQ90+1LKGWqlWEm5+eAGAPSWOnM9wNTbsd
         URTMS1oY1M0OZZ6rciFjiLSJBpjJe4hY3DU6R+nih/4bvPsmIusRBoYw8wUKZBUh8WyY
         Upzr9vTzlpoPpluZa7pNUMXQ6JM8/+DUUYLAF08BPf2VlBRSZLxaY1boplW3qnTVaPHc
         aptdLWAfx76TxQMoHfHw/4UFo1kMuLfLQdgdi7Et8oe2IA63ywx5nklfrpdPpYSZx4cL
         WSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140110; x=1789744910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQhtgmYJbGnl4jzEgaW57/yVc/C4uVNFXjb6bqrdM/Q=;
        b=WOdOiymgV8vjIIyOEGpCHKvn167aIfgNdrl518l1RVIZV414yvXZzwhCfJt44WxA9q
         t5OeuDMfUkqOg/hWXzU48xdIsGJZxMbge8PFqjGYGdvMgE0PzMWMDCQLhepxR/IKi7Lv
         8TO7+iK0svTGlIPFAPCHgS+Z22BLbekXxOyFatvTEuEYH0Eo6LGv2tZn4TzcDSlNwI8A
         VAOc1EzFBgFNWJDXDsYrFDNy63EzIpLRmx1x7DF6lzg+blUt82r9qmeRgs0m2WVpRUJG
         zP1SXPxmXtRVyDNDk92Wn+IB6QnH0bB/MoD8PbzxA/x/lPdcvRoZvflbi6GvFc53/W9w
         8rrA==
X-Forwarded-Encrypted: i=1; AKwUvByyu0jOMePldJqQ65ro80lODuVV8BMXWLoGQwtN/9FbZ7EU+ZJjFXIAO+oAz1/Sl36IV3cNIyfKkRnT@lists.infradead.org
X-Gm-Message-State: AFuF++kNOWFt61i51GRa1VrCItk9f+8SDImqo7JFq5aJwemVYZP0EQIG
	RV3a+lulo5m3+qWkEAiilXZKibYgkaNquPhI7k7U881S59xo1g40n9FvQmzmfJ0i/np6o1wciRS
	azeHq6T7heYvjeRRdIiwaqVA2E6T6o6E=
X-Gm-Gg: AYBFou0ZHu0wR7LeUABN6AdSyCPbKB2/ZAUrPQodDmIT0FxnqtGszL3msd4ZePhl42M
	bd21kXqIF9tKXkyu66Bjh7Y8NeQ4taVHSnj7UMJaeqWZN8ukZxoh5MqR1s1J4Z5EYa05y1rV4/B
	rQ1fwsCAbK2HciXkPQ0AJbTnQtUN7iACR9iUq4cgL6wo6xc5QQHJRIibBi7XMKsHfhJ/IBD9Elj
	zn432XqvU1h+QoRacMrCzhQTbboII/773LByubJDaoe0Mc3VW1RTagiOUFG/b1TPsIqGM1cnq/8
	g8FH836Rwqlq6hl5CLCso2+j/c6YZG/AOTZRz1QDArD2kK8XhMg1SdnEZKaQv8x3MMG0s9cKF6V
	3b/tn7udIPrZ0dqmiP0Vp2PUVSrMFsQEVnvR0DpM9q7QZbvoKMOIcXkx1ti2FcWQGBINa4oS7BS
	+C3Un0hQdW1USU3lJstv2P4k/FtTetYw==
X-Received: by 2002:a05:6214:d65:b0:90e:9dea:82f0 with SMTP id
 6a1803df08f44-9121208ac38mr58638816d6.15.1789140110377; Fri, 11 Sep 2026
 08:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260910180056.81257-1-astellman@stellman-greene.com> <aqQZQPs7KzBUVbgw@kbusch-mbp>
In-Reply-To: <aqQZQPs7KzBUVbgw@kbusch-mbp>
From: Andrew Stellman <astellman@stellman-greene.com>
Date: Fri, 11 Sep 2026 11:21:39 -0400
X-Gm-Features: AcwNN1UP2cM_C5j9v0JZaDq3Dx9ytWa2AHbHOso5NtFvykWS7wXXx1m1jj-DEXs
Message-ID: <CAChPuV_74cky=JBROM7veVqmYTJBv+vPuPVCX6d+OBeL5BS-fg@mail.gmail.com>
Subject: Re: [PATCH] nvmet: derive the CRTO property from CAP, not CSTS
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_082152_034002_D9A5400C 
X-CRM114-Status: GOOD (  20.36  )
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

Sorry about that. And apologies in advance for my equally long
explanation on my other patch.

On Fri, Sep 11, 2026 at 11:07=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Thu, Sep 10, 2026 at 02:00:56PM -0400, Andrew Stellman wrote:
> > nvmet_execute_prop_get() answers a Property Get of CRTO with
> > NVME_CAP_TIMEOUT(ctrl->csts).  NVME_CAP_TIMEOUT() extracts bits 31:24,
> > which is the TO field of CAP.  CSTS defines only bits 6:0 and nvmet
> > writes only RDY, CFS and SHST into it, so the result is always 0.  The
> > same controller sets CAP.TO to 15 in nvmet_init_cap().
> >
> > NVMe Base Specification 2.4, Figure 36 (CAP), says that when CC.CRIME
> > is '0' the TO field "shall be set to: a) the value in the Controller
> > Ready With Media Timeout (CRTO.CRWMT) field; or b) FFh if the value in
> > the CRTO.CRWMT field is greater than FFh."  nvmet reports 15 in CAP.TO
> > and 0 in CRTO.CRWMT.
> >
> > Take the value from ctrl->cap, where the timeout is actually stored.
> >
> > The Linux host reads CRTO only when CAP.CRMS.CRWMS is set, which nvmet
> > does not advertise, so Linux initiators have not seen the wrong value.
> > A host that reads the property directly does, for example nvme-cli's
> > get-property.  Advertising CRWMS is a separate change.
> >
> > Tested on 7.3.0-rc1-qpb-cc-crto-base+ (unpatched) and
> > 7.3.0-rc1-qpb-cc-crto+ (patched) in an arm64 QEMU guest with nvmet over
> > NVMe/TCP to 127.0.0.1, reading the properties with nvme get-property.
> > Before: CAP reads 0x8200f0003ff (TO =3D 15) and CRTO reads 0.  After: C=
AP
> > is unchanged and CRTO reads 0xf, so CRWMT =3D 15 =3D CAP.TO.
> >
> > The issue was found by Claude Opus 5 running Quality Playbook, an
> > LLM-driven code review tool:
> > https://github.com/andrewstellman/quality-playbook
>
> This is a very long explanation for a simple protocol fix. Just say
> something like "The NVME_CAP_TIMEOUT requires the value from the CAP
> register, not CSTS." Short and to the point.

