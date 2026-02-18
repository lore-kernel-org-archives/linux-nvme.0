Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5132E9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cDJ595EzNlIRPNEWgUvyHB8pLI4M3wyzlKqJjlAins=; b=BlCGOTOd9cHKhngPCO34qSPt4W
	wFv8BStpRClm3C44b9d0NeMRKiamp9O1MtRRy4+HAd8mfyu3qRYE0hTeZd2lVMsZL0Idv97kvU2vw
	1GuiEs77LCph61lRvP4CKPn47jx/EN2+Eg6Q3jwPWHxVLU+8FSNPmRvfaFkPLxOVJubC0w1+BD/nS
	kuT2Mx0LSD8g9gT9pvlHb1A7gPq/d9kxWu3qhX5rwUggbLuDD0N9EsIjkYNAlTrwDwSt5y0ws1KeZ
	kGzUaHGYYTcmg39KLF6QvfbTGnpgz6/kbnAaNLa2urXLGLkydhjthBwBQVdeZNwM33uFadsCaG5dz
	eUfYas7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgxX-00000009o3n-05LU;
	Wed, 18 Feb 2026 12:47:15 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgxT-00000009o3P-3aWX
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 12:47:13 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1270adc5121so7119477c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 04:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771418831; x=1772023631; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cDJ595EzNlIRPNEWgUvyHB8pLI4M3wyzlKqJjlAins=;
        b=ZD1ysQUb1lTIiauUm30o6WvQweWLvdcSbvaZWaUW58i8VM32yjpAR7+gnT+cBNmrGp
         NBE4tJm+DYasJxahr2ODg9C6DSe3/tZ9qZ4m3woBSqA6MVGfJA9u1lTK9JKzIkBR2Hzw
         Q3KdT3MCbgJ0LGnOXbUI3Ih0vZ2xRIP8uppaPXGQ3+VoTistVw+BSUEf9cVUS88RLF9s
         TPNHRrKMSDQwREStQRqPRWCHSjjNZAbVnnhcATOGq7HYna4HrbHamgMP1FSvqAsQ8hau
         XBSwAoNz5fNLQEAINoEe52gijXvj2ZZVIBGht/f2IzwTlMqwqjommm94wcxEvkAH/0IT
         hpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418831; x=1772023631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cDJ595EzNlIRPNEWgUvyHB8pLI4M3wyzlKqJjlAins=;
        b=a0pGaWWeF/PLn641ZWGUrXsfT9/8vpmDbI3W16P1C/P1Q/XQtQDym1d86PztTwSO2k
         dcE0Q4JG6cVYoIRmx1m2F2dlnEyBiwjOrefeBL28Iy7yd9TMLIFOuhKo5Vd/VD4rtQ5N
         1B11oAwAdxBniThZK1KlbP/5p3up0R+iXq5DIRYY8+yHDajXE8Bx3/9NQ3sX+ykYrbqo
         otGAv9lWb7yZxglGm06+GHepuBEAnXWIVDu7HCEXJQvU7AVD9k7pLKbJ0KezdFcPAP2O
         63fAxXR7KQBtl9zq/lbRvSGdYWD9JXiKIb9CkPc5Bj/GvxRsCiwXmQ4u2NXkTIHjAxUn
         Qg6A==
X-Forwarded-Encrypted: i=1; AJvYcCVE5lQg1w8S6L8SCRhVnvNTS/FGD1IbyBvbe6pu/ecGa9LLCsF4cU4GAUtZiVfWLA3W+tw+197N7Vta@lists.infradead.org
X-Gm-Message-State: AOJu0Yxokx+yKWWBsl6lKiqcjSgbK4OCbMlhT1HjLJj0u+10bsBNUQ4p
	aiJMzRhxI6pmoEaAEONwdnYFwmyILELf8zIFkT+mGVDFbsK5ysuDbGYtUWM9xJPq7WU=
X-Gm-Gg: AZuq6aI8aXBazul5yWE9fJJsbvV0Fd3CJfTP4kmlyo4jsPD5idauE0Q+Ps6jVdAiHoZ
	TQ7JzAXAiIcS4jGDKfqLEBRDiY/XeB/aC4584dpSx56noSge9FLfUs7wc2eAz8bA4N/xidbQrBL
	m7VNEraOxAmNGxFoSO5M+DHTbBwu3CyPFfEnlJ4KksLhV26uTMmAa3TNlOLdOKtmfnSKfsqbxOL
	12prYiKYliH5PgTX/A7wbOhJ8Wto5Uh0qzZQuXfvGRQ4pC5x/sN+TYyzy+DT61wYBXuqC60JE6V
	C2ht/Y8sxNSO+4ccuXtc1UEzHuqWsxMUYZfDdaDtidhPbnNssaDX6XbJiOpYvuUb8kaVhowVb0g
	0s+pnJapXniYBSgMOY5ZWzAASbDNdPD+ugvZ2wXnvVUD4owfCkp7zQjIOaNB/iSx5RgC077kwa0
	N7rpulAFqizUO/apS1DyFLiuLAqW1w30T+a7BKNA==
X-Received: by 2002:a05:7300:6d06:b0:2ba:70b6:a162 with SMTP id 5a478bee46e88-2bd502a6853mr696063eec.35.1771418830524;
        Wed, 18 Feb 2026 04:47:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb658509sm17230056eec.19.2026.02.18.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:47:10 -0800 (PST)
Date: Wed, 18 Feb 2026 04:47:08 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/21] nvme: Implement cross-controller reset
 completion
Message-ID: <20260218124708.GJ2392949-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-10-mkhalfella@purestorage.com>
 <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
 <20260217182554.GE3435530-mkhalfella@purestorage.com>
 <1a9feff7-5a0d-4385-b582-c9ab60d724db@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a9feff7-5a0d-4385-b582-c9ab60d724db@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_044711_926518_0244771E 
X-CRM114-Status: GOOD (  31.33  )
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

On Wed 2026-02-18 08:51:31 +0100, Hannes Reinecke wrote:
> On 2/17/26 19:25, Mohamed Khalfella wrote:
> > On Mon 2026-02-16 13:43:51 +0100, Hannes Reinecke wrote:
> [ .. ]
> >>
> >> We really would need some indicator whether 'ccr' is supported at all.
> > 
> > Why do we need this indicator, other than exporting it via sysfs?
> > 
> To avoid false positives.

We will never try CCR on a controller that does not support it. False
positive of what?

> 
> >> Using the number of available CCR commands would be an option, if though
> >> that would require us to keep two counters (one for the number of
> >> possible outstanding CCRs, and one for the number of actual outstanding
> >> CCRs.).
> > 
> > Like mentioned above ctrl->ccr_limit gives us the number of ccrs
> > available now. It is not 100% indicator if CCR is supported or not, but
> > it is enough to implement CCR. A second counter can help us skip trying
> > CCR if we know impacted controller does not support it.
> > 
> > Do you think it is worth it?
> > 
> Yes. The problem is that we want to get towards TP8028 compliance, which
> forces us to wait for 2*KATO + CQT before requests on the failed patch
> can be retried. That will cause a _noticeable_ stall on the application
> side. And the only way to shorten that is CCR; once we get confirmation
> from CCR we can start retrying immediately.
> At the same time the current implementation only waits for 1*KATO before
> retrying, so there will be regression if we switch to TP8028-compliant
> KATO handling for systems not supporting CCR.

The statement above is not correct. Careful consideration and testing
has been made to not introduce such regression. If CCR is not supported
then nvme_find_ctrl_ccr() will return NULL and nvme_fence_ctrl() will
return immediately. No CCR command will be sent and no wait for AEN.

What happens next depends on whether ictrl->cqt is supported or not. If
not supported, which will be the case for systems in the field today,
then requests will be retried immediately. Requests will not be held in
this case and no delay will be seen in failover case.

> 
> So we can (and should) use CCR as the determining factor whether we
> want to switch to TP8028-compliant behaviour or stick with the original
> implementation.

We do check CCR support and availability in nvme_find_ctrl_ccr(). Adding
a second counter will spare us the loop in nvme_find_ctrl_ccr(), which
is not worth it IMO.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

